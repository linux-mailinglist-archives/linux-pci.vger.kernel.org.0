Return-Path: <linux-pci+bounces-20488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA879A21042
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9945E188ADC0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA371FBE83;
	Tue, 28 Jan 2025 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfPg+fjY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E181FBCBE;
	Tue, 28 Jan 2025 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086893; cv=none; b=kbImQ2Qd4OSdq5bgvW2KqF76LfcQwHk34rhkT/9xpx6PnY+uRO3OLZ0sS2DOms6U1os1FencDnCVqktbCGETgUpqDO42km600ppmzH2bCd0Z/VFFRNwmdmZa9fVBLFY+W1cX0fJ4dTAoXhUfrO1F+Et0tpdkm/yBk0QoTXUVDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086893; c=relaxed/simple;
	bh=TzBwCX9j17IM44q2shCYjPrak6BigKhiP3Yk9p0LNXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBiTIFqfLq3qkeQL85jFPyFAqaiLFo4e2bOi8BFM4HOZzym4U+exfpTH7v4/l99CCBYRg+HlNutl0yqaVdeTyKxHYXpXSQP+mVzmgi0guY372knRvK3wFIufAfvxDym48RsDq4C4kMk5dZqC7DhEfBFUqlwKrU7+mt+UoNDAiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfPg+fjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25529C4AF09;
	Tue, 28 Jan 2025 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086893;
	bh=TzBwCX9j17IM44q2shCYjPrak6BigKhiP3Yk9p0LNXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfPg+fjYUMSoVvmpPDVlwxEwM3m6FjgC34WPZ6xfYmXpS02iEG/uyNMTwtOaOd3mT
	 ygVo5pwecl1g0wZLU0eKecVRlWHxaE8JNhwecEH58NLmNrDiSydKI8FlIAbRKQffN+
	 F6Xl5B8TY0Er5FXw7WpdMLfdYj2EB/KaNkel2wZ7YC/k8H2Xfrvu75e42wVWz/lVO+
	 ocQCLd8vVo64dDLvz7N5eO2BPh/9YLCiue07xnQQLVwAJTxF/idfQphJJp3gfSCay9
	 xGLfnSjo/Mzo30jqyF5iP+kP7V2zSanGQ9q1EDgBJOJdIb7wqfwsh+oSUozCFsH86a
	 Ftnm7K2vSBhzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/11] PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P
Date: Tue, 28 Jan 2025 12:54:34 -0500
Message-Id: <20250128175435.1197457-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175435.1197457-1-sashal@kernel.org>
References: <20250128175435.1197457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index fd35ad0648a07..a256928fb126c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6247,6 +6247,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
-- 
2.39.5


