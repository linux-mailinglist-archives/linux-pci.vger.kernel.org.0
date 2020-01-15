Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44013C1C9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAOMxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:53:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAOMxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 07:53:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so15559947wro.9
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
        b=RQa6zVa9SRTjAkDpWaeNQ+TzHNaqSmjwUNjLiSStgQQFU8m1OhdHW06usASKfswEOm
         ekBnCK32y0eGel6xTuDdUakkQQN3qPA3G8RZ2bB2/vEsRD4EoWf2rDFY7CHKqlFY4vh0
         QQFCA9QYc73ULV1UlWEobvL9/no+9Vz/XZYY2Tj674ONdjmt9oZZufAB1mBcKnbhBt2q
         4ZyVannnpIUGVhmPOs8HxT18d9vQXPh7dxHC9oOgWg1bO+r8Uh6hZp5mpAIPltKup6q6
         726G40en2MsW4RUUOKkrDY94g3Urf6AAlYT9SgfBjoDblDCkp9GNBhcmObIfka7aytXi
         sROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
        b=SMa7wEc3p4Wip4b9nOaPdvabed5JAQWNoC96eaOHEkGncfnMI1LV1fKUfc1u3jby35
         SefXiJvJ0esWKGvaENfI1x2Y9BIi+jtrfHW/FCljFg8mumhIxT7lvHO5Uisa2jd0SeHz
         5p87HpbQ2B27ZHkrceZGfW6ATdGemiLNEw8SXpicGF+Zdji/3c5sawRJu2O7H54Qu0Jd
         6uHa9c2r0+tmTIVEhLjhtmZ7nLaK+nkx9qnve/Bk/25m/Y0MzUTGCuioIiKBz/eb9aVk
         6jgBOUetSBxgpm7aS9c5nsdUuGkG/3MPJhuVYnfN5kx8J1QDLRdn83O8iB47Ggvqb0Yr
         vm+g==
X-Gm-Message-State: APjAAAUrd//gXiF0bcaN1cAAI8ftG5VpGaNIBZGDKfDa3VaX+7bku+Dc
        ihEeSXJf2kD8frWWE3JFqE3DNxe2zm8=
X-Google-Smtp-Source: APXvYqzMgS/+4YiEL+CRzGGcAhTGiJstPbrqmMFBjWd9wKtGLhNavA3EcOaksZRO/N8Ru4NFTMuSgQ==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr32846130wrx.141.1579092809778;
        Wed, 15 Jan 2020 04:53:29 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:29 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 02/13] dt-bindings: document PASID property for IOMMU masters
Date:   Wed, 15 Jan 2020 13:52:28 +0100
Message-Id: <20200115125239.136759-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.24.1

