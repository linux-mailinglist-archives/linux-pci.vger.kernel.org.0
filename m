Return-Path: <linux-pci+bounces-27223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3994AAAA11
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0BD7B3DC5
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972037688C;
	Mon,  5 May 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY90ImYk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23F2D60F9;
	Mon,  5 May 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485354; cv=none; b=LHoUsNQI6QF7B/XFu7JOhHF0xMY06NQbWgcBZ/xkXheagdLFAXcVQuVDNFzV+guS+NzQBlZGG7t1UDFzBIN9RiMD7huJbFhCxxPXtJtuAPcWby359bH4kYc7VRbzMLuSrNciSfyTTUgHQo58m1EWRm7OFYWq8+KSu2JkP/L5d7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485354; c=relaxed/simple;
	bh=LJNC1WGx3PsFqhoiIj4US5ok4Nl0wwbQHNr9rljz7+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goSNcYCuSHLwLg8Jad4hCAyH0UGh46JH8utR4Q6iZiPB7KR909WfMEKpNpGujjR9QDAULrsgtEZH8lr4OtD/zT+UvTa0kFdFduDWcHT7zoqKJ88rFQ33Tr/qSBLrBNh31yeuY0rw2TH9ECChWbT2SJy4OpWyv6j+lgH8Fc13gBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY90ImYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D9C4CEEE;
	Mon,  5 May 2025 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485353;
	bh=LJNC1WGx3PsFqhoiIj4US5ok4Nl0wwbQHNr9rljz7+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZY90ImYk6nTsMSNl3osw9xWnuWTuprcNBCIcAeriYif2UkV+KJDx2FrB7Z40NHqXO
	 qtDcZlJCpItuzNQ9Vpf+69NREjwlPZN2pyR8x0kW5i7YcKjyz8A/vNw+3zfr2/kONt
	 +zwY7QBfsIFOlVW2G6607UxxeaehUt5zrH4Dj1r4n1FeBa+6C87Axsm6yUivYWbJF2
	 qOUOoKO7yL2zfp6mLuqf2cOWl3/ndvMxHnYEiRv7qz81v82F3P9ZxFrf99YKJX3cpa
	 8QqZePWUOt4j4tlhjKdNh9u2TVNavwP+tqMZpmjh7+gO40f5jLpLdR0x4W078quAcp
	 nyJqm4Rlc2v+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	manivannan.sadhasivam@linaro.org,
	kw@linux.com,
	bhelgaas@google.com,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 282/486] PCI: epf-mhi: Update device ID for SA8775P
Date: Mon,  5 May 2025 18:35:58 -0400
Message-Id: <20250505223922.2682012-282-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

[ Upstream commit 4f13dd9e2b1d2b317bb36704f8a7bd1d3017f7a2 ]

Update device ID for the Qcom SA8775P SoC.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Link: https://lore.kernel.org/r/20241205065422.2515086-3-quic_msarkar@quicinc.com
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 54286a40bdfbf..6643a88c7a0ce 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -125,7 +125,7 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
 
 static struct pci_epf_header sa8775p_header = {
 	.vendorid = PCI_VENDOR_ID_QCOM,
-	.deviceid = 0x0306,               /* FIXME: Update deviceid for sa8775p EP */
+	.deviceid = 0x0116,
 	.baseclass_code = PCI_CLASS_OTHERS,
 	.interrupt_pin = PCI_INTERRUPT_INTA,
 };
-- 
2.39.5


