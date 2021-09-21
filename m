Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB9413A30
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 20:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhIUSne (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 14:43:34 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:59415 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233522AbhIUSnb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 14:43:31 -0400
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Skb8mlMr9pQdWSkbPmYt4s; Tue, 21 Sep 2021 20:34:48 +0200
From:   Mark Kettenis <kettenis@openbsd.org>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v5 2/4] dt-bindings: interrupt-controller: msi: Add msi-ranges property
Date:   Tue, 21 Sep 2021 20:34:13 +0200
Message-Id: <20210921183420.436-3-kettenis@openbsd.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921183420.436-1-kettenis@openbsd.org>
References: <20210921183420.436-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCOvKz2df6lbTQqu+3Bzl6OQqAFL8doZ/jDcyRiIzdBreR3rp4pyYwYhBQrErzWcJET/cD3qEqXLVR35034HdpC4xi9pV8rEqfNTZWExb6eNoLKtc+d/
 oj8X1qAWRjgBaqY/AwP+kjppW2QkzcDbHo8Kua8l5oaNhHOT+R1wzGwDLoVqNOrucIqm1KGlteDGMSMk6W4z2Urt+uAAl+ncwICjOpC8WF70pxD1RHI8WP4M
 a9+The1Ekb4MQ9o120gi79ST5HZoaaSQgrdTGLQWCLpoVkWOs33dgNCwcYILc/VCvc3wQGUCGTJaWns0SPzh6JO4s/a5t6T6wZtLI/vEvQvNiBLsPwZw0L89
 WLMM6elSZzwAQDLWlT/F/JU+0o4O/Hjbn7Bmpds2Rn+8w9rbcdOiwNWRti9YHR/vaRbmPzC9Bg0Hnd1EaYRIrsfuPHp39zaSp4k2oR5O8JF0TjK64KKdNEJT
 Iuy0QV12WA3b1WswR85lfMOY2A//xhZpxGW59WmvBIHUfVLmX7Vql0cax0te4u53wOJqnsbMyIq9kuNDSY7+8QESHfczbzk6v9jzS9VWWgp1sFcKJ1+ZElmb
 6lpRcckmpKVVYcfIvaDIvIX6xfsqd2jvuV4h+CLBQ/n1COnDtuXgOab6pn2rKkealROD+Y/jWKNJ9CAW36aQVz0apTjasW0RvuO4VxbVh4VsUCa6s/HO1rhm
 KNZBd3dUqedKenX5nwj+kUNUGSi30RKqcuZx71kbJnm7R24iyMFSxqOIl2sZ8HMrgt+VjoUX/tMBwe7XQ8W48jirGpZIiTeWNc8+6vWXRGMwHwX8Q7RC0A0F
 pFNHN+6rjB7GR02TwAl6XrQlQBplfkrTmzv5VLoNiJGqVxFpf+f7aGM7DxXzWw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the MSI controller binding to add an msi-ranges property
that specifies how MSIs map onto regular interrupts on some other
interrupt controller.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../bindings/interrupt-controller/msi-controller.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
index 58d898d5b943..449d6067ec88 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
@@ -32,6 +32,14 @@ properties:
       Identifies the node as an MSI controller.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  msi-ranges:
+    description:
+      A list of <phandle intspec span> tuples, where "phandle" is the
+      parent interrupt controller, "intspec" is the starting/base
+      interrupt specifier and "span" is the size of the
+      range. Multiple ranges can be provided.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
 dependencies:
   "#msi-cells": [ msi-controller ]
 
-- 
2.33.0

