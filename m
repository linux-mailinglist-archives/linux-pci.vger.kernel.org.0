Return-Path: <linux-pci+bounces-27210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A39EAAA512
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DDA16FD78
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4E28B504;
	Mon,  5 May 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlk7+164"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196228B509;
	Mon,  5 May 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484131; cv=none; b=Zvz09Jbx8bSnQ0TQxGzsATjcjJPFDUg7WwUewCfZQULYSt5ocoUCuLdGdIX2zSES0gh88qimol233bHjLQu5ZgJsixgw67rTcNyEhBToA3QrU1Ns5vM/8vIXNiVf1ndcR9TCtiO7eOpLrZDdSRy1E1i97OGkVSOTWLBVmniaj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484131; c=relaxed/simple;
	bh=LJNC1WGx3PsFqhoiIj4US5ok4Nl0wwbQHNr9rljz7+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuASbLsCl4UUp0bqhnSYKzrsAJXX/aKh+ns0z2nOs5suA7lKEXqvxX8G4iu0HAY+T6bfB8zZ/8HI37rad+jeahqmj0AyU3Iwz98kNeEY2RRi9kgsMq8krIX7NTMycpA3NLRMqt7HZhkBFkHPZTX0OASw9gM2znwm39U4qbG8AuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlk7+164; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C488C4CEF1;
	Mon,  5 May 2025 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484131;
	bh=LJNC1WGx3PsFqhoiIj4US5ok4Nl0wwbQHNr9rljz7+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tlk7+164B+Yw1Z73cCRcLh/0pOsw77KrY2Hxsa2eEcYUhCO2PkJQqwoa4g3axqVil
	 Tdp3/7ewu+afcEL2HPzxS0FD1/fArWwRyXWgK0JlMhzlCXkT/X0k0ZD1gvWcc1Sptd
	 PwA/UYToA906C5/LxaRnU76LismbsjXNqZ+etZ3RL2g/KWDX7r5WEsMlkeCRFC2m3m
	 YiQPYA8iLGT7pjUPo13H6hEjxwmGrprfSbc2rCYgzAC0j0msIAyOb6epSTpzA04wjH
	 oyb/zJabCNVh70D+3qVuLf/u2xim1JUUGEXH2UtYQ3zX3YAr4xucxgFot/plspbFjc
	 mZWRRT1F8885w==
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
Subject: [PATCH AUTOSEL 6.14 362/642] PCI: epf-mhi: Update device ID for SA8775P
Date: Mon,  5 May 2025 18:09:38 -0400
Message-Id: <20250505221419.2672473-362-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


