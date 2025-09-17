Return-Path: <linux-pci+bounces-36331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C7EB7E3C8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C331C05702
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7EC309EF4;
	Wed, 17 Sep 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWYeaC/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664682C029B
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100121; cv=none; b=XPxDToEVpbTVk1yR7Z3ernqRSjHYZvRBaTC7tQh8Ff0Bdw/yR7fdFF3T1VzdnEUXeWpCPtTGlgm4OtqODG+KtSO+3h8VExRIFgcOKipES4n1KHvuMopdze2Qp4AyAuUQ4vmLGuazpoqoSmTTWDGrQmaF2NcNoFtjrAOYzLDlt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100121; c=relaxed/simple;
	bh=NeezwXJGXj1F48zED42vI0NBwfeDht8tdHK17U7LJj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpcDx37HFff3XkwvT7TXG7/TIq9uN43h3rcUG+GinZbaAbRf781x5xqLJXp9HQsEFxphlbBmbFhbK3mfiLjxtRF9o0tgxgI4e3W8TbgAebPvf3pq55mmXbbZWaNDtngQKFzRY2NZknRt9I92CDVfuuk8b1lcg51p0ds40EZqQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWYeaC/m; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b79a332631so44774811cf.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100119; x=1758704919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fK/yzR2nnSWjMEz9dB3Wx1OEnDScXAn49RB1q8EWFFA=;
        b=GWYeaC/mnJPj68AWbeYS1ho3RtcxWqlJXqILTaLn4GQ4lFKPWsioNhgWQzDKvcZ8bW
         I1doD86r4Ne/lDsxfQiw7+Wy5yht7ZAu7NJbckdAI/qU/cUGFA+UeLEyR4UdroT0g8bV
         s94md3Fgdbl3WWc16vSNkVTSACof0d8eB0qzbeKdC0JH+IbHseW5TKcO7KBpCzT2cDnj
         b4Q+Z/PfFouZKlcL1u2KQEdvHTPP9Qa+JLQx20kYwYEEpKnzVhWLi3GH/jecU6ywbeSj
         3AdbQDkBdryQ1V0Y304DLSDJeSxSU++MJZ2U0NGgxAwDVpkjc8fOSMTD6tO5y6Ym1fFe
         6ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100119; x=1758704919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK/yzR2nnSWjMEz9dB3Wx1OEnDScXAn49RB1q8EWFFA=;
        b=DoVQhlLlj8XWD6yxqXSwgpfn4QPXTLoduz5ZOPDhw8rApWdz6uPYqI6ANlUvffwZ4r
         fOaXPNiWAy2F/hPeXC4dJxoNOSOX7y8Zt3lhxLKbI6g+MHrSwlWKM7t0tHe26xqbma93
         5ycBC52BCbjh5H79rQ3LDEBRyqu0RyDfnCtqnILygU+NcXJWMrrpyYPpf2gZtIDzo4KA
         6nMxTFdvk93xNga585kRW5IPRCzmQ34LZnmC8skw4NyrPyQf3854Y3HjyeembdZYUevr
         9Mf7eMpxts63fgR81JE1AhrI9VoNsMFIX9K2d8Tna3o4e0r8a+7xdNxzMr/4rQ6S3Tes
         66Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXe1f6LOVCmhdpm9TAtLmKwoLlQP9kGNvpHpL2u2H8nu0lSSNYunxfdft9sqoqm3Yj5o8HDBSCM0PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMvHB395xgarbs5vQWyaQDD3JsvlBWDOtTDzrRl9TeO+sgz8Da
	T9qiHaVUQDwUF0MFISWxxFnxbaeBT5fo1xvkQknRRbKw8u2iH9GUCtM4wwxOUq4l1dF2jMkRZYG
	roMkVT8zxAxq5IMpprQC7jSsxiNlvg4A=
X-Gm-Gg: ASbGncuYCEws+8p4A1PS6g6XMJvqXmpDTtNacnEXTGLQ93O8XrHneURwmmNT0wY/puP
	9uJY7ZVwmeCF0CREwEv2G9wSHGCqK8aOnGuRprIG8iVa3+xne0Quuk0mOgWUebgquiAV9g3u8rW
	X4dwVbQ1oDG99kYr2jTWo6jAn7bm757P1DS6Rj7souMSsVdrNdhCKmEesTCYsSNj6LhGXwSULt8
	TbrnLOoE0w9ioyau23DiAPuLIe0mKGZLA==
X-Google-Smtp-Source: AGHT+IGRJYabvoXtUgHqoVUxLFqRyhVbHtP5lPSZqDeZu2ftLXnWMA9CFSzK00cfR7SmG3eP5ESVB2ecKnDgWzcZQpY=
X-Received: by 2002:a05:622a:ce:b0:4b7:a92a:fbe9 with SMTP id
 d75a77b69052e-4ba6b750ddamr12109131cf.60.1758100119354; Wed, 17 Sep 2025
 02:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas> <aMnmTMsUWwTwnlWV@kbusch-mbp> <20250917083422.GA1467593@rocinante>
In-Reply-To: <20250917083422.GA1467593@rocinante>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Wed, 17 Sep 2025 11:08:26 +0200
X-Gm-Features: AS18NWCcEnmaIyScF_uPuPUHbZKj4uHeyhFZH0L1g6v11LmokM4UdYPVZfCD7EE
Message-ID: <CADvopvYGtqLzm5m4yhXLih7SuSSuw4RtRhBCiXob+rXsMP5fSA@mail.gmail.com>
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello <superm1@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you all for the helpful responses!

> Hello,
>
> > > I can see that the PCI r3.0 (conventional PCI) spec doesn't include
> > > the Device Serial Number Capability and the PCIe spec does include it,
> > > but this seems like it would fit better in the pci_dev_dev_attrs[],
> > > and the visibility check would be parallel to the
> > > dev_attr_boot_vga.attr check there.
> >
> > I'm not sure I agree. The pci_dev_dev_attrs apply to all pci devices,
> > but DSN only exists in PCIe Extended Capability space. Conventional pci
> > config requests couldn't even describe it, so seems okay to fence it off
> > using the PCI-Express attribute group that already has that visibility
> > barrier.
>
> PCI-X 2.0 added Extended Configuration Space[1].  Perhaps why Bjorn had
> different attributes group in mind here.

Looking more at pci_get_dsn, I see that there's no check for pci_is_pcie so I
understand the thoughts here and can see how it would make sense to move
to pci_dev_dev_attrs.

I also agree that the visibility check for dsn would match the
existing dev_attr_boot_vga
check, with the additional advantage of not making the existing attrs in
pcie_dev_attrs_are_visible oddballs without visibility checks.

I will prepare a v8 with that change, thanks again!

