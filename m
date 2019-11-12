Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFDDF9736
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 18:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLRfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 12:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfKLRfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 12:35:16 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB18214E0;
        Tue, 12 Nov 2019 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573580115;
        bh=+4EzQSM/k1VOif0/E/W/Xzv0GPRgNyMJHG5BQwoLXVU=;
        h=From:To:Cc:Subject:Date:From;
        b=mceh4Ur/VUEpqNhsdVlcNrzbKQFA3I3i+cQuPTI008T6RWy3FC2d15H05pRpKd3BW
         jWQWNqALKkTJyK/FbmzWRaDCohiyixeo0KKI1QAU4toEhNq++YbHzZVlVjoHQeVyeT
         1bmiyZkFCmbQ0PnoDeuOgGmZUQ6HFRsRubGkHM00=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-pci@vger.kernel.org,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH V3 0/3] drm: replace magic numbers
Date:   Tue, 12 Nov 2019 11:35:00 -0600
Message-Id: <20191112173503.176611-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

amdgpu and radeon do a bit of mucking with the PCIe Link Control 2
register, some of it using hard-coded magic numbers.  The idea here is to
replace those with #defines.

Since v2:
  - Fix a gpu_cfg2 case in amdgpu/si.c that I had missed
  - Separate out the functional changes for better bisection (thanks,
    Michel!)
  - Add #defines in a patch by themselves (so a GPU revert wouldn't break
    other potential users)
  - Squash all the magic number -> #define changes into one patch

Since v1:
  - Add my signed-off-by and Alex's reviewed-by.

Bjorn Helgaas (3):
  PCI: Add #defines for Enter Compliance, Transmit Margin
  drm: correct Transmit Margin masks
  drm: replace numbers with PCI_EXP_LNKCTL2 definitions

 drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/si.c  | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
 include/uapi/linux/pci_regs.h    |  2 ++
 5 files changed, 58 insertions(+), 32 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

