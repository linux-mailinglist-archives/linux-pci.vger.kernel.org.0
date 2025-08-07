Return-Path: <linux-pci+bounces-33509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908BEB1D1AC
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 06:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A796726506
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 04:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220615624D;
	Thu,  7 Aug 2025 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GvpP3D0D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9adb0lZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47576155A4D
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541569; cv=none; b=pqjIlKdl67qs6v3G1H0n+x6ymbMGR4S6B7U4FOubmsyf4r2Y/g7ZhdmNv4awlEvFHtnp3SOayIWl5jLPtH+UJLQXkx0soQqi7IAXocV3zoaPrqJE+hl0+jFK8NxwvSUW99lr86ZnlWBGDe85loJSnNM7tAG+dP/eSDMeD7gEvlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541569; c=relaxed/simple;
	bh=xzJoI+9NIgx3m+GyBfFg4Xyx1uTyMD9RBMfniGyl47Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3Ehau/l6jm9U8MRDMlPVVcmzDZurKQG9zKTaq6K6lo4gx1bfsCsW5afnqspYY1WOm8oIiwVKGlz1bs8C9zYeZIHpWGxe8xJkUCoKTVfgKsQHt0e2nFABB12FqkplLJtBQacUGMSbvAlSW6u6nSRgPMXiGNhUlk9IlhqonVCXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GvpP3D0D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9adb0lZ5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754541564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIZDXMI969rDLReVrkjd5HxH/u+fi1a99CGPUg0ZcV8=;
	b=GvpP3D0Dsd9oHiUGgzZwga2rHY/e3f3ZNGoM0r3JNxUnvD1A6janQQtU9eYpXTt49ThMmT
	l/L3tVtgVL1gSobeIwxFJDXSc6cVhvoyps8Ior33ngbJDVFBf13UGN1x+5EnZ5nk2lKMaj
	udaaCl+9lfNrhhz+ktxuebkDuSIA1u307A04tCOboW3nG9ifPWtuPAiT2NZNwJ8KL9pyPV
	aTbQ/fSRWChltgNOy9OQpiyxkaG280mEN0P2c0mDAKcbN4dh39mm2xk2A0Ynl66bzva6s0
	mdgGfnnOwRh2snuf/DmNPCGuk0xNy0JhOYtHmnuxSFazI4AJwk5QA03LFL+Tug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754541564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIZDXMI969rDLReVrkjd5HxH/u+fi1a99CGPUg0ZcV8=;
	b=9adb0lZ5EwHKMsDmh2WY84utlvnBGApW+gL2K3+OrVYUTKGMD9ryPKHGxdfegJRLtlor92
	z2nZDTBZxNrWQVCw==
To: Kenneth Crudup <kenny@panix.com>
Cc: Me <kenny@panix.com>, mani@kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Commit d7d8ab87e3e ("PCI: vmd: Switch to
 msi_create_parent_irq_domain()") causes early-stage reboots on my Dell
 XPS-9320
In-Reply-To: <dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com>
References: <dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com>
Date: Thu, 07 Aug 2025 06:39:13 +0200
Message-ID: <87v7mzn3ta.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kenneth Crudup <kenny@panix.com> writes:

> I'm running Linus' master (as of today, cca7a0aae8958c9b1).
>
> If I revert the named commit, I can boot OK. Unfortunately there's no 
> real output before the machine reboots, to help identify the problem.
>
> I have a(n enabled) VMD in my Alderlake machine:
>
> [    0.141952] [      T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM) 
> i7-1280P (family: 0x6, model: 0x9a, stepping: 0x3)
>
> If there's something else I can try, let me know.

Thanks for the report. It is unfortunate that there is no output to work
with :(

Let me stare at the commit again..

Nam

