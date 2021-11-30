Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28A463469
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 13:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbhK3Mju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 07:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhK3Mjs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 07:39:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F81C061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 04:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8761CE1870
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 12:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB14C53FC1;
        Tue, 30 Nov 2021 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275786;
        bh=k1Rvod7MOhJFz6wpcMxFkAaIYc2H98d63g184HYkm+I=;
        h=From:To:Cc:Subject:Date:From;
        b=bsbLdijgNgLugmoDA7SH7yoRQx5JSdt9u3+mpYkEd6kshVFd8CpSx1ZEwswORSpKN
         1+bHBPhVpqs91e2aEZo1ls5UABEzr5BhgkXS9LSs9gNQIx3bewBmpx474KbtCEgmHG
         tadJ07ryB/+PNMfKcOJk3qOrwDGghZ6VKcLwImqNWYL/T5w9rqQavlS6faX+pdluzS
         IrZWK5LmM+FLmjR3TcOzeJbeFShMwb9nJn569m+3A5a5GlNFN7bPz1d1ZUxXRwdIK6
         cIxqcUJmEXz5gN1E4YDPk3d2+6ofeDNuok7NPUHPOdg6WGiCP5UsGGtc2GzU5zevcp
         79RwQnW48iqBQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 00/11] PCI: aardvark controller fixes BATCH 3
Date:   Tue, 30 Nov 2021 13:36:10 +0100
Message-Id: <20211130123621.23062-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Lorenzo,

this is v2 of third batch of fixes for aardvark.

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
 drivers/pci/pci-bridge-emul.c         | 45 ++++++++++++++++++-
 2 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.32.0

