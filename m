Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D8623FD3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 11:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKJKdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 05:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKJKdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 05:33:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118F126100
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:49 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l12so2354249lfp.6
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmHaFFuqPlWBZ7a9hnHHjYy0tkKVCkmXGUK6hn+sk4k=;
        b=epDRvrPaps44f/b/JtYIpWhtSLsnBTf+X6LbmqrGi1rP+Cmw1SbFXewNjGAZkhLzLl
         TIoSGS9kU0R78tc1bd4MOiTcj0eIUN/4ukQjVSjAzbLE6zByIhuQJiP8MN8qnN+Tu8zf
         JUZ0egxSpeIH5vRcgSILKh/3QpYV+yD0s71KpLi584u9kDDXm0DG2jTqbMeAs/h6DxkX
         wlqXfB/qAc4TPJqed4HzvYLa5tiJ8jwRjYPHtFCbY1l1hMqjc4FBYNSCLJiWyQsWdhbw
         N633tazgUv9tScmtoHap3gowuZ9EM57tW9uxaQmq9tKJw1oZPzng+OyBA4md6TWL2JfY
         YL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmHaFFuqPlWBZ7a9hnHHjYy0tkKVCkmXGUK6hn+sk4k=;
        b=bHAgUHXyKAzuvgpQMOX5JgB8y+4HtJl2qtMAyJJdfS4KX1mhRw9vqugILHqeM727Se
         9KBIvLW9jpK16vguXn5+aVuvr4LDzv8wvVRvHKyqFUn9BGsfrShUwWlKHw9BRfF7Y5tE
         bJbl1TiVKlpDCNp/jZUPErgbZFmOcA54WkxSnmflBs7NTTZKfNyKFUqkoYAknviuY2lv
         fgPsCh+zU9p4yZJ6ahZoBReb2wkXqT8nHThEjjTS7Q51PHpE7ME1YXMieaHIpS8PBQoG
         d6KSHo0YMHTMN94E1pG2qyl3Nn/MyDYAVJsD+8riXv4kCwnwMitS7MmKALrCNFmAEFmw
         f6kQ==
X-Gm-Message-State: ACrzQf2ESr/TCbRnyyOiieGyJNBf0gdsGLPrV7ODKJrEb8dqcfylyNv6
        EqWWrcGXELHn3qgSVgKQdoDiUA==
X-Google-Smtp-Source: AMsMyM6BNtMBJ8+iIxA3EIgwGLU1L5ewA1cPO1EOjClZjd/YBgY3L5NySoSxVl/s1h8z1BjL2RSeMQ==
X-Received: by 2002:a19:5048:0:b0:4b1:3856:e422 with SMTP id z8-20020a195048000000b004b13856e422mr13624125lfj.368.1668076427405;
        Thu, 10 Nov 2022 02:33:47 -0800 (PST)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id p22-20020ac246d6000000b00498f32ae907sm2687837lfo.95.2022.11.10.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:33:47 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/8] PCI/phy: Add support for PCI on sm8350 platform
Date:   Thu, 10 Nov 2022 13:33:37 +0300
Message-Id: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SM8350 is one of the recent Qualcomm platforms which lacks PCIe support.
Use sm8450 PHY tables to add support for the PCIe hosts on Qualcomm SM8350 platform.

Note: the PCIe0 table is based on the lahaina-v2.1.dtsi file, so it
might work incorrectly on earlier SoC revisions.

Dependencies:
- phy/next (for PHY patches only)

Changes since v1:
 - removed pipe/ref clocks from the PCI schema, they are unused now
 - split the sm8450 tables commit into separate split & rename (Bjorn)
 - cleaned up the dtsi file, removing 'power-domain-names' and fixing
   gpio proprety names.

Dmitry Baryshkov (8):
  dt-bindings: PCI: qcom: Add sm8350 to bindings
  dt-bindings: phy: qcom,qmp-pcie: add sm8350 bindings
  PCI: qcom: Add support for SM8350
  phy: qcom-qmp-pcie: split sm8450 gen3 PHY config tables
  phy: qcom-qmp-pcie: rename the sm8450 gen3 PHY config tables
  phy: qcom-qmp-pcie: add support for sm8350 platform
  arm64: dts: qcom: sm8350: add PCIe devices
  arm64: dts: qcom: sm8350-hdk: enable PCIe devices

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  46 ++++
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  22 ++
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       |  16 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 246 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 164 ++++++++++--
 6 files changed, 477 insertions(+), 18 deletions(-)

-- 
2.35.1

