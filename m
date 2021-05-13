Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9403A37FF90
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhEMVDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 17:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhEMVDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 17:03:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A6C061574
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 14:02:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u133so3789002wmg.1
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hv/3AuEAWRU5UmgUEGy6SQZx0UkkZoKNbV070ZhXdiE=;
        b=sP4NkqxCt9deFh+LhVoiBxNRf+2KnaQ4Hgs4OTBhsliSds1aPrD/bCQTJU/wvHMLNx
         T5zsjLuFX6YCTYK0GPdJYbqIKkU0FwxUMDQ6BZuC2pnb6BGltACN34qby4lUD2IDnHz9
         B8VEI7dqUCkFWWGfBUvlPx7yLa1Hj4RmELizVoJiH/+r/6TORGce5n4pJm4ltTaEJeCp
         GxbKbWZzshyuskVFDP0iISeJKyWVvWU1Xzs97i8NPBdlGMHKUELsN1NyBn/hFlYgw+8l
         VWv3kwCkyQlibURfyh5lJVRnuUwIBakaTfi+Aw7rvcXgv4yPVxJE61t5NzQxdF6/oVRn
         /leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hv/3AuEAWRU5UmgUEGy6SQZx0UkkZoKNbV070ZhXdiE=;
        b=DPUgQtOHeyQS4K8YtiJZtc7p/x+s1B6Q/1cq8U/oz4tNQSXM0ZijpB0JJDi9IQ8ch7
         UYDIlqEOPD+v/KYD8YiqB7Lx2GCE00GBBX26rPPO7pN4IPlVUWSCl7eVYLVNhB1Ifhip
         Pejt40ARHf/PlxoEYjKdQWFQOc69G0cyGb94PqYTBcmJNpX5okkVR1J6RF1BjOcIZfer
         mfcOYJuB4ynsHtN/4xMiQPzepeFCPf7mqSjtuM05mCI4KLZveyblJkkqm8XetXgE0MlG
         Mmjx0+SS0ug6yADl6aSmWkQReRlawxBtd5TUA+JxAiSdfQaYoVimBDlBBCEL9AYNeV+P
         PlLQ==
X-Gm-Message-State: AOAM530iO4QQX7UJuX69SZHpAFjvhBN0eDZRH9vNMpNnMMNHwWcxYibE
        dey1m1jvaFBWtAGBfCXi/uMp52LRwOEUdA==
X-Google-Smtp-Source: ABdhPJw21fXwf9j/Psmv32dz0Jn1oQs9FelhdmOPiAdOvJ7N/PVJ0GnWJPYmq2cSfbfFBkzS5UbVsg==
X-Received: by 2002:a05:600c:154a:: with SMTP id f10mr46907949wmg.31.1620939726977;
        Thu, 13 May 2021 14:02:06 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:dc15:2d50:47c3:384f? (p200300ea8f384600dc152d5047c3384f.dip0.t-ipconnect.de. [2003:ea:8f38:4600:dc15:2d50:47c3:384f])
        by smtp.googlemail.com with ESMTPSA id h13sm3399077wml.26.2021.05.13.14.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 14:02:06 -0700 (PDT)
Subject: [PATCH 5/5] PCI/VPD: Remove pci_vpd member flag
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Message-ID: <e4ef6845-6b23-1646-28a0-d5c5a28347b6@gmail.com>
Date:   Thu, 13 May 2021 23:02:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the flag member and simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 76b20a13a..df252f906 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -29,7 +29,6 @@ struct pci_vpd {
 	const struct pci_vpd_ops *ops;
 	struct mutex	lock;
 	unsigned int	len;
-	u16		flag;
 	u8		cap;
 	unsigned int	valid:1;
 };
@@ -109,10 +108,11 @@ static size_t pci_vpd_size(struct pci_dev *dev)
  * This code has to spin since there is no other notification from the PCI
  * hardware. Since the VPD is often implemented by serial attachment to an
  * EEPROM, it may take many milliseconds to complete.
+ * @set: if true wait for flag to be set, else wait for it to be cleared
  *
  * Returns 0 on success, negative values indicate error.
  */
-static int pci_vpd_wait(struct pci_dev *dev)
+static int pci_vpd_wait(struct pci_dev *dev, bool set)
 {
 	struct pci_vpd *vpd = dev->vpd;
 	unsigned long timeout = jiffies + msecs_to_jiffies(125);
@@ -126,7 +126,7 @@ static int pci_vpd_wait(struct pci_dev *dev)
 		if (ret < 0)
 			return ret;
 
-		if ((status & PCI_VPD_ADDR_F) == vpd->flag)
+		if (!!(status & PCI_VPD_ADDR_F) == set)
 			return 0;
 
 		if (time_after(jiffies, timeout))
@@ -184,8 +184,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 						 pos & ~3);
 		if (ret < 0)
 			break;
-		vpd->flag = PCI_VPD_ADDR_F;
-		ret = pci_vpd_wait(dev);
+		ret = pci_vpd_wait(dev, true);
 		if (ret < 0)
 			break;
 
@@ -249,8 +248,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 		if (ret < 0)
 			break;
 
-		vpd->flag = 0;
-		ret = pci_vpd_wait(dev);
+		ret = pci_vpd_wait(dev, false);
 		if (ret < 0)
 			break;
 
-- 
2.31.1


