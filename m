Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3266857A7F6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiGSUGc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiGSUGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 16:06:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A225E9C
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 13:06:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by8so15092334ljb.13
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR4x547NI8VcvKHvRqVkj6OJDvRQX46zHm8TN7htZxM=;
        b=h0GE+bUy0Bs2hG4KWpculmCmAtq9Tf91SzX5nS19z7bZ6Nd/D9A1nNawX1MxIebopt
         LEiam3fmKidffAoIqhehXWRfYiEysJ8EF5ABZMN2eocl1WU+diF5L0593z9wCokRJboO
         MOKRoTpv9hyGsZ/t3uSCczJwmj/WZJSDgWVydv+al4C+oRZC5432LMf/kd1L7E3iUSae
         5NbyPF27HUbsrUh3a+GG9Pfu0xRz6MN+rC5pZSRHLiJ59Gm2Bpn2eSWyqX9LlAmwLIv9
         hKKWL5dzyz9YkbT4DGj1I+mdvApk88qaFeKGuo5vAYWtVaogc49m8SFcncmTuDSM7xa8
         AnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR4x547NI8VcvKHvRqVkj6OJDvRQX46zHm8TN7htZxM=;
        b=hpZihCm8s7X+5F2wGyop7B+Zjn/cpSOxAsOyDPoDtHw5/Its5EKYGQvWiap+FbuUWx
         cJ529R/LYNjEzCWCVkrACztdUOtrHOMu4knuhUXW+jSssad/6RZ/5iExXb0+/8MKJX+p
         Ztb4T09WAnsZWr2XOf8URu4GCM0ZjQVG1VmkSDoFmoo3rSWSokHMckJgmgPgCY0giwb0
         6CI2Qr9Fy1RleEyORGcX0LNbXveL0ZNWiEkX2551cJB/yUCvMG8CHT7ZTv/T3UNdQwmv
         Azh1tx6V+6HJlBoCGv1FmRIqi63POYiHgBowKq29e9KgwNG3SJQ7HiB+W8k/BKpMe9qm
         MaiA==
X-Gm-Message-State: AJIora/8MkvOkgF89BtQ4sCdJOE/5eehjVaZmYd9JKXtx947iDA9GdZ3
        A8FLjo68qimxYtiYreg5TVrFsw==
X-Google-Smtp-Source: AGRyM1uN2k7zHqAUY1+FSsTsYkFUJKD+P94mAnDMXjpNWqLKzendZ+rz/y7Oo1C738kWz/FQaNYvEQ==
X-Received: by 2002:a05:651c:17a7:b0:25d:b518:bb38 with SMTP id bn39-20020a05651c17a700b0025db518bb38mr6278008ljb.114.1658261187858;
        Tue, 19 Jul 2022 13:06:27 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b00485caa0f5dfsm3402324lfr.44.2022.07.19.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:06:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH 0/4] PCI: qcom: support using the same PHY for both RC and EP
Date:   Tue, 19 Jul 2022 23:06:22 +0300
Message-Id: <20220719200626.976084-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Programming of QMP PCIe PHYs slightly differs between RC and EP modes.

Currently both qcom and qcom-ep PCIe controllers setup the PHY in the
default mode, making it impossible to select at runtime whether the PHY
should be running in RC or in EP modes. Usually this is not an issue,
since for most devices only the RC mode is used, while for some (SDX55)
the EP mode is used without support for working as the RC.

Some of the Qualcomm platforms would still benefit from being able to
switch between RC and EP depending on the driver being used. While it is
possible to use different compat strings for the PHY depending on the
mode, it seems like an incorrect approach, since the PHY doesn't differ
between usecases. It's the PCIe controller, who should decide how to
configure the PHY.

This patch series implements the ability to select between RC and EP
modes, by allowing the PCIe QMP PHY driver to switch between
programming tables.

Dmitry Baryshkov (4):
  phy: qcom-qmp-pcie: split register tables into primary and secondary
    part
  phy: qcom-qmp-pcie: suppor separate tables for EP mode
  PCI: qcom: call phy_set_mode_ext()
  PCI: qcom-ep: call phy_set_mode_ext()

 drivers/pci/controller/dwc/pcie-qcom-ep.c |   4 +
 drivers/pci/controller/dwc/pcie-qcom.c    |   4 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 155 ++++++++++++----------
 3 files changed, 96 insertions(+), 67 deletions(-)

-- 
2.35.1

