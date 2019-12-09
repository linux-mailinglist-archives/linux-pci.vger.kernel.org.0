Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96440117395
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLISMB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:12:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35987 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfLISL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:11:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so17304803wru.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOPwmsVGim8uksddBYEL5Xr/XEk+fQ6sygiouqBeFpU=;
        b=Tts/uxwAulwDWx38JQ7vQN1vchjW9BMQPwqFcz5u8er0ybt0fOUvBHt+WEAB24gXyc
         BlO6xJwA59upCQs0IseN693yMmNMgDbbFgWrWiT8ZWofkwrA7Seq9O/D4Gx//cyDdaGE
         /guIbq5MoYH70/5n63vUCderClZlhJs3YBa2U9WpDRuoNG3S47hAE8+Ww4p9KU6i+ziJ
         sceo5n1ghS7WbisS3mMyOWUi5Kf2+viwAkPdhnJOYSbUXUfLBHgRWi46jnVUHnae9E52
         Wr8TWOQ6BMPwQ+bvP0D1ypo0U6Cun3Y1noijEKy7UPoDC+Idhr8iP2SN8THAoGBBnKww
         bVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOPwmsVGim8uksddBYEL5Xr/XEk+fQ6sygiouqBeFpU=;
        b=mZwed/XVPVpdzuiWkIM4+VjffXbBE11VWlFKdrPVPSQRyu2/Tbu75oSv3emxXuzNIa
         QfbsbMYMFhVdJBm9lQ06xEBEUtqUJnSNyMqjImUwt7SGzNaAtSm7q4l7luaGy8oxIOF9
         Ehim5og6D2LpZJKmZu12+TrvgKRGUeAMFeR1RXmcB3oygrxP5pTr8W+q4Z9JF/XiKr2F
         3PqqrJsZPs9eyEhuo1a4s9czEDbcuVotbxd7m1m4xQlKC/myHND4VQFxk9iRRruc9HRp
         +kkltwc15FdWm6VvRZBp70OsgElmkp/Ume21cc66ap3l7jQc4glIuwmry/g6Zg/h3cLU
         QJ4g==
X-Gm-Message-State: APjAAAVubIHM+9i+HRzBxqPMflzg02ZRHacQ9o5h8BiENx3SyedPbmvJ
        SU2dPNUBX7ec44+i3RQucj6+6jVb1KI=
X-Google-Smtp-Source: APXvYqwd75VErNxunler74D2aYIuUwxtIPPyshTDCbkZm56YpyIMcPHPAkjo50SdxP2In7GjOAaXhw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr3704624wro.264.1575915118236;
        Mon, 09 Dec 2019 10:11:58 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:11:57 -0800 (PST)
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
Subject: [PATCH v3 02/13] dt-bindings: document PASID property for IOMMU masters
Date:   Mon,  9 Dec 2019 19:05:03 +0100
Message-Id: <20191209180514.272727-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
2.24.0

