Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B663E4B10
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhHIRnH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 13:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234154AbhHIRnG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 13:43:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4C3660F25;
        Mon,  9 Aug 2021 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628530966;
        bh=FSFPv4kDztNyzO9/5NElHuOFEoE9ULfv2/yH+18aDsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VNrWPeDdTAiBVFGd4tE8zpWxdKdmy4uZNfT1xG9Ey8dAH7dGzy2c31IkFE9wqhszF
         sPg1ZS08jMOcY++hBBMKJl46omOGv26RAgaUHhwtqzouT8be3ihPXpXc2BVOWceOzr
         VzLE4PwGgZYl82onsupTZbAB6RyTgcbYud/IfXyqJflAMDkDS4adDqd3HYEu+Rv/q7
         eQ3acQ0wCZNInKHLW3sdL7fjtvpyFj8hL8jtrfliA/lKHv6Dp11tnIevVKPooqs2zB
         DHZKTfDCPZXc1Gn8wvspTzXBrEGJKKFGvCBL1CQQPy9mEV2B7pfeKfJjHPa9dQnSsO
         S/yuhaEMlYO+g==
Date:   Mon, 9 Aug 2021 12:42:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add ACPI config space quirk
Message-ID: <20210809174244.GA2167737@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a11c89-d49b-7367-a75c-13016a2ea5d9@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 06, 2021 at 09:55:27PM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 8/6/21 5:21 PM, Bjorn Helgaas wrote:
> > On Thu, Aug 05, 2021 at 04:11:59PM -0500, Jeremy Linton wrote:
> > > The PFTF CM4 is an ACPI platform that is following the PCIe SMCCC
> > > standard because its PCIe config space isn't ECAM compliant and is
> > > split into two parts. One part for the root port registers and a
> > > moveable window which points at a given device's 4K config space.
> > > Thus it doesn't have a MCFG (and really any MCFG provided would be
> > > nonsense anyway). As Linux doesn't support the PCIe SMCCC standard
> > > we key off a Linux specific host bridge _DSD to add custom ECAM
> > > ops and cfgres. The cfg op selects between those two regions, as
> > > well as disallowing problematic accesses, particularly if the link
> > > is down because there isn't an attached device.
> > 
> > I'm not sure SMCCC is *really* relevant here.  If it is, an expansion
> > of the acronym and a link to a spec would be helpful.
> > 
> > But AFAICT the only important thing here is that it doesn't have
> > standard ECAM, and we're going to work around that.
> 
> I will reword it a bit.
> 
> > I don't see anything about _DSD in this series.
> 
> That is the "linux,pci-quirk" in the next patch.

The next patch doesn't mention _DSD either.  Is it obfuscated by
being inside fwnode_property_read_string()?  If so, it's well and
truly hidden; I gave up trying to connect that with ACPI.

Bjorn
