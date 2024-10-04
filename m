Return-Path: <linux-pci+bounces-13861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6116990E90
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702EE281022
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EFD1DF98C;
	Fri,  4 Oct 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgjpQEKu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AD1DF985;
	Fri,  4 Oct 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066633; cv=none; b=C8k8mhO0hHUHHOG1kCYqkOK5WxE1xpqGXTvz7ZPD5EHV19PaALOIaXUiSCHLgJ0tBUAOXCCFAgt5PP41Za+UvZV3op++2xVBDlS53FzriHvBW1MOVU+VPH2dViBAzmXchino8Uspiv9dJr9Zog5XxJxvK+ANN3TQz2I/9KzK9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066633; c=relaxed/simple;
	bh=48xF3KYPyrDhFK+NnnNn7XOaMc2resuKCWppNm+DSzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1i24yxLcV7qe6toUrbKFxJjpNO1nks6KVWyNoxURiRqa9OfoY/L3Qv3hiE7cSTwf6ETTW7gVJSCVzfyLNkAublatj0XuZN2q5xbJs8b3YdpnwQaq6+hVPPW7mNUPT4/reRSigAnzVKPQoKINcjZnDB1/ugPHUxFxf//7/X7/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgjpQEKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445F5C4CEC6;
	Fri,  4 Oct 2024 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066633;
	bh=48xF3KYPyrDhFK+NnnNn7XOaMc2resuKCWppNm+DSzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgjpQEKuO/532IKpSeO28mMxZHvbHyRKOkh6ZoT8MhhD8XdzqC3reIrpwDBDUIbvT
	 gfPrEwDyw4pY+7rFMhZI6R32wsVChA3hnhy5bskAeShKHYozP6HyW4AF5LuHyHT0TD
	 j7HlgLPnu/SJNcfpEDnRKPc26wVjAHEUy+/pZe44eMVrThdtE2iVvg8dKHtoW90zLk
	 FOWfRiz2gR0HuuIuZU/qyOYcbEnxUEeg+H9Ym6X6z+iwMJBY29Wsn7TQnChV7PWwGf
	 ZjoWuM7rl77e9lIXlZfSIp0Aa/qJ2JROqAihbSxau5kVvD+Nz6mQNTXIjQgXCik1V1
	 dDRoX2b30H/Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 14/26] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  4 Oct 2024 14:29:40 -0400
Message-ID: <20241004183005.3675332-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 6f782734bb6e6..f0bbdc72255ed 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4920,6 +4920,8 @@ static const struct pci_dev_acs_enabled {
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


