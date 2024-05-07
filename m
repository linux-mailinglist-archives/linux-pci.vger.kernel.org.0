Return-Path: <linux-pci+bounces-7202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5CA8BF2E1
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC12280F6D
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C880E84E17;
	Tue,  7 May 2024 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XcGoajtF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAC7F7DD;
	Tue,  7 May 2024 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124267; cv=none; b=kNY0CcnzrWVD4iVJuBB1Z1/5USvGCoCDHZPwsEDpk2G5SCB0UGYfXriIMKLeFhRx479kBFjKsD1HIEtics1Jpe9jy3uxkL3aJk5xM2Cl1oGF2nrxt/xPSPJiQ0+I9+2pBHyUdJAJL7rKp5J3ri1B2nKbwXPqTEDkOpCAUP4sRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124267; c=relaxed/simple;
	bh=X2F+VlsprwM7D7QdSU7qc7Fj0UntWxZBPgo7PsGeKp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYD7Y2quANztln5ky5OduKlSfGr4AYfb0v6iCZYfDnkTq80g0pLed2zUJGPlwpZrcgNR/dgSykV2YqQY4MZfnZhFbZB1lIYTL5P2H47satnayZn7rWSDFFfbVtwRvYUfH3vXnXwg0W68wXud2E7cyeXL7Tt3CLLfQ4m7gdQ6ebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XcGoajtF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zO7+af/nqjoK/XsjAJJmhBSOwqfXQqfufQdsPrFjh/o=; b=XcGoajtFG7zD1NTG
	RNMryF46vcvoWxsSG7TqHfSqziSdpHgtXZe9YrObY5roJk/DorKqR80jHTpueB2cU9gTIOGi8mwhH
	pBBMY/xPdNQfkOdRJtfcvU9eBGlfOwwq3TfmrkW88fej6C1EF+IwgvFjfvfAVCPfkHV3kg29Lrv7u
	zvF7NhTbRxaAy/gxTFFB26DbTSD0GBn2pDRV1h/WZWsH0YfzTFV/FmHiccJ4lmFmFjY65UMyJcdi9
	O03aW04Z7J4fSazgG1k6bTewelhG9nBVVviqxMpER2bC4hBRAaFL25yLOP0Hf8hQiup72N7gRz88T
	0hZNdoJgdQ6+Jn/eng==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s4UA9-005Huy-1O;
	Tue, 07 May 2024 23:23:57 +0000
From: linux@treblig.org
To: bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] x86: ce4100: Remove unused struct 'sim_reg_op'
Date: Wed,  8 May 2024 00:23:48 +0100
Message-ID: <20240507232348.46677-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

struct 'sim_reg_op' doesn't look like it was ever used.
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/x86/pci/ce4100.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
index 87313701f069e..f5dbd25651e0f 100644
--- a/arch/x86/pci/ce4100.c
+++ b/arch/x86/pci/ce4100.c
@@ -35,12 +35,6 @@ struct sim_dev_reg {
 	struct sim_reg sim_reg;
 };
 
-struct sim_reg_op {
-	void (*init)(struct sim_dev_reg *reg);
-	void (*read)(struct sim_dev_reg *reg, u32 value);
-	void (*write)(struct sim_dev_reg *reg, u32 value);
-};
-
 #define MB (1024 * 1024)
 #define KB (1024)
 #define SIZE_TO_MASK(size) (~(size - 1))
-- 
2.45.0


