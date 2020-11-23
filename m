Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6943E2C0C15
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 14:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgKWNoR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 08:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbgKWNoR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 08:44:17 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813D7206F1;
        Mon, 23 Nov 2020 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606139056;
        bh=DB3QEZuy+Fe1QR9eYhfJo9ZD6woPmMFGSzD2JXS+9+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Cmr9EANzmv4bIP3wlI7Dhllj0uIjXveZ90qem2GkU4WVQzSmKOzQa17Jtu/YyEH21
         6rY+XVs4S0KSTvniAUG26veNWwMmaTW6qg/+TwvFiVqkb1o2hn2yDfVJWQINFzb3AW
         Oeqsv8YlMpF+tsbFbkDG9c2VnTzlXdI7XCvO/z6U=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Edgar Merger <Edgar.Merger@emerson.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Date:   Mon, 23 Nov 2020 13:44:10 +0000
Message-Id: <20201123134410.10648-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Edgar Merger reports that the AMD Raven GPU does not work reliably on
his system when the IOMMU is enabled:

  | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=1, emitted seq=3
  | [...]
  | amdgpu 0000:0b:00.0: GPU reset begin!
  | AMD-Vi: Completion-Wait loop timed out
  | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=0b:00.0 address=0x38edc0970]

This is indicative of a hardware/platform configuration issue so, since
disabling ATS has been shown to resolve the problem, add a quirk to
match this particular device while Edgar follows-up with AMD for more
information.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
Suggested-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/linux-iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10MB1310.namprd10.prod.outlook.com
Signed-off-by: Will Deacon <will@kernel.org>
---

Hi all,

Since Joerg is away at the moment, I'm posting this to try to make some
progress with the thread in the Link: tag.

Cheers,

Will

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692ac79c5..3911b0ec57ba 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5176,6 +5176,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
+/* AMD Raven platform iGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.29.2.454.gaff20da3a2-goog

