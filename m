Return-Path: <linux-pci+bounces-24651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001CA6EDBB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E026188A7C0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08978F24;
	Tue, 25 Mar 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GlB1XmtB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQtOMNjv"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32D254AED;
	Tue, 25 Mar 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898475; cv=none; b=en32ZSESZglNYk6Tot6njWJmGsJGsuH9d0Any+s9Vf2RQSz/G3LOloMBMvG46Wg3VScBN5YRsohnLiY+9ThD6APrf+FfvIhqOp1nCin0/5c/47F/bJPIs6fxyZ+MTxHr+JB3dc81psIHRIdPQ80at+SUHDGUyoC6KhPGMV/2t7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898475; c=relaxed/simple;
	bh=sO2zRW2LVfn7/sESe/qE9A18pHkBu/5co8/Y8zkBJ1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ACiIWGkBzw+wN/CW/0sNg5HPdRGp3wMKet/7pIlb2tYZX0rKRpizgis7wGc9o6CzOClBI5ZHhUFOaaS0ZowqhqzyFbABmosbRkHKlfXqRGFRvi4lYc/mcorvQl3NXfhVnk6bnelef4H5FmEy6wKZtRXFq7mvW+gmq06bLEEaK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GlB1XmtB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQtOMNjv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742898471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvl32OvnPLRYSLXsLJD3K8ubXhDmR8NyKqSawYdGMGU=;
	b=GlB1XmtBcJzrR/EujG1DcxuA7GSuw8ztFlhOAfHTpW18x4tuITiexuxuxWMRjViF59p7Ts
	Q0WJKTzWxNhFOWCGCfvFG8bywkIZyKvEulLAE4j8J+UHdULxVLa+DgAfELJ6iueGaVLEtY
	eHPixsxZ+WEuc4blT5gxAkNd7Pz5prQImkJcqCrdNVZ706TR/Xy4N4/VaG+xf+9Ipqd5xI
	JECGdEvNBe33JEoKh3Femg0RcO6k076a8OfUXFfkKWZXxGXzty9Q1dOGC/kNQL5cI4bzMh
	K9qKiyVv++xK59IaoDxbQbk589UwE0EJ9N3ensrAQAwcRvmBusSLx2kj3Oa9Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742898471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvl32OvnPLRYSLXsLJD3K8ubXhDmR8NyKqSawYdGMGU=;
	b=IQtOMNjvK2eZQPfrHHpxBU1R9ZHHsOc49/SwQ6rT6QsZ59ArWrRfX08DcAm7emFuXfy01b
	shG3B2ECVR92IsBA==
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, Bjorn
 Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
In-Reply-To: <Z-KDyCzeovpFGiVu@macbook.local>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx>
 <87v7rxzct0.ffs@tglx> <Z-KDyCzeovpFGiVu@macbook.local>
Date: Tue, 25 Mar 2025 11:27:51 +0100
Message-ID: <87sen1z9p4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25 2025 at 11:22, Roger Pau Monn=C3=A9 wrote:
> On Tue, Mar 25, 2025 at 10:20:43AM +0100, Thomas Gleixner wrote:
> I'm a bit confused by what msi_create_device_irq_domain() does, as it
> does allocate an irq_domain with an associated msi_domain_info
> structure, however that irq_domain is set in
> dev->msi.data->__domains[domid].domain rather than dev->msi.domain,
> and doesn't override the default irq_domain set by
> pcibios_device_add().

The default irq domain is a parent domain in that case on top of which
the per device domains are built. And those are private to the device.

The XEN variant uses the original global PCI/MSI domain concept with
this outrageous domain wrapper hack. A crime committed by some tglx
dude.

> And the default x86 irq_domain (set by pcibios_device_add()) doesn't
> have an associated msi_domain_info.

It does not need one.

Thanks,

        tglx

