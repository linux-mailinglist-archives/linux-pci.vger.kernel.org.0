Return-Path: <linux-pci+bounces-31675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A6AFC8C0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EC97B373F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194BC28468F;
	Tue,  8 Jul 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAxNgi4H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08917CA17;
	Tue,  8 Jul 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971536; cv=none; b=qEk7fNBw24zibqBX+QUSRaM3+2Zorb3VtNBzoOK63u01HfEZb3kgxb2laFKFr30bW6XOjXQqPBR20oYDGQvDJqEMhyrnOt2wWzfZtl3ylZum2+9r5vt4RVmTCZAn8TL+ycbRZDluEXybT6JZYaO8WIACVMVvYz2sSmeHi/XRqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971536; c=relaxed/simple;
	bh=HSewAqhrTyK3ZVdcaOzrW5/o9Q0lTTzZYLPkKS9Ox8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrdScENM8odznKJ6MgE8RkLCVo6oHc4RmiO+kuC5NvEAVIchuNIn3uZPgBMVpIJM3LzXow7be7lUX25NbR4rOH0Mo01VnjAD2K1dA/bw9J28wFm70RgyeKrbZCmVqE5r5UBg72mZcLV4G6AgOtFqdjvMy93oy2oi56w/jYORIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAxNgi4H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235248ba788so3316875ad.0;
        Tue, 08 Jul 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751971534; x=1752576334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSewAqhrTyK3ZVdcaOzrW5/o9Q0lTTzZYLPkKS9Ox8E=;
        b=IAxNgi4HIKGbQ/aUU+AbpOwHwd6lw5U2RGEVYDuVAXKgG+y3bymw9tZGQ+H0+AmhcZ
         wV1XluQ3ua/uxQPUUEpix0h1vcXKi/GIYu6BIIFtmtjW8UZfmp7OgfR631+Hltt+5EjL
         BVNEALKGlyf3tp7+uJtqKqeCZc/oDGXjJknb41t04cIz5cPf+VkN23vQOQKxcla9vf1A
         muVT66yY9WEHvBrCtUSYn+IFVfI4t2GUOuij1o8vjhUF1vOAbmt/nufiEg/wi7ieexjz
         kA062RcuaIwqa0aXDDBu13UQgFhcTyvgUpprWu6NbtUhGaccMI5dkX1UzUXYIWrVX0uu
         YscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971534; x=1752576334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSewAqhrTyK3ZVdcaOzrW5/o9Q0lTTzZYLPkKS9Ox8E=;
        b=Tw8m4QgbKzlXkxhyb7jHulHWRkrNK8s0bM/Aq9V5stsN9g4cW36tjINUuBpeNb04eS
         Nc6UaZIBsiMxUkky27RwlKNgIrqsOqfbAn8hNAD7+ttLK8K0JZVdmGShczKsgpCTm5QQ
         WklicEg5MPZ1i2zz1NgIQnC9gxE3c78WC5h3bP8YSRKLq+KqDbMqpFz3+Qt5kv0IZJdB
         dxGXdR+4P1sDME4VmlnEHInBX1yB635L5yKCOZXNMERwST13tr8Gtu/zmZjb3B+IDjOQ
         ESH97QFw4xNGaQZnUT/MbB2245rtkvjPHI36cbXsOTalcUZiUbpWYbfmh+2GA4jcbyqu
         KNMw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7pUiz7ZE/j4YHIQqJ6vmNM5OQLwn3LWoU80M0VjeVMN2l8lODXJKNOhPo0bU4/Qf8SMTd91u10st@vger.kernel.org, AJvYcCVRLod7NL8nj8rS/I2lfvBQKay7R1wnVsxeB+S4fil4AY+bMtK76i7IQXZyy5mjgrm2LYEZVk3VgDHXyfoW@vger.kernel.org, AJvYcCVTpXOMLsNMgFjY/piNSQ0hWOMgDs68GMtvRhbzGO4siObE6Kc94KITzAHyaCKWoHIwmOD8VGMf98Yr@vger.kernel.org, AJvYcCWI9P/T8kr+N0c86EtmeqU0nd7onR/idHp8HPyj+sA38yfic/uI33+bNQTsdp8KRziF82b8fNj3@vger.kernel.org, AJvYcCXJ//ytmM12ZVB8H+yDVQbbnsd737UVsKGmIVtj2u2b08UaLOpU1SSkYLH57p46S+tOGb/cL0HxPbz5Aowpr2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUGVUCpX68xuKruetSkWa6Z8FPofrsB0bk/NPtgRVc7TTa25O
	PZ4JeDUwUoLoI3roif10XbqDTulown1ol1dl0I+85oJp6X/5CLzFJcNNI4EC5XrL55acAAzlH2P
	/6jgfhX72qsHY5jZbbyQzQQDkiSik9ns=
X-Gm-Gg: ASbGncuGO4qhHZYGPqeIpRoefwOx+hDB5yh2EnaW5GBbnsoaiPZh4aiu5Vbf33Emg6j
	gc+nSA1Vg5Z3qbMX1fxzmhrBSGri3/Ldf3BW1Daw9fD2EdvwADzCqyZPE8StGa1KQQruXD3Y9CM
	nkNxOwXt38LdI7VG/CKZZRKTSgRr4Tp3qK+jvCvm4ou9T0
X-Google-Smtp-Source: AGHT+IEm3L7c8trcBPYqjxR6Ocp3T5kI3YMJkezrxQ89TyjzbFAZ+sfEnGRzsDPR5wrlqq6qJ/XkY9027ytzzYYdHeg=
X-Received: by 2002:a17:902:e806:b0:234:bfe3:c4b8 with SMTP id
 d9443c01a7336-23c85eae541mr82553265ad.2.1751971533736; Tue, 08 Jul 2025
 03:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704041003.734033-1-fujita.tomonori@gmail.com> <20250707175350.1333bd59@kernel.org>
In-Reply-To: <20250707175350.1333bd59@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Jul 2025 12:45:20 +0200
X-Gm-Features: Ac12FXyxXkuLp9PUeC-mS4nwqMQ5TUf2kfGzbt31LyPz8JoP83cE9x-RhgyyVJM
Message-ID: <CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
To: Jakub Kicinski <kuba@kernel.org>, gregkh@linuxfoundation.org, robh@kernel.org, 
	saravanak@google.com
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com, dakr@kernel.org, 
	ojeda@kernel.org, rafael@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, david.m.ertman@intel.com, devicetree@vger.kernel.org, 
	gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	lossin@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Does not apply to networking trees so I suspect someone else will take
> these:
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks! Happy to take it through Rust tree if that is best.

Greg, Rob/Saravana: Acked-by's for auxiliary and OF (in patch #1)
appreciated, thanks!

Cheers,
Miguel

