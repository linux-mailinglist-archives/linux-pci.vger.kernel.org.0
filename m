Return-Path: <linux-pci+bounces-20482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C3A20FEF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C44016780E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770C1F63E3;
	Tue, 28 Jan 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3W8HJ25"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B91F63DD;
	Tue, 28 Jan 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086852; cv=none; b=nD6wj6DTL3xXyRhwBqBWO4BiRTMbZNFdCvFAR67FSeIlx2FGGsIUE6DHpKsXhbXZaYAcnbQ1x6R6eGVZAOVHkkB2Bf1m3y14WsoJwSWT2YAKEEqYjQCh3vHQYAnzEJY/HzOYaD0ilqpq5umfT/PBf/k9Nu3yRKhe1OzjQ3xHSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086852; c=relaxed/simple;
	bh=nZgPIW+RCsGcgKd9OIKtj0HgzoUPCojhk/sJO9mSDAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5fR6nuSOJIdCFnFLRDJVVIv02yU8/RVttqTLijKTgyV/oZT/irywaxbGrPfEtQ8ByiXPIGzl8pSobGX8/Kca8lXPxP0tiVxA36Ef0euzfFauLvT0qNadVwn828TNalBE00TrRdH0VN9gSp5udeoKtnXUvnsQ7CKPsgb9QyahDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3W8HJ25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC92C4CEE2;
	Tue, 28 Jan 2025 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086852;
	bh=nZgPIW+RCsGcgKd9OIKtj0HgzoUPCojhk/sJO9mSDAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3W8HJ25WnjXJAiEJS0w8r+ApskzTTt8m1L9uvh6ZonTQR6vX7tswRwRYCaDTdjfK
	 +W9C1ah0mXadkeZpnAjuzeyCXMF5BpRo7sseDLzTw+3pIqqaV2KWQQCIvYuUD5Fr1/
	 shUXEE0XHCH3o5eL5wH6P7JSujjC0nDK9qyJGZ3CGM2DKDzGy+vAq4BhjNMnfLIlho
	 xAoP1EnG1vXZCpBPPr8FF2MOoHeFTLnaPdh0qaecu+FYbUtwzol+De1xr3BB1FbF//
	 QdNzCkoOBBz5AZWxNUcWRwaek/Ljt4PWQn7gNxL58V6dEgTTEOGHxfsYFZ7bCtKaLE
	 KwcxzReN06jWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 14/15] PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P
Date: Tue, 28 Jan 2025 12:53:45 -0500
Message-Id: <20250128175346.1197097-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175346.1197097-1-sashal@kernel.org>
References: <20250128175346.1197097-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b198499c7d2508a76243b98e7cca992f6fd2b7f7 ]

Apparently the Raptor Lake-P reference firmware configures the PIO log size
correctly, but some vendor BIOSes, including at least ASUSTeK COMPUTER INC.
Zenbook UX3402VA_UX3402VA, do not.

Apply the quirk for Raptor Lake-P.  This prevents kernel complaints like:

  DPC: RP PIO log size 0 is invalid

and also enables the DPC driver to dump the RP PIO Log registers when DPC
is triggered.

Note that the bug report also mentions 8086:a76e, which has been already
added by 627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake
Root Ports").

Link: https://lore.kernel.org/r/20250102164315.7562-1-tiwai@suse.de
Link: https://bugzilla.suse.com/show_bug.cgi?id=1234623
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a1..4ed3704ce92e8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6253,6 +6253,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
-- 
2.39.5


