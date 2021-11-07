Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E494473CC
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbhKGQcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 11:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhKGQci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 11:32:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC3C061714;
        Sun,  7 Nov 2021 08:29:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r12so52788189edt.6;
        Sun, 07 Nov 2021 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/ckoETcz+yDddWrcBDGrX7LHLDThJbVjbuAhn7hXgw=;
        b=lRBeGE/xg0a+xoaD5hh8v/nFUW1deAUpUGukxE2AVv8bQ7P2HCTuweeZlopfRUuT6m
         OlppMVp+40Fz3X68LLZvhEQJaxnqtK0mUbikvp/a8jHKCOZkDkFV91qiG0gKoCanraH/
         WcshdJL0pmUyLOK+rQP6XLT1UejHswpAipYDpt0A52gltqXygrERO+AvijtnKqjKRlfg
         CmewquMkGF5oGTMK7wrLZyhoXUPO2OG0P8qzWBlaQoTvq0/4IT5N1DuPb5gnPEOtBr6C
         pIGrCf1J13Swkpeh4edwXiMdQyKrwbGR9bwcTy3kWxLc+lM+/eihVslPYsG5iv9kor3d
         rh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/ckoETcz+yDddWrcBDGrX7LHLDThJbVjbuAhn7hXgw=;
        b=kGheVYFDwU5FT26faaPiWG55MzOSRILctAi3ahQQnksNsj5S2jd1VaTvkB6Xe3Z91D
         pcu83apAh9d6LR0102G9vVDcuRE8KceXRngGHpc+/OrdOraKpKVvOWg+fk0zajboTb95
         sV1Qcli4pQg1JFyGQ+ITwAGoKFpK6vZDvCe/zrVDYFLDYyMeJ2flFiTulK7vUgbiMqh+
         U/L8Fo1g/ItgC1SQ6svMEsFa/av+30GAnS9Jui1WQI/gtAn9FauMpvqHREZXJvRjyzXi
         hLnv6AwV75oL5EznQddVHdJXAvYS2fPRMZ9jeRAWSSf7FfYIeX32rv8oee+B5cFn3GQx
         KsKg==
X-Gm-Message-State: AOAM533dy9/L7pVBRCeJwLHZzgYTw0ifDnk/8t5WfkCJKWL9tsljWMG2
        NHJq1qpQy2zqBHin7BMfYYOxb5A53kg=
X-Google-Smtp-Source: ABdhPJx4PuvDotJ08CW+xFbSbngb6rx7IRub/ESTPR7bXTqFVALcrYeyiWAHmqOQZ+4MJJGb8nBs1g==
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr90720331ejc.555.1636302594559;
        Sun, 07 Nov 2021 08:29:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id hq37sm7195270ejc.116.2021.11.07.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 08:29:54 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 1/5] PCI: Handle NULL value inside pci_upstream_bridge()
Date:   Sun,  7 Nov 2021 17:29:37 +0100
Message-Id: <20211107162941.1196-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107162941.1196-1-refactormyself@gmail.com>
References: <20211107162941.1196-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Return NULL if a NULL pointer is passed into pci_upstream_bridge().

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 include/linux/pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..b087e0b9814e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -695,6 +695,9 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 
 static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 {
+	if (!dev)
+		return NULL;
+
 	dev = pci_physfn(dev);
 	if (pci_is_root_bus(dev->bus))
 		return NULL;
-- 
2.20.1

