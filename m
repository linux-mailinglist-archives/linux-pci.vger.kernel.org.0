Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08FE3EF10F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhHQRsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 13:48:19 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:38737 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHQRsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 13:48:19 -0400
Received: by mail-oo1-f42.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso1987498ooe.5;
        Tue, 17 Aug 2021 10:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69BPOBhixVLpjqjlfcu2a3pFxgxoW9SxH8F9r9f4HkU=;
        b=MgQ/yIj2XJ/hVHZM5NxW+igyjv+uHbw3p1jMSQQkBZBp5G9DRhLoVOfMpSN82kil7t
         WlbFGWWol30hz/ZqJ0TqTVRsd7lqblZM2qkKnSh+I6pTMclUDqrEHLAkrSXQJa5k9qyh
         LO7Y5NhMf1IehLRT7hyqOduA8UzzyBzIk+H8uzFZd+AU+5J1pQV9vYhZs4jKUSbfOQGQ
         P0ry7AaXu7vo7PIfwMfI3fD+x9I0yYa45biGOCVJ8ilMHJxHj0j5PjONueN1K/dc6S5J
         W+X1Wxg9EQfyF/72sqDaHxoPvIo5H09WkAmNOHbTjwbSzbNCohCxDv+d0negl75MFGhY
         kipw==
X-Gm-Message-State: AOAM530h5xSh9kJ37dT7NRRw8oGrbrnMf+/+DsTtqKDIoeTWHuheRx2B
        GbC5yT1m31xnCrkElT3XxJPSWppUBQ==
X-Google-Smtp-Source: ABdhPJy8zb4a3ePdH1h4YKzECFd2cKwyl8rb8yFrcTyh/bhHFJq6oYJN4ljYEArgGfxfrXWerORhUw==
X-Received: by 2002:a05:6820:502:: with SMTP id m2mr3473070ooj.47.1629222464913;
        Tue, 17 Aug 2021 10:47:44 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o133sm622812oia.10.2021.08.17.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:47:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: faraday,ftpci100: Fix 'contains' schema usage
Date:   Tue, 17 Aug 2021 12:47:43 -0500
Message-Id: <20210817174743.541353-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 'contains' keyword applies to elements within an array, so
using 'items' only makes sense if the elements of the array are another
array which is not the case for 'compatible' properties.

Looking at the driver, it seems the intent was the condition should be
true when 'faraday,ftpci100' is present, so we can drop
'cortina,gemini-pci'.

Fixes: 2720b991337d ("dt-bindings: PCI: ftpci100: convert faraday,ftpci100 to YAML")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
index fb32f7b55035..92efbf0f1297 100644
--- a/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
+++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
@@ -113,9 +113,7 @@ if:
   properties:
     compatible:
       contains:
-        items:
-          - const: cortina,gemini-pci
-          - const: faraday,ftpci100
+        const: faraday,ftpci100
 then:
   required:
     - interrupt-controller
-- 
2.30.2

