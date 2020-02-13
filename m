Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3186715C8CD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgBMQwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 11:52:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33060 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgBMQwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 11:52:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so7590235wrt.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJQuvs9RpncXIyFZgaHy4qfH2MXeX4KRcKSd32KW02I=;
        b=FRxKsOeYxspq/g5ZXQF5hEOTsVmnm1UDJ/kf7q2GeDWRw12p5AWgkElZS1ols7kw+s
         dzR64m9v0kLvMIAf98898PxAp+rZRaCMiXSRy4brZInJjJ6/VxxLBWM/9lwa8d1fjk3H
         yrBRTY7uPwUlO475tyPxQAhFP+xtWiu24oAsL9T1/3ejakQNp4NhRXjorbqBjDQvC2x+
         umWUy9HFmYG09ozyz8p/qxPi9s9GL84tQk3qVBpVhVK7pttVl9Or84knSQx1xMAHhIfz
         CLWA+FU1t1lS2HAZfQlHELEJoCgFDSyhJVnwQLLH58Q5mnxUj/vQkHn9bAHIS8WU9hNU
         k79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJQuvs9RpncXIyFZgaHy4qfH2MXeX4KRcKSd32KW02I=;
        b=fJvl8EyLYi3qxK6sif6WDdh0CRQKFQAL2M8OQuNqLNnwE2oWPbygwFTD/rup0fVhpR
         gikKBNHMOXHH0GRessHgLwwN6r5q5asjCvKl2AY77UDWFPybGY14CayVatzP1FcOOqLq
         5x7ds1rWH58dDwC9Mza3QdFjSSVD01ykytBXiivFUVJHmiqiR+8f2FNEyni3MvK8Z+Qd
         4LALTUMFjk683XHe6B8zIyFxA5ijTskIRoy55rBFkieejhZhuUZdTBcBL1rPua56NGNk
         olwIJTWsW5sh8wcqlOo2us7dtVXzjjrfp1x+dqcAvLHPdqqTg8mmOBk3w0TXJ9DyURyb
         VgAw==
X-Gm-Message-State: APjAAAUJWJ75XzFODA1VLQwgzFjF84sI2ab1ArcFGMxPICU9mVUPxMdZ
        gqbkePuwnU5neN8IDu+t//28Ig==
X-Google-Smtp-Source: APXvYqzeNhwO1ySgCH6GebdW+o3FuDqODOSO5w28TGumAGZvm+dXwumkzW+9YyKVQhWGqXpnMT98kw==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr22595338wrt.100.1581612736660;
        Thu, 13 Feb 2020 08:52:16 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:16 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 11/11] Documentation: Generalize the "pci=noats" boot parameter
Date:   Thu, 13 Feb 2020 17:50:49 +0100
Message-Id: <20200213165049.508908-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "pci=noats" kernel parameter disables PCIe ATS globally, and affects
any ATS-capable IOMMU driver. So rather than adding Arm SMMUv3, which
recently gained ATS support, to the list of relevant build options,
simplify the noats description.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d684627..e5fa8d057a3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3606,8 +3606,8 @@
 				on: Turn realloc on
 		realloc		same as realloc=on
 		noari		do not use PCIe ARI.
-		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
-				do not use PCIe ATS (and IOMMU device IOTLB).
+		noats		[PCIE] Do not use PCIe ATS (and IOMMU device
+				IOTLB).
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
-- 
2.25.0

