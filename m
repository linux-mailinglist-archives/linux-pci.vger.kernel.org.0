Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0780C50CBBD
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiDWP1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiDWP1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:27:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3A34B98;
        Sat, 23 Apr 2022 08:24:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id fu34so7552330qtb.8;
        Sat, 23 Apr 2022 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLbC7pdDC1pftlDsSAPppqPquRIxG4vESMwZRNDZe9o=;
        b=Y9EGE09ejLufncSbbMzMQwFHCfQQPutN+srK2CbRmo4/UsDQeh61haozgbBk4qLcv3
         5Lcxf4IBCUETkujemwhIZRzser7j5LuxnwBPeCmVINYxUUraiFNK8cBn0QZn/wHEBb73
         XqxCFrG+Hdd2/9b/EgTgF3aq1OJnWQUe+e7L+/vEmmXuMBkEsqM9o4Y9so8XJp3nhQE1
         5pVywDRnvO3HFBO/FB/3sFZxsQ90cX5YBlE/jWD2r7jHX+MWwGGGJ4u0i3ek3bx8cjZL
         sqAI/48HkilGpzakatcYpR1y49SZCPCYtwCA/BJcTgE4BdSGLxM0b9agr/1nJQ+NrF5z
         nSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLbC7pdDC1pftlDsSAPppqPquRIxG4vESMwZRNDZe9o=;
        b=3RZ+07zvGpLc08ibFaUS1RpEVwFvfSQ9ohk25Kdm8lu9/HKseWrChObd+5xmxCsR3z
         zakUm9Dix0bD4wUObUSc2y5y70BPc95D+udQWmC64IJqj3bIsXFhOU4vjLSNMETOAB+A
         trvosB+dIjEfINl7qHW8FlUo5QGvgRk7LWE1/btzqXIVZxgwgLwKuFtq90KfStx89Ims
         HihhUA7SU62ibnz1LFd/Kfx6sDOr/oLymNYYaW4Ap1JSeQGFxkWaICZ6gBRQDzacY1Ko
         o7Xpas+atpRWUyDsVSI+7bY4zDvTfi7r1BzLZGCklY6gFAhbtB9b9FkrefTSTJyv9D1d
         fdpQ==
X-Gm-Message-State: AOAM531IZ3A+Sh8AAirhJFB9ma2UTiMPcjzSbfAwpLzz6BfbaAN0MkHy
        l7LHksVlCcZWe0HS8/IqUF0X4tj/q12J+g==
X-Google-Smtp-Source: ABdhPJzsgZ/C+xK+RUOpKmXowUiTSShH+imJOmy1G4yZoWTsFp2gRG1sIA2Qunfe0n+wMx7lkJjb4Q==
X-Received: by 2002:a05:622a:6114:b0:2f0:ffc8:53f8 with SMTP id hg20-20020a05622a611400b002f0ffc853f8mr6769395qtb.681.1650727446594;
        Sat, 23 Apr 2022 08:24:06 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id y6-20020a05622a004600b002f33ba280cbsm3184165qtw.8.2022.04.23.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:24:06 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] Enable rk356x PCIe controller
Date:   Sat, 23 Apr 2022 11:23:58 -0400
Message-Id: <20220423152403.1681222-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series enables the DesignWare based PCIe controller on the rk356x
series of chips.
We drop the fallback to the core driver due to compatibility issues.
We reset the PCIe controller at driver probe to prevent issues in the
future when firmware / kexec leaves the controller in an unknown state.
We add support for legacy interrupts for cards that lack MSI support
(which is partially broken currently).
We then add the device tree nodes to enable PCIe on the Quartz64 Model
A.

Patch 1 drops the snps,dw,pcie fallback from the dt-binding
Patch 2 resets the PCIe controller to prevent configuration bugs
Patch 3 adds legacy interrupt support to the driver
Patch 4 adds the device tree binding to the rk356x.dtsi
Patch 5 enables the PCIe controller on the Quartz64-A

Changelog:
v8:
- add core reset patch
- simplify irq enable/disable functions
- drop spinlock
- only enable/disable irq requested
- only pass the irq register bits used to irq functions

Changelog:
v7:
- drop assigned-clocks

v6:
- fix a ranges issue
- point to gic instead of its

v5:
- fix incorrect series (apologies for the v4 spam)

v4:
- drop the ITS modification, poor compatibility is better than
  completely broken

v3:
- drop select node from dt-binding
- convert to for_each_set_bit
- convert to generic_handle_domain_irq
- drop unncessary dev_err
- reorder irq_chip items
- change to level_irq
- install the handler after initializing the domain

v2:
- Define PCIE_CLIENT_INTR_STATUS_LEGACY
- Fix PCIE_LEGACY_INT_ENABLE to only enable the RC interrupts
- Add legacy interrupt enable/disable support

Peter Geis (5):
  dt-bindings: pci: remove fallback from Rockchip DesignWare binding
  PCI: dwc: rockchip: reset core at driver probe
  PCI: dwc: rockchip: add legacy interrupt support
  arm64: dts: rockchip: add rk3568 pcie2x1 controller
  arm64: dts: rockchip: enable pcie controller on quartz64-a

 .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 ++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  52 ++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 114 +++++++++++++++---
 4 files changed, 185 insertions(+), 27 deletions(-)

-- 
2.25.1

