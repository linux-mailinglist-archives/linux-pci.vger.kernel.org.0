Return-Path: <linux-pci+bounces-31872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71148B00BD0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E461C885D1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BFA2FCFE0;
	Thu, 10 Jul 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpRhusBm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E825760;
	Thu, 10 Jul 2025 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174386; cv=none; b=OtlT8FZU0j/oaHMqcDo2AhwNeAWH+h9gw50aqBdDZkTX8pIVR31LJ2APfW7FyDt24r+YU4kueEj2Uk+J8C9ZPGr9MxHhspQMRHtakDSsMir2EkYOkBIUrtljujFuFfZzwudgJwa15RYSsIA/OX1AE0havERPQJhdAuyUMrVO6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174386; c=relaxed/simple;
	bh=N/CJm8Q37Va3Ls9gDwlRWmfbEFB9jggb2Srg/9czkzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltQQxTeaPUbT0senE+bhsGcQjqRty4xCOH7WRCKOUvzVp2jWZp7H3J6fFX6g2MPA2pfazPI5E4KG1UJNj/oXalCYadPHIGEVtqvFfA+m/k1FeT2DMVfryE7b1tdqQk+D2jEB55EMh6S5iIcya9meXenxslFgNIJxPcPm/FC5V50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpRhusBm; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e740a09eb00so1118468276.0;
        Thu, 10 Jul 2025 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752174384; x=1752779184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/CJm8Q37Va3Ls9gDwlRWmfbEFB9jggb2Srg/9czkzM=;
        b=UpRhusBmbRMkNWCdz3woBPXAs74oY5IzhGZX9TuU7pf8mFPbdgxQKpMhYA0mmyESLb
         1d87f/56msl6YeDbn81vX1+SCskbrjAl5ovDKCWkpZNZajSWulgN/at4BfsxYt80jBsb
         X1Q8ySgxMoKHnT9/asDNgMDq91yWP41Mj+2xTMUcBOom0IO9cq0fTFJH7W2/zJsoy/QB
         pdqqlgRt/u4OPYyVTkNduC4u2Tci0soMrxE5D9mpPu/35QdjEt4kNJNEWxyatUT5f0GL
         SqFSyLtmcR3hKaYXZV4gh+Iifg1qOocXDgZjTy2qmSny9JTAL/HffffI0K42SjdJ0MfA
         W9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752174384; x=1752779184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/CJm8Q37Va3Ls9gDwlRWmfbEFB9jggb2Srg/9czkzM=;
        b=bbintGz1+IctgzZZ/8EgokB5jI/XYzjW3Nk2F9QUvJpFAE8bZM18wg7Tshz7PZ5WqQ
         YDmmH6/g9at0PGVkN0UK/g/TUXT4nMjk29RHFS0hAz3czhLVSbEp4yXlZ0v5SFVQfhjo
         LocVJ5mFGbWvQ2BECF0j1gDIqain/VeCYDImUyZ5GSKjl2Uykr3NSL9wji+BA2TAPVOu
         XTI44X75kD2i14nAXZcA9J1dxXkVQBpcWo+6bTDvnaHUpybvJy34B8bYLkHi7Z5sMnTg
         xON69JfHVOp3Am4szJ/A+41Nr2GZYz3xOM+ui8LdvWxnMjj/qW9aqyMo4cyt6kawVy7F
         8LOA==
