Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D12D08DA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 02:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgLGB0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 20:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgLGB0o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Dec 2020 20:26:44 -0500
Date:   Sun, 6 Dec 2020 19:26:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607304363;
        bh=cKz2CRKeDbCy7RYoUvb9++ciuFqkOZ+KcclmKE6cKYo=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=I53LVHfuwcu0tPd/Zd5YgEVHkp4V5sXM8fgaDc1UcTAliiH/XJjZtAcmTWJk6gBBV
         15jnsrClJ25oqs5zb8UnOm4Szpo7yMgA8iGEv7zKsNDl3YTJOJwV5NlH15mCs1GgkV
         iVvLvJfj4JY+VqCN2DJjj7HLFAVjepmUJQKAPJX+OXEfpb5KHYFVWuUqcBrrylxrz/
         303LQ2OEPIftCeTt/25BG/CFDMA9Eln4R02HwU/c3LpEDI1dKglUnNUBgrZsUN7j5s
         LOhaRkUt5TBf8wyuI+u2HtdsUfE+aA4Ns+5N8s6wuahI4cxQeNymK6/Hf+HXo/Xq9j
         Hma9O7aUjD9Sg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Message-ID: <20201207012600.GA2238381@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496516ECEDBE667B5813460586CF0@BYAPR04MB4965.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 06, 2020 at 11:08:14PM +0000, Chaitanya Kulkarni wrote:
> On 12/6/20 11:45, Puranjay Mohan wrote:
> > Callers of pci_find_capability should save the return value in u8.
> > change type of variables from int to u8 to match the specification.
> 
> I did not understand this, pci_find_capability() does not return u8. 
> 
> what is it that we are achieving by changing the variable type ?
> 
> This patch will probably also generate type mismatch warning with
> 
> certain static analyzers.

There's a patch pending via the PCI tree to change the return type to
u8.  We can do one of:

  - Ignore this.  It only changes something on the stack, so no real
    space saving and there's no problem assigning the u8 return value
    to the "int".

  - The maintainer could ack it and I could merge it via the PCI tree
    so it happens in the correct order (after the interface change).

  - The PCI core interface change will be merged for v5.11, so we
    could hold this until v5.12.

I don't really have a preference.  The only place there would really
be a benefit would be if we store the return value in a struct, where
we could potentially save three bytes.

Bjorn

> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  drivers/block/mtip32xx/mtip32xx.c | 2 +-
> >  drivers/block/skd_main.c          | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> > index 153e2cdecb4d..da57d37c6d20 100644
> > --- a/drivers/block/mtip32xx/mtip32xx.c
> > +++ b/drivers/block/mtip32xx/mtip32xx.c
> > @@ -3936,7 +3936,7 @@ static DEFINE_HANDLER(7);
> >  
> >  static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
> >  {
> > -	int pos;
> > +	u8 pos;
> >  	unsigned short pcie_dev_ctrl;
> >  
> >  	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> > index a962b4551bed..16d59569129b 100644
> > --- a/drivers/block/skd_main.c
> > +++ b/drivers/block/skd_main.c
> > @@ -3136,7 +3136,7 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
> >  
> >  static char *skd_pci_info(struct skd_device *skdev, char *str)
> >  {
> > -	int pcie_reg;
> > +	u8 pcie_reg;
> >  
> >  	strcpy(str, "PCIe (");
> >  	pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
> 
> 
