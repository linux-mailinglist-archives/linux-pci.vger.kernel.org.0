Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D620463478
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbhK3MkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:40:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44612 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbhK3MkG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:40:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F45FCE1993
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57351C53FC1;
        Tue, 30 Nov 2021 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275804;
        bh=OyvDA4KdWu05oEmPO5pM0S8DH5a/aV8ZVB4bn8ffkxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iC0n6ZhJghYSi1ctCjO8ESJOab4aLxGGXFtxodjCpVoxDG3vFNj9JPi6d8OA0RRBc
         xhRqPnRunXv0z/4gMsdoCxyK0AnUGZ0XC72q01KXc0WNqwIxKXgNyI5gzIoOApqCeP
         STOc+ggUj6753ea2yVAioGmjsYB0B2Md1r1aS83SeiFQ1/W1Fj2voOrawhTHexvVkc
         nS1DOhOIfwYdyLw/E9x/8WeYaimV0o+mfcjTBVflhZzHZU0Ym3+/vuZltgXUlkWK/X
         VxyWS6h1/FlVnQz/Q2pANm+d1gEAiSq6odlibiksvukcxSRI4wlhWs6dBSDkFqt0dX
         1/kEII9QT7srw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 11/11] PCI: aardvark: Disable common PHY when unbinding driver
Date:   Tue, 30 Nov 2021 13:36:21 +0100
Message-Id: <20211130123621.23062-12-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130123621.23062-1-kabel@kernel.org>
References: <20211130123621.23062-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Disable the PCIe PHY when unbinding driver, to save power.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e5c88f1c177b..2a82c4652c28 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1750,6 +1750,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	for (i = 0; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
 
+	/* Disable phy */
+	advk_pcie_disable_phy(pcie);
+
 	return 0;
 }
 
-- 
2.32.0

