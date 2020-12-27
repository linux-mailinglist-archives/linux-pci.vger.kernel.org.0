Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD92E313F
	for <lists+linux-pci@lfdr.de>; Sun, 27 Dec 2020 14:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgL0NNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 08:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgL0NNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Dec 2020 08:13:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C276CC061794;
        Sun, 27 Dec 2020 05:12:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l23so5023130pjg.1;
        Sun, 27 Dec 2020 05:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RFDwzYgwwuGZ5Gz6R//Rp+CcioNRUEFb3RimiveR+qs=;
        b=MJq3lZjl5BC/D4aHf9PH1V+ONXVY0q8+u9v9P7GtsA1IjSKW1152FaeeziHBNrYjLh
         PrWxiyfSOZS2nGr2B5uo7v6k8wsA+3kX0aQcFCQ8qP0eNJGz9YRuNHD1aQCSLz7DOLkQ
         v7CTnosv6lP/RXRXKxEyh733584tedksLVDmiBL+ZkinZEaNC1G+LkzHT/LiwtMO9fAW
         aIR6Iu1ieCCbjnvWE5RHpodZTuUMTN8w4mO1q9pTtu+UFBMcZbzw7Z4HY5zjpdIS3Sz3
         t3zkQEH0S6DpKM0qc04tIJHiGQ3Vtyl8rISVOBhVwiqNWQt9AodJ1NTQxSSxxWZq3TpV
         V2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RFDwzYgwwuGZ5Gz6R//Rp+CcioNRUEFb3RimiveR+qs=;
        b=h7eA8rvPqna9ZNEGxcem8UHHz42QtA4413ekZErhrA6duB4Y2rC428VrYnz8VnHiWv
         lDA2r8Gq9NtG52I/1Ii2cABW3hTDXIG5GDEnlPYL6nj+XGS/h2f6zB4r6xYv4dvB+6kf
         fl503pjgRSDw3mruCXGQTqsLTF4V+dRElWu9kRFOE7pdNNL6gZbUh+vViORIfGMIEDdI
         i5Rdt5GYgl03J6eqyd7w6kAQTM+A+jsjw0v1EJ2c0rGIYuCBC6O2Y70A2MVrz0LGWpNS
         r8zv16dj+HuSh0QAQhQ1OVftfY3pB74Rz7h1tpm9+nyZjzn5L/Gqi9hqGBXSINgc1PQL
         ngbw==
X-Gm-Message-State: AOAM531FoLPS8CD27+mxR67hD0AXp04poHBe/ZG8KfH3q9Sc/Nh2qfs1
        jCRWWm0XUlONlWiJrqKlfgO6S7T80Gg=
X-Google-Smtp-Source: ABdhPJx8bl2jLYqBWQHhPNip6NT1uy0IrM7N1ffuF02yCH73ZCKIdqZ8GkI5GRwiIOcX6fwTZDEfFw==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr16431489pjb.236.1609074745592;
        Sun, 27 Dec 2020 05:12:25 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j15sm33510269pfn.180.2020.12.27.05.12.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Dec 2020 05:12:24 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v4 0/2] PCI: Add new Unisoc PCIe driver
Date:   Sun, 27 Dec 2020 21:12:12 +0800
Message-Id: <1609074734-9336-1-git-send-email-wuht06@gmail.com>
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

2) Delete the function to get resource 'msi' and 'dbi' which were parsed by
   the DW core.

3) Delete the function 'sprd_pcie_host_init', because the DW core has done it.

Hongtao Wu (2):
  dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
  PCI: sprd: Add support for Unisoc SoCs' PCIe controller

 .../devicetree/bindings/pci/sprd-pcie.yaml         |  91 +++++++
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c             | 293 +++++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

--
2.7.4

