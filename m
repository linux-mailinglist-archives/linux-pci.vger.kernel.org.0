Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A0228E8C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 05:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgGVDXQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 23:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731781AbgGVDXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 23:23:15 -0400
Received: from embeddedor (unknown [201.162.241.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216B42073A;
        Wed, 22 Jul 2020 03:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595388195;
        bh=uM6fyj+PQ5qOmnVhpZd9ufFET3RZbSsFk/iuwvXvJBw=;
        h=Date:From:To:Cc:Subject:From;
        b=bTpAYBskiiDA2AEnBpXKU9F74egBStaz5fCX4tMbBPOJ9qqY9Vwjon9V/kbGodXrh
         TGKa2xmqZ5bgYJf4XSxmAaspA1fZLcmO/3fPQwF8+kvmg0v8tw6ywcap/h5mMXTHYj
         Syx2lWVUH7S8Cp9pIWNBAylQJjUG/KMGUb40dVD8=
Date:   Tue, 21 Jul 2020 22:28:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2][next] PCI: rcar-gen2: Use fallthrough pseudo-keyword
Message-ID: <20200722032851.GA4251@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update URL. Use proper URL to Linux v5.7 documentation.
 - Add Geert's Reviewed-by tag.
 - Update changelog text.

 drivers/pci/controller/pci-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 326171cb1a97..2ec7093a7588 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -228,7 +228,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		pr_warn("unknown window size %ld - defaulting to 256M\n",
 			priv->window_size);
 		priv->window_size = SZ_256M;
-		/* fall-through */
+		fallthrough;
 	case SZ_256M:
 		val |= RCAR_USBCTR_PCIAHB_WIN1_256M;
 		break;
-- 
2.27.0

