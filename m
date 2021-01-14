Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F562F5C68
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 09:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbhANIaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 03:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbhANIaR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 03:30:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE75C061786;
        Thu, 14 Jan 2021 00:29:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ce17so535899pjb.5;
        Thu, 14 Jan 2021 00:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9R2jGV3ELt7e4yRKD7ul8p29a+2uSNEqBXC3W5gt1Gk=;
        b=V7e5LDbJkJbR58fkAEL4hjlfLgteWt83JyppQ6z814W/aVJhxuFoNoRXxnJgZ3Wjsk
         +NMv6l/fvqSCP2TbBTQ6BDEVUK4QO9ltjdvjeNc3fz8wvOg/I7ui++uBvCLF/h8J2KzJ
         xiz4ukrtbms42QyKeSL7EG4rha+t2aPCX8ZDKllEwenBMDYt5mNdLlF9NSZg1ufjXKzG
         Kr2X+29J0ZlG54JY3EYAwnKma7xEB9uF5viLyiFuE13kzMw5NMNo37ZT3mQ5n/Dj7ZBl
         pza0xFvIo2bjmuNtFgfzWzxDQJBL0hiRNO5uWOgwtLd5GoDpL9dFSLLhWZk1z3mPAcE5
         hLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9R2jGV3ELt7e4yRKD7ul8p29a+2uSNEqBXC3W5gt1Gk=;
        b=PqUGX5Quov5Qj9V7extM9DINPyvp5BxUNLbFDmf+axr3xZ0SZJsc6IFupPfGFyBOhS
         W86f7Rw4YQ/seyqoCt8w00m2F9pGJJGLz1SvKuJni2Oq+bcfztXXxwLkQf5zYCsXY2HF
         +zDjqpmQBs9BzLq1Kah1cY8mImEnzAGgT6DpIPcvsdHTPHrommVRNxm6JaBhwSq1Umvh
         tvC90eQyfill22QdS4onbjqTuar725T+PNi0x5odQmDQR1TyCRCYuMWV0ajx753p3vWE
         zhiluan9Ryn1nLEyugZxczbaSqeFvNnn1AMgPDvhYLws0SPG8+TDa7ZEGOmcqa3rD+IR
         Gs9Q==
X-Gm-Message-State: AOAM530iy04j8JSZyUVgk6T9KmvF/cXqWHVjSfRQiG7wh5kexwjkZfE4
        nY1w0eS1CmaoGfbFuPEa+1k=
X-Google-Smtp-Source: ABdhPJy5BFtnIYW3FZVtRKKO0zBt0IaGmJisHU/iiVqbjsPtKiV511XFyWtRhXAc8PYkN/713VpuQw==
X-Received: by 2002:a17:90a:7e90:: with SMTP id j16mr3810251pjl.163.1610612977112;
        Thu, 14 Jan 2021 00:29:37 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x22sm4776888pfc.19.2021.01.14.00.29.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 00:29:36 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [RESEND PATCH v5 0/2] PCI: Add new Unisoc PCIe driver
Date:   Thu, 14 Jan 2021 16:29:26 +0800
Message-Id: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
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

