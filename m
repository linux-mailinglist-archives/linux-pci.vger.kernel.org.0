Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE31F185193
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 23:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCMWXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 18:23:09 -0400
Received: from yyz.mikelr.com ([170.75.163.43]:57254 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgCMWXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 18:23:09 -0400
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 103123D5C5;
        Fri, 13 Mar 2020 18:23:08 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mikel Rychliski <mikel@mikelr.com>
Subject: [PATCH RESEND v2 0/2] Fix loading of platform ROM from 32-bit EFI
Date:   Fri, 13 Mar 2020 18:22:56 -0400
Message-Id: <20200313222258.15659-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes an oops when loading the radeon driver on old Macs
with a 32-bit EFI implementation.

Tested on a MacPro 1,1 with a Radeon X1900 XT card and 32-bit kernel.

Changes in v2:
 - Add iounmap() call in nouveau
 - Update function comment for pci_platform_rom()
 - Minor changes to commit messages

Mikel Rychliski (2):
  drm/radeon: Stop directly referencing iomem
  PCI: Use ioremap(), not phys_to_virt() for platform ROM

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c             |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c | 11 ++++++++++-
 drivers/gpu/drm/radeon/radeon_bios.c                 | 12 ++++++++----
 drivers/pci/rom.c                                    |  9 ++++++---
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.13.7

