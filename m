Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41C4FF7C3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 15:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiDMNkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiDMNkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 09:40:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F55F240;
        Wed, 13 Apr 2022 06:37:59 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 75so1391046qkk.8;
        Wed, 13 Apr 2022 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=obH3d/S2lYaSS3WRVgxjm06UjcTOK/XeI/fbZ8tvhu0=;
        b=p0rEdTVHqEwUjYkBCxSFHcimffPFsmL7M+fvAGh4R/FEqKk184GdIfe4UKgalRYNo3
         YVdI+ZOyOgZDfikqiwW0SfsWDA4Xc+n2iIufyo9ucCztXMJmXTq5CJS4y08rR4aWw4WB
         lfDAO8XL8mjMO/pSvRwKBmpt2aQJmC7JkeigeC6BAwhYX6UDJYMeDzF7mtiKXdKaabcJ
         brhRCPFfYP3YCPTMor8G3FsOliN6954u6kvYZ1pYL0rggFF0b+KR010tuFhsD2xp/ak8
         0+XAt6fronujGCN9wBx7fcVzGvokG9bobJkG/0o2IUs5qVXC6b3jYmMbwka9Ld6/+VLV
         5KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=obH3d/S2lYaSS3WRVgxjm06UjcTOK/XeI/fbZ8tvhu0=;
        b=DWOC0wKJcZhZFcRPD1yMbCVOW4Lot9tIwxuhQFY2iO0DLxkIIeVBS1Ve7YO/tT9w5P
         KzLoloHIzeo0ObbZu0N+4mFbRIYSdr3UOztUEQbY0EAWO96CWV+1w6Cwh3qa3VL3QrEC
         T2JqIN8JyzqRxhDPVhh8ESa9ai2IjF+03Mx20njcUmKh2sFPQpGrp9CVn+Hd633aGYTe
         qWBXBDhV58mzghwLA+GWqrBk0GOiOOsSjEffvwRwwAAfo9BmJL0EPfNZlL7Br7JcUR+5
         71dr11u4ow32NEQ+gsQHBWpu2ZXcHO8LEYAQc7LLfpJ6BQjreeQy1WCPCx+L8QI43h1S
         mliw==
X-Gm-Message-State: AOAM531oeu1fCjvTyVYnNMgBfY/s5HvwC8JRRzk+BzwMpcbZioYd7nYX
        ghlJuFrQfQTR2gRWRYZbFxQ=
X-Google-Smtp-Source: ABdhPJwoNltjyMwmDwC9a/qTbbRk6RRmZyCNXPt32NI15GQs+mxl++8piNnzqINFOdcavlai9Lgx/Q==
X-Received: by 2002:a37:614c:0:b0:69a:d30:e936 with SMTP id v73-20020a37614c000000b0069a0d30e936mr6632280qkb.667.1649857078596;
        Wed, 13 Apr 2022 06:37:58 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 143-20020a370795000000b0069c59e1b8eesm790584qkh.10.2022.04.13.06.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:37:58 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Enable rk356x PCIe controller
Date:   Wed, 13 Apr 2022 09:37:27 -0400
Message-Id: <20220413133731.242870-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series enables the DesignWare based PCIe controller on the rk356x
series of chips.
We drop the fallback to the core driver due to compatibility issues.
We add support for legacy interrupts for cards that lack MSI support
(which is partially broken currently).
We then add the device tree nodes to enable PCIe on the Quartz64 Model
A.

Patch 1 drops the snps,dw,pcie fallback from the dt-binding
Patch 2 adds legacy interrupt support to the driver
Patch 3 adds the device tree binding to the rk356x.dtsi
Patch 4 enables the PCIe controller on the Quartz64-A

Changelog:
v2:
- Define PCIE_CLIENT_INTR_STATUS_LEGACY
- Fix PCIE_LEGACY_INT_ENABLE to only enable the RC interrupts
- Add legacy interrupt enable/disable support

Peter Geis (4):
  dt-bindings: pci: remove fallback from Rockchip DesignWare binding
  PCI: dwc: rockchip: add legacy interrupt support
  arm64: dts: rockchip: add rk3568 pcie2x1 controller
  arm64: dts: rockchip: enable pcie controller on quartz64-a

 .../bindings/pci/rockchip-dw-pcie.yaml        |   3 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 +++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  68 +++++++++-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 123 +++++++++++++++++-
 4 files changed, 221 insertions(+), 7 deletions(-)

-- 
2.25.1

