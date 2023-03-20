Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3006C1F34
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCTSMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCTSMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:12:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482E43900
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 11:06:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so50173230edb.11
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679335569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X51Q8hDC/IQxJug1cczWInk9U8e16wx3dU7fgiFAEVU=;
        b=s4zbcOKPCoiqw9KRAGBSFZTaJyDewczivh7t8hPtYrCCNn8bqj0J0T2OqKKvvYB9Yj
         sjh0W2oKI4G+eK05iX0on9cf9ERsEgAzAtxsMiSbKSiXG8AEeXYGrfj+/BBUEDNV5Cks
         iIM9K3QIL6ZoIOsIbLETQ9fjlIgn8L3PLqVMlyW4bmbD1ByykROv2swPRVbDSfjM7tAm
         yxsyeAcIt/mXzqN7vvzXDrGWbIx1xhatTOyeO5gTuwLiStGJIOC5aTzEndiMiFkFFfK3
         NFAEIfclPmRhsNlGGeHRf4Y+XC+xAaDHACHQxat0cwf9qtx7onBavwhxCoz/pziy6/Rq
         ceHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X51Q8hDC/IQxJug1cczWInk9U8e16wx3dU7fgiFAEVU=;
        b=PmUAfNpu6s4y67oDAYptHxIY5g+gPSJRP5z0h1hvwXB52B4BT79EAWFxO8GymRcbcS
         3mSp+JQFpn862u7cc+hpsqwVsa49La0GdlH4dlCfA3JMIMzD4GPh5O1HVsp0qd9Q0RPN
         D8shaLEw0pEYdUwE1WgecCRCKR+pdV935r7RzhVHa1mHMTKZcnbl69f6Z/inUVJ4c5NW
         Wkjg6SyKANmuiFxAaRTGDOa9EVHeREdc1iLkIRNgETWv8K+87b7kib4iSzb0WJg62zVa
         hvXXWWVvtjQlli5+GtX42nlJmZTEtCh2SRcIOL3sh2k56lPabbT0d678qSIyEqh8FpA/
         W9mA==
X-Gm-Message-State: AO0yUKUGKzuC205HRiD411feUOzzbHX7VJZrfA9/SFZN3qEJiCqf/D1X
        Mu6Z5U/x6Y1RtueYF0h765L7lQ==
X-Google-Smtp-Source: AK7set8tMwaO8piMMP4jhGMzPqLtV6anULnSbduxtDUNwOaGKChCb4uO9Q+3Akhnoo86JOA6tYtPRQ==
X-Received: by 2002:a17:906:eec2:b0:935:4981:fd0b with SMTP id wu2-20020a170906eec200b009354981fd0bmr3016551ejb.55.1679335569395;
        Mon, 20 Mar 2023 11:06:09 -0700 (PDT)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t14-20020a508d4e000000b004d8287c775fsm5213115edt.8.2023.03.20.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:06:09 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     eric.auger@redhat.com, rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RESEND PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
Date:   Mon, 20 Mar 2023 18:05:29 +0000
Message-Id: <20230320180528.281755-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When setting up DMA for a PCI device, we need to initialize its
iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
this we use pci_for_each_dma_alias() which calls
viot_pci_dev_iommu_init(). This function incorrectly initializes the
fwspec of the bridge instead of the device being configured. Fix it by
passing the original device as context to pci_for_each_dma_alias().

Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This fixes issue (1) reported here:
https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica/

resend: Added linux-pci list
---
 drivers/acpi/viot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index ed752cbbe636..c8025921c129 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
+	struct device *aliased_dev = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
+			return viot_dev_iommu_init(aliased_dev, ep->viommu,
 						   epid);
 		}
 	}
@@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
 {
 	if (dev_is_pci(dev))
 		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, NULL);
+					      viot_pci_dev_iommu_init, dev);
 	else if (dev_is_platform(dev))
 		return viot_mmio_dev_iommu_init(to_platform_device(dev));
 	return -ENODEV;
-- 
2.39.2

