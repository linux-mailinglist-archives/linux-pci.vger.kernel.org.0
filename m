Return-Path: <linux-pci+bounces-60-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E17F361B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB1D281FE7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626351020;
	Tue, 21 Nov 2023 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW+n6C08"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF851034
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15255C433C9;
	Tue, 21 Nov 2023 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591823;
	bh=xBeqzteKzjRFD7AK4f9XGIWZHMzDuTSTe3bPhMPVydE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XW+n6C08SNh+kInRoEGKqDrPEzsmS4/A230SA1t1ygBldR47hQJaz0mYmCkCFf3p0
	 VrlzzKWr2unKQkxS6rU6CxyBKOq0P0Lp5flZeYXdFimOWl4kV+FpiFji8iVt8Rt+8A
	 cHtXR8Vb+F6VjpGZI3o8NDdtV8Igl4BtI5oHyRVrP7milTrTWKXU8xJuavzoe3gjzL
	 RuIxdCWCnwiUlQhcZQK62gh3kKt95dBx1SBBZSOyt+BIfFDbGN5z/+GheND+w3YSzi
	 FlGBrovDFtly2OWiWeSgTl3voaQ5JsTVvHXdlOm8Z0MuYaezO9iYSPqUKozVF5kscx
	 wvJh13DDHuRbA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Yunying Sun <yunying.sun@intel.com>,
	Tomasz Pala <gotar@polanet.pl>,
	Sebastian Manciulea <manciuleas@protonmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 7/9] x86/pci: Comment pci_mmconfig_insert() obscure MCFG dependency
Date: Tue, 21 Nov 2023 12:36:41 -0600
Message-Id: <20231121183643.249006-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

In pci_mmconfig_insert(), there's no reference to "addr" between locking
pci_mmcfg_lock and testing "addr", so it *looks* like we should move the
test before the lock.

But 07f9b61c3915 ("x86/PCI: MMCONFIG: Check earlier for MMCONFIG region at
address zero") did that, which broke things by returning -EINVAL when
"addr" is zero instead of -EEXIST.

So 07f9b61c3915 was reverted by 67d470e0e171 ("Revert "x86/PCI: MMCONFIG:
Check earlier for MMCONFIG region at address zero"").

Add a comment about this issue to prevent it from happening again.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index b36c10e86505..459e95782bb1 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -786,6 +786,10 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 		return -EEXIST;
 	}
 
+	/*
+	 * Don't move earlier; we must return -EEXIST, not -EINVAL, if
+	 * pci_mmconfig_lookup() finds something
+	 */
 	if (!addr) {
 		mutex_unlock(&pci_mmcfg_lock);
 		return -EINVAL;
-- 
2.34.1


