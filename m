Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928B23B3FF0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhFYJHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhFYJHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 05:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D44A61429;
        Fri, 25 Jun 2021 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624611911;
        bh=/yKmQjvvAriWKaSF8AZeFSHN6aUtEK+OaFQo4i93O88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeDwti3I4RIA3eHvRfcRsx4CLOxp41zE6bUYJNauasCY2YkVUNP7lQw87u2nI182E
         VRVsHSKA96lSJiPFK7sNM9ADAPxsJw1q50xoMRYHR6Y7q6toMePEDmfRbqnX6zvU+7
         4Q7Pxge3nTMh2+OyHLb8P5dSY4KXZQz7ld/HOcmm8QU+B+2Osj/16xbrWncTMG/4Nf
         zR/AA3y6TPJIfPG59fZCiPl62DLK0IhqzfxDeiJojyo3Tm1Owg3Gzcn4X5BT3gJqR7
         jKqdMuZbmzTzNIqahKcM4ExnMn1+iZ2dbhw5n33KVBwnHvMP1ggbpenw98cJg9/c7T
         vvxVIZZGm8aRg==
Received: by pali.im (Postfix)
        id E059C60E; Fri, 25 Jun 2021 11:05:10 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] PCI: aardvark: Check for virq mapping when processing INTx IRQ
Date:   Fri, 25 Jun 2021 11:03:14 +0200
Message-Id: <20210625090319.10220-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625090319.10220-1-pali@kernel.org>
References: <20210625090319.10220-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is possible that we receive spurious INTx interrupt. So add needed check
before calling generic_handle_irq() function.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 36fcc077ec72..59f91fad2481 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1226,7 +1226,11 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 			    PCIE_ISR1_REG);
 
 		virq = irq_find_mapping(pcie->irq_domain, i);
-		generic_handle_irq(virq);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected INT%c IRQ\n",
+					    (char)i+'A');
 	}
 }
 
-- 
2.20.1

