Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8C1DF329
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgEVXsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:35 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:43197 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgEVXsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:35 -0400
Received: by mail-io1-f52.google.com with SMTP id h10so13310298iob.10
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uLCU8sQ+woPP04Xr1GwF1ZBRxRs4r1OQvya7FlG8wW4=;
        b=qXrGrrW+G9RrsBmzlwz4+9eS3xAOynC22eiNnMTrEKVTpDj3ScUVJ6bVJNv2MtaAc0
         OfFdgGGwc/Ph/EjUmlUZDSdvpy935x2g318K/7M0w7zRg8Xi5E39qC1c6f8CpE0p3ccS
         hEQAIcbbWUnl5IT/AieghXDOlqdaglLJGguvjUaFvqGI1J38GYac0uhjZat6hPwar+Pv
         LAY3hp4lTnZlkZpe9PS0I2GYcbiMlOsY3cF3pf5zE+r4IjPa4Oru7IDuwazUtzfhl0ji
         RpOONoqiEBBjP+f7aBIo+LD6xu1nX6S9h3tAvdLlx8518+LEx8lHJJQTja/wiUisEZpO
         214w==
X-Gm-Message-State: AOAM532cYBFkrEpipqImLmx+UNKWUeqfdaByoP+H+BVAzL8DcpP1+xfG
        +NMb/plf/zOtnmBl/E/ilA==
X-Google-Smtp-Source: ABdhPJxkRtGiTmqoiwssYgkBwjOwxjP4j719HNs4rmgXrvUoZ+sAiT1xBDeTsinxHc+YEPlbPyeWWg==
X-Received: by 2002:a6b:3b94:: with SMTP id i142mr5281842ioa.76.1590191313944;
        Fri, 22 May 2020 16:48:33 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/15] PCI controller probe cleanups
Date:   Fri, 22 May 2020 17:48:17 -0600
Message-Id: <20200522234832.954484-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I started this on my last series of dma-ranges rework and am just 
getting back to finishing it. This series simplifies the resource list 
handling in a couple of drivers and converts almost all the remaining 
drivers to use pci_host_probe().

The one holdout is Designware. This is due to the .scan_bus() hook 
which is only used by TI Keystone. I think it could be a fixup instead 
matching on the root bus id. I'm not sure though. See 
ks_pcie_v3_65_scan_bus().

Rob


Rob Herring (15):
  PCI: cadence: Use struct pci_host_bridge.windows list directly
  PCI: mvebu: Use struct pci_host_bridge.windows list directly
  PCI: host-common: Use struct pci_host_bridge.windows list directly
  PCI: brcmstb: Use pci_host_probe() to register host
  PCI: mobiveil: Use pci_host_probe() to register host
  PCI: tegra: Use pci_host_probe() to register host
  PCI: v3: Use pci_host_probe() to register host
  PCI: versatile: Use pci_host_probe() to register host
  PCI: xgene: Use pci_host_probe() to register host
  PCI: altera: Use pci_host_probe() to register host
  PCI: iproc: Use pci_host_probe() to register host
  PCI: rcar: Use pci_host_probe() to register host
  PCI: rockchip: Use pci_host_probe() to register host
  PCI: xilinx-nwl: Use pci_host_probe() to register host
  PCI: xilinx: Use pci_host_probe() to register host

 .../controller/cadence/pcie-cadence-host.c    | 26 ++++----------
 .../controller/mobiveil/pcie-mobiveil-host.c  | 16 +--------
 drivers/pci/controller/pci-host-common.c      | 36 ++++++-------------
 drivers/pci/controller/pci-mvebu.c            | 13 +++----
 drivers/pci/controller/pci-tegra.c            | 11 +-----
 drivers/pci/controller/pci-v3-semi.c          | 13 +------
 drivers/pci/controller/pci-versatile.c        | 14 +-------
 drivers/pci/controller/pci-xgene.c            | 13 +------
 drivers/pci/controller/pcie-altera.c          | 17 +--------
 drivers/pci/controller/pcie-brcmstb.c         | 20 +++--------
 drivers/pci/controller/pcie-iproc.c           | 18 +++-------
 drivers/pci/controller/pcie-iproc.h           |  2 --
 drivers/pci/controller/pcie-rcar-host.c       | 18 +---------
 drivers/pci/controller/pcie-rockchip-host.c   | 18 +++-------
 drivers/pci/controller/pcie-rockchip.h        |  1 -
 drivers/pci/controller/pcie-xilinx-nwl.c      | 14 +-------
 drivers/pci/controller/pcie-xilinx.c          | 13 +------
 17 files changed, 45 insertions(+), 218 deletions(-)

-- 
2.25.1

