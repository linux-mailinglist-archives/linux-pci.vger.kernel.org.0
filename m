Return-Path: <linux-pci+bounces-13836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F5C990B47
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712BE1F211A0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E985221E4D;
	Fri,  4 Oct 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXfYnKIK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B35221E48;
	Fri,  4 Oct 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065959; cv=none; b=kF+AWcBUrdvMiXdwqtsPd7OIgtk4+GBf4/qlAjDDHpqci447bPt8B3uq70jlfeSSTi8posRhs2XBxz9yWJqv9swHOOl1JF/+OKV+U5FiGPusVKv5wQdTOtlD1+fBQaVzbBJ2QIzQTxeYeiPLiI+WxE63iIv0dNwFVEr9Qlm9cbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065959; c=relaxed/simple;
	bh=T9FSG7KHJMwh3KSyMtOxrwtYHuwt9XZBB3dVvCGapi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMa5UW/ur40WwUK1dmb5I3yNLjcFZwy6X81eBOURhP+EjLSzBwO3ahlF1LzGcz2xhGHyAy+59sEHXpv+nk3MZ7SBfWOYC45ht7KFYGcDMKC00oAdDZvoLkxrFH8LDdtckIKBcpSoW+CPZDfyKiKnESDhsKeZ89ShKQDJE6jBbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXfYnKIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1123C4CEC6;
	Fri,  4 Oct 2024 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065957;
	bh=T9FSG7KHJMwh3KSyMtOxrwtYHuwt9XZBB3dVvCGapi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXfYnKIKzZn+HxHphlEy2xxldqXbEANCHjuorvn6RYDV/mj+yoi/crZvF/vM8HVfm
	 ubxt8tj8KAYEkheEu6ZepfdFv9zfATSzhFABL+tvrXk1JglOX4EqVin/Kg+X4ryB3D
	 0haQ37UJ3t+nkNSjpWGDh1FofRhNDddqaI8BB5Cerwwp15md6e0UUJzPRz8pTjtXPo
	 TQwn5j4nAtrArsqBtabk7QAmK26cSZlweA3MDtTF8oMXaoBIIB1cJn438Q/Qx/TaI/
	 yylItEhdRUVp/U9p/hmVWuhhh5h6g8RpRMJsBA8dHnVqplTn245FZwbW0/isu9jxMb
	 Ekq6Pm7Pfe6GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 27/76] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  4 Oct 2024 14:16:44 -0400
Message-ID: <20241004181828.3669209-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index cc6c82c3bd3d0..8502f8a27f239 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5074,6 +5074,8 @@ static const struct pci_dev_acs_enabled {
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


