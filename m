Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35A62496B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiKJScD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 13:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiKJScC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 13:32:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8124AF3C
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g7so4855520lfv.5
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0w6ifh3W55ssxBCHDKhFfL8ApImlsR3PhJUV68KXmQ=;
        b=dqAY6ELHLoYHk8ekMGk/H+RnE1jsvtfHgWAXBq8WzJ2i7SvezqO5FoWS0uUgq+Q1fS
         8TMO7nXrk0QoT18p4SeDD3nxHXHd0YSSxg5Oh7OX3vVVtAzQhFQNg8iBBP5Cf7xNkISi
         zn6IzlS2WugybziDt7Kab0eIHA+XZr0oQ3HcZrZBcz+PF1S2pB1OZWsjjArnzox7Fr0h
         N2hQu81+nTDGi/o4ej8RwoWI/OsMmHC4XG6x4p9b3MLJn4oGnxzbZ3jr7Ox/UuxPZed6
         kAEWOV1lYX4e0KY11k6THC/aWlLwD/eVbdWS5AfRiZx8BstcQqLRcImAI8cxIYl8ORM5
         W7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0w6ifh3W55ssxBCHDKhFfL8ApImlsR3PhJUV68KXmQ=;
        b=kCVdmWW/1EYJPultMPeFYjxyTjcsAvYTEFFW1H2Rno1P4BwyjK88aGyIEL4cj5fRDb
         wdaDWrA2MbiAHwKKhWXnI5XxKxZRTOqZ3RjkvT+55vgz2cBZJz/343sPFvHlevxHt6uw
         cN4xwEFxQFMjVPcS0NbnE+R7Jq+bV6jyEPB4m3WIVJaIf9CC8xMvPIvAziTkiecbbbmG
         mw/ZZJI8Fh/Q/pHVu+i9CdB1x2Ty6QyI6ve8hxqu1ldbY+w/qtr+48vzeBev3TBi7CIQ
         YVFDZdK29EXus704dwN0IsfpZPmtXnyCL0WeBFolbt8QENxlGwgXIO/TW04pYaUVVdZG
         vH7Q==
X-Gm-Message-State: ACrzQf3773+mNZn8U8qluuymM6vS6hRsLBHzrR0UAyDw2RXxn6xd4lS6
        ZzVEe2PsAiBMRUx3fPylDcjlkA==
X-Google-Smtp-Source: AMsMyM4Np8thznuI2huzMD6NT4W7d8cCQMrCPgsi3stR6myY8i6AHx721i8He4MZOJjmA3y4Bu5viQ==
X-Received: by 2002:ac2:4d4c:0:b0:4a4:6e90:c571 with SMTP id 12-20020ac24d4c000000b004a46e90c571mr1741400lfp.570.1668105119880;
        Thu, 10 Nov 2022 10:31:59 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m18-20020a197112000000b004a2550db9ddsm2837087lfc.245.2022.11.10.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:31:59 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/8] PCI/phy: Add support for PCI on sm8350 platform
Date:   Thu, 10 Nov 2022 21:31:50 +0300
Message-Id: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
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

Changes since v2:
 - Rebased onto phy/next
 - Added voltge supplies to the HDK dts file (Johan)

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
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       |  20 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 246 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 164 ++++++++++--
 6 files changed, 481 insertions(+), 18 deletions(-)

-- 
2.35.1

