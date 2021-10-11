Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20B442968B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhJKSMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJKSMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:12:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAC8C061570;
        Mon, 11 Oct 2021 11:10:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so40234pjb.5;
        Mon, 11 Oct 2021 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOpzKqtZkl4vpPBZR8uQl2s3BPZXOsp3vKlUaVIS/Mo=;
        b=NCpPkW2tW+1A9ejqPsw/E89AdQ1IG22gXH4d0M9se1jCFdsfpIKYs4e087pVmidl/e
         q8qXvAKlGq9XLghs8p7T9gx0F4y0R4IX350PxIBQ7mkLYCyILrSZ460YkVB36SdBHikK
         rw3NuJ9e5U1bRxNP0zCAQawqJ7QisUHe8RacVwL6iHNGGS7S7+Ecra7/vN+xVk3XU0gt
         dwP8+iyekUEdEAprLEoIHsnCrxeWBakt7ZC1+zNNyHYBfqOizT3BOii/pEbLivYDE0PA
         etsTVYzI2VFTdzajkhJOd8NRKWRFxzTiyNhBL5CODQz4JBTbgElhcn8JeIQuYbARVDBX
         6L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOpzKqtZkl4vpPBZR8uQl2s3BPZXOsp3vKlUaVIS/Mo=;
        b=HVBStgdDxQ7Tz2N5/tqAcDi0p5i/HSgjkLemb+4Lt96/GJX6hVPIaWvSfsSwjtM9Nm
         yRzAWHiTpA2UzKYoTojci7YMNUc6oLAlFOCB42Hrc6Jyct97w/GZIQRJvq8NuuXx7k5n
         uN58SZmFvUzTEOS3pugZcXpSmhZ/7th5YVgWvBkCbuT74OjFHqSrR+OkuSx4APJFnWwS
         n6HRBqpe/E14Vqu23407Si53buPLNPYMRUKJ9IYkWZrNDja4z1j3TgHqFtWWBGeSrCpU
         6+3MkgsH+nQJPqSBxIFX9V7grGqi8hSErRchD9NMeT63UxdDrPd0lM3ktvmiBSHkeHmk
         X4gA==
X-Gm-Message-State: AOAM531+mq8l7Im65tNYnP7LwDS9MAqy3a4Yu2Rq2F7pVsIJHxAsh8fX
        Srvjq4SjKEx4pJe4nzNd2wM=
X-Google-Smtp-Source: ABdhPJyTTIVV9W/Db1QkVLCqIJwuHX9GWdlAoaPYXja1BJeanTcWGwAAwOoIrYet7aTT3B6sBS+BxQ==
X-Received: by 2002:a17:90b:4a01:: with SMTP id kk1mr552278pjb.208.1633975830306;
        Mon, 11 Oct 2021 11:10:30 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id j16sm8471216pfr.42.2021.10.11.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:10:29 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 18/22] PCI/PME: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Mon, 11 Oct 2021 23:40:14 +0530
Message-Id: <53e9d01d1683ccae66b07a5b7904e2aa124c5aa3.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/pme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 1d0dd77fed3a..24588d0b581f 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -224,7 +224,7 @@ static void pcie_pme_work_fn(struct work_struct *work)
 			break;
 
 		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
-		if (rtsta == (u32) ~0)
+		if (RESPONSE_IS_PCI_ERROR(&rtsta))
 			break;
 
 		if (rtsta & PCI_EXP_RTSTA_PME) {
@@ -274,7 +274,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
 
-	if (rtsta == (u32) ~0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
+	if (RESPONSE_IS_PCI_ERROR(&rtsta) || !(rtsta & PCI_EXP_RTSTA_PME)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return IRQ_NONE;
 	}
-- 
2.25.1

