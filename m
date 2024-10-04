Return-Path: <linux-pci+bounces-13864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF31990EDF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD691C22D2C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899422CAE0;
	Fri,  4 Oct 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW25GSL3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45CB1E32A1;
	Fri,  4 Oct 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066687; cv=none; b=rk0fNQby88crCf5NgkTJCeGWJxzjH5XUzzDttdFj5QELvF3NkrtAJ783wotUoEbz3DaW97CZrk7QhtHpJwcPl//Q4I94w2dY3ckoBfJAqruf8mlsAPPUQaTpgGafBSHaD8Lp2uzgNoNGpd78pHBOGI0aT54OAtFB5Mogqu3TDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066687; c=relaxed/simple;
	bh=ReLgJE35yoIG/GdSIz+3KKTOjtzM5I/vyRK8weibBpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4ZlEEd+QIxuU91hJn1ChRZxni7WPQjze+O9Be2j7BPdvl7KGCyj06deK3iJ80mt2F41bXUx/HvM/osvGossPTSb44ZuBiqmCJqKbKoogZ3lZRR8U4q0s1uUGYvfVtMY22QVLBNucM0ng37LYT3AhaTi5UyVIG8XdJz85QGe6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW25GSL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C00C4CECE;
	Fri,  4 Oct 2024 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066686;
	bh=ReLgJE35yoIG/GdSIz+3KKTOjtzM5I/vyRK8weibBpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XW25GSL32GjvLDGcnFaJMawoB73fSElgwD3pOZ5XXw4bbkGlIpZWr266fF2BcU2da
	 TIorrisNL0tntXGA1N97BrpHKzQnJZ9FwCHqAPHuS+ufZ134eggl+tbY0PF2rjdqBq
	 FaWKasA2GfgsAJq/ps3XFXIzTVjxCLxPlFhwpvWZFkNE8gQzPkEW+x1PcSKfeArwBX
	 m+kgT/kCXQd44wHMX6X9KlOcnj9SNnyePgDt/c13RKjP37n0KF52naPZSBQK1zQ2el
	 jNt9IlXbT7KuY6dp0sl0WkaaE4De9O56cC4sQC0GqJQf0tly9y09NADLBYKON+rVms
	 6rtk8MbzlG1DQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 11/21] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  4 Oct 2024 14:30:46 -0400
Message-ID: <20241004183105.3675901-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
Content-Transfer-Encoding: 8bit

From: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>

[ Upstream commit 026f84d3fa62d215b11cbeb5a5d97df941e93b5c ]

The Qualcomm SA8775P root ports don't advertise an ACS capability, but they
do provide ACS-like features to disable peer transactions and validate bus
numbers in requests.

Thus, add an ACS quirk for the SA8775P.

Link: https://lore.kernel.org/linux-pci/20240906052228.1829485-1-quic_skananth@quicinc.com
Signed-off-by: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3bc7058404156..1e846b62feba5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4957,6 +4957,8 @@ static const struct pci_dev_acs_enabled {
 	/* QCOM QDF2xxx root ports */
 	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
+	/* QCOM SA8775P root port */
+	{ PCI_VENDOR_ID_QCOM, 0x0115, pci_quirk_qcom_rp_acs },
 	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
 	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
-- 
2.43.0


