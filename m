Return-Path: <linux-pci+bounces-21449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027BDA35D1F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 12:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF433B0225
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FB2066D8;
	Fri, 14 Feb 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8QhK/y4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EwcgCNJz"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2F275412;
	Fri, 14 Feb 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534004; cv=none; b=oDYy8NpvaLyM3xh4pUg51exdedk9Q1VrQxYO6R7SwELTmid6X/vS8KCrfjjYkpqh294z8btUUcP//pMfTjbu54/RwAeQPCfILvgT6LtQk1qM4BRDvnZFxPnwu1IjinyiSlZGWWAj5cKp/rjRwuc5HOM4coFWh9M27i8ic/gBCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534004; c=relaxed/simple;
	bh=md5n2k/tf1pks0MeAndLT0GhIynJyuMazB/ncs9fZG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c29S2/OdbIgX2kt3GI+TbHLxmAisFd1xYjemWd/uDK1Y6lvbK40bnLG2W8POjeq+K/ewOTzQkFFFJs0RD5cKEwCuQ9hYYwCMqhtyz7vqt4XxXKHJPWZRcY40b2oEG2EliW3hlBTB35G+BC+m9jCzqp4qN90Y+eFMJcU4k+U1eYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8QhK/y4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EwcgCNJz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739534001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWEz1ZWdWkion5MIyu8qQHqr+FAKdZJBuw4TfNzpQAw=;
	b=N8QhK/y4dwnmr4ugopa5yoykfbkMb8irN7O3zRSTu/OhAxgGch6PkMzgo5jTSnzvPacPST
	v3jPvkpIUXQS3zrDSU3W3BUS/djaZCd4dnn2t2Y3Md/hao3nIhs+R2LB3Vy1/lHaVJuXEs
	FLpI6P5RnGaeBUaQqCTNSD4hLsjWTXfZIKURDbpzH4NN8PgUcWQryMdczRnRbB3pEepWtJ
	DmBDZnV8fvk1jX1KtjWR+ylmkeBIDzaSYufyW4gslApJDYkdL87HhwfwXIjC+qXcCxl0e9
	fr7b0WjrkvdcgA3Qsb94A3uHLxp/2J4H4a3M9ntP9i+e0euRUfxd+Qzmr5SaZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739534001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWEz1ZWdWkion5MIyu8qQHqr+FAKdZJBuw4TfNzpQAw=;
	b=EwcgCNJzpir6XiFKZvbnPTawfCwZpEXo80qK9V1v65lBdmcVUHhzp/u/6wMu7bLxiQYVJ6
	6J0zFKm64ELGmNDQ==
To: Bjorn Helgaas <helgaas@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/3] pci/msi: remove pci_msi_ignore_mask
In-Reply-To: <20250205151731.GA915292@bhelgaas>
References: <20250205151731.GA915292@bhelgaas>
Date: Fri, 14 Feb 2025 12:53:20 +0100
Message-ID: <87y0y8ivyn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05 2025 at 09:17, Bjorn Helgaas wrote:
>> Albeit Devices behind a VMD bridge are not known to Xen, that doesn't me=
an
>> Linux cannot use them.  By inhibiting the usage of
>> VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mask
>> bodge devices behind a VMD bridge do work fine when use from a Linux Xen
>> hardware domain.  That's the whole point of the series.
>>=20
>> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>
> Needs an ack from Thomas.

No objections from my side (aside of your change log comments).

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

