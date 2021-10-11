Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B624295CD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhJKRi1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhJKRiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:38:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD3C061570;
        Mon, 11 Oct 2021 10:36:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g5so8761499plg.1;
        Mon, 11 Oct 2021 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJzzZJUwpzeKQJlZIVOTzoqmYp8CWlcv3F3YYYU8MOg=;
        b=UQY5fuaeniwoPT/xwHQ3Ao7FeWJFVAhorTY5szyrGdLOGVxLcMbAyI4cuBXif1/HZV
         /PdEKOkP4XWO0c1FKucvGnQLn0BCRsberthTXZxRsm1u3v89wk2oZ3zOnqs9s4ya43NQ
         XWiezH28+9l/P3xR5zTpFmo1T95D98vsV/3nNl6990Qagg8v+WrADDXJx/HGiSOFn4hX
         5XoI5q9TiV72vLFs2lDVIeFnusAPqBeanD8oUQ+lBrDxUns/MCcRe2AdoX2SLgHAI4o/
         QqyEPf7f9Stid6ShIEinzes0Ri61q601MnMDe/BaR+6QaqRYYe4anDzLKd7yAt8ZQLMR
         cfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJzzZJUwpzeKQJlZIVOTzoqmYp8CWlcv3F3YYYU8MOg=;
        b=nfPK/P9dAO6cfz8LAYRcZnaolY7aE6rLK28pNS+uv4YVQIOVAtC9idAXFaQvu3vK3V
         8VkEZxMQ8Rp8b5qv/3Z8+KwyTtdfz5m49UuYYDuuZQuctLe2MSPDyesfzepNazSNQY3Z
         0J+dQdwlqgJ/jmRUY6z7v5KFx4ZEmDpKAwuWkFFTd/zYqJ4j+J28/W0r5kvd/pNuE5BA
         Z5PRtyBIs2rEdDOE/zMVoOahvoYOG+PheefmtBLuo8dbw+wVHJMfq6MI+4RNv3go9tPL
         fOHlv6PF9JsZoTX3KDo3nLCOs7xnvEgRVytqzJyky0HAfyEMFjLA7T67v/30Zbt+xZUU
         exAw==
X-Gm-Message-State: AOAM532KMVD3O0uRyIqscTXX72RaXTeEDyt80RmX8x1Z21KnzSQzhg5e
        UT5Pj7MOky7y1Ou6eONppIGPfQTi7YDJz3lo
X-Google-Smtp-Source: ABdhPJxbCg5k83AJkkf7TpRQJrReqilB+qCC+1rDSbSN1M5Qa0bgpA3LMBJFY9nGSbN5K03Q8ex3zQ==
X-Received: by 2002:a17:90b:1804:: with SMTP id lw4mr354756pjb.174.1633973781406;
        Mon, 11 Oct 2021 10:36:21 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id z8sm8859954pgc.53.2021.10.11.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:36:20 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/22] PCI: Unify PCI error response checking
Date:   Mon, 11 Oct 2021 23:05:47 +0530
Message-Id: <cover.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the 
CPU read, so most hardware fabricates ~0 data.

This patch series adds PCI_ERROR_RESPONSE definition and other helper
defintion SET_PCI_ERROR_RESPONSE and RESPONSE_IS_PCI_ERROR and uses it
where appropriate to make these checks consistent and easier to find.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Patch 1:
  - Adds the PCI_ERROR_RESPONSE and other related defintions
  - All other patches are dependent on this patch. This patch needs to
    be applied first, before the others

Patch 2 - 13
  - Uses SET_PCI_ERROR_RESPONSE() when device is not found

Patch 14 - 19
  - Uses RESPONSE_IS_PCI_ERROR() to check the reads from hardware

Patch 20 - 22
  - Edits the comments to include PCI_ERROR_RESPONSE alsong with
    0xFFFFFFFF, so that it becomes easier to grep for faulty hardware
    reads.

Thanks,
Naveen

Naveen Naidu (22):
  [PATCH 1/22] PCI: Add PCI_ERROR_RESPONSE and it's related defintions
  [PATCH 2/22] PCI: Unify PCI error response checking
  [PATCH 3/22] PCI: thunder: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 4/22] PCI: iproc: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 5/22] PCI: mediatek: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 6/22] PCI: exynos: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 7/22] PCI: histb: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 8/22] PCI: kirin: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 9/22] PCI: aardvark: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 10/22] PCI: mvebu: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 11/22] PCI: altera: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 12/22] PCI: rcar: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 13/22] PCI: rockchip: Use SET_PCI_ERROR_RESPONSE() when device not found
  [PATCH 14/22] PCI/ERR: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
  [PATCH 15/22] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
  [PATCH 16/22] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
  [PATCH 17/22] PCI/DPC: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
  [PATCH 18/22] PCI/PME: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
  [PATCH 19/22] PCI: cpqphp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
  [PATCH 20/22] PCI: keystone: Use PCI_ERROR_RESPONSE to specify hardware error
  [PATCH 21/22] PCI: hv: Use PCI_ERROR_RESPONSE to specify hardware read error
  [PATCH 22/22] PCI: xgene: Use PCI_ERROR_RESPONSE to specify hardware error

 drivers/pci/access.c                        | 22 ++++++++++-----------
 drivers/pci/controller/dwc/pci-exynos.c     |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c   |  4 ++--
 drivers/pci/controller/dwc/pcie-histb.c     |  2 +-
 drivers/pci/controller/dwc/pcie-kirin.c     |  2 +-
 drivers/pci/controller/pci-aardvark.c       |  8 ++++----
 drivers/pci/controller/pci-hyperv.c         |  2 +-
 drivers/pci/controller/pci-mvebu.c          |  4 ++--
 drivers/pci/controller/pci-thunder-ecam.c   | 20 +++++++++----------
 drivers/pci/controller/pci-thunder-pem.c    |  2 +-
 drivers/pci/controller/pci-xgene.c          |  8 ++++----
 drivers/pci/controller/pcie-altera.c        |  2 +-
 drivers/pci/controller/pcie-iproc.c         |  2 +-
 drivers/pci/controller/pcie-mediatek.c      |  4 ++--
 drivers/pci/controller/pcie-rcar-host.c     |  2 +-
 drivers/pci/controller/pcie-rockchip-host.c |  2 +-
 drivers/pci/controller/vmd.c                |  2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c           |  4 ++--
 drivers/pci/hotplug/pciehp_hpc.c            | 10 +++++-----
 drivers/pci/pci.c                           | 10 +++++-----
 drivers/pci/pcie/dpc.c                      |  4 ++--
 drivers/pci/pcie/pme.c                      |  4 ++--
 drivers/pci/probe.c                         | 10 +++++-----
 include/linux/pci.h                         |  9 +++++++++
 24 files changed, 75 insertions(+), 66 deletions(-)

-- 
2.25.1

