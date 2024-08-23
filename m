Return-Path: <linux-pci+bounces-12059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D995C424
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247A9285767
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2860E54662;
	Fri, 23 Aug 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm3Mu0U8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159552F9E;
	Fri, 23 Aug 2024 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387157; cv=none; b=XooC+czCe749mefnA8b20cmbzsqryo5ySBu6mjj4JBWnPGTBINzZpTd9S2CnFlIoR+EBACLmk1G2z6GJb3wiP0W9cJ2fnDxKCdO2jFrIbyWAvs6pFb0As4F6q44P7F+kj6lNNulNPgIkrTsnYJrZRT65QFsssu0/ulEnKwn0qt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387157; c=relaxed/simple;
	bh=z0uQygdcAHrMjAXG1Lf9YOIxktlUNpBgvWQMl/loIQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYYjNCo09pNj6VGiNjpnzaBTaLObQUeEzfQEhrzkgsfFsxhBTXql0OHYji8wyFVwt+LDixpyacOJArR9oXqMSQWPxgFaaJ6Lz6uKdaNWbXz13xvwEu8OvL+FGCNZTiU9HW4jxw8Wbd08RJERYP4IBfKb2d49+s369CrhRLuYN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm3Mu0U8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB05C4AF14;
	Fri, 23 Aug 2024 04:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387156;
	bh=z0uQygdcAHrMjAXG1Lf9YOIxktlUNpBgvWQMl/loIQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gm3Mu0U8s/kLq8k1Xw3ypBJfyLWzDmT+kw6hbBSFaARn9/q6llg7W6S9MJ7OQATTF
	 yeualSjiCBu/gF+E87gB2ETQfVZCGAcQrPY7DLdqaHv6LgCxi7lkmY1Av0kG4xM/Fr
	 D0lyXSuv6KKfE8ttowgwVw5n46bxxD8nGTJQE+f8ATfuVXCQrOt4DX3tEUAyAMb2DX
	 GseYIHjaY4vtXYPI+KyPz5cLIrA6nFc6lhzbRWF+JfOGGAhFmUiZoDlrkSzSA4Fzvo
	 yho8aYx8V/cWlcWg/5l4+HyqohAXlKTROfxh6JrCvVoIVjD4KcPhfxB3IkDoMMMyWP
	 jeJGlCUbh+kHQ==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] x86/tsc: Use rdtsc_ordered() when RDTSCP or LFENCE_RDTSC are supported
Date: Thu, 22 Aug 2024 23:25:04 -0500
Message-ID: <20240823042508.1057791-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823042508.1057791-1-superm1@kernel.org>
References: <20240823042508.1057791-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On AMD processors the TSC has been reported drifting on and off for
various platforms.  This has been root caused to becaused by out of order
TSC and HPET counter values.  When the SoC supports RDTSCP or LFENCE_RDTSC
use ordered tsc reads instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/tsc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 94408a784c8e7..1c0cda1702bec 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -24,6 +24,9 @@ static inline cycles_t get_cycles(void)
 	if (!IS_ENABLED(CONFIG_X86_TSC) &&
 	    !cpu_feature_enabled(X86_FEATURE_TSC))
 		return 0;
+	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC) ||
+	    cpu_feature_enabled(X86_FEATURE_RDTSCP))
+		return rdtsc_ordered();
 	return rdtsc();
 }
 #define get_cycles get_cycles
-- 
2.43.0


