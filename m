Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF04870E4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 04:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbiAGDEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 22:04:14 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:40590 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiAGDEN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 22:04:13 -0500
Received: by mail-oo1-f47.google.com with SMTP id q14-20020a056820028e00b002da9808b90fso1157881ood.7;
        Thu, 06 Jan 2022 19:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRRdpZ9XyeRoSURDhbsRSdPKg0YAHn0kW8MW0qcU/Ok=;
        b=dkNgKbjA172J0nCPZs41zP9OOFCbF9Xu5zvLBTzW7+8kzc431y+kyIJIA/hcR2gCzT
         vgIHOg8uwVAvr9Ee55aZ9o6Iq7OFPvGod6dC0uCAlb9q9rznDE3jSF/17Abp0ZLB2naW
         85+sq1LK0fJxzJ9RkhPJyNnOk710kGmZW7JWtfoE8D/MFI0L7piX5FouWqTPgsFJirG3
         kc6iPvAILtTHTQHOpgjrbaW9wW/ETrC1x0C6PDTbHAq9I4N60XOhqy0k063rg2BvYkca
         to2bJjpDOuyU/ImGeVim8UyCvYtX/YZUW8cn5cYhmBifpyVfmav4bPCfjXADJ402RPVO
         PDsg==
X-Gm-Message-State: AOAM532x5RWK+RDXomQ7YwVI7FX0FgT1XjwugHffPGLl6K7LIcCRA85v
        +lF5MuxVZjBv3mF/X8motA==
X-Google-Smtp-Source: ABdhPJzjQEqtgkEpzVNnaKV74GLesLoAZkKasSwjDPm+vTgZMrrflhs+FAic4Khwxa/TtcQPQLGFAw==
X-Received: by 2002:a4a:9647:: with SMTP id r7mr38994015ooi.76.1641524653047;
        Thu, 06 Jan 2022 19:04:13 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id o13sm666388ote.2.2022.01.06.19.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:04:12 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: snps,dw-pcie-ep: Drop conflicting 'max-functions' schema
Date:   Thu,  6 Jan 2022 21:03:57 -0600
Message-Id: <20220107030358.2378221-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'max-functions' is already defined in pci-ep.yaml schema as a uint8 and all
users of it expect an uint8. Drop the conflicting schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index b5935b1b153f..44a0d670b4c3 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -64,10 +64,6 @@ properties:
     maxItems: 1
     deprecated: true
 
-  max-functions:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: maximum number of functions that can be configured
-
 required:
   - reg
   - reg-names
-- 
2.32.0

