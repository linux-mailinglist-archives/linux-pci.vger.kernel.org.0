Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85372E7F55
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 11:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLaKTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 05:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaKTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 05:19:17 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B012C061573;
        Thu, 31 Dec 2020 02:18:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n25so12900758pgb.0;
        Thu, 31 Dec 2020 02:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9R2jGV3ELt7e4yRKD7ul8p29a+2uSNEqBXC3W5gt1Gk=;
        b=en66T6zNOVQmN1ObDfufH9C8UVy2z+bsJ3I8JkCTQqM8q2a8CkGzcFGs9d6deSfMFG
         YBcGQ/VDd+dz0fqig7f+kCgdrbxvnpENOPWqX4+XBFRJfHFSgcv8fzoO3i6xa9i0ZMdl
         Eu+aNtXzr6SRRhntTSLvEqqA8Iz9JI9LSZAvajlsP51WjK+irf6EHwsXDiKYz7nQIRgA
         5HNDPOMzVUPn/AChwjuTHmwFbARkkQ90k1j++gPZJFxVdG9KyolFO2SVW8triwEdXxau
         Nq2sgJemiZbYFLPM90meD3ga02JrqE1gcwwoQPYb7t5x7QHkjK/FBqglm3hMrXaYcqlp
         EXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9R2jGV3ELt7e4yRKD7ul8p29a+2uSNEqBXC3W5gt1Gk=;
        b=DQV0HKQsmrs84cseQaLxD3dPRdRln8jrnCx9LTRPzC/NQC/vF/d4uWpIZoPyPgaf7t
         EbWi/VZhd47rj4PlqeIj5YCN+Bgi/RDgiL4TcolLcV+jqZqle56/yyaEsMB4tFtYLTpL
         udGepxcZ5ttT1Lb/+bJONzv20KIslvCM0PPpQHxb4E6Yi4G9OKO+ZHPbl0IOJWJynAB5
         E3PVpFvQEq+i2BkbOseCs6qZaimQGVX0kHut9TH1/WX3Vooe4kkPS2gZaYtym0/Gs6A/
         hNn3BkpdmaRpQIGBRqk9+MHiqG6mR/dxfQqoLciU/xIZpa4DtX2REd6bsz1IFejeDF59
         vZng==
X-Gm-Message-State: AOAM532i4i9Y00PYu+B1HEMh9BNZCBIlGyGMkDdMpRaH/kOLOHFsDegT
        yy4vQqPPI1JBEeOPLcVQ0xUQsOibEFE=
X-Google-Smtp-Source: ABdhPJzJoXvuqusBd5m0e3oR2Tr8yOJqQ0B3YLY9VN4xQnBxERuNBhD3a8nHuatRl2rj7k+5QI7C9g==
X-Received: by 2002:a62:c1c4:0:b029:1a7:efe9:163c with SMTP id i187-20020a62c1c40000b02901a7efe9163cmr30994880pfg.47.1609409916508;
        Thu, 31 Dec 2020 02:18:36 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a141sm45470937pfa.189.2020.12.31.02.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2020 02:18:35 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v5 0/2] PCI: Add new Unisoc PCIe driver
Date:   Thu, 31 Dec 2020 18:18:23 +0800
Message-Id: <1609409905-30721-1-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
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

Changes from v3:
1) Split the property 'sprd,pcie-poweron-syscons' and
   'sprd,pcie-poweroff-syscons' into reset, power domains, phy and so on.

2) Delete the function to get resource 'msi' and 'dbi' which were parsed by the
   DW core.

3) Delete the function 'sprd_pcie_host_init', because the DW core has done it.

Changes from v4:
1) Install 'yamllint' and upgrade dt-schema in order to solve the yamllint and
   dtschema/dtc warnings/errors.

Hongtao Wu (2):
  dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
  PCI: sprd: Add support for Unisoc SoCs' PCIe controller

 .../devicetree/bindings/pci/sprd-pcie.yaml         |  93 +++++++
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c             | 293 +++++++++++++++++++++
 4 files changed, 399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

--
2.7.4

