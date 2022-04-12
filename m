Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B294FE84D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 20:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358796AbiDLTAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 15:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbiDLTAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 15:00:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93551CFEE;
        Tue, 12 Apr 2022 11:58:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j6so14508741qkp.9;
        Tue, 12 Apr 2022 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuwBH94C0n6aA7QlxhA8EuWZbFghowwSP20mti+OFE0=;
        b=ESPesL+ha/VDC3WrnqhfHAxmVJd6vyaeXQYrIEbyIgkDHHSFzvSSRG6aHsHf54kpC1
         haUrOukpFRo2T1pTEo9TFmO5OJOCaIt2fmsEjaDBHUnhnZBGZUR2FHgwkjeqUifabIT+
         SWL9dkwmdYbt6f1OmxymQDv/LVutahk9EbMqCbQv9Hd7+zxvIBujpnYRbdLmVOjX/+1J
         nHpXIz0tL9J/ZPfdnj6au8YmN3L0tdLyoYqqzwxDJe5lhTSnjfL5oV0ch8Kcs+4B5ouf
         wZGB7/Nfva344S2fz8Ycq+cjww060hnnVNuNds9E7+p4tXJ8Shyg2rYix7F03qY8Ei+Q
         hHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuwBH94C0n6aA7QlxhA8EuWZbFghowwSP20mti+OFE0=;
        b=bRqO6H975N51eXLkjEakWtJuvId0ju/vY8WYQG1E1bssoBVHIrJpOLUwZ2QWwfxrEC
         rycFs2h49AMGTeacbKdmAswAVAFB3yjKv6AbjGUXOqSVt/hvSKBJpSVU/0P9kajn6v8P
         ZAKsjQMSpMbHFLFnVVE6UKVMMUk+pmdNRSW6NjW6smE7RADXYNo9W+wmVN1OaQbn3oCw
         x9FQDCwzlxzdLfHQ77AwGIHiqY+gam0M4ecf0PDpZgG3Yo22ukxkNC0flF0y7rJYw5Vg
         FFvXrZoI7Dmy6QWQwNuGChRERRCDZAIpwLz1nFPfLvChdXQUT2Fr+Pt0ZtfdgbjqR6aN
         zn1A==
X-Gm-Message-State: AOAM533658kk2wBU7Y6oMb6yd/MqNygZ2vE9frROE8K4PF+uv17kCLt+
        1zIyEnoI17poHArEGwZ5avc=
X-Google-Smtp-Source: ABdhPJyXUdC+5P5g3zdNWZC3j13Lm90y+xiyQ1BBV27wd2BAygeNwg1QX7qc/UHSRd88hpinwbmSYw==
X-Received: by 2002:a37:9f55:0:b0:69b:f262:bace with SMTP id i82-20020a379f55000000b0069bf262bacemr4228890qke.236.1649789879757;
        Tue, 12 Apr 2022 11:57:59 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a05d200b002f07ed88a54sm1820610qtb.46.2022.04.12.11.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:57:59 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Enable rk356x PCIe controller
Date:   Tue, 12 Apr 2022 14:57:47 -0400
Message-Id: <20220412185751.124783-1-pgwipeout@gmail.com>
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

Peter Geis (4):
  dt-bindings: pci: remove fallback from Rockchip DesignWare binding
  PCI: dwc: rockchip: add legacy interrupt support
  arm64: dts: rockchip: add rk3568 pcie2x1 controller
  arm64: dts: rockchip: enable pcie controller on quartz64-a

 .../bindings/pci/rockchip-dw-pcie.yaml        |  3 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 34 +++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 68 +++++++++++++-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 92 ++++++++++++++++++-
 4 files changed, 189 insertions(+), 8 deletions(-)

-- 
2.25.1

