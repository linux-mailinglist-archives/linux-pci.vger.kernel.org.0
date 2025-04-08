Return-Path: <linux-pci+bounces-25503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B2A80FA6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E71440BDA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1EF1DB148;
	Tue,  8 Apr 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShegqFp7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6422A4F4
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125309; cv=none; b=UVq8XdpCKVFqYfBCEqRftA+XRmV8wTvETPUfYWj2amsnS0OyWFXhvE93B2KAJEQpX15+vvXaCRRI2exL7JSb4Cy0dE9aE8QQb2zngkptIfnDCzl121lux4jVwXC7bb8ktbMKjr3IeoKZ00nMbh4YRV5/V1UIUjKNPCZgcmq1nAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125309; c=relaxed/simple;
	bh=+mLx9u/YYS/qt2xeD6b9X4TgXKhRUvbosn4uED0BoEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfT6diGcalv9yy0+DrklIVDTCSDKGTmMmin6aJE07VNA4r0fE0xV5aB8H9RM+kzXvTQDYv4Ulu3RoGC7DPzG5B+3TkVxV7Gv+r4R5DGWHO0xL4qQFrNJVkhP4HQvx/sKLheEVVL3Gnc1gPYvkyfV1oaO0bi+RrV6xeDGuNL3P84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShegqFp7; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c7b2c14455so3770353fac.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2025 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744125307; x=1744730107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q34Qqg7vn+zu5qq8KMt2iLz7U6Q082RVfoXEGWO0UJk=;
        b=ShegqFp7+tTMTEgc3G72l3Yxqk1FMILdTKsJK+F3Bzwy5GvFBPw9DGatJcsBFY5/5d
         XWOHUIGmwp43d2vMJntLsvy0IEqGI7hMYOl8t2sbJ7HPe2VeczKW05Jg0hxBH2RnvooE
         c4oSROcl8YJ3kzZPoW9J0NhLAd3XHLRiNANP/F4NE17YMiPDWLv2lqCSyhc06mnJ4YFq
         4W/y6HKhMXgQ28c8djLcJFYoFIpfQbN+p33mTSogxGeLj5TT8ZcSNYyGRF67rPZeHTHm
         0r5+xgIDALvH4tG4Gih38RJZKsJoHa5rAPiUDeXuUba1+ONDaKCedPsPqCir4JDc4eeh
         aX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125307; x=1744730107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q34Qqg7vn+zu5qq8KMt2iLz7U6Q082RVfoXEGWO0UJk=;
        b=AzRXhXCDFx5RmxheRFOBLgaRTt0YHF184wX5sOghUveSdUB2dlYd2Y0b1HUOfsYCYY
         PgHeXjzIxc92bGPq6nAgZrs/NKKbgdjiIQmdQ6uMipVCNB/b3A4vEJNmcbqK2TjmfKQ5
         pvN029cyKMrKgh6y8aBADXKSeolwtavG8bIW+3H/N4auuJCWnAAR3bHfAEGJpxyerPVZ
         pK2AQuAr7UeWyzwkGhqx6m+dF9WEPFC5aPhmv9ItTIdw6trLSkSozSrwGy/kiOUHXAse
         Y74CYcgsmb2+lOR5815fYUs99N+bju4ny3ms5cX6rA2hN1tHvEOGuLYLGdkneZRju6Zm
         3ZIA==
X-Gm-Message-State: AOJu0YyYRDr9lMX9FlAfldfJPgabCzrscfP9/PBOBKqleP4m2Vdz411k
	mBExgck5hmuIwGumwCpI9m3ZCcmgQqfnxYjjkiqNyv+KREoKmo1xpL2GHy4MUSVe/NeYxIsUnyZ
	fTIp3So4LwJkyZF9yLq2GfdTHtbE=
X-Gm-Gg: ASbGncsoaQJn+Mx9JlcPgdOSdnk6SpBuQgGh1uzFg3QjR/iIeeLZyrVBatQJvSD4ZNk
	3tWWC/AfBZ2KmGI9uhckSej1r+xv4CDm/sLbtPRsPMfh9nSMFi22E/AarctKzUmOuHpA3jlOUdw
	OWbX33Afk8vicC5Bkw5BQbwMIzQDrATEw52oIZRheA26HThnwKq7JiZPrWkg4V
X-Google-Smtp-Source: AGHT+IGKdgfsN6oRiu3j/dC4pGhvX5jndigFbXgwDuTGAw46P2B8m8syIq/tbwr1/bpJekq3900g9mp/hXk3MlrvwQQ=
X-Received: by 2002:a05:6870:4945:b0:2c2:d749:82d3 with SMTP id
 586e51a60fabf-2cc9e7e5b31mr10196455fac.27.1744125306891; Tue, 08 Apr 2025
 08:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAUwoOjXGzaTQ4Dbx3wcMOiy484Sjd4Vv1=ZDiVrYvCEaNiRcA@mail.gmail.com>
 <20250408150623.GA232275@bhelgaas>
In-Reply-To: <20250408150623.GA232275@bhelgaas>
From: Damir Chanyshev <conflict342@gmail.com>
Date: Tue, 8 Apr 2025 18:14:55 +0300
X-Gm-Features: ATxdqUGo3zQYlufj7LCFijeBtlan6yS-Mbq7ljSlOj-rsEJFswZeLlBWd5ISBso
Message-ID: <CAAUwoOg-uUGRcyNx3npvJuA9ZQa=dH+7tzdtKnA1y69kBriyuw@mail.gmail.com>
Subject: Re: P2PDMA support status for the sappire rapids+
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, 
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 6:06=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Logan, Michael]
>
>
> The pci_p2pdma_whitelist[] is only updated when somebody tests a
> platform and determines that its RC can route peer-to-peer
> transactions between separate Root Ports.  This routing is not
> required by the PCIe spec, so we can't assume that all platforms
> support it.
>
> From PCIe r6.0, sec 1.3.1:
>
>   The capability to route peer-to-peer transactions between hierarchy
>   domains through an RC is optional and implementation dependent.
>
> Bjorn

Thank you so much for the fast response!

For the testing, is simple rdma ping-pong sufficient? Or a more
specific testing tool?
Unfortunately I don't have a fancy pcie hardware analyzer.

--=20
Thanks,
Damir Chanyshev

