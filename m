Return-Path: <linux-pci+bounces-5844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B2E89B40D
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 23:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4762E1C20A06
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879342073;
	Sun,  7 Apr 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii2PtuJF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8D3D576;
	Sun,  7 Apr 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712523952; cv=none; b=n7L2/Bs6ncvClcuuruVYmotZIjG/6AtN6FWxztzZkkctezNevFf0T+Rz6trd5YpuJNqxwrVd9TkU/x0u7URYOD3K1aocS5VBT7yD7RWthzLG3BoEFpu/UDVgwhhvDPwMetg3BM5iuVKFvcu3c+Zm21MxRx2Y2uu1jbkRB7Pgp8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712523952; c=relaxed/simple;
	bh=alFJHuuY58av6Gpl72+zYmR9Fs+6674Zyv4hEKl/Gr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j9y6E47qUQVd9AlbnL7tAWFhHq5d6DBXRNq8MY+M3UMflV/jtAiCqaka4B96jP+IWVm5yyu9LEuYA5HeOOW1zHZNM3BujNd5m1WFlyktzTeMLmQztYXN56rKTlO+QzTHXCFFJvroBrhOD0xjCyVZcsgnVVPaD4a3oabtDZb5iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii2PtuJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EE4C433F1;
	Sun,  7 Apr 2024 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712523951;
	bh=alFJHuuY58av6Gpl72+zYmR9Fs+6674Zyv4hEKl/Gr4=;
	h=From:To:Cc:Subject:Date:From;
	b=ii2PtuJFpxgQJTh561Dx4dKf2IWsrqB7TOMg3giuAc6P751oRKiTaQduKvfsUV2i0
	 G95vbPJrMhO1bG3Xns9BIO5qtkcJYOJIZgKvJLRQsohZGzAIR7SDFlF4iNVsduRlfA
	 bM2DZl2S91YA4hPfQ/3ruXpVEnkuX0GRAueC9laW9qJTctWj2VRRUYRjM1VxvfVv0x
	 OU5tEhI7hUi34qaJ71Y11o86wU5iAsZdBBX8ix6XvM+IpAekH54IyXcP3oRRqv7wJb
	 BHFoxhovJtj9uvNxrRHuNrPXj+aumivwHZJ/CHKu+9G1ElskaE6RjgQ51A6x19OQ2Q
	 t9TxeFgVF3Pkg==
From: ppwaskie@kernel.org
To: Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	PJ Waskiewicz <ppwaskie@kernel.org>
Subject: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup failure
Date: Sun,  7 Apr 2024 14:05:26 -0700
Message-Id: <20240407210526.8500-1-ppwaskie@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: PJ Waskiewicz <ppwaskie@kernel.org>

Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
drivers on Emerald Rapids systems.  However, on some production
systems from some vendors, a buggy BIOS exists that improperly
populates the ACPI => PCI mappings.  This leads to the cxl_acpi
driver to fail probe when it cannot find the root port's _UID, in
order to look up the device's CXL attributes in the CEDT.

Add a bit more of a descriptive message that the lookup failure
could be a bad BIOS, rather than just "failed."

Signed-off-by: PJ Waskiewicz <ppwaskie@kernel.org>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af5cb818f84d..56019466a09c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 
 	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
 	if (rc != AE_OK) {
-		dev_err(dev, "unable to retrieve _UID\n");
+		dev_err(dev, "unable to retrieve _UID. Potentially buggy BIOS\n");
 		return -ENOENT;
 	}
 
-- 
2.40.1


