Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B35EBE73
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiI0JYb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiI0JYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:24:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEB9CC8C8
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i26so14752139lfp.11
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=t6VJu8/Wiv6IWB8+BmCNnWaAShjWuGgtnz4D16lWKkA=;
        b=gI68beGbJZoo0vPg2KcWfCFD+IkjfDmW6ssvm6SfL8kvFWUcIfDxDGyYWYt2ekE4qg
         lnmEuBh42pT8CDRomBvhvdo/Rw6jWa8EQZbY8aepey9JCjQOfYC0csEdE4QnM45eO5CF
         TBeufoOX4QRienNaZM+Fkdgc0Zmy/rPTyemlM8zfNl4Lq4TaeYZ6A26WrAfjHIQ8izcT
         c4uEm5EOXSUHpN7JrqiEcDxAfSlE5ZtFuI2Xsw0MtcS2aRw4KMRrxTlSMzeG6+JLQKvY
         E5hSLes2xYLj7JLwLDEARQo9O7dXhE9rqYDJ85ks0HolfhYcghBVdhmsyPk9jrGhopUB
         cvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=t6VJu8/Wiv6IWB8+BmCNnWaAShjWuGgtnz4D16lWKkA=;
        b=0n9Vq8Zrp9K7G1+IBP3cSWn7bPd5ElZ12vcFhzgi0fVRxdVpCyETuV8UKh+aJR2S41
         duldr+VVHC33CjVg7UnD5t0qOQEkeYEHd1hXhv4kcdeEgs7aUkkWKFys2I2haoJJiJxY
         oGSR+jtt5kC3THeVrIVYVdMaYr8i1YRQokBgXHYn/IZF7FzMgAuThl9OeqXT4ai1qtn7
         U5vhUfQbYBvdhfWYYuDJTWDLmiNB8hry8oJYHQWYkdsyltajHJdgXgSoNOsOaK68j9hX
         uuDNlbxsAHlGeHBC8Z5w2WAzOorjKDU2tdixdXJZSDl8GU97lphW7VRI06+t/aQjpWna
         3RGw==
X-Gm-Message-State: ACrzQf0F+94FO3aiWrmCn543Wu9zlMnrZEUtB4Nhqvz4RDhnaZtTCG1+
        fbsIJS7Dx4BC40+wZfi1kYqlVw==
X-Google-Smtp-Source: AMsMyM4bdX/XPynEVd9IO0nlZgabJ7bk+eApg6ueDPdJ8Mp1fK20BKCqZTKf4rm0M/am4akh1nzJzg==
X-Received: by 2002:a05:6512:158b:b0:499:f9b3:df87 with SMTP id bp11-20020a056512158b00b00499f9b3df87mr11410112lfb.451.1664270528074;
        Tue, 27 Sep 2022 02:22:08 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r28-20020a2e8e3c000000b0026c15d60ad1sm104584ljk.132.2022.09.27.02.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:22:07 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v6 0/5] PCI: qcom: Support using the same PHY for both RC and EP
Date:   Tue, 27 Sep 2022 12:22:01 +0300
Message-Id: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
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

Programming of QMP PCIe PHYs slightly differs between RC and EP modes.

Currently both qcom and qcom-ep PCIe controllers setup the PHY in the
default mode, making it impossible to select at runtime whether the PHY
should be running in RC or in EP modes. Usually this is not an issue,
since for most devices only the RC mode is used. Some devices (SDX55)
currently support only the EP mode without supporting the RC mode (at
this moment).

Nevertheless some of the Qualcomm platforms (e.g. the aforementioned
SDX55) would still benefit from being able to switch between RC and EP
depending on the driver being used. While it is possible to use
different compat strings for the PHY depending on the mode, it seems
like an incorrect approach, since the PHY doesn't differ between
usecases. It's the PCIe controller, who should decide how to configure
the PHY.

This patch series implements the ability to select between RC and EP
modes, by allowing the PCIe QMP PHY driver to switch between
programming tables.

This patchseries depends on the header from the pre-6.1 phy/next. Thus
after the 6.1 the PCIe patches can be applied independently of the PHY
part.

Changes since v5:
- Fixed typos (Johan)
- Added R-B tags which I missed in v5

Changes since v4:
- Fixed the possible oops in probe (Johan)
- Renamed the tables struct and individual table fields (Johan)
- Squashed the 'separate funtions' patch to lower the possible
  confusion.

Changes since v3:
- Rebased on top of phy/next to pick in newly defined
  PHY_MODE_PCIE_RC/EP.
- Renamed 'main' to 'common' and 'secondary' to 'extra' to reflect the
  intention of the split (the 'common' tables and the 'extra for the ...
  mode' tables).
- Merged the 'pointer' patch into first and second patches to make them
  more obvious.

Changes since v2:
- Added PHY_SUBMODE_PCIE_RC/EP defines (Vinod),
- Changed `primary' table name to `main', added extra comments
  describing that `secondary' are the additional tables, not required in
  most of the cases (following the suggestion by Johan to rename
  `primary' table),
- Changed secondary tables into the pointers to stop wasting extra
  memory (Vinod),
- Split several functions for programming the PHY using these tables.

Changes since v1:
- Split the if(table) removal to the separate patch
- Expanded commit messages and comments to provide additional details
- Fixed build error on pcie-qcom.c
- Added support for EP mode on sm8450 to demonstrate the usage of this
  patchset

Changes since RFC:
- Fixed the compilation of PCIe EP driver,
- Changed pri/sec names to primary and secondary,
- Added comments regarding usage of secondary_rc/_ep fields.


Dmitry Baryshkov (5):
  phy: qcom-qmp-pcie: split register tables into common and extra parts
  phy: qcom-qmp-pcie: support separate tables for EP mode
  phy: qcom-qmp-pcie: Support SM8450 PCIe1 PHY in EP mode
  PCI: qcom: Setup PHY to work in RC mode
  PCI: qcom-ep: Setup PHY to work in EP mode

 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   5 +
 drivers/pci/controller/dwc/pcie-qcom.c        |   5 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 518 +++++++++++-------
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |   1 +
 4 files changed, 330 insertions(+), 199 deletions(-)

-- 
2.35.1

