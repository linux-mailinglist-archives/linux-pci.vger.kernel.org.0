Return-Path: <linux-pci+bounces-19416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01635A04127
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE1F1886DC1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A31EE026;
	Tue,  7 Jan 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="muni3Yx0"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928481F12F4;
	Tue,  7 Jan 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257724; cv=none; b=mHkD0hYTSid4rmIdOh2AumQcANVm2loZSe3CHDkS8wguzHGq8K0HdyVlNbY6XpezFUK20UOFMyI3CkoGMEUK8P4wE4rDrDz4FiRzLrPdOO3S6ZZoguO5t6/PZRHhoa9GKpsLM69WPLGr1JDmZ1z3U4MGvRM94USy69vWxSJGuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257724; c=relaxed/simple;
	bh=mHxcNU8y0mx2f5AbwxDnCTwc0E5sP4xfZxt2aoMnJ5w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=n7lVhweNM0l1gtucmll3b0T+k5LEsQxwkMZS54yJdlZH/mCR6aWchauu+68mTIBzMcvXJ+zu1KYB4PtR2VFa+VTi8vS4t8w12L+Qm9dsDHDdvDtslDZMB4uMTIAYl8ftRPyCl7GBnFTzEQOv2mpvoZOi/dgApcvobYE4Hc/fiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=muni3Yx0; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736257408; bh=HDGS018z8SZ+VUzFh7FhhspHyPs0aJJXv4Qlbf/4mf8=;
	h=From:To:Cc:Subject:Date;
	b=muni3Yx0nT4QdXlq3fsPaCAuco9xgSjrH8hOpTiIgEo0SbAc0ZtitFdQ5rlB3Kpkf
	 n5hw3Gnk0bkLWfJIMyiBFEirJepGGcUHA8QiJZN4fWaWanLoS0US2qpFwaWyv4of8X
	 QkvNdYntHokKmzf01PyDWuLfaga4pQmOw001lKVs=
Received: from Ubuntu.. ([240e:305:25d4:e300:6504:4e8:136:29f6])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 945B9C89; Tue, 07 Jan 2025 21:37:06 +0800
X-QQ-mid: xmsmtpt1736257026t2v8dbnvw
Message-ID: <tencent_464C8D4A8F6D1EEEC05A30EDF0112FA58805@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJPhSdrpMqEpNSP5FxBeB/LIn8wSIE8f6wGjyU02BfSfvCaltyc9
	 nZY08NiRdaiV+wiEC/ENNuFh3hzlbIN42nzi4S34DEpKbBWC0y5KS7delEieI16l79NsaZk6Y8T8
	 0G5J4/qd0yScO5kUdfH65cuDwdLUcUUW+Goa2x4elLivhfWZkAhJkz52BnoH4234k2osjO7VMiZH
	 ji4RxYfgwmIm2O21oPcc6hUTM4ytG7PjAUIPajQA98/ihSg30Jr473Fai93+Gq6kit0Ayoqimgoy
	 mfQgSObB5jkgEkXF9dcI/T44WUqFnsDL7blM9IegPPk+KT7pv9PCmoJW1o5SVrFdps5lrz9JcA3t
	 /c6ELV2NRkwwTRZFBFKC0k5Bi5zVi135hB2vW0U/Hf+/5MnA+cQLZGL6TJuSLdrUAgbREcOklJxx
	 1RRgjbdusrtSeKO9QJ5zZUJR7Gyg2lcIWicUCO7W/TzGfsosmuUt+LwWh9UgSAdVuIjGc3bUwz3G
	 rbOhxZ9gjtjmT/SiUeoInHmP3lzOfH2SkVPht9/bS7b1Do+zEjzdNe6TehZVfcNdnt1Vdrstggst
	 3T5GEbEFqnVn6Nw7ODuuay25kAYPyWMXh/GSn7LnQSqAUnsCwtAwleT01vq0JSaIyfsOdjQjGdMz
	 j/QQk607Qhl9or7uU5Di0Pu0C9Dn+yK/lNNN0IuJEcBisbH8/r7p47PZI1Fa6Yshkqfjl5T1w0hV
	 HOYEdrbuCuvCqMdMsBRPs6+CaRI8My4iW/aE+kSlWAtFUXqZd2Lizd5YGb3BUU95ALORudd1Yeu3
	 635cequL2SbH6ds/jpogvTTqqYkgKd3s8Yt/McDtJC14luW+nrPZWUwSEc21nXwLaJj6j6wvb8xc
	 2HMbYAadauyh4JTvUz6dQSqrg3jlaa7FBlN1XN8AI0h2e0ch49c7zA8sO9iwmo+fT7Pwt5GGFWA3
	 SoVxa0dByz60sotOSS8BWSl+j09rlwKZT/MxrthVIsLrQF99pX7BCcYfDjbWzLQPmkK44Gzcb0f6
	 1j7SjDldI95P+w45aeF5QizoNC4gzsHoVLKSp0PD/2RbMtCuzl3fFvmSwK23A=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: kingdix10@qq.com
To: marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	prabhakar.csengg@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	King Dix <kingdix10@qq.com>
Subject: [PATCH v3] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region
Date: Tue,  7 Jan 2025 21:36:54 +0800
X-OQ-MSGID: <20250107133655.758670-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: King Dix <kingdix10@qq.com>

When using devm_request_mem_region to request a resource, if the passed
variable is a stack string variable, it will lead to an oops issue when
executing the command cat /proc/iomem.

Fix this by replacing outbound_name with the name of the previously
requested resource.

Signed-off-by: King Dix <kingdix10@qq.com>
---
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


