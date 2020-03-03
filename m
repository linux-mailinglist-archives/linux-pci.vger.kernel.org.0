Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC36E176D9F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 04:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCCDl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 22:41:56 -0500
Received: from yyz.mikelr.com ([170.75.163.43]:57142 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgCCDl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 22:41:56 -0500
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 7D0933CF20;
        Mon,  2 Mar 2020 22:35:02 -0500 (EST)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Mikel Rychliski <mikel@mikelr.com>
Subject: [PATCH 0/4] Fix loading of radeon BIOS from 32-bit EFI
Date:   Mon,  2 Mar 2020 22:34:53 -0500
Message-Id: <20200303033457.12180-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set fixes an opps when loading the radeon driver on old Macs
with a 32-bit EFI implementation.

Tested on a MacPro 1,1 with a Radeon X1900 XT card and 32-bit kernel.

Mikel Rychliski (4):
  drm/radeon: Stop directly referencing iomem
  PCI: Use ioremap, not phys_to_virt for platform rom
  drm/radeon: iounmap unused mapping
  drm/amdgpu: iounmap unused mapping

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c |  1 +
 drivers/gpu/drm/radeon/radeon_bios.c     | 12 ++++++++----
 drivers/pci/rom.c                        |  5 ++---
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.13.7

