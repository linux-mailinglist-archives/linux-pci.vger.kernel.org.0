Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75E47C201
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhLUO4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbhLUO4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD14C06173F;
        Tue, 21 Dec 2021 06:56:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 842A861659;
        Tue, 21 Dec 2021 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32573C36AF1;
        Tue, 21 Dec 2021 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098610;
        bh=iOm7uhs+2+Y00wU5942hoH5Ypg2VEv9NlwRanu6QquM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8JGCyWQiEo0FeYt4MhAer93WIjm9rkmEHCBYUc8ETBTMpv/I4bjQYagB28X+ul+I
         M1PIAjpdaHrzVIwIQo1DqMgkaZ9x+QYGvAD81STAzNYi0CJ0otvX4ibGz2rtuFTR4K
         q+eKkEwbS8Z5yCrxNZFnaETERxtPGjmSfyXiJVklLiwerDdl4CA6GevhgLdXNu7ujo
         xRacVza+ntAs+QBFDve3C0lNiA0jydBC+3gPKWa6O8kzgYH9k4RoAxjOgKpuqar53Q
         sb2iO1vF83AD3ZCExX709WzVHaxAE8tvDI5Go6+vGhmvLolr+0umW301WJmS330AbU
         TPe+OyEra98iQ==
Received: by pali.im (Postfix)
        id 24FCE284D; Tue, 21 Dec 2021 15:18:12 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] =?UTF-8?q?MAINTAINERS:=20Add=20Pali=20Roh=C3=A1r=20?= =?UTF-8?q?as=20pci-mvebu.c=20maintainer?=
Date:   Tue, 21 Dec 2021 15:14:45 +0100
Message-Id: <20211221141455.30011-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>

---
I discussed with Thomas and he ask me for taking maintenance of pci-mvebu.c driver.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..24527789d933 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14617,6 +14617,7 @@ F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
+M:	Pali Rohár <pali@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.20.1

