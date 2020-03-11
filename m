Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41E11818A4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 13:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgCKMrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 08:47:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35184 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgCKMrL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 08:47:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so1978800wmi.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0rLUPpWc9LKXF0i9+CPpLN+OwQQCuUUQ2gfv2HulHQ=;
        b=IMq0GOglrv9AJ7IWePlqPKh+g5vEP7KPGWHNuTRmuqqvl++Phj5Ie3+A+QfEKkME3h
         q0vWho6oLDy9c22giASuCH1G1T6he+iSuHY/0OPrxfchkouzillYMOGGlzBA9bwKR7Yg
         +I0CgBIjKYUYCNZqgojagWqC+afKYcAZQQapMTNAk/850hRMXduZJO1Etpt2EYWQCcUy
         n3ofi2ltjHGzGZBjILh2yTVAHr185N6iaj4H1T9AvACvPv+DIvL+M85edL84HEByBf8K
         uVCJ+BkBjMVx15RAWG7GqnxYs9Z1XwTzh1D54MLnPmoo3LAkRQYN2UwFDW+zLVcZypwF
         ZfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0rLUPpWc9LKXF0i9+CPpLN+OwQQCuUUQ2gfv2HulHQ=;
        b=VVsmPk1k2rjKPYLMe80Lf7LzAUySzxRv1iItSw8B10Po6E1SiBMME9XYpVfgjFZZ/t
         MLuMvTORM0TmvTr6fge7otG5gWPjwm5DLIezG0E0cpNLGPbIS4bRU2RF8CvfYZNpUljm
         JAO0moBpmr8kvusTub/NkFC+ph8gSy5/AtHbhZBIY5PiS/V6TbELiS7p6ZUZahQEZoxe
         s61l4PGmTjK4i2B75pUHJqrDIQp2FWc7UXtSO5Jfa0KxZOt/upWGIVRUO01onTwKw4NI
         YnP/4NMq0ObkNOjgRFa5ICiNIjbHZhnE3Jim4UnPNI1XoYz/rrm5ZCgLAswOVkDUoiTf
         5Wnw==
X-Gm-Message-State: ANhLgQ0faS/05XdC6F12zDlGDPlyQZSou8oqeiU8jSTrVOMIXVSSMFnT
        mGSnG75AHXE8De1+qvYj8EOMrA==
X-Google-Smtp-Source: ADFU+vtSp3bp4YHfuXWS38IAA5q6tgH8hB5aWJ3nzhD3eOkPVBueydoPmuaFZUj0SnvU9SNNjQlTgg==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr3678319wmi.119.1583930829492;
        Wed, 11 Mar 2020 05:47:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:09 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 11/11] Documentation: Generalize the "pci=noats" boot parameter
Date:   Wed, 11 Mar 2020 13:45:06 +0100
Message-Id: <20200311124506.208376-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
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
index c07815d230bc..3e17ddb76731 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3610,8 +3610,8 @@
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
2.25.1

