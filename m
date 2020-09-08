Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43758261305
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIHO0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgIHOYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 10:24:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4CDC0619C7;
        Tue,  8 Sep 2020 06:47:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o68so11006871pfg.2;
        Tue, 08 Sep 2020 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=desmngMEhq+Bl6GRnZjRLKp5/Ig6cW8Nd4zeE2+dVOc=;
        b=l1Aw0Yd/TChtCxJhjaAzLpudFcBidJhdzobIQBiONKCPU+qpeJhWJQLTI/tFIrhokQ
         QgDtTJ5YTFZ0xB0l0tZRQNSXwV9Mrtnezr8alEj0OqEWxEsrZ/SbPMVRVzy40DqqkzpJ
         eCBtZQnkOEaTfYPHAFVed2pAJHqLcjcLcZX9NI3BjpIzAD8AvhFM5BePPYVjq+GsSPUe
         JfXqOJ1pgh4VH6RzJ3DZ0fyzP9+j0dLKPP5dWVusN0GWz69IdCnPwKzB1WAcq4ztmKtK
         aE3PHF/ni+0jVEpqMy8HcaS3mv3YI/mqb/+70C8flGcHqaKiSG2Oq9gImD7zTStyLEkC
         18Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=desmngMEhq+Bl6GRnZjRLKp5/Ig6cW8Nd4zeE2+dVOc=;
        b=mS5ZZarigDYGOPbuyzdD5d5DAtElRjkrLrEl8iCMmFvKEsLR7RqvZqRJ7/hj8cVSEH
         uiHaXQr0tyjPSm1bJo3trt68s4Nyofi6ricxLMdWLuS17gwZ3X6t+osF+p3LG2z1iPQF
         cPx0OWwt5DBOg5e3xupJlS3jm9jpT1nKtwFSxxTZEOMTnY4MZXVs5YaQeqSzcyyx1qG1
         lhLhWAMKv6orPveTeEby75kVLKOL4dMiC9rQfFiPttjHiKh7OmJLKpC3VMyEyPU33L69
         pHB1VDNABkf167CZeKlwR6sJeNF8bgCxKRK7xVJyyMIYXKVjDR450Y2yJomhHO8p6E2Y
         E1wA==
X-Gm-Message-State: AOAM532WqkvJjf3/xWu2XlmK4tmOOOfEJ9a0yCyc/UyfJVCHgevK0gdd
        Cgf1F3Gsz6JTsvtMwmM0JqsIgYg0csM=
X-Google-Smtp-Source: ABdhPJxSvaO2jI1NLiCtPBZfROkieHeDyd8FUtXyfbKpJq3gy9asID9vNMGjM7NxOcmigxIi/LQ6dw==
X-Received: by 2002:a63:64c2:: with SMTP id y185mr13694809pgb.125.1599572849347;
        Tue, 08 Sep 2020 06:47:29 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j35sm14852313pgi.91.2020.09.08.06.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 06:47:28 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Billows Wu <billows.wu@unisoc.com>
Subject: [PATCH v2 0/2] PCI: Add new Unisoc PCIe driver
Date:   Tue,  8 Sep 2020 21:47:19 +0800
Message-Id: <1599572841-2652-1-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Billows Wu <billows.wu@unisoc.com>

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

Billows Wu (2):
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

