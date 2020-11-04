Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1F2A6F64
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 22:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbgKDVKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 16:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgKDVKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 16:10:35 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5CA207BB;
        Wed,  4 Nov 2020 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604524235;
        bh=uoWgJtlpalvS/vhvNfOmgOaqD3gAqdPFrgDsuIjX+EA=;
        h=Date:From:To:Cc:Subject:From;
        b=k7qknR4YUdOvJ0ZbIlJNJmz5omW9jvtlRZ9NF1dlHzW9aT3qNqPsmIrWeMtPJ8Gsm
         lQPhYniVE/6ayrWVI/13fTwa/lVstxJLw5krlSqENmb9brY5UI/n/HQp1oPrhQehlE
         bqOlwioMFTMZm8hrtwnk/+eO4/kvae56GuleKqVs=
Date:   Wed, 4 Nov 2020 15:10:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, vtolkm@googlemail.com,
        Vidya Sagar <vidyas@nvidia.com>, Boris V <borisvk@bstnet.org>,
        Rajat Jain <rajatja@google.com>
Subject: [GIT PULL] PCI fixes for v5.10
Message-ID: <20201104211033.GA418499@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.10-fixes-1

for you to fetch changes up to 832ea234277a2465ec6602fa6a4db5cd9ee87ae3:

  PCI: mvebu: Fix duplicate resource requests (2020-11-04 13:55:30 -0600)

----------------------------------------------------------------
PCI fixes:

  - Fix ACS regression that broke device pass-through (Rajat Jain)

  - Revert DesignWare ATU memory resource to use last entry to fix Tegra194
    regression (Rob Herring)

  - Remove duplicate mvebu resource requests to fix regression on Turris
    Omnia (Rob Herring)

----------------------------------------------------------------
Rajat Jain (1):
      PCI: Always enable ACS even if no ACS Capability

Rob Herring (2):
      PCI: dwc: Restore ATU memory resource setup to use last entry
      PCI: mvebu: Fix duplicate resource requests

 drivers/pci/controller/dwc/pcie-designware-host.c |  8 ++++++--
 drivers/pci/controller/pci-mvebu.c                | 23 ++++++++++-------------
 drivers/pci/pci.c                                 |  9 +++++++--
 3 files changed, 23 insertions(+), 17 deletions(-)
