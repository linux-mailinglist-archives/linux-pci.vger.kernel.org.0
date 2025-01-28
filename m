Return-Path: <linux-pci+bounces-20494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B220A2104C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5527A21A3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E4200BA9;
	Tue, 28 Jan 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGfCmCEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF256200BA2;
	Tue, 28 Jan 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086915; cv=none; b=iuJltl4Ptp1tJjMQ3ZicHpgYRLUNFVY/tsLoopKWpixogMaRRd5O1rdIOoRE/XU/8RoyAOV1usQJIFIHiknYHwnKUDACB96Go3k+eh9+FhY2L1RRr2D+ID0bzOzvDMkJg3RHununybjh81wZgbvZ55HNTGUe1zR/ccfTJ3raJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086915; c=relaxed/simple;
	bh=v1mfuCsD0UoyCi1L6a5JGBPlC9e9Ns/5g+EQOVxS9CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgdzRV5D6pixGreWlIQCH0AMinuRRLYb8o/BkVOzeCh8Pw9P+XKNUet9p0TQz9ABz0dvSsglks7n3C7qUmeJT/eHeHyl9F/hdEX3/r58ak5jzkGxcdNeBci4xuyD4AguisUg8HXbrX46+u5oufUOnfcI+XJ5J83u9L8M0y/ddjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGfCmCEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79E4C4CED3;
	Tue, 28 Jan 2025 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086915;
	bh=v1mfuCsD0UoyCi1L6a5JGBPlC9e9Ns/5g+EQOVxS9CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGfCmCEXDQNYt3QT/sA2qLghJIPtrX7UmNWgNWTBxVgUHc3162vbl3foJ/qq3Bd45
	 TrNNhXVUsIj5BzgOSAkvxib0zDPhrhwbB1rC2XRIpBEiEMYIr1STFmqTv5SjGvLgKy
	 uWdp7WS8n4+W/uk6j9Wa8RCf78cYeyHpSoxYGA3NyfAM46uGpKQ7Ip1DtiDzzIjab6
	 6UfOFyIy5k1rSme5cMoAfUP0nwDMWH1pAQtDFEuGD9IvFSgBIPjU3qp2KBa+CtsWRh
	 j+ohShJL86SWbyJdETPj98XPhPs3dP14tGbHEu362gzW1yYn8JvaGRsw0abIva0Yot
	 kAnjZG7An9HNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/3] PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P
Date: Tue, 28 Jan 2025 12:55:10 -0500
Message-Id: <20250128175510.1197735-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175510.1197735-1-sashal@kernel.org>
References: <20250128175510.1197735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index 7c65513e55c25..6564df6c9d0c1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5964,6 +5964,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
-- 
2.39.5


