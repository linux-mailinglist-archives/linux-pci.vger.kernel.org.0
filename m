Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90BC3C9AC4
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbhGOIoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbhGOIoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 04:44:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D17C06175F
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 01:41:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m2so6714013wrq.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1+fNENkU/XHttt7NhYYEAfDEeUZHkkRiUlgPrZKXBJQ=;
        b=HgHCAX5OMXpXOGM/5g6uTzOHGmFD5nr06iVYtRqE+YrdwFZnypel0nNPK3TO5m2ArU
         OUTdi5l5UlHu4QMFd4QoWfMJKBa4rU0dw2/dViDfj/au3e6aE6YemLK3XO43n+yTgAME
         dLsTxCV6sEvCzPAK8NVm6OrdnMdh2QoGtRoV04Aun/lDgRv5UXkezEU4ggNNN023du4M
         UiVf1K4VTVE91kUNvbjI+JuqFv1lUqPlOIejgnpBhhB5fvwAKyfnFE0QFp3ToG5dptbC
         WQDcPbT2Xv98gExSeoOjEMWpuheekD8r2DOIcatNQF42sJzvnsqlN1whe3+MaL6ZvMfV
         MRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1+fNENkU/XHttt7NhYYEAfDEeUZHkkRiUlgPrZKXBJQ=;
        b=o+rG78NwKil9N2DWvvMgCOF5EvKeCyAEIKGUUgU4GD/Lxn5zjmh+CwNPQaWwy/uXcv
         OC0r84HmEKxbl/+LPoobOhrNQJaI8cspsBx2EVPXV81/tOUiq03WjSa09ivph16pQGaf
         1VFxQZKFi2jCVJCeI1oBmuOuxcsILHSctVpYVojmV7xPm32ztDV8xTGptgz5vygbpc5W
         YsQ6hpB87KLxkIQAm4FhWovRGwKVdRdYo3FZUpvRCdXHo9onQWZk8y4LIiDclhfvFsFe
         u8qYnlDlCPmZG8KmVHIBxgsCCOQD5Rd1qj1j8YsW/ZdT4JwSp6HaYvOgbWwsHgEwE/SR
         cF+A==
X-Gm-Message-State: AOAM5308hSdSuZfg3zO5CzrLjsERpKMjtg6aaLFLsJYDXFWPEsgfi3Xk
        7454Ldida6eqmQqJyRBEZAk0YFooDl4HTw==
X-Google-Smtp-Source: ABdhPJy/pEmuglJa6lVfD2+bOm0dlt3+jDlhXnozonD7eAms0EeI77Md7j6JmWD1YlXuK2eFI7+CWg==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr4042001wrs.405.1626338474567;
        Thu, 15 Jul 2021 01:41:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3f:3d00:a44e:35f:5dc8:75e? (p200300ea8f3f3d00a44e035f5dc8075e.dip0.t-ipconnect.de. [2003:ea:8f3f:3d00:a44e:35f:5dc8:75e])
        by smtp.googlemail.com with ESMTPSA id p4sm5757799wrt.23.2021.07.15.01.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:41:14 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Treat tag 0xff as indicator for missing VPD EPROM
Message-ID: <8de8c906-9284-93b9-bb44-4ffdc3470740@gmail.com>
Date:   Thu, 15 Jul 2021 10:41:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First tag being read as 0xff indicates a missing VPD EPROM, same as 0x00.
The latter case we handle properly already, so let's handle 0x00 here too.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 26bf7c877..6a32d938d 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -78,8 +78,8 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
 
-		if (!header[0] && !off) {
-			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
+		if ((!header[0] || header[0] == 0xff) && !off) {
+			pci_info(dev, "Invalid VPD tag 00/FF, assume missing optional VPD EPROM\n");
 			return 0;
 		}
 
-- 
2.32.0

