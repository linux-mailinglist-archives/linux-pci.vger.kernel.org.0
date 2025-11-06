Return-Path: <linux-pci+bounces-40504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716D1C3B45D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 14:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910001A43CC6
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0EC3321A0;
	Thu,  6 Nov 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RejsDbjP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B0330321
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436080; cv=none; b=GYKI7lDwI+ymZzcElMPoJgZW1KgmtVTlMNQck++uHzB8agnwaWmbT7KE7Bl6pFigMTGiT37MGBKj1q1tV2Vv2hhyUYnQCfCD83HlK/3NnRX2Ltzq5omo6E6H8oUSrj7XZnrQ66gWo7/ShKhPRN2d9rOr8XvCSXJlm6U5Wp8EyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436080; c=relaxed/simple;
	bh=j9SuhjIVPNBBqJfnVLYcJU6kiIExeCsnHgyWendxW+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdTAXa3ICDUTXc58atUvjMyZEVHy1joqMM2PBCNWoTZOA/bhxYbTfTuZN2vo4sKmHqSfHrGXu/v7O7a1jmj3xhlPDUOWwo8bzXi4+9Xeez1eb3/9AZGD5976Gk9whIRCV/nk7XXZnfG+mVr5fcd4P/vlzctWjo/hFWrEnuWR3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RejsDbjP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29498a10972so1228545ad.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762436079; x=1763040879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAPFc6E2cuOBznS+PFsa8uaGEFuFxns4wE3SuTksKDk=;
        b=RejsDbjP2jbgpCpqsdNG6OMV13aH6dy2qkkZoZiMhJdYvPthSskFOjy1WXWxigrFfT
         x0zrGjVhvmGenH8bAspZjjV6n30oMIHvkpUflefZtXs50vZ6TmG6tE5EpfV83MSevzRu
         /MRSVUH8RVDdhxZF6tkVgGOHj8dKEG+xvhgcu3sgjaCs7FxGjqXu3rW65Fc3DV/8qiLN
         ksxt7atx1AX3oZTtyoEI2WsTP86YA4G1TjOGtdUPw2vAsopxkkDdqpkHD2CKB3vWn/0t
         1eZrI8a/qn9JldEtgP0NGSzIU6nKrrST3EzNlwA4bJ4TIDNqMd5A8JUXHCVa1xGffE/A
         M41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436079; x=1763040879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAPFc6E2cuOBznS+PFsa8uaGEFuFxns4wE3SuTksKDk=;
        b=v44xwhcjlD+OezZtd+04erbQLDybhnuvPldduf2WMU+ggSQL7T4TCplVLFhbMMRIPo
         9f01tIJUMRLqgLg+BDOYBNtMqi0FxfYq513kDvdvtdftx0dywBIfP2sI3OU+9HomGaUm
         mffdxteEh+Bo11oIA1PVUSVY6QEzToWLTCOwphtCp4aDVsZlOmQn6mYFmfEyv3fb2CwE
         iGXZaHsV8F3UWcvJeKmDiCVh1UKouvQqHApPzCfJAmb/7Y3eKI6ty7ktVXhPDrLDmujt
         09TQS81ZCtSSvjAQY2Y0JXKl+sGGuQ51rZRWZX3XSEZ23xlK+/AmXOm4hthpYTiiHO8A
         fOOA==
X-Forwarded-Encrypted: i=1; AJvYcCXvLxjXCsTzMS8/WodjVzRyu/Le8N7p6QCdVYUUcud2wuz02pBnp17joT93X2SRBCDrP4heY2iEG08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2FiXnz8CmQwnvvV9BJ07nGsQ3VGOsQd8/NjPiE9Em7n/4iLi
	Q8P30HgMkLydJK9T9XpiclmJEKN6SEy7UcTS23oVAUrJXhEuHQo+7rH/GcMwaAAP97BKH8SZg5U
	NO1P6iD2+2dkIjyf1fpGtkc8O8Oc93fY=
X-Gm-Gg: ASbGncssGL1P0z9C0vcM2txThQ8kgln3XaQ/gRu7i4C1mFGuKSl4XvXdLIGZMiAPvYy
	klA4OIb3WqAb+omnLjzauP4FT4HJx537FM1m2BLvJWH0EJgRdCOfFcF5l6Ojqhsh07V18R3iYqq
	5uV04Ol1kYpI8KpHi8/6l8XOVEJshAekzfHzrQ6GjQNvMhLkPEXzQ1UR55dLW6nYjpfscRaVb6I
	/YhnGijg+LEWVoPymyUmX9e5yJsAe9wco590FFWEaErdlpaYuRJmium5nE6kaavOcd1NWppM/Xo
	bFwKhMRM/FbxZGE5OoggtYaSxadWwkccOu0vHclt9/69uzTORU852YmunZtBI16XyXUHsR/4Jk0
	8iR0=
X-Google-Smtp-Source: AGHT+IFgsu64H5AxVDYQ4VC1AtIntPLrClhNs2DhzecuOxKsWfCafPqovP7OzWqL14ZLgcHX93hNFscreoxfb/7qqJM=
X-Received: by 2002:a17:902:d2c5:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-2962adb0131mr50508655ad.1.1762436078666; Thu, 06 Nov 2025
 05:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106102753.2976-1-zhiw@nvidia.com> <20251106102753.2976-3-zhiw@nvidia.com>
In-Reply-To: <20251106102753.2976-3-zhiw@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Nov 2025 14:34:25 +0100
X-Gm-Features: AWmQ_bkZlBPvsV_cw8dYZQNsheLfRuBL-Y7e_Ty1STSrCFE-bOnmtmTHqEfXIAE
Message-ID: <CANiq72kE9QFdAP2cTjBaxwsQ_H=BmMyabY9vSWUdfj0Ai0QZCA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] rust: devres: style for imports
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org, 
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:28=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
>
> +///     device::{Bound, Device},

Is this one converted?

> +    /// # use kernel::{
> +    ///     device::Core,

This hides only the first line, which will look quite confusing when
rendered -- please double-check with the `rustdoc` target.

Thanks!

Cheers,
Miguel

