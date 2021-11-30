Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D298C46355D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhK3N2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:28:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59318 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhK3N2w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:28:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 217C4CE19FE
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EFFC53FC7;
        Tue, 30 Nov 2021 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278730;
        bh=16RVcrqaBmMR43aspTwZCscC3NVFsAEmtV7ZMbpjKTU=;
        h=From:To:Cc:Subject:Date:From;
        b=Qw46RVFQdVfVsZ36VcxKJw5fBf0yapEGOAMqEUL+RQV+0h2Hl2GmtBfE7D8/kpGHk
         2QALblerpyZOZBAbpySC7irI8LJ9/d/tEmsam1K0aCVBeRgDl0f0KEmHWQYuc8Hs3t
         q1q3xtaUsd/F2XRH+NqwHBMcVAEDpEFhCo+v7dKXmBr59cWwx+LsQc3KxNZNTQ9+fS
         4ZAfOGL6JST5jzAiUd7N6rEFHbA/PNLjA1Z1m2qerJkhWUMpOPKXaXxsN7St5IDwbZ
         sequz8MHpk334boxGtHlhNINQhlB9i1ri2TybebCuh+omTB8l2Z4xS4cot56Rzfvof
         /jRg6JktSnz9g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 00/11] PCI: aardvark controller fixes BATCH 3
Date:   Tue, 30 Nov 2021 14:25:12 +0100
Message-Id: <20211130132523.28126-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Lorenzo,

sorry about this, I overlooked one more change Pali did in the second
patch.

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

