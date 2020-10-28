Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3229DED7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 01:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgJ2A4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 20:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbgJ1WRg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F977246E8;
        Wed, 28 Oct 2020 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603886816;
        bh=c3/rdvftJ6JnKD8VUBIW4eoNR5VA7ESNHgN0Zlp4hJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Untss5VPA7L1b4nTbLJJ9hEObyi+ldMQjQ+NARyLMYKn4NiGyFOPYFi/M8trh1iHI
         n3hrChqGa9Gn63erK+GKqTPqX2Uh7401xdku3fJjEzww0qMhVcjTOby8evFYbY9mRz
         zAbJ5BXJ9ZjqBG2Xid4JjZoQ7RD74txrYQfIYfTY=
Date:   Wed, 28 Oct 2020 07:06:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "yue.wang@amlogic.com" <yue.wang@amlogic.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic <linux-amlogic@lists.infradead.org>
Subject: Re: pci-meson covery issue #1442509
Message-ID: <20201028120655.GA306101@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2020102810175892085918@amlogic.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's best if you can reply with plain-text email, because I don't
think multi-part MIME messages are accepted by the mailing lists:
http://vger.kernel.org/majordomo-info.html

On Wed, Oct 28, 2020 at 10:17:59AM +0800, yue.wang@amlogic.com wrote:
> HI Bjorn,
> 
> amlogic PCIE_CFG_STATUS17 register:
> 
> and bit7 mac_phy_rate :
> 
> Amlogic pcie working mode is only GEN1 & GEN2，so mac_phy_rate is 0 or 1；
> 
> PM_CURRENT_STATE(state17)  is related to Amlogic pcie working mode，and  not  related to power management.
> 
> "PM_CURRENT_STATE(state17) < PCIE_GEN3"  is always true. 

There's no point in making a comparision that's always true.  It just
clutters the code without adding value.  IMO you should do something
like the following.  If and when you actually *need* to check the
mac_phy_rate and there's a possibility that it might not be OK, you
can add it back.

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 1913dc2c8fa0..bb7a35c7c57f 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -35,9 +35,6 @@
 #define IS_RDLH_LINK_UP(x)		((x) & (1 << 16))
 #define IS_LTSSM_UP(x)			((((x) >> 10) & 0x1f) == 0x11)
 
-#define PCIE_CFG_STATUS17		0x44
-#define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
-
 #define WAIT_LINKUP_TIMEOUT		4000
 #define PORT_CLK_RATE			100000000UL
 #define MAX_PAYLOAD_SIZE		256
@@ -341,30 +338,23 @@ static int meson_pcie_link_up(struct dw_pcie *pci)
 {
 	struct meson_pcie *mp = to_meson_pcie(pci);
 	struct device *dev = pci->dev;
-	u32 speed_okay = 0;
 	u32 cnt = 0;
-	u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
+	u32 state12, smlh_up, ltssm_up, rdlh_up;
 
 	do {
 		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
-		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
 		smlh_up = IS_SMLH_LINK_UP(state12);
 		rdlh_up = IS_RDLH_LINK_UP(state12);
 		ltssm_up = IS_LTSSM_UP(state12);
 
-		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
-			speed_okay = 1;
-
 		if (smlh_up)
 			dev_dbg(dev, "smlh_link_up is on\n");
 		if (rdlh_up)
 			dev_dbg(dev, "rdlh_link_up is on\n");
 		if (ltssm_up)
 			dev_dbg(dev, "ltssm_up is on\n");
-		if (speed_okay)
-			dev_dbg(dev, "speed_okay\n");
 
-		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
+		if (smlh_up && rdlh_up && ltssm_up)
 			return 1;
 
 		cnt++;

> yue.wang@amlogic.com
>  
> From: Bjorn Helgaas
> Date: 2020-10-28 00:40
> To: Yue Wang
> CC: linux-pci; Kevin Hilman; linux-amlogic
> Subject: pci-meson covery issue #1442509
> Hi Yue,
>  
> Please take a look at this issue reported by Coverity:
>  
> 340 static int meson_pcie_link_up(struct dw_pcie *pci)
> 341 {
> 342        struct meson_pcie *mp = to_meson_pcie(pci);
> 343        struct device *dev = pci->dev;
> 344        u32 speed_okay = 0;
> 345        u32 cnt = 0;
> 346        u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
> 347
> 348        do {
> 349                state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> 350                state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
> 351                smlh_up = IS_SMLH_LINK_UP(state12);
> 352                rdlh_up = IS_RDLH_LINK_UP(state12);
> 353                ltssm_up = IS_LTSSM_UP(state12);
> 354
>  
> CID 1442509 (#1 of 1): Operands don't affect result
> (CONSTANT_EXPRESSION_RESULT) result_independent_of_operands: ((state17
> >> 7) & 1) < PCIE_GEN3 is always true regardless of the values of its
> operands. This occurs as the logical operand of if.
>  
> 355                if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
> 356                        speed_okay = 1;
>  
>  
> "PM" seems like a funny name for a link speed.  It sounds more like
> something related to power management, e.g., D0, D3.
>  



