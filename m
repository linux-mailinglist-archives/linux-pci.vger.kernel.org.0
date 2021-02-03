Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6F30D58F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 09:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhBCIvJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 03:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhBCIvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 03:51:03 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C02C06174A
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 00:50:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so23234942wrz.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 00:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NUWjl7NyH3UZs4Rb5FI8Yx6yd321ciMD+oIv2jdSvOs=;
        b=K3V/UAXxxKeoouQ1urvQIuUTkcdNnwZ3Cc9FQ08+KYt47woH8jbr0DhdiCkCCQnYnu
         dwfwZ05y0Kj1MagLYx/PPw4kYNJanhjxE+IyY4s7Fj2zfaahOSPZ8pZY3nOrRZwikOHD
         /LVDD5HKleXTnkfpKUVoTSb/O5XGj1F4c95NoOFB1TXK4P/bVIWtGkYQpRkxm3ueBWnT
         B54lej+zNeYsfp5ec3GJO32K9T+a5WtBM/LxV1dShoeN51Rxhr6zLavF8ns5c2Lx5w/k
         UuGELIpedi5U6uACppRmPtswTaKLgxYSU56F+8kNfBMTxzXDsJJ1woX+lHNIXC701h3/
         koVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUWjl7NyH3UZs4Rb5FI8Yx6yd321ciMD+oIv2jdSvOs=;
        b=i/IMkdqyJkJrnO/N+Ts0vR7mrlBcBV/0lZKe50W4ijzW+NV6UJSCB9XClRla9SyzFG
         1ycZsKTw22NrODhLgnEZNg4RWObVLQ07n6gvHORBJ/vhYIcs+O+fVozgCmST42ybIvjG
         NqiLDZJpBEkIbcN0XPs8LrMvHrMGhZE43lBtHOzfq/F7oXbyZMrVbJEqEFzvke9F9jSu
         vpj9qfgdY2GJcznD/Y1chJ4QCQx2bLPIQjZqhdAbd3jGcnjMrniTXFee1A+UmnigHwNQ
         KAXT7UTyplJbqQDA0vfZOmWxPL571L86ilz6ZhI06OYCXHRH6BQGw3yrystVKSD9HVu4
         HoRw==
X-Gm-Message-State: AOAM530SNmNsmr42s9fHYtEymHN2hap5L8wwN/EmMDEnE+V3wIDtxmNg
        Qwsc3MHRQqbDU+1WKejhCbxHuYVRVHs=
X-Google-Smtp-Source: ABdhPJzYm2LL8eCHBXBA38cETQyTiTIDoMqiDLfCPmsPILz7FJ8q/Xq1EJufT2I9Gq0zr8o21Vzu0Q==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr2253618wrn.363.1612342221108;
        Wed, 03 Feb 2021 00:50:21 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:f08f:200e:76bc:9fee? (p200300ea8f1fad00f08f200e76bc9fee.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:f08f:200e:76bc:9fee])
        by smtp.googlemail.com with ESMTPSA id p12sm1695283wmq.1.2021.02.03.00.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:50:20 -0800 (PST)
Subject: [PATCH v2 1/2] PCI/VPD: Remove dead code from sysfs access functions
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
Message-ID: <267eae86-f8a6-6792-a7f8-2c4fd51beedc@gmail.com>
Date:   Wed, 3 Feb 2021 09:48:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
attribute size is set to 0 (unlimited). So let's remove this now
dead code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- no changes
---
 drivers/pci/vpd.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 35559ead2..2096530ce 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -403,13 +403,6 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (bin_attr->size > 0) {
-		if (off > bin_attr->size)
-			count = 0;
-		else if (count > bin_attr->size - off)
-			count = bin_attr->size - off;
-	}
-
 	return pci_read_vpd(dev, off, count, buf);
 }
 
@@ -419,13 +412,6 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (bin_attr->size > 0) {
-		if (off > bin_attr->size)
-			count = 0;
-		else if (count > bin_attr->size - off)
-			count = bin_attr->size - off;
-	}
-
 	return pci_write_vpd(dev, off, count, buf);
 }
 
-- 
2.30.0


