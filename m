Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77A15C89E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBMQwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 11:52:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38243 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgBMQwH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 11:52:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so7544226wmj.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXCUGqeL6PbA336GlcM8rHQqOkBRfH65mxhuhA/oiUg=;
        b=FATGPw/03i+6ra7pZ+0f2Yx7d0nkjAHHARTnqpWONoRS28EzIc1UyHX9MFMwcYzjMO
         tDZF/Te4B8oxJVrV1QVr1LCSEri3Tg2n5xWLUhn1au776Ax4XiUmQ2kdo7lRUa6qX1Sx
         /Fy56EkZGaDzdzOVIv1VC7bH47seMnoM/b2J6jXZAxmX5hqaaoNdLx2scUViX1CzZjFB
         e+L7Uz0O+ni5Lcnojs3FGqgeQ9Nl7VMoe0T+RV7D5e7qrYVSitpvavCEIt6HXReEVnj5
         /n1chMpOz0k3HzMYg+rmm+sEkqhCAl9Zp8e+q8evyaL6NW/jWEpQKBfb0sQC3GI0RrPY
         +d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXCUGqeL6PbA336GlcM8rHQqOkBRfH65mxhuhA/oiUg=;
        b=nosc9DoWt11i/KyZmt0aTQAb2Sf8yi7By7JjdeCNJLB5pN9FVTeQX4QIxZHj4Nrcs7
         ZK3H0Yc1Q+UXraMcgsF29V1HzLaGJrfjT+VEQHgeKFcJooxgCaQjdNSoOTrB2x8GY6vt
         j2GF81WJAcmotycJ04Hh8Nqixo/ENE6ATqJ8TFJ/SPBGzavLd2qcg5pAAGQImOFT8AwT
         rqQ6tiny8Gk2rXToPPpJN5C4qeK4jW/V05TDrmT5lMz/vjLOxxNKhf96oOBW1kO6+xA3
         wYgE83U7yhLWTsgWFLE0eRj/IuWgFjOAcLSxSbHs5tA8ST5AwEaR7JzdV80KhaZs8u8h
         wrAg==
X-Gm-Message-State: APjAAAVvQrlP3q7BWElJsix+ifrLgaFlExIque/RLdFpi04+FfccFLPy
        z2WsLw5w6+oAumHojYrJRXp5QdmBQi4=
X-Google-Smtp-Source: APXvYqzT+gxKpbYpQdrXRe7VcscUkXpdsiUrg5UigA1Q8dxYZpS/a2crEVA74fADKvuMRYM9+kU+PQ==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr6554015wmi.14.1581612725090;
        Thu, 13 Feb 2020 08:52:05 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:04 -0800 (PST)
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
Subject: [PATCH 01/11] dt-bindings: PCI: generic: Add ats-supported property
Date:   Thu, 13 Feb 2020 17:50:39 +0100
Message-Id: <20200213165049.508908-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a way for firmware to tell the OS that ATS is supported by the PCI
root complex. An endpoint with ATS enabled may send Translation Requests
and Translated Memory Requests, which look just like Normal Memory
Requests with a non-zero AT field. So a root controller that ignores the
AT field may simply forward the request to the IOMMU as a Normal Memory
Request, which could end badly. In any case, the endpoint will be
unusable.

The ats-supported property allows the OS to only enable ATS in endpoints
if the root controller can handle ATS requests. Only add the property to
pcie-host-ecam-generic for the moment. For non-generic root controllers,
availability of ATS can be inferred from the compatible string.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 47353d0cd394..7d40edd7f1ef 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -107,6 +107,12 @@ properties:
 
   dma-coherent: true
 
+  ats-supported:
+    description:
+      Indicates that a PCIe host controller supports ATS, and can handle Memory
+      Requests with Address Type (AT).
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.25.0

