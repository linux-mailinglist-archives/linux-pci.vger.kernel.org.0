Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D29146A5E1
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 20:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbhLFTro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 14:47:44 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41696 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbhLFTro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 14:47:44 -0500
Received: by mail-oi1-f179.google.com with SMTP id u74so23359703oie.8;
        Mon, 06 Dec 2021 11:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfihAw8tyo1zNh4VJTiAyI88HJdV6X35dks0WWfJL2c=;
        b=GX2MwqEy7FAfBqIfSAUBM2opsBbqq1RoDk+zITpP9iwQzdzZTVjBwRUuyHxx6Yl6v2
         O7sCUALUyk2MEJ5XMmgcJ3lil5nijysDwle4BYV8fkOUO47eIbj7J6T4au8WWpQD5bUS
         /Kvd0w4TlmQpTzJLL8clgr11hA7/JxaJ/3w97pZAeQFnjR2hbYE4IAi8JFBqp594Hc6L
         pSkcmi+/B5+f+5MhMPw0DyV8geLKVbtwyn3JX0X7nRtM2eGEx2bXaLFKZlPPFGzx/xMW
         2PHtq7fWaYoNLM6sWfe4NPjmCn81WcCriW3DsEXc7Jai6Cm6tQOmegCswUoB8wzT6kTE
         Y76g==
X-Gm-Message-State: AOAM532Qst7XQijamUIDb1IHQZhDvm2qH64aJhalGGhy1Tlqy/N+dbXy
        y+weG7ovcJC4TKCQCJ+iHA==
X-Google-Smtp-Source: ABdhPJyJZUdf9lBNZX5yg4nfZjxGo3sVeUe+MvwzhJh5d71jS/HJ0OmZLOwxlAA5ffobrxPzoEozkg==
X-Received: by 2002:a54:4191:: with SMTP id 17mr708499oiy.50.1638819854929;
        Mon, 06 Dec 2021 11:44:14 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s6sm3067855ois.3.2021.12.06.11.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:44:14 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: cdns-ep: Fix 'unevaluatedProperties' warnings
Date:   Mon,  6 Dec 2021 13:44:13 -0600
Message-Id: <20211206194413.2469643-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With 'unevaluatedProperties' support implemented, the TI j721e endpoint
binding example has a warning:

Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.example.dt.yaml: pcie-ep@d000000: Unevaluated properties are not allowed ('max-link-speed', 'num-lanes', 'max-functions' were unexpected)

Adjust where pci-ep.yaml is referenced so that ti,j721e-pci-ep.yaml will
include it.

Cc: Tom Joseph <tjoseph@cadence.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml | 1 -
 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 651eee88989d..e6ef1012a580 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -11,7 +11,6 @@ maintainers:
 
 allOf:
   - $ref: "cdns-pcie-ep.yaml#"
-  - $ref: "pci-ep.yaml#"
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
index 21e8a8849076..baeafda36ebe 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: "cdns-pcie.yaml#"
+  - $ref: "pci-ep.yaml#"
 
 properties:
   cdns,max-outbound-regions:
-- 
2.32.0

