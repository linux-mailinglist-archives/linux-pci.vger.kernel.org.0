Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7122F72B3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 07:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAOGFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 01:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbhAOGFm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 01:05:42 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0106C061575;
        Thu, 14 Jan 2021 22:05:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a188so4813900pfa.11;
        Thu, 14 Jan 2021 22:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uNxmF20bYgUoFeuxLQis6xHKwj5Rp1A5sgJ3aaIKLQ4=;
        b=aMKH4O5WpFT7Dc+xWdIqp46yvo1A7iw7ylfqUtRdRh0tuX5DzmbE8urh9DuZ5ONyUn
         073xXdOFi/ysimiN5hqX4Xvh4+bhhFq82ekSlrBQnrR1B73v+CEhYk3c00BYJAkWNuyr
         OH/Ndt0ZRQC3UPwwny6ezb+vBogEe++I7Ogo1udqAdJYZL1vixzNMZ7xI12Pta2A92qu
         OmxTjZ5N5u9S+1Y18xfSBCQU3RIDUled9ro9ruENTXQUtr0lIzdL6vJvTRQdQWoV9IoE
         xQX77RfTfgOhOZuIl7Gi8LVxvkh0uirPoU0UROWwvpXCPQQIXpItqPabncSqI/06YAij
         jzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uNxmF20bYgUoFeuxLQis6xHKwj5Rp1A5sgJ3aaIKLQ4=;
        b=UrfFgAQy3tKfzC7mW55ZNJl7AWPhgjRFi+gEg8fE4C0m0TxaBu6kcgEbHTOmWi+h9R
         9ONPot3+5nYHvwjkhcvoYtYcmPxfLKj+3osYPrt5CB/BQDME+MrU8bDU2dlOnfIRcqTs
         J3J1+X7EGJbV0AcfrgCP+aOLRTorF6LSOEN8WedXx5PzC6HDKI7rTO77TvOl/l7xhHHU
         wnS6g7iDD9AbcaxZOzurE4iezaOCULPhPXIXnFysHZo7Emyu43Irmj3GT2Vo2x5FlGfR
         vdExXGQ9tWcv+1TmBIx4L8PIyjjjYfTk8/sscgIkgmw8GYyzk6zoQ795CmfWg4eXilym
         OeDg==
X-Gm-Message-State: AOAM533VNmER2lF152MolUdnPRoLFgOLPbQp9SYm6ZsXjPY8OJdG2A1v
        m0xfCm2jVmRSRJfvUx+Jnts=
X-Google-Smtp-Source: ABdhPJxqSJVctAl1xO7LHLgMxNuQuWxvmgkBrYiFBdQnB7rd3xUoFISGRkgM2PhlFBXEgOU9kqJHDA==
X-Received: by 2002:aa7:9e43:0:b029:19c:d0ab:2684 with SMTP id z3-20020aa79e430000b029019cd0ab2684mr11344901pfq.42.1610690701475;
        Thu, 14 Jan 2021 22:05:01 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t5sm7051929pjr.22.2021.01.14.22.04.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 22:05:00 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v6 0/2] PCI: Add new Unisoc PCIe driver
Date:   Fri, 15 Jan 2021 14:04:38 +0800
Message-Id: <1610690680-28493-1-git-send-email-wuht06@gmail.com>
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
    dtschema/dtc warnings/errors:

Changes from v5:
1) Change "GPL v2" to "GPL".
2) Remove exit_p wrapper which used to define remove callback.

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

