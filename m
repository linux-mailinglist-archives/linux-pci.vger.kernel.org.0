Return-Path: <linux-pci+bounces-40980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4660C51AB4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 672164F991F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3D302CA7;
	Wed, 12 Nov 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=markoturk-info.20230601.gappssmtp.com header.i=@markoturk-info.20230601.gappssmtp.com header.b="XuGjaS7J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E73043CC
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943056; cv=none; b=plYupg5X3KlZmONELolw21QIV9YlBDLCmd0uttG/t6QUq305DAnpDy6hQfLApbYO8h1ZMkV4pXWO64kfQmQEH07DCnNSOiTE3Gpdkqq9k8CJjEvzyl49zou5HDHF4WZAACf/ED6AAVnTupphAXOT1/zA+17JD3AzJrGlx6nm2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943056; c=relaxed/simple;
	bh=M8uAG9ixHRcCTpHYvaaWAx/R8QVND+K/8ZZYTlL2/zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt/FxRZar9jCqNO/l5Omk5Fva4GxHpdmhKA7e11Y3OTIx85gzZPfcFA9AM0aV/H/+3tv5oWMhLsE/2ygu72x9tcaxMuyMo1OXVPYAUqTaVBMMr/BIVrLbzRB2ScYNq3M/vL/utpArK5Z/sFB0PvFOr8wDfQODmUi4k4lJXiyjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; dkim=pass (2048-bit key) header.d=markoturk-info.20230601.gappssmtp.com header.i=@markoturk-info.20230601.gappssmtp.com header.b=XuGjaS7J; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so1011218a12.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 02:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markoturk-info.20230601.gappssmtp.com; s=20230601; t=1762943053; x=1763547853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ic0qfm/57y45gyiMD5PGLbyXiZfTfxHN/0+4CG80SRs=;
        b=XuGjaS7JPzAvvrtvXqK3iSIV8DqEHvlz3PLT2cu8UNWY+9UJvuma+jFogeHsOs5VBY
         KRI3khejk3UVSD79hCdJzmTWUDEbmbGXV9OAr1knPaccvcnQJsDGUFanIiopLSd24q2l
         EsCITOTz6YE50V23BwLt2SQTMV8XsqnPHZTpfP0JHLFfn0HhQ5MGmVtzQzkryEvesju+
         JG9CrOlv/qdIBM0dAi/EZOlQV/oBgPnnoObuPhNt9072WUCic0SIoOLp2f2AlMW8CKzT
         Zi6lmO7loWEef0NFqT1cZFSCIcAvMXIstHAV7LynxQ91kgp+x3Jb8vcR7TVW9aOAQqmr
         wMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943053; x=1763547853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic0qfm/57y45gyiMD5PGLbyXiZfTfxHN/0+4CG80SRs=;
        b=MmcuECbUvFqq2bSCRqkEIc5zZnt0MIHnT4c6apjFHQkvhAuRDM8XclI6bWKv6sq7Z7
         RCvA5sNNWdQi5TcrRYdSFxw/qfFzvDgtnVF27EmlVTXQAOmEO07RScvtOh7lmagu5yfY
         CswTiEcu/WvhWbpSHsxua9m0Szik5SceUDfUfYiqkSiYfesSR7H0uhXNeq0WhHS/hen4
         cBJWFOxTtAY/kwiCr6WVrJ8jJ1QR3+EtFLEBIKcUc0iTR7Ypz2f2H4w4DN4fKPqeqZz2
         cXv8q6AJpuLIyQwH3ZkwrrZVrAVkWRMT7TI7r+8ZhRRNdQ+uW+SxnzqmmQIDYXuYMkyT
         6+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs8LfqsOaz/FTRTfxLIkzKMvWtBoIQALkB0gX9sTsBax6Oqi/WVViMsJhjj34XzOc0BxWRyjG/ChM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGaokcS3Puw9tPfL6/fOr3um+ydQfLacuVkojSOVaqaOMiy/L
	zXTjKg0+/yfkIKvibXLEJvPmoi5Qn3J9CJnqwyncCS6vseVr6GXuZDhKFd9URDDkQ7w=
