Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C91EC51F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgFBWgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 18:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgFBWgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 18:36:21 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D011206C3;
        Tue,  2 Jun 2020 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591137380;
        bh=/mIo8q1mMTXO4fFd8iQWpQDeSXxkevBUGxI6osoTx9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=v78wUJyl7H1wwkooJ5aVeAaY398gyz5qtAYJluYJaD0UkvlE2S017rCqfURZugebt
         Mff3Ar2aB5MrR1dB9hc9n16m6ZsuYiJmk/3mntyxoDaOWr8RjfCtKqr6DOpUR2H3HI
         UlCv/n89h+NOMsCnlBp/Y+sZSCw6lK1zSSqv41vc=
Date:   Tue, 2 Jun 2020 17:36:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
Message-ID: <20200602223618.GA845676@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5ba708-18a9-fd42-8cf1-af32ef367d5e@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 02, 2020 at 01:50:37PM -0400, Sinan Kaya wrote:
> Bjorn,
> 
> On 6/1/2020 9:57 PM, Yicong Yang wrote:
> > well, Sinan's words make sense to me. But I'm still confused that, the message
> > says we're "disabling ASPM" but ASPM maybe enabled if we designate
> > pcie_aspm=force as I mentioned in the commit message. Will it be possible if
> > we replace "disabling" to "disabled" or we can do something else to make
> > the message reflect the real status of ASPM?
> 
> What do you think?

ASPM is a mess in general, and the whole "no_aspm" dance for delaying
setting of aspm_disabled is ... well, it's confusing at best.

These "_OSC failed" messages are confusing to users as well.  They
lead to bug reports against Linux (when it's usually a BIOS problem)
and users booting with "pcie_aspm=force" (which is a poor user
experience and potentially dangerous since the platform hasn't granted
us control of the PCIe Capability).

And it's not even specific to ASPM; when _OSC fails, we don't take
over *any* PCIe features.  At least, we're not *supposed* to -- I
don't think we're very careful about random things in the PCIe
capability.

What if we just removed the ASPM text from the message completely,
e.g., something like this:

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 800a3d26d24b..49fdb07061b1 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -453,9 +453,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		if ((status == AE_NOT_FOUND) && !is_pcie)
 			return;
 
-		dev_info(&device->dev, "_OSC failed (%s)%s\n",
-			 acpi_format_exception(status),
-			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
+		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
+			 acpi_format_exception(status));
 		return;
 	}
 
@@ -516,7 +515,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	} else {
 		decode_osc_control(root, "OS requested", requested);
 		decode_osc_control(root, "platform willing to grant", control);
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
+		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
 			acpi_format_exception(status));
 
 		/*
