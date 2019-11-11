Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D93F7FE7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKKTaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 14:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfKKTaD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 14:30:03 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 470262184C;
        Mon, 11 Nov 2019 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573500602;
        bh=/6YuVyX8+CxUq2e6F7e9g+b1C2bSx1WCkr5GbVkW9Xs=;
        h=From:To:Cc:Subject:Date:From;
        b=fafL6OYNK8Cw8CWPDakiGzTnD86oWHwarGqqueP7zWkIWHFcNjlv+Fci1aHuu0ScV
         QguxNMhurKQ9ijInqiaCmj6OtVdZqV1SezT7oUD7gJCGRrmyVaijA9KRDnqiTmwzjv
         EevmB60AD22bc6aZKsGIhqfoxEZOiV2xQKazGwn4=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] drm: replace magic numbers
Date:   Mon, 11 Nov 2019 13:29:30 -0600
Message-Id: <20191111192932.36048-1-helgaas@kernel.org>
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

I don't intend the Target Link Speed patch to change anything, so it should
be straightforward to review.

Since v1:
  - Add my signed-off-by and Alex's reviewed-by.

Bjorn Helgaas (2):
  drm: replace incorrect Compliance/Margin magic numbers with
    PCI_EXP_LNKCTL2 definitions
  drm: replace Target Link Speed magic numbers with PCI_EXP_LNKCTL2
    definitions

 drivers/gpu/drm/amd/amdgpu/cik.c | 22 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/si.c  | 18 +++++++++++-------
 drivers/gpu/drm/radeon/cik.c     | 22 ++++++++++++++--------
 drivers/gpu/drm/radeon/si.c      | 22 ++++++++++++++--------
 include/uapi/linux/pci_regs.h    |  2 ++
 5 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

