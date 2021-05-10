Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AB3377AE6
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEJEPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:36 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:47001 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhEJEPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:35 -0400
Received: by mail-ej1-f49.google.com with SMTP id u21so22345777ejo.13
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ES7VTSt0mLOOOtyK1uMH/ESz61Of936G331zCp64LY=;
        b=gSfRR5hIj11Mgr7erK9jAQDNLzphgxVc7/FfP3JLPx6uSpFpEmBUrlil7IcdkPW7mi
         eMRq6BxS+FDbyRwa+yFT/639+h++7VP36q6ur+ExF77VuGr9JtwfJSyQplV2EWhWBH3d
         c/L3gsVeQNbr2+3w8IsqroigXu2P73rYMi6rLFSGoxoV6+MoPXckc85bhw1ZoOoAyQr0
         YuCwZjr9+dPplOYizk48/y/GKsN7d3yup+/PdgM8FKXvE/G9tCVAeiJWzA33zYWHG3U2
         62j3KWvhW+miFx/8OyUGl+LLFyAP/lASMeHLiG12F6euuzfu8coixUbqNf6c/xk89vnn
         qidw==
X-Gm-Message-State: AOAM53100r5eBOLbnzPllB42U+xkoF4P4VEE21F+X3/Twiwo2dZa8wNF
        FbJHRc4ST+QFcQJTwN8uoqM=
X-Google-Smtp-Source: ABdhPJzvYeZB0gJ8Hd40URzIwWVyTAi3VNFUZmxcR/jxN5TjnMZNduHfimEhYp/9YuEV8weCphuT1w==
X-Received: by 2002:a17:906:35d2:: with SMTP id p18mr23354318ejb.339.1620620070916;
        Sun, 09 May 2021 21:14:30 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:30 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/11] PCI/P2PDMA: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:19 +0000
Message-Id: <20210510041424.233565-6-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
References: <20210510041424.233565-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/p2pdma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..a1351b3e2c4c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -53,7 +53,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		size = gen_pool_size(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", size);
+	return sysfs_emit(buf, "%zd\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -66,7 +66,7 @@ static ssize_t available_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		avail = gen_pool_avail(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", avail);
+	return sysfs_emit(buf, "%zd\n", avail);
 }
 static DEVICE_ATTR_RO(available);
 
@@ -75,8 +75,7 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 pdev->p2pdma->p2pmem_published);
+	return sysfs_emit(buf, "%d\n", pdev->p2pdma->p2pmem_published);
 }
 static DEVICE_ATTR_RO(published);
 
-- 
2.31.1

