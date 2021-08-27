Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57CD3F9D75
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbhH0RQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 13:16:45 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:36585 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239233AbhH0RQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 13:16:44 -0400
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud8.xs4all.net with ESMTPA
        id JfS3mDfw9JWNeJfSJm6c4S; Fri, 27 Aug 2021 19:15:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1630084552; bh=k7m/qqndabCmHEUUSTpBJLvDRdJ6wDBdYGC4IJcEHqg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=kEbW7hGntzF5Jlc+nLLJpOxFMAKouHLlgl0hBGZKaj0cnM4odo2965rDZT3HnLY9M
         VdfK2+7mZxvMGoinDLNLXAi0gsdMNbIITnxVvL8pBW2Q/QTDJ6HvXzxBpL9TJFswDY
         bDWeadawJTkZ8aVicQxgx3+N5DIhjF5TkXDApI/5gAydSoxxyqvB/f/6qZAx1q6bdb
         m2ix4iL3RZnmzoCfp87FHVVyQwNcK6tFrY9wG2TMvX15Xd4TGhb8cxnme/m5KAfrhK
         ZE7zqM/dUhWTMH2LNvkMd3cyAu0VnkVpsNdomw81GT6Sd8szBfPjHVZNtqhjp8XTbE
         Zd1AA4AAIph+A==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] dt-bindings: interrupt-controller: msi: Add msi-ranges property
Date:   Fri, 27 Aug 2021 19:15:27 +0200
Message-Id: <20210827171534.62380-3-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAn0dMlyco3EFhBT6OCPQR7eqkcBtarYOztGBW8b0eEglHGVTauot96M2GTJzoTMcwq4lLkI6NhvhS9anrWKYUAvMdEs8hq5zjSj7KpUQp5RwCbV7Scr
 74Xe9WRBxAUrTxzeJ5HRAybCQx9k7VLnZ9UGg6++B8FvXyhO0uRlkrpBRC6F5v/iRlAP8gkSJz4WlOIeKviCHiSqokisoui1Tr8BrvNm6Z6FpzMc7auw2jaX
 C7Z+9gi1T4wIMvahiBCScSgudcUGyzsieRQNrEGp+gdITWyX5BQovLZPUXTEmGx6LFmg73ZBQeETR+VnLpFmfZmMbuiOsBeEaXy5eGHkxexTQl6XFjSiFC2G
 rW4yMrfRUzDGICii6cNX3atrc3O1nkb2eaUYAaG6Jzgf5FLhlpN7RNmeJ7K2dN3Plg8xoPS0P0Sb2gbchoZLPn/CXy4+/6nQeUCjEYkkuroLtWtdRcOYjV6i
 mFQ6cfM9pvFl689bf/eiA0nscv0WP1qyr564IdhZyg4COIe4/CAswcKbuXygynN8K5bFK5Y+dMqUk1nU/CruO4g/HKTx6hu3fI4Wgkaoxm82A6KbxiXb8yed
 BQFnI42m5tb1urUh191NsRd/hdB6p6WMdms2nt8EPOVIUE3TAVB6gc74Q7CsneQttK7ojn8mAK/tm0fSmlFNkINB65K8naBa7P90p47+jHg7eIe/wRtAZlaT
 BatW6a+ES93YciTBxwIS7toyqKVlfc5xl4hgzsnULwhwQiXGPDoiH8jih7tCVhgJLzgsOot1ZOFl2BffR8uJVfxlNEgWl1CMnbDObZY0JfzFa0uCdQxMsPrv
 u0QiLI4GgIzHbC5GvWg=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

Update the MSI controller binding to add an msi-ranges property
that specifies how MSIs map onto regular interrupts on some other
interrupt controller.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../bindings/interrupt-controller/msi-controller.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
index 5ed6cd46e2e0..bf8b8a7dba09 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
@@ -31,4 +31,12 @@ properties:
       Identifies the node as an MSI controller.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  msi-ranges:
+    description:
+      A list of pairs <intid span>, where "intid" is the specification
+      of the first interrupt (including the phandle for the interrupt
+      controller) that can be used as an MSI, and "span" the size of
+      that range. Multiple ranges can be provided.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
 additionalProperties: true
-- 
2.32.0