X-Gm-Gg: ASbGncvusd35kftiT86TSbP+2po+MUrUCkQ+OPDsV4zwu2vTeeH+Zwrg2iC8GLM+AiU
	XPnvkkG6vbMoMm+oAS/rFn72zTXpXUtkEXdQSjS4mGdeTygoUxikpu2PBaKDVPN8SdSDnVpwsgH
	KFS+Ap0gi7zw3tuNafKBddhs87Rg1FyDylIxAd+Lsgl5E1yzm7brQLdoG0K4ZQSlwPjLGQZb5t/
	SPwejXBXTL0f91DNy6L5OWQhipmR8jm/PGN9DX07nCX9Yv8opCo9ramDgd8SXp/muRn5VY1aevh
	oTwnq/56IFWQSEe0rpQS4Z54vRVHz+FbzlYSx22EQ6s3c3uTvq7GSLqlsXhHG9flAAxSGosUUVK
	7QIkcjNmhzBcDUfWERZuiGFh/pM3V1KRkcGwy2i9Ijuh4f9Kt4WBqR+lfPfG6rIoqhnOosJxeNQ
	Is0xg7IdAoBWA2A1I=
X-Google-Smtp-Source: AGHT+IGPX2jqgfNlBcn8vUVVz5PZOrSa5PVRsmMn0VDGyjnwgM2lcTvxiPhRZ4VUOy1lTWfuw/2Gpg==
X-Received: by 2002:a17:907:9688:b0:b6d:5fc8:4a93 with SMTP id a640c23a62f3a-b7331a6f98emr226168466b.36.1762943052568;
        Wed, 12 Nov 2025 02:24:12 -0800 (PST)
Received: from vps.markoturk.info ([109.60.6.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be009sm1541886566b.60.2025.11.12.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:24:11 -0800 (PST)
Date: Wed, 12 Nov 2025 11:24:10 +0100
From: Marko Turk <marko@markoturk.info>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, dakr@kernel.org,
	bhelgaas@google.com, kwilczynski@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
Message-ID: <aRRgSsOFGlt76E7o@vps.markoturk.info>
References: <20251101214629.10718-1-mt@markoturk.info>
 <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
 <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>

On Wed, Nov 12, 2025 at 11:16:40AM +0100, Dirk Behme wrote:
> On 12/11/2025 10:37, Miguel Ojeda wrote:
> > On Wed, Nov 12, 2025 at 9:47=E2=80=AFAM Marko Turk <mt@markoturk.info> =
wrote:
> > >=20
> > > On Sat, Nov 01, 2025 at 10:46:54PM +0100, Marko Turk wrote:
> > > > QEMU PCI test device specifies all registers as little endian. OFFS=
ET
> > > > register is converted properly, but the COUNT register is not.
> > > >=20
> > > > Apply the same conversion to the COUNT register also.
> > > >=20
> > > > Signed-off-by: Marko Turk <mt@markoturk.info>
> > > > Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
> > >=20
> > > Can someone take a look?
> >=20
> > Your message was in my spam folder -- that may be affecting who saw it.
> >=20
> > > From https://www.qemu.org/docs/master/specs/pci-testdev.html:
> >=20
> >      "All registers are little endian."
> >=20
> > So this seems right. A couple tags:
> >=20
> > Cc: stable@vger.kernel.org
> > Link: https://www.qemu.org/docs/master/specs/pci-testdev.html
> >=20
> > Cc'ing Dirk, since he tested the sample originally.
>=20
>=20
> Hmm, I can't find the initial patch in my Inbox. Even
>=20
> https://lore.kernel.org/rust-for-linux/aRRJPZVkCv2i7kt2@vps.markoturk.inf=
o/
>=20
> doesn't seem to have it?

Initially I didn't send to rust-for-linux mailing list. It's here on lkml:
https://lore.kernel.org/lkml/20251101214629.10718-1-mt@markoturk.info/

Marko

