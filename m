Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA91463CCD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhK3Rck (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbhK3Rcj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:32:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6844CC061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 09:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE997B81A8D
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 17:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D00BC53FC1;
        Tue, 30 Nov 2021 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293357;
        bh=U0GU1rnXdY8gnYvvVKFbOnVc7lO5SmqtnFfxaOPPreo=;
        h=From:To:Cc:Subject:Date:From;
        b=YXMZzoCulWEizLRuDbRlWlJOUJ8yWLZE7pe/axHfi79I3TeJfMYtL6d1UIieX6D3S
         JmtWPP4K0s4jJay5LZ+ia2ncfpSZHooTKnA7giNna62by1NRje2cmvmJkSrtiIeX/n
         O+tPKcNElPl5JAN8f5xeSZWDMEqe+xzun8G1LK2gd/Y2evh/rw6KMaJLDOLZ2EX8b6
         vm6EqJnU+vVJzo1of0LVmekxnhIUm6t1BK7/X+Xffxs8eQ3jhOH+k2pYTfSE6CC2fe
         NiSJBRCZfGmTNIqjg/3GiCxDaDOOGksMNDJdGGm+6Gsr03eJdqrZPAsiA+ZyBVLuP3
         K2cmEeyKRRsxA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v4 00/11] PCI: aardvark controller fixes BATCH 3
Date:   Tue, 30 Nov 2021 18:29:02 +0100
Message-Id: <20211130172913.9727-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Lorenzo,

as you requested on IRC, I added more explanation to commit logs of the
last 3 patches.

Changes since v3:
- updated commit messages of patches 9, 10 and 11

Changes since v2:
- updated the second patch, updated definitions of registers
  PCI_EXP_DEVCAP2 and PCI_EXP_DEVCTL2

Changes since v1:
- removed fixes / stable tags
- split the patches as you first suggested, since it makes more sense
  IMO
- changed some commit messages a little

Marek

Pali Rohár (11):
  PCI: pci-bridge-emul: Add description for class_revision field
  PCI: pci-bridge-emul: Add definitions for missing capabilities
    registers
  PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2
    registers on emulated bridge
  PCI: aardvark: Clear all MSIs at setup
  PCI: aardvark: Comment actions in driver remove method
  PCI: aardvark: Disable bus mastering when unbinding driver
  PCI: aardvark: Mask all interrupts when unbinding driver
  PCI: aardvark: Fix memory leak in driver unbind
  PCI: aardvark: Assert PERST# when unbinding driver
  PCI: aardvark: Disable link training when unbinding driver
  PCI: aardvark: Disable common PHY when unbinding driver

 drivers/pci/controller/pci-aardvark.c | 65 ++++++++++++++++++++++++---
 drivers/pci/pci-bridge-emul.c         | 49 +++++++++++++++++++-
 2 files changed, 107 insertions(+), 7 deletions(-)

-- 
2.32.0

