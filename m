Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990EB4C0FED
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 11:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiBWKPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 05:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiBWKPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 05:15:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F588AE79
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 02:14:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j15so30070585lfe.11
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iX1ZeLF9Gp+VwIS5LsBskWHUnS0HsS8oiMTD54YQjTs=;
        b=cHqVkKRV86o2eEV1UeWuU0HCYKCfTt9NSvJOlpYKPl9IlGrDSQVWQ2k3yMroblPKmO
         aiEQ+4gOuPLw8djmpMroDGxy/oquR4pBFG+k0k3ihUBDpieRhzH8OObso5GHcaojKG6N
         a1oM9JdZVss44vjANB5HRt6fSaUMJu9i9HVk/se5jtsEl+Mib/OgHCLteFifmNrMtsnO
         rz0ns9X/xWzChBnUHskS02pqU91bZP+SQ6Ueu61op+g/pfhlYLWb9vaJNokp0V8RmCvD
         GuEacjQ0K3xIj0AVHArdBDZGxB2McOvCIkadx0PUx+4LnEoTMmcxs0eZG+RlovygskK4
         RHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iX1ZeLF9Gp+VwIS5LsBskWHUnS0HsS8oiMTD54YQjTs=;
        b=CI3DGWUGtPpMXWHVC/e7ij39DJOsPAD2K+/HBOhFvAOSwhN152hFQNNmZiqYpchgA3
         DRL0zUdYSR6ZVB2YvjXPTU1PilSlRHFggStPml4puZAVJuIxIfxBdY2lT4UkDmspWhBM
         8J606p+KF/pJv/94MvmheYm8XDjKoApThZgoV/g2J4iRpUmAneJ3K+SWl3hci4zvC9ri
         q6ErqSaGZ+hp43h1WTXr6drMpyNEPzxnzXMZ12DX5vx9zU8lOitJo0T3j1OjOcOj7qXY
         +YDmA8xRl7Y8ARDSLeXlPFxMwOg+Kd9a/72NruT9mFGqKja1aLVncxUkdTiC/k4+NzMi
         n4kA==
X-Gm-Message-State: AOAM530oixdiGrqvOE3cCxhrwujoDQCu7+7eQq3Kk4vYUXVp2dPZkNVO
        HCHr+08NWJ7LV/jbH+3olN/hPg==
X-Google-Smtp-Source: ABdhPJwWGshHSvrjvjn+t34cea1aJ9jvn22/Fm42XQYDA16HH37CePJGkQRrS5SaeSEtyshh8BdztA==
X-Received: by 2002:ac2:562b:0:b0:443:76b5:cb35 with SMTP id b11-20020ac2562b000000b0044376b5cb35mr19392663lff.208.1645611278030;
        Wed, 23 Feb 2022 02:14:38 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.217])
        by smtp.gmail.com with ESMTPSA id s9sm2060256ljd.79.2022.02.23.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 02:14:37 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v6 0/4] qcom: add support for PCIe on SM8450 platform
Date:   Wed, 23 Feb 2022 13:14:31 +0300
Message-Id: <20220223101435.447839-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two different PCIe controllers and PHYs on SM8450, one having
one lane and another with two lanes. Add support for both PCIe
controllers

Changes since v5:
 - Rebase on 5.17-rc1
 - Drop external dependencies. The pipe_clk rework takes too much time
   to be reviewed. SM8450 works with the current pipe_clk multiplexing
   code. Fixing pipe_clk will be handled separately.
 - Drop interconnect support. It will be handled separately for all
   generations requiring interconnect usage.

Changes since v4:
 - Add PCIe1 support
 - Change binding accordingly, to use qcom,pcie-sm8450-pcie0 and
   qcom,pcie-sm8450-pcie1 compatibility strings
 - Rebase on top of (pending) pipe_clock cleanup/rework patchset

Changes since v3:
 - Fix pcie gpios to follow defined schema as noted by Rob
 - Fix commit message according to Bjorn's suggestions

Changes since v2:
 - Remove unnecessary comment in struct qcom_pcie_cfg

Changes since v1:
 - Fix capitalization/wording of PCI patch subjects
 - Add missing gen3x1 specification to PHY table names


Dmitry Baryshkov (4):
  dt-bindings: pci: qcom: Document PCIe bindings for SM8450
  PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
  PCI: qcom: Add ddrss_sf_tbu flag
  PCI: qcom: Add SM8450 PCIe support

 .../devicetree/bindings/pci/qcom,pcie.txt     | 22 ++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 93 ++++++++++++-------
 2 files changed, 83 insertions(+), 32 deletions(-)

-- 
2.34.1

