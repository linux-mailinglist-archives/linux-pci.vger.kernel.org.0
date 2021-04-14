Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6F35FC88
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 22:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhDNUXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 16:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231710AbhDNUXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 16:23:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13B7A61158;
        Wed, 14 Apr 2021 20:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618431791;
        bh=Q5pb7SCK4vCX3kzIoucnyWc080J5IiTOY/mwTdt6Jpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TJSGivUWv7lySsBuF922sMyiY7IWiWqoNWmE/fVcs97ZRQlRtvLTQbvM4F3Rww0yl
         KQvh2KH5kEvj2oq1qG0ktmswUpBbisVjpUQBYXe/ev5rcSBSU+iKwU/lJIiROpyUOn
         lVopzP4Bx6OuHRwIikuF80CgfcZHksDcs35Pwzzu2NwpVOmpdLciCwyh7wQCG4m1u5
         bbsWaV9pzxA0HwbaYJDXuLGxCcAoLFgw2EDrjpUYgMFrmT8EzjZ/eSFTCV2mocMYft
         fxL8X45lTr8Mkx2pJ0grZRPEJ2LqpWxDB3wb7I3w3OqSlo+67GhLq1LaCXLn/GK2rc
         poRC3/x793Seg==
Date:   Wed, 14 Apr 2021 15:23:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20210414202309.GA2533708@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413083916.5wwe6lsl65jix3gc@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 13, 2021 at 10:39:16AM +0200, Pali Rohár wrote:
> On Monday 12 April 2021 14:27:40 Bjorn Helgaas wrote:
> > On Mon, Apr 12, 2021 at 02:46:02PM +0200, Pali Rohár wrote:
> > > Define new PCI_EXP_DEVCTL_PAYLOAD_* macros in linux/pci_regs.h header file
> > > for Max Payload Size. Macros are defined in the same style as existing
> > > macros PCI_EXP_DEVCTL_READRQ_* macros.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  include/uapi/linux/pci_regs.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index e709ae8235e7..8f1b15eea53e 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -504,6 +504,12 @@
> > >  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
> > >  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
> > >  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00A0 /* 4096 Bytes */
> > 
> > This is fine if we're going to use them, but we generally don't add
> > definitions purely for documentation.
> > 
> > 5929b8a38ce0 ("PCI: Add defines for PCIe Max_Read_Request_Size") added
> > the PCI_EXP_DEVCTL_READRQ_* definitions and we do have a few (very
> > few) uses in drivers.
> 
> I'm planning to use this constant to fix pci-aardvark.c driver. Aardvark
> changes are not ready yet, but I'm preparing them in my git tree
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark
> (commit PCI: aardvark: Fix PCIe Max Payload Size setting)
> 
> But as this is not change in aardvark driver, I sent it separately and
> earlier. As it would be dependency for aardvark changes.

OK, just include this in that series.

Bjorn
