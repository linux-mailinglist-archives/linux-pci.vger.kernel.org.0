Return-Path: <linux-pci+bounces-21320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538DCA33341
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068F3161E8A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D320011F;
	Wed, 12 Feb 2025 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1ZvVKCl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC151FF1D6
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402396; cv=none; b=ok7py15L+FolSoZV4FfjiO22lfoQ0GwAQ+x0GXzs2CxudZR0VQiQ62SoN8/bvvl12dsktFRB20/u8SJbV/8QfuS2hlSukfZe9XVEp8X+y+n0COdsI7Xd7/H0aEK8W6sOo4ZWgiAbzxxHSc8vMTEmYyJaP9650kzS7slOMm0/5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402396; c=relaxed/simple;
	bh=JTD4FuRV/LhHKuxL7RioLGejiptbf8PQLqOdgssxrnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxnNNOxMkZ6QmmuCUDXF3NKVfUcrJ70MdZrwkrS59iXWAZW8W2c0QhIaVwlEG6jVfTc/TtmK6pIudXeZIL9j4/o2SK6DU8pTNOP9dtyTm+VTVGW963xp0Zesb0dZrEsOqjgC50hv1RPrJ+c0pBkTeBXcBZ8nBI3PxRxEmWkFkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1ZvVKCl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7c81b8681so58560066b.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 15:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402393; x=1740007193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTD4FuRV/LhHKuxL7RioLGejiptbf8PQLqOdgssxrnM=;
        b=M1ZvVKCl9sFBHHIy92GPD6jT3E7MfslawhM2XrwTplQeDrtKr/L/QKINeQIKvoezLo
         apw080SCTe/D8lCwjUU+D3L5DfKOZ0ojYkXKHRmaKOBGtVLgT4lc0WJkerYUek6Xdvio
         WIyUCLGlAcLZejH/W7tDaoSs3GwIOHOMV4K3ln6cyztk9N23ABbMd/rwUBMn8kjsMKoB
         pSqG9bBmjK0IIpRHMnI+1N4EeoSokSaMBGQkXtbfy3fBVTLwBS+9CWbwarQcTApPeew5
         Y76M2VPD2C9f6i6St97GNS2wXNvY1nObZCaSxlhzLuBGI7mt4WCXUb+Xwsz2y+W1kLwL
         bz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402393; x=1740007193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTD4FuRV/LhHKuxL7RioLGejiptbf8PQLqOdgssxrnM=;
        b=pAKWw6BdMQD6m5ypnLwwCxZHAlSgjKep4qz8pljPRp1u4re4GGjDYNsZaNfICibUt5
         9XrpjfUnj7exbF1Lpqz5hHkZiBBY/vHIb68JJ0AiQ44bHaeswXsmmz4/nzXTr+mw5O3x
         qSjhmoDwBQIB3kwxQEQsmbCzQwKAgfCf3FqImklnmq8nYJtkMyyyFmch0l0hZv/hUJwx
         Hxq2z42EP21rFbFXfWm71so18wgXSCa1mRCDuXpSObk26N2272XVT9YJ4hpr1z1ZFznk
         8kgojevDzEtqOddjJeQ8mhr3WPWGdRGH1JWEUaLK/DgjluAF2U5QTB2/DImrPrObZWlt
         3yhA==
X-Gm-Message-State: AOJu0YwQasnLcHtDixf+lUJjlEKdhXarQXVLn5GH+MMZDmVJvq+LQqdc
	W9053Bb9D6sY5nHDsBcbBWUNEJg5tAKd5xg4R8xxlUiyMS6a3BcGCIBSUfU+mMnclluDDhBUo9+
	qIuryuKJ89F/tA/g7XeqCiyE1ZZoNpGSjXdYA
X-Gm-Gg: ASbGncs5fuZnECGIzQ6f+ENKoiEKuBMZvdjHV55b2n0JlNh1hX9EkOFkSVYgYW1SH3Q
	Ri5w+V0VOqXwOtDUcNV4B1qHzOBIUPxMzjjXxQKbURmmCR6MktVpF254l8xFnA8F9bw5Prq8wLO
	cXO/X3TUZatETeVeQjyzVO8AzRrUk=
X-Google-Smtp-Source: AGHT+IHzBhnuBjfRu4Ka8s7HnmF56k8bGRDTAyY5xK2nSu/SKw3NxLrpbMSvbc0PdJA7vmEtt3w29gsSYE8kG/iKYJU=
X-Received: by 2002:a17:906:6a0d:b0:ab2:bd0b:acdf with SMTP id
 a640c23a62f3a-ab7f38768bdmr475053366b.36.1739402392687; Wed, 12 Feb 2025
 15:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <8f26a854-5d49-4993-a838-efec7270155a@oracle.com>
In-Reply-To: <8f26a854-5d49-4993-a838-efec7270155a@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 12 Feb 2025 15:19:41 -0800
X-Gm-Features: AWEUYZn_jT0nHCAR_ONIvWwEje1TRiidqUwnevbBX2CmGDURQlrqZEwhrQoN3sA
Message-ID: <CAMC_AXXVQHZZFeDxsdqGzCuCS24iCZDHEZcbOppu9Vxvt-gH6Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Rate limit AER logs/IRQs
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 5:32=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> Do you have any update on the series?
>
> I'm aware that a lot is happening in the AER code right now, so I was
> thinking if it would be helpful to split up the series to get the logs
> ratelimiting in sooner. There are some concerns about disabling error
> generation that should be discussed, but I don't want them to block the
> logs ratelimit changes. I think it would be good to fix this first to
> save people (myself included) from overflown syslogs.

Sorry for the delayed response. I was on vacation and hadn't had time
to address the comments. I think splitting the series into log
ratelimits vs. irq ratelimits is a good idea as we continue to discuss
the latter. I'll aim to send out v2 by the end of week.

One outstanding item (mentioned off-list) is Bjorn's desire to
consolidate the logging paths (aer_print_error() for AER IRQ and
pci_print_error() for CXL/GHES) as a prerequisite (clean up/reduce
tech debt). Maybe you could help with this?

Thanks,
Jon

