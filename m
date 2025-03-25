Return-Path: <linux-pci+bounces-24631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDDA6EB25
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 09:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA5F189193B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35491253F2D;
	Tue, 25 Mar 2025 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuu9Wv6p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zawn//iF"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2F253B60;
	Tue, 25 Mar 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890274; cv=none; b=HB/+k7Pz5rOeNDD+jSSIaJUWF0mPaTcVNEKJlnR7mkeZnPxKtFhCKs9qP7+/ensCOTmGzE1CFTFxr7oaWvXVjYg4lMDj7aUV6meVgqXzk4jYyTYbRsGEhk1rc1h4JF82i4rlZHTt+EGFWL0VRfW6614kNOj8F4be2VLok4x5B2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890274; c=relaxed/simple;
	bh=8gjoMs+t6/hW1hSlaknfnqD78WUml+/4v7BFGq/X2W8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wp+PopehmVBy3jDuyF0J4x/fGRfi3W7i6YuvsbRCABYl8eGxM56cQYwlKRgzdpHdhjNwhTeXuSIOs+DRCEDP6jQcak34gW5BJStaaj3D66akKMN4vuhAx1HNN+wwbgJbWdiRewfTBix4X7M0otAg54ZwIt3RPmRsceWvt+lYQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuu9Wv6p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zawn//iF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBlYuYPxuiW4f/YH3m2JiPO9h8/st5bDHO18kaoaxWU=;
	b=xuu9Wv6psqJzPFfn8nMntVCSCH9iODJd96EJ94rTd8BA3tpxSRI7FC+Z8px+3BfOtKWwz4
	EQNAYMOijbgOFFS7+rH/VfTxOn3FxTl5i4udS+twC9fl5AXSJ702DONji18Nfzufxt3P8k
	hAJMo9n336BIMnf84oX/JXqSA0j0lKk6zhJuprnlWpwoGcrlYJRF1G/qysdW9NOceQ8IWz
	AxC3zXeAMYHxivQJvG3CSp+tbm0DA65C8MoZL07GOeZp7AaIlLeLgXZ217wNE9p4f98eNQ
	FWWjzyRHu5AOK9111zSqok0p+97KrvNlYKC5GAOPqqYwJuqrraND0jAhG6UZfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBlYuYPxuiW4f/YH3m2JiPO9h8/st5bDHO18kaoaxWU=;
	b=zawn//iFOlyQCFAWgDgHOmxcNuu0Ak6JkpKA/7TZ4dwphNSIIW3fFEFxxZVI3iFGgo16uU
	kGLzpS+oUoMNZnBg==
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>, Daniel Gomez
 <da.gomez@kernel.org>
Cc: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Bjorn Helgaas
 <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
In-Reply-To: <Z-Gv6TG9dwKI-fvz@macbook.local>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local>
Date: Tue, 25 Mar 2025 09:11:08 +0100
Message-ID: <87y0wtzg0z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24 2025 at 20:18, Roger Pau Monn=C3=A9 wrote:
> On Mon, Mar 24, 2025 at 07:58:14PM +0100, Daniel Gomez wrote:
>> The issue is that info appears to be uninitialized. So, this worked for =
me:
>
> Indeed, irq_domain->host_data is NULL, there's no msi_domain_info.  As
> this is x86, I was expecting x86 ot always use
> x86_init_dev_msi_info(), but that doesn't seem to be the case.  I
> would like to better understand this.

Indeed. On x86 this should not happen at all. On architectures, which do
not use (hierarchical) interrupt domains, it will return NULL.

So I really want to understand why this happens on x86 before such a
"fix" is deployed.

Thanks,

        tglx

