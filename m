Return-Path: <linux-pci+bounces-17213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3509D616A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 16:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80C0160455
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC26F30C;
	Fri, 22 Nov 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kenpQbti"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107895D477;
	Fri, 22 Nov 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289788; cv=none; b=DT+4PEorc8tkK60WLikQJIE6PjNKZedRILW1QZa4etNI79kqTQYSEoPWNe6DLsCCB8qZz7Ri9Mp52COLamFo/h0bqC3+sgHCO2OyAWuth/r1nmHT6IQE71ohAId/vfHaGC4WUZnN24zkp00WWIvm+hUQJlX58Wx90quvRKVVzAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289788; c=relaxed/simple;
	bh=ulkVZrbJ7LXfdpAd6jVryr/bZFOMZdGHRYTROX1Nyxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3Brv2eskOXkm+xjg+utdAAXJe/jmOq2GAKGWSnRoCaw5YGoglzEJlNRfw+oks3R5vEsAc0uWGGjCpEk2J/cSxzXSa7TqagGJHM0y6nPJjfDtIDOfLwzRf6aYHJn6q22xCQ/d+DlOqnceJuv99kSoOok8gGsLKBHn3BKP/gmw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kenpQbti; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea22159119so301459a91.0;
        Fri, 22 Nov 2024 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732289786; x=1732894586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZZhhkaVdntqSbWoUtx77Z41xHVJ20hmKmC+zzkttso=;
        b=kenpQbti9eChG0FYMgbUs5hgZEGf3bX0QFesH6g+H1xMpmhrPNTp5sx7rem2qp2OOp
         JWZKdfhYQWV4zAtXL1TiHka6mr2jsOisllSOs59JEwUzn8yptGRI+dd/IERMTYTrcMIj
         6bR7Fkyx8a7VgGbfG87CvaxjLjfG8ynw0f9Uih/wXq9tuMSM6KaecxDV9n3/HwK8WWSK
         4TMy1+lb91Xo/YbfcPMaAT98297acxXrlAH0FsD/Q5HgOeHdMKuMwrhLBq6Z4IbLcWba
         QgElxFHRDxYrTsOE9aq31881lrUExoTo20i345DMlksBrYH8arpF8H3UQgfLC6IJEwi2
         pLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289786; x=1732894586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZZhhkaVdntqSbWoUtx77Z41xHVJ20hmKmC+zzkttso=;
        b=Nufw83eERsYvz84DBaIiJoxxxQvjEyXFkDDTOS3IoDbdvnQQ0EjfRYA/5QoMkgaNIn
         WCDwhHPhJhR4BQ586nCNSFBEGwiz6AYNn26E13krnnWiSfxseOGwkPIQp0/qMf6R8WnD
         VtZU4aeORUn3uqmH+TfXslYdXME6cr6PXoB1TOxvDB3Dd79k0kHEw9ZcsFd6kU9pkoZM
         sQofFX15ufxvbxyQw8Fx0I1u7Nci/r41uHq1L6dl7zPwb+3iMcLKGuNzw0hoHYBK7z9D
         bbyMH5rNX3W33bSeAVq+RLp7uEcHFlZNwlHkk+s4Coht+bWhhoh/jH4J4jiTx7ukuToX
         GBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBD4KtsR8K5UmYyj2+FeGCc1ZRm7OEmSdllvc1NDeaOBEFkT/M/OkzNpNSGyOBgMYfLvjftvu1BsMBJevm@vger.kernel.org, AJvYcCUTsdluGEHGPkbpQtkjjnZEZjgoDi8XvXA6Md+SzBHuM00RszFX3i6pHVMjP+eEtmv1VEpwllk09RM=@vger.kernel.org, AJvYcCUdeRPzaBVpLOx26Lv4VYes2WEyhUceE0KHWES9RLZ6+q1oTmfmkWvZQ5i6vREmGTaU265ECGQqnOwVRzcYe70=@vger.kernel.org, AJvYcCXw82q9+iLV/DQTJDYdiC3C2cYfjQDt69PIK1qHUGd5cuywDek3clBAtvYgfWcCGiIKFLTit92LELHG@vger.kernel.org
X-Gm-Message-State: AOJu0YzkbwPh1stQMaU34eGVawF6khSs400F34ROfqKJ1WlVTMSdunof
	mK/ms0GzaopVlZcHAH/oKw9DZgq580yuxlVkFPXIHwGXvtQPp30nIffAHZ07uecbD9M98pbopnN
	zF9HjApEKZP3BBZ2zs7CpAhI7mns=
X-Gm-Gg: ASbGncsEqc/K30LgJGrgM7ZwoI+NFTuK8hKvzYf88IgIN9FjJYw8Y2sGpj1IBlbIh96
	FWHTPxhfXQv/zFWUocX1NBLOd1hkLrU4=
X-Google-Smtp-Source: AGHT+IEiXHEmYFiLYnBV5W0lodikfivrMm17pCnk3inuDHM90S+JA+PramY2vQB6wYMHrjiRuzDZfyvwNw/BUL0njCM=
X-Received: by 2002:a17:90b:38d0:b0:2ea:b2d7:4a24 with SMTP id
 98e67ed59e1d1-2eb0e8906a4mr1670153a91.8.1732289786210; Fri, 22 Nov 2024
 07:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115054616.1226735-3-alistair@alistair23.me>
 <20241115175831.GA2046032@bhelgaas> <20241122153040.00006791@huawei.com>
In-Reply-To: <20241122153040.00006791@huawei.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Nov 2024 16:36:13 +0100
Message-ID: <CANiq72=oiBwZSMjFonZ=KqMtJ=KQk1B2KU=QtkH6wWUY71ADJA@mail.gmail.com>
Subject: Re: [RFC 2/6] drivers: pci: Change CONFIG_SPDM to a dependency
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alistair Francis <alistair@alistair23.me>, lukas@wunner.de, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, bjorn3_gh@protonmail.com, ojeda@kernel.org, 
	tmgross@umich.edu, boqun.feng@gmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, wilfred.mallawa@wdc.com, alistair23@gmail.com, 
	alex.gaynor@gmail.com, gary@garyguo.net, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:30=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Not sure it will!  Security Protocol and Data Model
> which to me is completely useless for hinting what it is ;)
>
> Definitely keep (SPDM) on end of expanded name as I suspect most
> people can't remember the terms (I had to look it up ;)

If that is the case, then perhaps it may make sense to put it at the
beginning if no one knows what the expanded form is:

    bool "SPDM (Security Protocol and Data Model)"

However, from a quick grep, this "at the beginning" style does not
seem common...

Cheers,
Miguel

