Return-Path: <linux-pci+bounces-19581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20843A06A09
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 01:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCE73A4237
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 00:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C441853;
	Thu,  9 Jan 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DWDo22jj"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598E38DD8;
	Thu,  9 Jan 2025 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736384029; cv=none; b=k4Qeq5wsN3grSOJCIo3RQE8In3VK8KIu7BMLtqvFph7bjGcBiMwFyuTE6Szflo2Ceak90fYl08SxuJ4E8o4fNDMnznxfCsOXCxCS6jrkHEhOx/WrKKFOKxnDWUUQ1UacXWTyuhdb9PSZKYfPUyBYzKEUwVyIofNFX101YTzrPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736384029; c=relaxed/simple;
	bh=lYbK4NIWrV0VHcbEOwwH4nOOxGZR8pgoBUm+eCevzRE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=orUEeP1zzin0LdyNn+Ha01fnXFt9Ya3eqOy7P8gbSJ5aBi5Diqvd8EiTZtf140rmx3A76mLJbzJkYUfrgcVnUHBTFIZ0DgbsULIie1ixMUJ6yZm8JOhhR1dNdywqIt7scsdKca4yJcASX8Qhe0kqSh6vNSsglVtB5ts6kC+NLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DWDo22jj; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736384008; bh=WNo1hPAFLM871tv6VN1nf0zPKzmHKD0v2ec7dCLKzzE=;
	h=From:To:Cc:Subject:Date;
	b=DWDo22jj+gsp+t21XcOA+HEEYtKqW0QErC/Pb3Itx2nLIt5zbxkjZ707O3ps7NMcP
	 P0fD4J4bHg7Z+xK3xIr3swXRyHG+nKfr+Emd+0SpFNg+mRSdvv43FBpfhZwys3cmyc
	 /FoGSyd5fwLo4eh2nvX8lX7Yd6dG6enFq/CxjU54=
Received: from Ubuntu.. ([240e:305:25d4:e300:e8b8:34da:c848:9463])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id D588EC54; Thu, 09 Jan 2025 08:53:24 +0800
X-QQ-mid: xmsmtpt1736384004tjibwi3j4
Message-ID: <tencent_DBDCC19D60F361119E76919ADAB25EC13C06@qq.com>
X-QQ-XMAILINFO: OK7NBzdNss/RI/ERHcqweWD7/RhMx3aWC+LPs+UaefQ4huMWM7pkYfnC4pfHLe
	 7VMcIryyfedjozgYKsOanafT9oNHg1yiMe4GKeluYkhMIiPVYLXbgMolzUFgopIcMtCC9r6xFlaD
	 fNSeWC3L2DvSXO2CbTpa6dnlDtpwl7R8xJWzzG5z3GcS/0jexhM2l+P73sX0AJaDjJ6FpdzjwC3E
	 DcVd8J+OvXvARqT/FG7B5SjR2o5KXSjxWsn35oODBjxEwt0komlmHpzlIIOTOVSPtZnC6U42uAVA
	 6sfvVtp6x+jmSp2sBSflvS/JWvAGCW2izcWGASFGkWdf38x+zi/AGBW6mZ4NB7T5i28mEsZMNxaW
	 QxdyJZAuho8qF5P+q6ubPpdcrnv/OYNxZJLUhqSomFlxETrlR/7exShDUi82aAOPlsXP4VHJgzbp
	 +SNmnJM+4cV7FIJk4VSqBl/2Vr3UqmgYwieWRG3USYtwbyH2ItiBfG6r+PSzRxOKL7AUR0L5pp2c
	 HbNZ3yFvayDTXufAqWpWfoe2KIQvxIvN9bICOsXN9tJrhvk4EqgmNSmR+Zy6M3hoFFo+jHOmH8gZ
	 e47Ttg98Ta1TTI4SpYj69DhnddWPTNthlNLLYMsRoNlo8ut5VaW7+BpwV0oXGXzh8Wa6XW+THZPR
	 bPfSDDSp4vWB1EU7prxdENRhhaxfpwJZqwqqtzMErKec7Ynt5l/eIwfxErJmhpT2FEcyHli+X/0/
	 Z2nlyXr5Le/1wA9yYQFVFSCsUrdHKBT4vgMsGPwZVu4ds2W1wCFwCP8mTscInTAHh1w0BJWFq8TZ
	 vpmM8R4zzr30cUdlxSuDvoptTAGR+k1Qt1pfp8HjTISN0xvRk27/80jV10TTt+4dg40JIUaMtK30
	 RNPZHi3eJU8a4UW76fW4Ld5rfdccHLAUDlMJDgGrKKLSguRi+Kbd/jivhzohJv9RgymNCOzvhohH
	 ATKX/yh1oGmJ7x9Inw88ExvbY8DuReXoMlWLniaghI5gm3msIpRTeGqcnRY2d2C3mzWpdvEkvOHC
	 vf1zP06yDOtJUiaaCGQkDA3OLOPWY7eHe2VcuX0VvXFAz7k4bdLn8esw2jSrQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: kingdix10@qq.com
To: marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	prabhakar.csengg@gmail.com,
	biju.das.jz@bp.renesas.com,
	geert@linux-m68k.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	King Dix <kingdix10@qq.com>
Subject: [PATCH v5] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region()
Date: Thu,  9 Jan 2025 08:50:18 +0800
X-OQ-MSGID: <20250109005018.1933553-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: King Dix <kingdix10@qq.com>

When using devm_request_mem_region() to request a resource and the name
parameter is a stack string variable, it may cause errors when executing
the command `cat /proc/iomem`. Depending on the content of the memory, the
manifestations of errors may vary. One possible output may be as follows:

$ cat /proc/iomem
30000000-37ffffff :
38000000-3fffffff :

Another possibility is that garbage characters may appear after the colon.
In very rare cases, if no NUL-terminator is found in memory, the system
might crash because the string iterator may access unmapped memory above
the stack.

Fix this by replacing outbound_name with the name of the previously
requested resource. With the patch applied, the output is as follows:

$ cat /proc/iomem
30000000-37ffffff : memory2
38000000-3fffffff : memory3

Fixes: 2a6d0d63d999 ("PCI: rcar: Add endpoint mode support")

Signed-off-by: King Dix <kingdix10@qq.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Changes in v5:
  - Add examples of error outputs to the comment.
Changes in v4:
  - Add more information to the comment.
Changes in v3:
  - Fix the spelling issue in the comment.
Changes in v2:
  - Fix the code indentation issue.
---
 drivers/pci/controller/pcie-rcar-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 047e2cef5afc..c5e0d025bc43 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
 		}
 		if (!devm_request_mem_region(&pdev->dev, res->start,
 					     resource_size(res),
-					     outbound_name)) {
+					     res->name)) {
 			dev_err(pcie->dev, "Cannot request memory region %s.\n",
 				outbound_name);
 			return -EIO;
-- 
2.43.0


