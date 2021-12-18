Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518A5479B2A
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 15:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhLROKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 09:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhLROKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 09:10:30 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC18C061574
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:30 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u22so7891005lju.7
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFt6X0KER9eQ+C0OYY/wY0eK0N3IsPMop2A/RWQEB+8=;
        b=Sv78hEqnXqXaU8ZsZL+1SFCTGZio744Bua3QkrdgMwABcuhMRNQCQxnq6V0H8yLzRp
         5B8s9Bg9pgSENp2SVlkwmR3dJJ5UqmCa8VuXdkROUho77JvyIz6qXMdYXrjIwnvD9hUZ
         NoqUDmdcjf315URgqhjhttQX7CtaSZsNn1LdQeS5ceZGIPARlPqIBu2tgMdvbnYr1C78
         OxRm0+p4tN+jFDxYauWeNHdWDuTm+9R8RtAXs+U3czmoq+IaFgOmwSkA19Plt9dGVJpY
         rvi3HlXMH9o315iWLFMvnPFvQt43yaHctk/N29/w5Gj/noEQ3P3FRScTEIlLu7UBp0GA
         nZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFt6X0KER9eQ+C0OYY/wY0eK0N3IsPMop2A/RWQEB+8=;
        b=WCMveT+4FF2K70+r+y5iVIIcoIEeZZ3J0gSlyq8vHcm0lp0rbCRo4aWYE+1KrIverm
         YXdLf9Gz89pIISlM1J2JepWO8LCtMhJcjLYmQeA11pHzQkNnfXSxRu4hf7ybNx8nj+l0
         kQBV4sX7H0zlGD7fPp6d7vVV8v++RWh74LmfP82jXOwvsR67TAeQg1ki2Eo1hv+Uej/1
         JEDZBiZ2ZguzfLhVSzHDYA36PThK/7GckfA/rLObOb51uurcqMcBGRzbqI6IkvDpskiB
         e/5shtvcvKERhDQb+VfPH92YSzJ620tT5nEZHTiKojtIhIX5quy2VwX5NPgRBxFkWO+H
         49wg==
X-Gm-Message-State: AOAM5301sOI3rmRJrULuoJt8c5zgp8eOKi/VNRnW/MK0o+L6FyPiXFJ8
        QH2CSKmEbRzD6IBvzgZrdkzG+A==
X-Google-Smtp-Source: ABdhPJxQx+BiEdXyNqa+ssNg1vIeTyUlhVk9vDvWUSuNBVNNrFZigv7asswBCg3rY4KUd29fi861xA==
X-Received: by 2002:a2e:a305:: with SMTP id l5mr7140349lje.73.1639836628838;
        Sat, 18 Dec 2021 06:10:28 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id c2sm145789lfh.189.2021.12.18.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:10:28 -0800 (PST)
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
Subject: [PATCH v5 0/5] qcom: add support for PCIe on SM8450 platform
Date:   Sat, 18 Dec 2021 17:10:19 +0300
Message-Id: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two different PCIe controllers and PHYs on SM8450, one having
one lane and another with two lanes. Add support for both PCIe
controllers

Dependencies:
 - https://lore.kernel.org/linux-arm-msm/20211218140223.500390-1-dmitry.baryshkov@linaro.org/

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

----------------------------------------------------------------
Dmitry Baryshkov (5):
      dt-bindings: pci: qcom: Document PCIe bindings for SM8450
      PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
      PCI: qcom: Add ddrss_sf_tbu flag
      PCI: qcom: Add interconnect support to 2.7.0/1.9.0 ops
      PCI: qcom: Add SM8450 PCIe support

 .../devicetree/bindings/pci/qcom,pcie.txt          |  22 ++++-
 drivers/pci/controller/dwc/pcie-qcom.c             | 101 ++++++++++++++-------
 2 files changed, 91 insertions(+), 32 deletions(-)


