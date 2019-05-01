Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D410C11
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEARg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 13:36:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37401 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEARg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 13:36:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so15504111edw.4
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WQh6+iJ1c5LV37hewjiOUJ2VVaJB8K0iqnjk0rOcMbE=;
        b=CEjb4MdJxi08K/sHDaK0eh5tzCmNnbKo8l7lks3hzoghFBcg/r6yFxaG++ZgfgWdOW
         yhDjocgFxXdRp2TXI0xdQdK5/myMxON+Mu0JLn+NQ1dTx8bFetH/46D3fX3SPvCsbFnq
         MJg+fKzdyXBskAw+hqszBABaL0ctbb+ffQuas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WQh6+iJ1c5LV37hewjiOUJ2VVaJB8K0iqnjk0rOcMbE=;
        b=WFZK2RSNsBlh79GsSjdsqPuzyvOt3PvoOVu0QwlVRoLqJZuyzgd2t/EidQJwy3nQHj
         urVdVtb0Ct4IAnu9hH8OgCI/DNtwTRXB89vkZ0IbJ7yJBftKSZOsivS1QBMCxQGrMt3e
         ruD7y4HxR/506b7VsbctGLB0gvJ6sclRsoNYCND/h80dKh2jDosnn7WR653aOnMAhrwg
         7iPK5v6Y2S75hnx+fFRpCSElndSxBAnEWaHIhKLBKRXfoU7FjXYeWo0wimZ72G4FNAGO
         YJGko28qHDj29wtM2jQbWxeAaTY3pJeUvvV4fEtDxL9R3FDeqpfPlE/a0p9bLC4HEaAb
         +goQ==
X-Gm-Message-State: APjAAAXZ+dWIoVx1suT8OyrJho4H4YFDbIL8EvQpdZO+5aktQgaPDx7M
        Fb6pLAIgEWrsHCe1gF9cZ3dPUA==
X-Google-Smtp-Source: APXvYqyT8CYAd7eurrFrFI8PfzHJPMcWdZ7fq9QHDpPRgQBgROfDRCybBxqF9//b4tm21qJoRt4Byg==
X-Received: by 2002:a17:906:e10e:: with SMTP id gj14mr15158656ejb.285.1556732217818;
        Wed, 01 May 2019 10:36:57 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s6sm2462671eji.13.2019.05.01.10.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:36:56 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 0/3] PCIe Host request to reserve IOVA
Date:   Wed,  1 May 2019 23:06:23 +0530
Message-Id: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges. Allowed inbound address ranges are listed in dma-ranges
DT property and this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list resource entries of allowed
address ranges given in dma-ranges DT property in sorted order. This
sorted list of resources will be processed and reserve IOVA address for
inaccessible address holes while initializing IOMMU domain.

This patch set is based on Linux-5.1-rc3.

Changes from v4:
  - Addressed Bjorn, Robin Murphy and Auger Eric review comments.
    - Commit message modification.
    - Change DMA_BIT_MASK to "~(dma_addr_t)0".

Changes from v3:
  - Addressed Robin Murphy review comments.
    - pcie-iproc: parse dma-ranges and make sorted resource list.
    - dma-iommu: process list and reserve gaps between entries

Changes from v2:
  - Patch set rebased to Linux-5.0-rc2

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma_ranges window list
  iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
  PCI: iproc: Add sorted dma ranges resource entries to host bridge

 drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.7.4

