Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC76B91E0F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfHSHkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 03:40:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33647 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSHkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 03:40:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so568096plb.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2019 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CaEyohzlQpJYqDCuXjIODakxTs9XRVBNPX1JZzttlCQ=;
        b=pJK2jXyDeMWUjNBTjESp9kqhWZFgtxlpp9hT6a5dwxiZAWB2uz1U+Xdn0f6VfzUzdH
         RAj/dxYd6IEljr+hE0ntxM2y7BgrE1o9Bn0RgUWRptHDjbpd4sklYSCsflHs9vh4BvTR
         mHhu8qkmWBIepdI88+axbC3B+RK4n5Db56qfSWCGDBPvVxImDhfynsV9Ct5pxwFV98LT
         AOHCpJB3H8k8WcBuREp6qKWisKFuWQSqAmmqmkqFtv06tZ5hYBxiCA9HvaS2wRKsJm7c
         Y8ibCLf2GAMPl7USkicUQUdGD9sxi73pLrJfj4DIGUmOqxqZCHnyNxjjo7j5bvUeAhik
         di+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CaEyohzlQpJYqDCuXjIODakxTs9XRVBNPX1JZzttlCQ=;
        b=MrmMWO7lLOMC7ZUSy1NOnI66mbwTVn0Uuy6j/3E7K9xIUQ+NI42XrsIp/8pHImS8Yn
         oPk8M5jfAjhRRfLvpWzmFnjmmO212WjOGpCd9eTNTLT6xHpPnNdULplkgtAepYhlFzUZ
         HQvu6UgUUv2/oLmI6JBcv5NzJ2CrVlTiPhihUlJNiIj47F/jZRgugm+KmCvve3a/4JmH
         3gb0w0fAU4yRGr0FrT6/IFqikquNMKk57rsug66If8EqrTKnPrsona+n6mSFP6SBqIgn
         Dff4PwFWdJw+j3zHpSvby85lfFkO4SUAIdPsx261yqYu1KkXZOweKjcMvzlVf/spXpwG
         hNEA==
X-Gm-Message-State: APjAAAWG8Iw0KMAaL1WtTWPOc1lTOM43Y6y2GtMx9Yzicpuv5MGwOSD/
        4OLe0l7vm16RHEzYLAfgogJ2aGB2
X-Google-Smtp-Source: APXvYqzL2W3rIUkDov75vdvuPdgoVtF/U2J5xiRzAwkjJkduLXMgAx+mbtsSHzbpvfOzTYLdOndQOQ==
X-Received: by 2002:a17:902:6a:: with SMTP id 97mr21331339pla.257.1566200399544;
        Mon, 19 Aug 2019 00:39:59 -0700 (PDT)
Received: from localhost.localdomain ([110.225.16.165])
        by smtp.gmail.com with ESMTPSA id h11sm14855215pfn.120.2019.08.19.00.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 00:39:58 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] PCI: kirin: Make structure kirin_dw_pcie_ops constant
Date:   Mon, 19 Aug 2019 13:09:46 +0530
Message-Id: <20190819073946.32458-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Static variable kirin_dw_pcie_ops, of type dw_pcie_ops, is used only
once, when it is assigned to the constant field ops of variable pci
(having type dw_pcie). Hence kirin_dw_pcie_ops is never modified.
Therefore, make it constant to protect it from unintended modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 8df1914226be..c19617a912bd 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -436,7 +436,7 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static struct dw_pcie_ops kirin_dw_pcie_ops = {
+static const struct dw_pcie_ops kirin_dw_pcie_ops = {
 	.read_dbi = kirin_pcie_read_dbi,
 	.write_dbi = kirin_pcie_write_dbi,
 	.link_up = kirin_pcie_link_up,
-- 
2.19.1

