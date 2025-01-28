Return-Path: <linux-pci+bounces-20493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF6A2104A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB528168FC2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F161FFC59;
	Tue, 28 Jan 2025 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8spWj4Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93111FFC56;
	Tue, 28 Jan 2025 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086909; cv=none; b=gCC6V/ud6M0rBVrYEGkfHFG/tI+3eU8hfTQ2INIXSvB0b6gPQMymR7GEqH/xynjTCSWXW1I8PUQeAW1CdRadrUGjTlELFXKile0HVBEsaaEkdgFp2aAe41sFYogrUxwjc+pXq72wyj3M2myrfSHd85D7NL8v0oYi825Yz+ECr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086909; c=relaxed/simple;
	bh=SKWaARZIH6yZcoMUHUSbOouic7bxx1Ltj5a8tIdbqf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBm3LCyjo+wAF+FlvC9cmXpbQeuXQ3ySUQ2aZcY4Y/m+MKc+B4sJMzpgKQC2xVL1+j2I05e8rbWtb3XC56Sw8YaPV+k+q+jhHIKGR463ifB5zu/0zWrfKBNT2pZvWZ6rCTyctL86msApHIln7lqiSwmbGNPQMANSXrsAOtrXBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8spWj4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BEEC4CEE1;
	Tue, 28 Jan 2025 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086909;
	bh=SKWaARZIH6yZcoMUHUSbOouic7bxx1Ltj5a8tIdbqf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8spWj4QtUjhQF1U1y+bmJyRDQvxUBVqrWUVZUPTaE+Jn3nwJ1GaWGtHV7gq7IFr6
	 cSKzkaPLlcCH12DwrHBxGGzslM47IEhNiObuUQQygyQxRpzUHgzVJm+4d5txNJP+PI
	 YtFNpXzpygVJfrOKoor77tOZhu7w1y5P8p44qYqbXiaiztMaGW1hpHryFqSpUmbWFQ
	 QO/XTWFtb5sBxaGzPWMQe9BE0+9AqDqWoAKQJGvZHntAp2MOdYUGDSNUdIXrT3ZGh3
	 ZCoOhjq3kN1/74qErWh0xVjDpJkCT2PZ6xqQZWpHxTIyQ3jJ4JidJT7jK/thkl24Of
	 4QyxEsMTGP9wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/3] PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P
Date: Tue, 28 Jan 2025 12:55:04 -0500
Message-Id: <20250128175504.1197685-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175504.1197685-1-sashal@kernel.org>
References: <20250128175504.1197685-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index 24fde99c11a70..a1f85120f97e6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6005,6 +6005,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
-- 
2.39.5


