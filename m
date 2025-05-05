Return-Path: <linux-pci+bounces-27231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED64AAAC4E
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBAC984992
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB3387514;
	Mon,  5 May 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVDx91ly"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86565388C40;
	Mon,  5 May 2025 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486684; cv=none; b=a1pAnx3Vt0E6M7ENVH8j59weRMYg9XVVAq1yYusz0sQM36luLUWKwcHy10wvHJ14n41rKd5LOpX35kdeJT34Yva6O/UFuoCOoS6H9rguaXDIwHNF8SWO0u8FlBJFFNs4DHH3Jzi+W5JlTyd5g97bocXYymPtJj02OCc3qtqDY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486684; c=relaxed/simple;
	bh=//7t0y4RckeXy3uUcJzl17fcR5b2cU+WZre6frQ4xYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7MKFm6sSbcULpXCpynHrMPw0OVkyxiZatV/HV3QaznmYa+bGQSGNNA81Poq82ceIpAgjnnXBIX14siqP+9GYliTrnILFeY/5D8+F9XUa3xDnB50NeUKIWjWEgMay37YAE2Dam8IvJD3o0VPcVQSe1OPyRNVvoRoAwOOV2QhBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVDx91ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B4EC4CEF1;
	Mon,  5 May 2025 23:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486683;
	bh=//7t0y4RckeXy3uUcJzl17fcR5b2cU+WZre6frQ4xYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVDx91lyw8Y5ojGEdUInGKhw+TPa6lH3gMvsq0Ka3v8CDob7wCgzNtLK+q0b1OF49
	 /H46LCMGKLh55pziH87KUsGAMiOg5ohoTlM3XCLiJsPJDtnVnSxUA81Xj6iyDFI+I2
	 foWTIqD/TuwjY1MddQh1lFrMzjrCkq0KRkoVf9MZlZqATjOGWPlbLFM9RPIdTAMQTa
	 wXmJKLbBNests8AzEJdOGnXhSpjlcuyVetP00A8HYCX+379j442jRQhxvsHXU/LLF5
	 KzDGimXDBced7DThPtdOmuMW7V0LXhMUmkphXuxdXNhRaAz+QIzhGaAH7aBKGs1Xtg
	 6tXOmhPm0Me9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xiaochun Lee <lixc17@lenovo.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 149/212] PCI: Fix old_size lower bound in calculate_iosize() too
Date: Mon,  5 May 2025 19:05:21 -0400
Message-Id: <20250505230624.2692522-149-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit ff61f380de5652e723168341480cc7adf1dd6213 ]

Commit 903534fa7d30 ("PCI: Fix resource double counting on remove &
rescan") fixed double counting of mem resources because of old_size being
applied too early.

Fix a similar counting bug on the io resource side.

Link: https://lore.kernel.org/r/20241216175632.4175-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xiaochun Lee <lixc17@lenovo.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8c1ad20a21ec5..3ce68adda9b7c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -806,11 +806,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
 	size = size + size1;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 static resource_size_t calculate_memsize(resource_size_t size,
-- 
2.39.5


