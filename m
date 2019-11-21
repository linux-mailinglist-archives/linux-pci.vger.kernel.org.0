Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33BA1053C1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 15:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUOC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 09:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUOC3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 09:02:29 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDE4020679;
        Thu, 21 Nov 2019 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344949;
        bh=kegAbqQ55YAKJFVhHNJc+bQ0rbgYivDuVa8I99XBJ9c=;
        h=From:To:Cc:Subject:Date:From;
        b=2GwomWDZvpK92iHDorjwezZ5/4UYvebR151EZGZfqqlASQxqholOLgorVKdkbFWVw
         YdmgL7/pi5HxEhqxeWxTshMRLxwChujHVtmORfyy8/eHF8Is1ZT7ErJwWM26jA4UQq
         FGE0WL6vIXveCEfARsgvY03PTEZJX8q1ujxCFors=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/7] PCI: Prefer pcie_capability_read_word()
Date:   Thu, 21 Nov 2019 08:02:13 -0600
Message-Id: <20191121140220.38030-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use pcie_capability_read_word() and similar instead of using
pci_read_config_word() directly.  Add #defines to replace some magic
numbers.  Fix typos in use of Transmit Margin field.

These are currently on my pci/misc branch for v5.5.  Let me know if you see
any issues.


Bjorn Helgaas (5):
  PCI: Add #defines for Enter Compliance, Transmit Margin
  drm/amdgpu: Correct Transmit Margin masks
  drm/amdgpu: Replace numbers with PCI_EXP_LNKCTL2 definitions
  drm/radeon: Correct Transmit Margin masks
  drm/radeon: Replace numbers with PCI_EXP_LNKCTL2 definitions

Frederick Lawler (2):
  drm/amdgpu: Prefer pcie_capability_read_word()
  drm/radeon: Prefer pcie_capability_read_word()

 drivers/gpu/drm/amd/amdgpu/cik.c | 95 +++++++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/si.c  | 97 ++++++++++++++++++++------------
 drivers/gpu/drm/radeon/cik.c     | 94 +++++++++++++++++++------------
 drivers/gpu/drm/radeon/si.c      | 97 ++++++++++++++++++++------------
 include/uapi/linux/pci_regs.h    |  2 +
 5 files changed, 243 insertions(+), 142 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

