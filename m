Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF271173B2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLISMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:12:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54417 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLISMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:12:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so316596wmj.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dS9JHQoIet3pVv6eJb9kJhT5ftY7Ua+yYZWdXaG4gzo=;
        b=jHfiTmHM4CgLf+XW4XJxxOpTyiR6rKXGw0zHau9qPm2vGLuTDtwrk1iEmqAtUcL0i1
         GsCQCDgc6hgt4m1sndQFIWIIUKcYhL3IICK4Fqklm0GGYn+i8/U2GBdcVIS7kpyJntqK
         FncR+fmMSAF2mS9jczjFGKFdm/z/keSkGM1LzIOx+yDEkmzwl+Dx3hiYEEq7n5Ta8Vlq
         ruclXWt71bhEl2VL8xVlpMVPiSsHqe3n9I6P6HD+ta2oXHF1cST8lor+yZKxe9kLQzqp
         //OPHKtrlucEqJ22vm3L1SlVRIUHcuhtXn61mRWuGRC0y+tJPOx0Fb2FHsmhDZ9xMc1r
         golg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dS9JHQoIet3pVv6eJb9kJhT5ftY7Ua+yYZWdXaG4gzo=;
        b=WegTzgvDqdRid9a9H0s7KKm7+ietCN9z0ojm1bb/BRfwGwoaPwleoPWMPn7/gyeQ56
         Erru0tODxDkvE7QcUh7XUEMVbTUB4TPVEsYzNIscI8rPlZmBPVCOXFd6X1YOqgQa+8Zm
         ms3w4eaFC74hojeboa+u8UWYgETV3HZf9ozVwCw0QhlDVN3TWIU6PVeJqVKjEhbHKkNt
         MTU3t3CWhp/PewrmK4vV/3SnoT+CUZxmqjvsXuIv0wPKrcLFGpdQsbhA2b+1PrbTpqFk
         dMkS6s7dIy1lG5Df1PozFzwW5TzQJD6G1Efp8JOB6wxHvORqby6mZweGyuhDk5+F9Q7b
         OkOw==
X-Gm-Message-State: APjAAAVhfc/7EUQPEPKE708vNC3S0ImUY/zkZBckWrTlJiIDUTciR9Xn
        pjC3ecMS8IwexD2vZ2HIGXMGYnG8OTs=
X-Google-Smtp-Source: APXvYqwLObPVApm61pTMGQoHPnKg/K//kDJoQJn+2j5gLjfljwmJA5TLzDgo+SfmbkrNRrb8uanIWA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr394499wmg.66.1575915127985;
        Mon, 09 Dec 2019 10:12:07 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:12:07 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v3 11/13] iommu/arm-smmu-v3: Improve add_device() error handling
Date:   Mon,  9 Dec 2019 19:05:12 +0100
Message-Id: <20191209180514.272727-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Let add_device() clean up after itself. The iommu_bus_init() function
does call remove_device() on error, but other sites (e.g. of_iommu) do
not.

Don't free level-2 stream tables because we'd have to track if we
allocated each of them or if they are used by other endpoints. It's not
worth the hassle since they are managed resources.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 52adcdfda58b..d20a79108f8a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2836,14 +2836,16 @@ static int arm_smmu_add_device(struct device *dev)
 	for (i = 0; i < master->num_sids; i++) {
 		u32 sid = master->sids[i];
 
-		if (!arm_smmu_sid_in_range(smmu, sid))
-			return -ERANGE;
+		if (!arm_smmu_sid_in_range(smmu, sid)) {
+			ret = -ERANGE;
+			goto err_free_master;
+		}
 
 		/* Ensure l2 strtab is initialised */
 		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
 			ret = arm_smmu_init_l2_strtab(smmu, sid);
 			if (ret)
-				return ret;
+				goto err_free_master;
 		}
 	}
 
@@ -2853,13 +2855,25 @@ static int arm_smmu_add_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
+	ret = iommu_device_link(&smmu->iommu, dev);
+	if (ret)
+		goto err_free_master;
+
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group)) {
-		iommu_group_put(group);
-		iommu_device_link(&smmu->iommu, dev);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto err_unlink;
 	}
 
-	return PTR_ERR_OR_ZERO(group);
+	iommu_group_put(group);
+	return 0;
+
+err_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+err_free_master:
+	kfree(master);
+	fwspec->iommu_priv = NULL;
+	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
-- 
2.24.0

