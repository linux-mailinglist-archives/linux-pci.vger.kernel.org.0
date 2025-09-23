Return-Path: <linux-pci+bounces-36752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA6B95388
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 11:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87105188658E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51992DEA79;
	Tue, 23 Sep 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4u4AjKV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E792745E
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619278; cv=none; b=nYwD9LL/D+6r5Ab2GkBGF//aGHvWQcGbWWVNjyZ8SKyZv+PrzPepDNrlhBseHoQDA/9rzxKks8n+qAsQOAWw1Pv5h8NvTt8z9oeW526HHX0blwBI7OxJFezCimyouy/nuo18WZSxPqx1LKLja83bVQHDaRYzIUnI0pIrrUc5dzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619278; c=relaxed/simple;
	bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLGURh88MSUgiLo5PRvVMN9RhLovohTMrzutK0U8uysJG0Meun4A0iGkrHmTNFrlwz9oz+OQek3WUFcgveiewG7uRFTavY3irSqMvUv0i6FuHqMEryBI8gcUk5FPREUHaCFRHHsdIMZWOOcr5E/3OwlV58GUC5Hf4D2N0w7Qs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4u4AjKV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26c209802c0so37264705ad.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619276; x=1759224076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
        b=h4u4AjKVfmAEskwkOvwzqAgL88xwomHfGrvqa/5xhZTFEvKPRDxQ3mzuuNdgvUhCoK
         kf8eytRgKJqhaVcHEnd14tfDLk4r7F0OulEsicASVZuyYg0kGQVOdiS3RVqTmXs+RKfF
         5CMt5HxvdXkogUdqNdiB6nrFAVo7BZlFfk5fDdN7/YUVJGhWfK2vX2Czbky8A8EHk9Wz
         xmheSDvK9GN7pax/RoyTCabh7iBQUZAZHIhVaSIRi7HFJOdLpxbjv/FrtG/4C3KHWm3T
         6nxbMtXQ462veq5po0xK5zqGjkv5OfgiVKrhGSWLHCy56WGWB2HWeV5rrvxhxsKaxH7a
         vkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619276; x=1759224076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
        b=IDD8CpJ1ErlzjHcECiQHFA2Q7jK30svusLqXkyF018k2eYFXVLJreW8SNDHwGbah77
         e3CgY8qY9gp5IZLfA10C7hf6Y+X3KXRUuQVAfMI8/NdpC25DWS2/m7MtDQK66c/e9MZW
         lxsuCpL2CbNeGiLDjjHOUbWnvr5tXvGRLz2eQPxHWOAJzSzqoL7sr1weSBilOeaq/M4P
         JOmYmYf/pU9E+S6mb+MsslD59HozyxJSgmFdO6w3wFzJsz9gozzXKqZfmwhKJnkyA348
         Uw+NjYMh2Sw1rTJFdLzsRjDdxnSgtovfEec0hLp7WD5WI/GZYfd00WD/VpxB0PIY37kl
         4f8w==
X-Forwarded-Encrypted: i=1; AJvYcCU2cyineZU0mnA+qLOLhWvjnTgg3aU5jIBzgf/dBoqCrlXrU8GVVsbQsAT4rvQwNTnwqq2k/eS7uY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmqTnoKOwIUGs/2uomHoCz5s0i3Bgk4TxyPMlBn9XPsP6h5qd
	74ITIjKKXSBUZyv8T9nJF3byo66AazEoCGzH605P5B00dm3U9zKQXt7+L7peeFUm1X8mb9dmM+z
	ECZ9sZ2sth9pUyLHqB8CD8w+uJMQQ6k8=
X-Gm-Gg: ASbGncs9Rhrz+1y9922NntJOsb9ExlPBYzJ1GCjmsqCxMtgh4uLZViR2AP3cgs0kpYF
	/9s9YFde72Y2pOw/L+CMraxCOoRr7XYSyJIzQjhMnlffCcpbEnF/3CSyT3UYYLJfgClqkhpSF40
	EUqf82mdPaSbIHaVi8FhZXM/ZjVYTRrsJ5rseotlgk79LzHdwjA9iidCld/flqlkM9YLPVU91JK
	Z4YW0I=
X-Google-Smtp-Source: AGHT+IEXMKhCjwTKhodebRPoXK/OAjJWAlGGH8OjPPnekcnhylOt4yiZehwUT2NqIW2Pj2CyhcJ/iwqTogEC2ndcvmA=
X-Received: by 2002:a17:902:e790:b0:269:a4c5:f442 with SMTP id
 d9443c01a7336-27cc712289emr25047665ad.47.1758619276576; Tue, 23 Sep 2025
 02:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827013539.903682-1-terry.bowman@amd.com> <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
In-Reply-To: <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
From: Srinivasulu Thanneeru <dev.srinivasulu@gmail.com>
Date: Tue, 23 Sep 2025 14:51:04 +0530
X-Gm-Features: AS18NWBwICuC4DXdolnXhBDgNb4F3syXj6-2puxjUsRmcPuIhwxe03vFc-A6n2I
Message-ID: <CAMtOeKLe-HtjpNze4WPj-knDDZTw3GRq6qMwpig6ygKH+Mq7AQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling
 and logging
To: Gregory Price <gourry@gourry.net>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, dan.j.williams@intel.com, 
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com, 
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com, 
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com, 
	lukas@wunner.de, Benjamin.Cheatham@amd.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org, 
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had tested these series, Thank you Terry.

Tested-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

On Tue, Sep 23, 2025 at 8:59=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Tue, Aug 26, 2025 at 08:35:15PM -0500, Terry Bowman wrote:
> > This patchset adds CXL Protocol Error handling for CXL Ports and update=
s CXL
> > Endpoints (EP) handling. Previous versions of this series can be found =
here:
> > https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman=
@amd.com/
> >
>
> I know there's still some in-flight work, but for the series so far:
>
> Tested-by: Gregory Price <gourry@gourry.net>
>
> Please ping me if major logical rework gets done and i'll roll through it=
 again.
>

