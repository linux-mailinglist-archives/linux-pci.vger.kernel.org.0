Return-Path: <linux-pci+bounces-13843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657CE990C49
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFCB1C22584
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E621F54FA;
	Fri,  4 Oct 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0NDTB3J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222461F54F6;
	Fri,  4 Oct 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066169; cv=none; b=VsbsDxmyGbgWvt1Gr47/qElRLzFsM2R2is7x9OMUISJ+tJh2RF0QnWphx7+Zz+8V0ngHdtaP+06OBwp+lzXlWlN237FkIkjd4DaqJmwFj14JTmt+MELPVHf87xNnL5jTkXy3hS3xRA33qoXXggRiFHbwjwddBoKCmEdCRngohks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066169; c=relaxed/simple;
	bh=xujVA5xSDetm1nfAYYEnDj1/taR+iuBVKWIr+H6w7M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOTtWdm/NCsGKIVdnCZa0Y/r2gwiN+geRK0m7urdM1agIo2N/CybROsTiTNAjJAMDvYSHiYyysttnerKMSoMAIa5AGzmIWtV1tbgqd8txFeHkfyX0RJyFnNoJrfM9Wu3x07i4ZHBBO+njBcM9y9ObVVJ5vZoafVnplpk8QjHSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0NDTB3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27F3C4CEC6;
	Fri,  4 Oct 2024 18:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066168;
	bh=xujVA5xSDetm1nfAYYEnDj1/taR+iuBVKWIr+H6w7M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0NDTB3J4R9GXhUhLmExg0A6F1NcWboIOEbzpUsYR8QGjgs+NnV9wLPh6Pnt0KgwA
	 mKpjbiIp+J+KC0a805/wrrCUaPwCYT6GjEUyox+dtOmRRK68Cxz6Hwdik/5Il6SiCM
	 0uKUDdxY9d2YBBYkRC7HAuZ5ZSBql57liMPeQ/tuKJ3IHlGwk5LJ71F1Njy8L96dSY
	 2mA3BSAszR3jIrwFuH+scG0PvygcTPl7oq+mAbpvXxxdfgir8drcEZG+ceSU3Ekdzw
	 voNKfU6YrXuz+vNgb3qPZuTXL8HncDC2/fu2TxaAb6UncPrFKlXP26TNIFHvJVuHq+
	 sqTAzd+Ol7UzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 26/70] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  4 Oct 2024 14:20:24 -0400
Message-ID: <20241004182200.3670903-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index 2c327ddd7f83e..e616add85b134 100644
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


