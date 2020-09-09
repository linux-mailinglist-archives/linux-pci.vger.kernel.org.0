Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76249262C67
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIIJsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 05:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIJsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 05:48:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F6C061573;
        Wed,  9 Sep 2020 02:48:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so1683535pgh.6;
        Wed, 09 Sep 2020 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HV0bVobcIZ0gjyOIH2sXtQ/z9JBh+ctYWBjRN80Et9k=;
        b=on7PaYSt15SUyw9NXiB2iPy7irBgBzVlFsAXx16w7pIZRYZE+V1ssRaggrQS/NtaN+
         iCj7/N3HFbFOQQAD0E9tvq6FqhhBNaUGFTiBIOzsULVnsY3ltG4jZi7ssFdwH9JDZJgk
         eYaSM/fA3llk0YvzoXiVXEkoZtg3NayaAQj8A+KxcvKrifW+GQRRa3j0Q7eDmqHCH8FG
         4E7+agZOp3TvmYPtsobO+5vCd0aT4WlKtNEDg1huRvT8+l3NqT4T56PBr/+FXvljE5HV
         ai2vnEuNBjk7UdurkUi+jKnCQtag0oZqnu9D2Ue5h7kJRrruMqBxDYIE3gac6Ubcxr7z
         brrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HV0bVobcIZ0gjyOIH2sXtQ/z9JBh+ctYWBjRN80Et9k=;
        b=O6/3wiW87t9VpJ4ZmyB/tMyIVlwTTK2empsi6iBDscQRoXA3YDydqcSCeCMVo8xbk8
         1Ytr7BaFR2fh6inR5FFZ+X3iUL2oult7RGlNl1da4dAGLXcckVQge8O09qMpQVnkq/Nl
         vxdYA7rSNj/fwnZw5I0DkbHjK/8NNP/pCdxFMBBK0VYQJKjnFTZvG6aQqBRKiP0MOMqn
         VieH1oiBR8WlkYNYdhfcqe2qxouWVP4As6hQ7lRSVsMySpajf0ZDdGc7/2ZRx75FsfhH
         HthODJiz3/AASbvgBZ1hTydgg1CR9QrSJRAfcMM+GRJC0ad3qRqxaju42ZPTzGAY5BiT
         80Cw==
X-Gm-Message-State: AOAM530v6/wXAnzuIdCnT6gtflMVSNarfvqapGxEKQZLW8e/lxhH+WYy
        2BcOe+XL+sp4iThOyHvkLySbkdwlszY=
X-Google-Smtp-Source: ABdhPJxOaGWCh5/4OawFpoS59MGkvHgAnYSLgHxdBUfilihkJ8FMWX41TLAr/QS8z3Ks+7/01HtC3A==
X-Received: by 2002:a62:5543:: with SMTP id j64mr86287pfb.45.1599644919759;
        Wed, 09 Sep 2020 02:48:39 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u14sm2224149pfc.203.2020.09.09.02.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:48:39 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v3 0/2] PCI: Add new Unisoc PCIe driver
Date:   Wed,  9 Sep 2020 17:48:30 +0800
Message-Id: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe controller driver for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Changes from v1:
1) Test this patch on top of Rob Herring's 40 part series of DWC clean-ups:
   https://lore.kernel.org/linux-pci/20200821035420.380495-1-robh@kernel.org/

2) Delete empty function

3) Document property "sprd,pcie-poweron-syscons" and
   'sprd,pcie-poweroff-syscons'

4) Delete runtime suspend/resume function

5) Add COMPILE_TEST which CONFIG_PCIE_SPRD depends on

Changes from v2:
1) Change RC mode to host mode in drivers/pci/controller/dwc/Kconfig

2) Change Signed-off-by from Billows Wu to Hongtao Wu

Hongtao Wu (2):
  dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
  PCI: sprd: Add support for Unisoc SoCs' PCIe controller

 .../devicetree/bindings/pci/sprd-pcie.yaml         | 101 +++++++++
 drivers/pci/controller/dwc/Kconfig                 |  13 ++
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c             | 231 +++++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

--
2.7.4

