Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D88B222D72
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGPVJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 17:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgGPVJy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 17:09:54 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08E0207DD;
        Thu, 16 Jul 2020 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594933794;
        bh=AcwhowgLvFEZNKhytEiTcdGfl0j994HbxXy5LFPSc18=;
        h=Date:From:To:Cc:Subject:From;
        b=WkZDqo7FDqKZ6oomojkl8Say6lmEeGL8iewbke1QHhFyqu9tTR8MbbAWx1jtqszSB
         Jv+Vlu8aujRO7T7O4hZG02RTqSg8s3yTFFjgmyGPMe1iJQpr2P0PqEplXfmiMhoEZ7
         ZovdgyAIR1uhQfGsmv6B3+WBA/k9JkM2w+p8hr9E=
Date:   Thu, 16 Jul 2020 16:15:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] PCI: rcar-gen2: Use fallthrough pseudo-keyword
Message-ID: <20200716211517.GA17174@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
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

