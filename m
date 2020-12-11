Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C458C2D8249
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 23:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392934AbgLKWm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 17:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394011AbgLKWmd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 17:42:33 -0500
Date:   Fri, 11 Dec 2020 16:41:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726513;
        bh=CzOhIDGkl3UprOKXbtfomhvXwhcIdMbufejZI4QCbOI=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=ZFJCMTLuLlQz3Px+TgUwer07fyqbCEKPMDPMx2MokebsxVTi4bd6TFbvNmieUjyrM
         jLL6OgK1ntbMJNBUZwAuDJ+jQQnym4wJyhg4xPeJys3JmxrgzNqRIHFUABE3ya8nP2
         BjKog7nX/Z2rrH/gplwleDAlg+f8StpzCnTA2kMfyuoj/ECWj5MyGUBcq/NrO2tX+s
         TJeRhY9q0lfujyHiAu8e3wJlCxhz3YaxTxDw1HwMSIyWxm/2fC7Dkq5dt9H89AxYkr
         mlOcOjlaFTPnzSeKRh/DIo7+KQ7Wut12X2A9nXdYUxH/rtL2vOPUBCiDJMYkOQwUfo
         hg/EHPU+8Mm5Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: skd: remove skd_pci_info()
Message-ID: <20201211224151.GA113093@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496513CB49E42A3467427BF686CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 09:50:52PM +0000, Chaitanya Kulkarni wrote:
> On 12/11/20 08:45, Puranjay Mohan wrote:
> > PCI core calls __pcie_print_link_status() for every device, it prints
> > both the link width and the link speed. skd_pci_info() does the same
> > thing again, hence it can be removed.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  drivers/block/skd_main.c | 31 -------------------------------
> >  1 file changed, 31 deletions(-)
> >
> > diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> > index a962b4551bed..da7aac5335d9 100644
> > --- a/drivers/block/skd_main.c
> > +++ b/drivers/block/skd_main.c
> > @@ -3134,40 +3134,11 @@ static const struct pci_device_id skd_pci_tbl[] = {
> >  
> >  MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
> >  
> > -static char *skd_pci_info(struct skd_device *skdev, char *str)
> > -{
> > -	int pcie_reg;
> > -
> > -	strcpy(str, "PCIe (");
> > -	pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
> > -
> > -	if (pcie_reg) {
> > -
> > -		char lwstr[6];
> > -		uint16_t pcie_lstat, lspeed, lwidth;
> > -
> > -		pcie_reg += 0x12;
> > -		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);
> > -		lspeed = pcie_lstat & (0xF);
> > -		lwidth = (pcie_lstat & 0x3F0) >> 4;
> > -
> > -		if (lspeed == 1)
> > -			strcat(str, "2.5GT/s ");
> > -		else if (lspeed == 2)
> > -			strcat(str, "5.0GT/s ");
> > -		else
> > -			strcat(str, "<unknown> ");
> The skd driver prints unknown if the speed is not "2.5GT/s" or "5.0GT/s".
> __pcie_print_link_status()  prints "unknown" only if speed
> value >= ARRAY_SIZE(speed_strings).
> 
> If a buggy skd card returns value that is not != ("2.5GT/s" or "5.0GT/s")
> && value < ARRAY_SIZE(speed_strings) then it will not print the unknown but
> the value from speed string array.
> 
> Which breaks the current behavior. Please correct me if I'm wrong.

I think you're right, but I don't think it actually *breaks* anything.

For skd devices that work correctly, there should be no problem, and
if there ever were an skd device that operated at a speed greater than
5GT/s, the PCI core would print that speed correctly instead of having
the driver print "<unknown>".

I don't think it's a good idea to have a driver artificially constrain
the speed a device operates at.  And the existing code doesn't
actually constrain anything; it only prints "<unknown>" if it doesn't
recognize it.  The probe still succeeds.  I don't see much value in
that "<unknown>".

Or am I missing an actual problem this patch causes?

> > -		snprintf(lwstr, sizeof(lwstr), "%dX)", lwidth);
> > -		strcat(str, lwstr);
> > -	}
> > -	return str;
> > -}
> >  
> >  static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  {
> >  	int i;
> >  	int rc = 0;
> > -	char pci_str[32];
> >  	struct skd_device *skdev;
> >  
> >  	dev_dbg(&pdev->dev, "vendor=%04X device=%04x\n", pdev->vendor,
> > @@ -3201,8 +3172,6 @@ static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  		goto err_out_regions;
> >  	}
> >  
> > -	skd_pci_info(skdev, pci_str);
> > -	dev_info(&pdev->dev, "%s 64bit\n", pci_str);
> >  
> >  	pci_set_master(pdev);
> >  	rc = pci_enable_pcie_error_reporting(pdev);
> 
