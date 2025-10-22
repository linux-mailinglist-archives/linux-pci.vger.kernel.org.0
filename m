Return-Path: <linux-pci+bounces-39033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4918BFCBB2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC026E277C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52434BA2A;
	Wed, 22 Oct 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcJgRTt1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498934BA5A
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144566; cv=none; b=LKSZ0Cqdb0MUZgoS+rmpcc2YXjmvI+jU4A9mcRRq1xqS7OveNYGHKhRCOdiSz0k/l5XdPUqrYR5TxVx/sz2EDxiz7p4dDSqbblKfTzZcSrgUq2nOvMFMnqV9XUe3femeMnsyMbg7IlL1jualtOvtYZ0qupBW0uXrli62fxhNZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144566; c=relaxed/simple;
	bh=uVrdZywsvojbYW/ShZ3B9IaBmkqNPvUEGHR6+1PI74k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OT6D1prV2V60DYTDFh3dI8iJyEsBdHu8Er020iCEY2GQH044f4J6D7yHkDX9VD9qBJEcXJBkLR7auxsCBzVUBjL3KOgYfpT3mMrctpuIj1CmMBZ8W94Idrt0rOHFYtIYOOsk1VM3fIWcLzWCQHSj1K3sgPc+WoR7p2wjCnL9f1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcJgRTt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B649FC4AF0C
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761144565;
	bh=uVrdZywsvojbYW/ShZ3B9IaBmkqNPvUEGHR6+1PI74k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GcJgRTt18PR4/e4uws6LwZjy1R0K2MCAp8USsjjTmVZx1oyWEl3Kxq5T/eR1gkHN6
	 I7fjD/0E2s/aJx6ALEKPMtGO3wY1eVe/fePPj6hNdBBzHMqi6kItpliihowOg9+02f
	 PMC5NjSpNhpoC011pCDGed9ItzvAINsOYHWT6DvpbcmTNbsM5n3CQnpakRlQTTKlm9
	 Rof59w4IDYinQBDLZ6gvYT30l+wAJqn98PYApDbG8S+0A/6adKoCZezbGuICe6lljJ
	 L+Zl3/X+wcmcNi+THWXMxrwk+COs0y4EsJ9li23GqKXGCEE0Xg7RQpBfrDLH8JgqO/
	 pVY1VcMmeJFfw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso266588166b.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:49:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjR3lqHcWbTisUF8BH4eCvZVlvrS8sE2mauKTPRnGr4zVp+IwBMLVoDOjIGjc7RAKC06WoRMIuw8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyne+56h0z94Je+bbN7UtgiacSmIsRcMMNAD8RL2hgN7dEdDNiE
	8v8Cn2iHsYxc6ByPGaxHJ8ebA0mSUoLnauBiIyO7NKBxma7al9e1yRgVcKCB61FzmN1i9xXjm+i
	LTSR+aHkTRtY3un9U9hSnpsyFV/8zZng=
X-Google-Smtp-Source: AGHT+IHjqF8CkmN+ksVn7kZFTC5DOe4Xj1ExP2XN4rxEOErSMM7ORyjkPQbVjXcg6vLar9lNkIS1JPp/onN4LXQGjv4=
X-Received: by 2002:a17:907:6d25:b0:b41:abc9:6135 with SMTP id
 a640c23a62f3a-b647493fa65mr2548249766b.41.1761144564348; Wed, 22 Oct 2025
 07:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3f11e8562f589ddb2c1c83e74161bd8948084c3.camel@linux.ibm.com>
In-Reply-To: <d3f11e8562f589ddb2c1c83e74161bd8948084c3.camel@linux.ibm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Oct 2025 22:49:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Q932R0fAbL6JyygZcgALdO_HJZ1Cqo88EhNMm04yjtQ@mail.gmail.com>
X-Gm-Features: AS18NWAQpPsXDHwOTvTcc1X8jgpB0I5uU_kcTmy7oSSQ6mezCquTSny3lerp1-Q
Message-ID: <CAAhV-H4Q932R0fAbL6JyygZcgALdO_HJZ1Cqo88EhNMm04yjtQ@mail.gmail.com>
Subject: Re: Potential issue with hypervisor_isolated_pci_functions() handling
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, jailhouse-dev@googlegroups.com, 
	linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev, 
	Farhan Ali <alifm@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Gerd Bayer <gbayer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Niklas,

On Wed, Oct 22, 2025 at 7:40=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> Hi Huacai, Hi Jan, Hi Bjorn,
>
> I noticed that with commit a02fd05661d7 ("PCI: Extend isolated function
> probing to LoongArch") LoongArch now also makes use of the isolated
> function probing. First, nice to see this sees more users and that the
> interface is useful to you.
>
> Seeing this, I was reminded of an issue I ran into when using this
> mechanism with SR-IOV capable devices. In that case VFs with devfn > 7
> and PCI_SLOT(devfn) !=3D 0 wouldn't get probed.
> This is because if a device is found next_fn() will check whether dev-
> >multifunction is set. So if for example devfn =3D=3D 8 is found (fn =3D=
=3D 0)
> dev->multifunction won't be set in pci_scan_slot() and for VFs it's
> also not set via PCI_HEADER_TYPE_MFD. So we won't check for devfn =3D=3D =
9
> even though that could very well be there.
>
> Now for s390 this currently doesn't cause issues because for all
> multifunction devices we have, we either get a VF alone and then since
> commit 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs") use devfn
> =3D=3D 0, or we have the parent PF passed-through and then VFs always get
> hot plugged after SR-IOV enable, which then uses
> pci_scan_single_device(). And for non VFs we always have devfn =3D=3D 0
> and/or devfn =3D=3D 1 and multifunction via the header. So in a sense the
> above commit works around the issue, though that wasn't its primary
> intention.
>
> Did either of you also run into this issue or can reproduce it?
>
> Somewhat related, if ARI is enabled this would also break the isolated
> function case including on s390 where ARI is used by the platform
> firmware, but detected as off by Linux because there is no struct
> pci_dev associated with the PCI bus. If I patch Linux to correctly
> detect ARI, it no longer finds an isolated PF with devfn =3D=3D 1.
LoongArch do have some problems after commit a02fd05661d7 ("PCI:
Extend isolated function probing to LoongArch"). Please see:
https://lore.kernel.org/linux-pci/20251014074100.2149737-1-chenhuacai@loong=
son.cn/

Now we don't know what happens exactly, so I haven't answered Bjorn's
question...

Huacai
>
> Thanks,
> Niklas Schnelle

