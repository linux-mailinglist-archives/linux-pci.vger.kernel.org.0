Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06867BFBE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 23:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjAYWOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 17:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjAYWOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 17:14:44 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502D5D11B;
        Wed, 25 Jan 2023 14:14:39 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id p19-20020a4a8e93000000b004fe1e423feaso31925ook.12;
        Wed, 25 Jan 2023 14:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4voD50w/+ksxwFcij0Hi2k8GVOMpIV6t4brpPpzQ3Ns=;
        b=kbj8x/2bH4wfNBkmm4fcu67u+PyBjIr0mgujhsH0atwdabBrIcBKgSyiUAaZyUgQjo
         ciE7fYEG5grad/6vCI3z1gd4K9oJ/fDSU8uZa2ZKAhGAIS+bjLtjWJ7qVt8MC2PcRf/A
         xSEtrAlDFCq4ysk6uhcxa1QbkhmLxIc/spcNSt54kp1sP7mPQP40pd3/rpiymjzUrFUK
         qxcJK84z8G/ifDfB070DKGQBR5+GSuOHlFrCjtafWAp6OowlDFz1WHfVSbNOOzt/96ea
         xLEy5b02NmxbNqgeFYfz7IP++F3lYGjZOBL46/f1nHoHg9KSReeIx1ME457tZLg7d97s
         24ug==
X-Gm-Message-State: AFqh2koy0NAN1HANjrwW5dOTshSVG+Y1N/In2UGTCKxq0xW5yh/z8+0V
        sIEV2IfWnelPef9CDh8/iA==
X-Google-Smtp-Source: AMrXdXubJ+vX1qL07aIcv27EdNi8itc03MGifx2WtrqvMZhD+aq19YXuZ3xY7pgZTjfyQEzvlxoE7g==
X-Received: by 2002:a4a:d081:0:b0:4a3:bcce:5b56 with SMTP id i1-20020a4ad081000000b004a3bcce5b56mr16890293oor.3.1674684878654;
        Wed, 25 Jan 2023 14:14:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b43-20020a4a98ee000000b0051134f333d3sm1416928ooj.16.2023.01.25.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:14:38 -0800 (PST)
Received: (nullmailer pid 3058519 invoked by uid 1000);
        Wed, 25 Jan 2023 22:14:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: ti,j721e-pci-host: Simplify 'device-id' schema
Date:   Wed, 25 Jan 2023 16:14:32 -0600
Message-Id: <20230125221432.3058405-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'device-id' is just a scalar value, so just 'enum' is sufficient.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b0513b197d08..3d7aee97353a 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -66,15 +66,11 @@ properties:
     const: 0x104c
 
   device-id:
-    oneOf:
-      - items:
-          - const: 0xb00d
-      - items:
-          - const: 0xb00f
-      - items:
-          - const: 0xb010
-      - items:
-          - const: 0xb013
+    enum:
+      - 0xb00d
+      - 0xb00f
+      - 0xb010
+      - 0xb013
 
   msi-map: true
 
-- 
2.39.0

