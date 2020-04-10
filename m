Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213C01A48CA
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJRHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 13:07:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55785 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 13:07:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so3053875wmk.5
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2020 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=clJNAroYTWV4rFME+VeIhbSZLGr3iQaW6NDSUMyrTgw=;
        b=FL5qTg4nFJ/6Eu82dsF6X+euCiginV5M9aN1kQ6Oxlx9WUrVLzSKyHblXlhSpP4ZjG
         yMF6oOIzL+fs44m+5QvdMVlgogNTGyYmoyzo13BKNVRlvUpHQTF1fGXE3zqGXFzllvku
         jXqUVWzEHEruhOm8BeEBoktOd6G0lgeXV9oIp5dWzp6QuNV3gLqzmaH4PxyW0fBN/rBV
         +zsGruFnMg5aMG5Wge/sp+iGnJ4BhsAbOqDUDAnAQnk0GOiFAu02FPMcM8L6VsY1t1TA
         /XcNHBZLB0M9iv7MTHQELe+sGnHjH5NSgWxEGF+BnsABclCyvlNs7MaurokY93y2x13v
         xfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=clJNAroYTWV4rFME+VeIhbSZLGr3iQaW6NDSUMyrTgw=;
        b=S96e0H0GpmU+iqxnKq7thIHT/B6BYDZLTUFHnPoyz3YzPn8jDy8rkcQB9ov9yq6qaw
         3xsI3G5jB4Jzhjih+vhenoy9IXSdC6ABKUwLYFzOup39cDXWEqPCet1vbACvzg4KqpU5
         26R68RlN+BGSqmz0BBeUYO8Og40FMpVs1y/6eH1fX7+zZPXlmw6dp3NSUyzZYDPVpXQq
         oujBBHheuf5Vjnw0nOTlgyA1euTPPCoI6Hf08E8putxSohEL7KtvbwBtFzB3teDFGG7K
         zrb26V17EroLzAgjNSwLmVfQLcGZYvRQRGdS64LbVvECIdM4a91C8HC5jP1ztu5AsSvu
         hbQg==
X-Gm-Message-State: AGi0PubXfkzf3u6MEPXlTsLktp6HQB8I/eTPj6bPNUWNwYTcI2E4f97v
        KHGnuqnaGN1dQkQrNNvXqx8=
X-Google-Smtp-Source: APiQypICHuExie1wnsp+D/paEQPShT2cLdtXGr4O+4g8z2a4gWSYVQbESOQWg9hDvuXw7hhw7rx1nA==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr5867075wmo.35.1586538437353;
        Fri, 10 Apr 2020 10:07:17 -0700 (PDT)
Received: from localhost.localdomain (51B6D8A0.dsl.pool.telekom.hu. [81.182.216.160])
        by smtp.gmail.com with ESMTPSA id j68sm3618363wrj.32.2020.04.10.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:07:16 -0700 (PDT)
From:   Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] Replace -EINVAL with a positive error number
Date:   Fri, 10 Apr 2020 19:07:13 +0200
Message-Id: <20200410170713.2029-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 451f2b8b2b3c..d5460eb92c12 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-- 
2.17.1

