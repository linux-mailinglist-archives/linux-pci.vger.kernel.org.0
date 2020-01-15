Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34B13C1EA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAOMxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgAOMxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so15645050wru.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3g2nYTO2xQzb0GJuxY8N32scuZW4mZloVEmHa7VH1s=;
        b=GizgJV+NAlkwmPStOaKeLJGVjuw+mNcVnRBGC3KOsPI8Ckz3NtzP81ZW0FXqyGTgmo
         CQSBQ1i/367JhF2Hr9aOyBH7HhwOtRQxxhF1ER/yFhgBYGARKyuYZwnyUOM16f9ZkoHz
         932OC6jTw3G1Yo73aVV7ol9jYuBydFvGU5nbMGRb8wnB/wZMPE3SbC9TXmYjWfC0Hj8w
         toP68qIugnKqfeVmyqApFpJyXHnxypMTrAs0iJBxdz+LQ8B8jT0dBRDD7X39lECHCK9Y
         lz9qLSHufNXYhKd+fOGRYzHa41Bh2IjLy2+y4DlRmvQ2I5XcgoOrSTzHbGvUrovuTt/X
         3gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3g2nYTO2xQzb0GJuxY8N32scuZW4mZloVEmHa7VH1s=;
        b=pwDHYHcYjcAdth9Bndt2h4gTg3NsW+e5ia1vAKCi7+WrIB6NeuoF49G166zS0+y6rz
         DLU3aEylDrWISAtgZcjLq5jQTbHMjacmXhr2pTJLm0FNHhMm7zXm0quTLPf2tTxTh194
         gTo9Rse/ffJk9R9EzBp70y1mLBMPI79s/q0AP1gBivQXEwq9ylUIoQSb+Gxwo2zsc4zZ
         D3pRtSiA23Ew6jETqbMOgsTPvum/e54EliwCaM3WPQ1PEQVv1v5sWBa1u/7fROazPI3G
         uIF2f09PUd7nOqUwpua325UTg1WMs8IF+QcbcAwxIqJhdvoXP9jfFqsuTJu6OrV+Rdpx
         udAA==
X-Gm-Message-State: APjAAAUahPyGNDWWD4Dg4lpZwBkbKLuZkkJen213GMusx4EaHzJWGklV
        VMCXNm8O7D8W2xXkLmgicRWk+PLd8XQ=
X-Google-Smtp-Source: APXvYqwSGcbdAtd5+ica/pXHhp8VLPeN94EbbtkoRsRsPY47afNQboGMHUBtV30+2XDoEbdnJ8V8Ug==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr11624781wrn.140.1579092820130;
        Wed, 15 Jan 2020 04:53:40 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:39 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 11/13] iommu/arm-smmu-v3: Improve add_device() error handling
Date:   Wed, 15 Jan 2020 13:52:37 +0100
Message-Id: <20200115125239.136759-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
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
index 04144b39c4ce..b2b7ba9c4e32 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2827,14 +2827,16 @@ static int arm_smmu_add_device(struct device *dev)
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
 
@@ -2844,13 +2846,25 @@ static int arm_smmu_add_device(struct device *dev)
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
2.24.1

