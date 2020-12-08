Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB02D2A76
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 13:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgLHMO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 07:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgLHMO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 07:14:57 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267CC0613D6
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 04:14:16 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id n7so12038013pgg.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 04:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXCEVGsIRfU3fvhpZQTmT+oIgD4SahenV2U/sWf5U20=;
        b=Xi09IcSDA1msKP7AAF7eX00q2D6OwK6gSBuUGpA2wuYwcJlM9NUbRRx7MdK3LWlVe1
         am4ut+xc79MskNZWxHte1/VTzVh4mvZvLfpCjfwMTu7IYDzPyPIWWo9WV6OnUmNOYDFC
         4IuhYwBaDIumRMtGV5QsUNXyuYO4ltqk8Odtk44VrEHDJMpttLRzeYOYzpIXbO1T+cs0
         alyC22DY/WF+LswKNkyqRxrBHP3cI7PI3I0K64CwXpVwSQo5OAa2Cwbj3/YX8eCNi6pj
         wqztEifvFqaWUfIQz03Jr7h7PvZyjqXv+OFtGkqGnZSXdqvA3LxocB3QuT5+23h+zYUf
         ORow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXCEVGsIRfU3fvhpZQTmT+oIgD4SahenV2U/sWf5U20=;
        b=KJONc/wg0Uv0/EQD/6YeW5DW44aluHaiNTGFQldTO9+U3loEbI5TxiQ8K02LtJEtn/
         wtIsqw/5UtR8JUeD3wiJkJeXcivsODdKXqwYe82TWi5+xv8emZb/nsA6fHGmY0VBH74d
         lwfx3TP49V4pzJDhwaBiWpnTBm4C6sLR1pvicXSrAxddwo1FwAGvnJU3yiaJoxpvrwZ5
         JGMa4JwcpzZLirzQLom387k4UJ2P2OyG8HAKQecDYZSqkERhMCgezg4juognxXD1eIoG
         Xmks+N0hJlPmNRu/UPeLaCXqJfDSH0zXSiOdTVEsn38GXKxzQzBlZVMR3EeyHYdxKyIp
         cKAA==
X-Gm-Message-State: AOAM532nlj35izf9DEHSm9ARQjXnl68cOPisKHy9bV/3NbTaoa5VDh4t
        WKCvV+q4Zok9XN616fgGmb0z
X-Google-Smtp-Source: ABdhPJxnuneQiA43hK45ihID2ydEYhPdh54oYY+0SUSzUCDDyEkIakdavTKKdkMzHJd14OwJrOSf4A==
X-Received: by 2002:a05:6a00:2302:b029:198:4459:e6c9 with SMTP id h2-20020a056a002302b02901984459e6c9mr20125297pfh.33.1607429655887;
        Tue, 08 Dec 2020 04:14:15 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v3sm3489889pjn.7.2020.12.08.04.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:14:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org, truong@codeaurora.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v6 0/3] Add PCIe support for SM8250 SoC
Date:   Tue,  8 Dec 2020 17:43:59 +0530
Message-Id: <20201208121402.178011-1-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series adds PCIe support for Qualcomm SM8250 SoC with relevant PHYs.
There are 3 PCIe instances on this SoC each with different PHYs. The PCIe
controller and PHYs are mostly comaptible with the ones found on SDM845
SoC, hence the old drivers are modified to add the support.

This series has been tested on RB5 board with QCA6391 chipset connected
onboard.

Thanks,
Mani

Changes in v6:

* Dropped phy patches and rebased on top of pci/dwc branch
* Collected reviews from Bjorn

Changes in v5:

* Added Review tags from Rob
* Cleaned up the bdf to sid patch after discussing with Tony

Changes in v4:

* Fixed an issue with tx_tbl_sec in PHY driver

Changes in v3:

* Rebased on top of phy/next
* Renamed ops_sm8250 to ops_1_9_0 to maintain uniformity

Changes in v2:

* Fixed the PHY and PCIe bindings
* Introduced secondary table in PHY driver to abstract out the common configs.
* Used a more generic way of configuring BDF to SID mapping
* Dropped ATU change in favor of a patch spotted by Rob

Manivannan Sadhasivam (3):
  dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
  PCI: qcom: Add SM8250 SoC support
  PCI: qcom: Add support for configuring BDF to SID mapping for SM8250

 .../devicetree/bindings/pci/qcom,pcie.txt     |  6 +-
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c        | 96 +++++++++++++++++++
 3 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.25.1