X-Forwarded-Encrypted: i=1; AJvYcCWmIze9SwF7lFMK9CyVRKNwGcJBNNI9Q9Jp4nQNrHrsX3nDnq2l38CjwJtCcxkQXFrhLPoFhQMn@vger.kernel.org, AJvYcCWsqa1usEKhwpQNnQ010ivoMTlh02Qo+RBxxMPKrVby8F7RKR5ZcAzeL5z9X+2RB/jlVtUT8kBdYaV8@vger.kernel.org, AJvYcCX4/gTRcndxQqBpp1b/wMzq3h7gB73qc/Ku75lhZd3vMa+6jTRWfo/MxS/Op0QVi8HUr3Wlfq1AmY9vPRibWX8=@vger.kernel.org, AJvYcCXATu3aphJ4KoK4JVOqAdBLY0KN5fcfp196N+OgaB0/nL15NfDHRS/kC99ezcc+WPwYTerfYZkZUKnf@vger.kernel.org
X-Gm-Message-State: AOJu0YylktxNmSuL5JMTka/uTbrl0mwPCIkeWnaHTgePz2lvhscwK1mh
	mnNljbThNofTyi1fVsAvlb/euuKd+kZObsxUEnab3j4q6WB9p0i6Asy1+Rya1eF83mhh4HIi7s7
	TlD6aTxWNG1fH2UoBh2wvGHzDci/Q1lzW5YGJswltBg==
X-Gm-Gg: ASbGnct0ajdDqemJpyfWx/EX2hcURBDIYui2xpLz4pd2pNLL7eFtPHt5kwcHP9OjGjI
	KcG4iysQcUPo3GFGkxI/o0fETBwtsQZFplSfr57Q4AUchaNYs4zAvTbqOrGdubU8hBNjAvjJTA4
	EhpKoKUcs4PEgY38IHOKV3tBumkjWjOaQCHTQLb52xoxbQlA==
X-Google-Smtp-Source: AGHT+IH/La36AZil68VOGEY6oXvInjSrZkyqxX4Csk+T+jPPRq31W1rogvQyxXSOBTCvOC1EsXl5hSyqgohVEvW5L04=
X-Received: by 2002:a05:690c:38b:b0:710:f39f:4d66 with SMTP id
 00721157ae682-717d78b6564mr4126457b3.13.1752174384216; Thu, 10 Jul 2025
 12:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705195846.GA2011829@bhelgaas> <9D9D9375-1BD0-46EA-9E85-47A2D8325F98@gmail.com>
 <2cq6jeywii5fscozazz2epugh6zflcpfbo4ffhjt2lyk76cq4m@vg2jcsmlhtho> <FB89ECA8-93E2-4015-8DCF-6D362A53D825@gmail.com>
In-Reply-To: <FB89ECA8-93E2-4015-8DCF-6D362A53D825@gmail.com>
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Date: Fri, 11 Jul 2025 00:36:12 +0530
X-Gm-Features: Ac12FXyPTlLwATY_CErqME9P_iG-GcCgUwb6H3kdzCI5TuYyYXv0SfmzVne8uYY
Message-ID: <CAEmM+Qj=TA=WtQAXQZx6wCUpdsOQ4j66Kpyze3KNZHC79KfyRA@mail.gmail.com>
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, we did it. Could reproduce the errors properly.

Here are the journalctl logs:

Kernel level: https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23ec=
a03ca2ea43a1d832a16180/raw/a9e93c4ba41fb0b3d7602e6bfddce9aa5f3a19b2/KERNEL%=
2520journalctl%2520v6.16-rc4
User level: https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23eca0=
3ca2ea43a1d832a16180/raw/a9e93c4ba41fb0b3d7602e6bfddce9aa5f3a19b2/NON-KERNE=
L%2520journalctl%2520v6.16-rc4

Just so you know, I have used v6.16-rc4.

Bandhan.

On Wed, Jul 9, 2025 at 11:00=E2=80=AFPM Bandhan Pramanik
<bandhanpramanik06.foss@gmail.com> wrote:
>
> Hello,
>
> I was actually a bit distracted by the things caused by the Automatic Par=
titioning of Fedora. I'll inform that in Fedora Bugzilla... anyway.
>
> I realised that making the modules will take 8-9 hours, I didn't even hav=
e much of a success (because all the modules didn't properly load, particul=
arly the firmware-N.bin files couldn't be found).
>
> But I'll try to recompile the kernel, I'll just have to give it overnight=
 time.
>
> Bandhan

