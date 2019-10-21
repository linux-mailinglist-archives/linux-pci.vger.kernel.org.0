Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC00DF280
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfJUQJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 12:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUQJy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 12:09:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665D3205C9;
        Mon, 21 Oct 2019 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571674193;
        bh=yAFVLkxjq0Sx/TKG/3FFK7vmvO0S13xxudXXKeP8cls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UJLPRlaUWuFmpX+NxO/8w1KbZGIRH4d0ob9OZ1lhjvd7SyHzsvySc7DcUoLh3ZXTn
         Y4bB/59GrW2t07f4+eAY985zcRpPVQES2Ejwytla7wMFbkuUQssn5Q6uidZG7iDJvg
         Hs6/5hZyZQF2qN0iZ6oZsMsmW7I2rVXRZxU5NdH0=
Date:   Mon, 21 Oct 2019 11:09:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-pci@vger.kernel.org, "Michael ." <keltoiboy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not
 working on Panasonic Toughbook CF-29]
Message-ID: <20191021160952.GA229204@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020090800.GA2778@light.dominikbrodowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 20, 2019 at 11:08:00AM +0200, Dominik Brodowski wrote:
> On the basis of the additional information (thanks), there might be a
> more specific path to investigate: It is that the PCI code does not
> enumerate the second cardbus bridge PCI function in the more recent 4.19
> kernel compared to the anvient (and working) 2.6 kernel.
> 
> Namely, only one CardBus bridge is recognized
> 
> ...
> 06:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
> 06:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 11)
> 06:02.0 Network controller: Intel Corporation PRO/Wireless 2915ABG [Calexico2] Network Connection (rev 05)
> ...
> 
> instead of the two which really should be present:
> 
> ...
> 06:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
> 06:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8b)
> 06:01.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 11)
> 06:02.0 Network controller: Intel Corporation PRO/Wireless 2915ABG [Calexico2] Network Connection (rev 05)
> ...
> 
> To the PCI folks: any idea on what may cause the second cardbus bridge PCI
> device function to be missed? Are there any command line options the users
> who reported this issue[*] may try?

Thanks for the report.  Could you try disabling
ricoh_mmc_fixup_rl5c476(), e.g., with the patch below (this is based
on v5.4-rc1, but you can use v4.9 if that's easier for you)?  This
isn't a fix; it's just something that looks like it might be related.

> [*] For more information, see this thread:
> 	https://lore.kernel.org/lkml/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..7a1e1a242506 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3036,38 +3036,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
  * #1, and this will confuse the PCI core.
  */
 #ifdef CONFIG_MMC_RICOH_MMC
-static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
-{
-	u8 write_enable;
-	u8 write_target;
-	u8 disable;
-
-	/*
-	 * Disable via CardBus interface
-	 *
-	 * This must be done via function #0
-	 */
-	if (PCI_FUNC(dev->devfn))
-		return;
-
-	pci_read_config_byte(dev, 0xB7, &disable);
-	if (disable & 0x02)
-		return;
-
-	pci_read_config_byte(dev, 0x8E, &write_enable);
-	pci_write_config_byte(dev, 0x8E, 0xAA);
-	pci_read_config_byte(dev, 0x8D, &write_target);
-	pci_write_config_byte(dev, 0x8D, 0xB7);
-	pci_write_config_byte(dev, 0xB7, disable | 0x02);
-	pci_write_config_byte(dev, 0x8E, write_enable);
-	pci_write_config_byte(dev, 0x8D, write_target);
-
-	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via CardBus function)\n");
-	pci_notice(dev, "MMC cards are now supported by standard SDHCI controller\n");
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
-
 static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 {
 	u8 write_enable;
