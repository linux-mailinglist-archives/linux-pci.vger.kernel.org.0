Return-Path: <linux-pci+bounces-35321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56704B400C5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83347B996A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79C256C8D;
	Tue,  2 Sep 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQcWOFhi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DdHE4rcb"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF3253B52;
	Tue,  2 Sep 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816554; cv=none; b=LxPASxIl8j8J2HjnbUGFPAaRy8HpXKGO2qpvreoHqYlJNuBzFhJXD7aZeAOdA5iu5kyJHoeMIHtnj2v8CS+OKRFkW9UuqOq1gYOE+GGA7gbsZ8upw/4eclbS+N139rnqHlbvahm0XHoynf1GTWDr2bn9Eo+jbt0Fl1T0rdG5SZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816554; c=relaxed/simple;
	bh=ofPVTEywHjbZi7xI7CE4Pos2/8kJGdtAszi9dDtY1Yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QVX3T18o9xlg/wEhigl1Efctx1fAvenWnmDq4UqSZxrXdH5MAdiEpgKf0kVwJzdqTMJa2Swu5+sxzUtPmxq4fB3KEovEtEhrslIpIQlmCEx6dKGDwiNR+3mYhTjJbqV3uQpEU5yIGDd4TsckKMmVyxyCt9/kefEMhrTxZAlOcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQcWOFhi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DdHE4rcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756816549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofPVTEywHjbZi7xI7CE4Pos2/8kJGdtAszi9dDtY1Yw=;
	b=BQcWOFhi1s9XaHj3atjY/jHB2pGHgZbpv2VJpo2dMhwugS46f2d+JgTvZn0Qd4KDMb3LCO
	qDfgwnQ9znqdmU2XSJvtSc21L+EJAcx/eZJTutVHJIgix7xQByCwsiEz/EfIa+cAXz6Tj4
	u4yuLz6E/X3nZggYB1t6lROqu50+Q7iDw1YVo+XdaEs2nXp/h2lYV/W6jjZXKfEcRRw/y7
	1UA4JgrueoqF2xbcl3d4LGg0cgvmdT8YldhFwNu5Jmc9Lw+pMjrlD51MoSOP1D51IwYDcZ
	ET92AdLLNctiKv652dhzOrUPlo6wRIG4GuOS6azAOcpVMFaKgdFtilYC7ryHew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756816549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofPVTEywHjbZi7xI7CE4Pos2/8kJGdtAszi9dDtY1Yw=;
	b=DdHE4rcb+q0FXllbsuEWCmur2wEAZj0Ge4LIL3leGp+wKUqDKwE3E0WOOCVGCnBm+2FV2r
	zE9wH682NbQG6EDg==
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Inochi Amaoto
 <inochiama@gmail.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li
 <looong.bin@gmail.com>, Linux Kernel Functional Testing <lkft@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>, Wei Fang <wei.fang@nxp.com>, Jon
 Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
In-Reply-To: <fqnwjgkqpvgxnzqocsdzqxyrczitjrztaxupjk43sk3gcgwbk2@3b6624izsfny>
References: <20250827230943.17829-1-inochiama@gmail.com>
 <fqnwjgkqpvgxnzqocsdzqxyrczitjrztaxupjk43sk3gcgwbk2@3b6624izsfny>
Date: Tue, 02 Sep 2025 14:35:43 +0200
Message-ID: <874itl2fs0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 02 2025 at 06:20, Inochi Amaoto wrote:
> Could you take this patch? I think this fix is good to go now.

I was AFK last week. Looking at it now.

