Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10A166F82
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGLNEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 09:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLNEX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jul 2019 09:04:23 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E0120863;
        Fri, 12 Jul 2019 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562936662;
        bh=u96N68lduvC3FQgAP3xAaT3SUCGGECkXStzM+/6LFiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEqeNZhJm60hUaHF1LdMWBV+vec2TZTgGaYRf2jEI6LEoO1Zhth+4X8jI5iHz6xPP
         MFT78SpOBHN7gUzUfx1XfrKytHizziPtXCb/mPANT/6//2LGzBhKJUFkZ24ZEmx0hk
         lgh2IvzG+B5sjPFmw1TXmyLK4txUszERPJo209Xk=
Date:   Fri, 12 Jul 2019 08:04:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dwmw@amazon.co.uk, benh@kernel.crashing.org,
        alisaidi@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        talel@amazon.com, hanochu@amazon.com, hhhawa@amazon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/8] PCI: Add quirk to disable MSI support for Amazon's
 Annapurna Labs host bridge
Message-ID: <20190712130419.GA46935@google.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
 <20190710164519.17883-5-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710164519.17883-5-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 05:56:25PM +0300, Jonathan Chocron wrote:
> On some platforms, the host bridge exposes an MSI-X capability but
> doesn't actually support it.
> This causes a crash during initialization by the pcieport driver, since
> it tries to configure the MSI-X capability.

Nit: The formatting above is jarring to read because I can't tell
whether it's one paragraph or two.

Either rewrap it into a single paragraph or add a blank line to make
two paragraphs.  I noticed this elsewhere, too, in a comment, I think.

s/host bridge/Root Port/, if I understand correctly.

I don't understand the "on some platforms..." part.  Do you mean that
on *every* platform, this particular host bridge (identified by
[1c36:0031]) advertises an MSI-X capability that doesn't work?

Or are there some platforms that configure the bridge so it doesn't
advertise MSI-X at all, while other platforms configure it so it
*does* advertise MSI-X?

If there's a line or two of diagnostics from the crash you could
include here, that would help people who encounter the crash find
the solution.

> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 11850b030637..0fb70d755977 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2925,6 +2925,14 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a1,
>  			quirk_msi_intx_disable_qca_bug);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
>  			quirk_msi_intx_disable_qca_bug);
> +
> +static void quirk_al_msi_disable(struct pci_dev *dev)
> +{
> +	dev->no_msi = 1;
> +	dev_warn(&dev->dev, "Annapurna Labs pcie quirk - disabling MSI\n");

s/pcie/PCIe/ in English text, comments, printk strings, etc.

Actually, I think the whole "Annapurna Labs pcie quirk" part is
probably unnecessary, since we can identify the device via the
dev_printk() info.

Speaking of which, you can use "pci_warn(dev)" here to be consistent
with the rest of the file.

> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_msi_disable);

Why do you use the class fixup here instead of the simpler
DECLARE_PCI_FIXUP_FINAL()?  Requiring the class to match
PCI_CLASS_BRIDGE_PCI suggests that there may be other [1c36:0031]
devices that are not Root Ports.  If that's the case, please mention
it so it's clear why we need DECLARE_PCI_FIXUP_CLASS_FINAL().  If not,
just use DECLARE_PCI_FIXUP_FINAL().

>  #endif /* CONFIG_PCI_MSI */
>  
>  /*
> -- 
> 2.17.1
> 
> 
