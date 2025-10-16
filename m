Return-Path: <linux-pci+bounces-38387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2ABE51F6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 20:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8635E070F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3C23A98E;
	Thu, 16 Oct 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/AcmAyY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6E14F125
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640864; cv=none; b=Hv1rAO9+BtXBZfl7rFQo8A3bHo4fdhICNBRQQMF6qr9HYHx8jLcEpjYcvpuqVjvYyc4KcgckvB2UfxunsFMGIy1NmRpbIXFt/3d+H2MsuZv1pgwvqTHdcjRL7kJ1LmUYVN5RfckjtAjw2+DqFkG9Flj5i9R63Ins/wQDwNNgTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640864; c=relaxed/simple;
	bh=+utBgb+Y0Uu1IYHRlU1599odQNpYd89QM72RzQIjkKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw1AV5n4HXAt02zYUFGrK8Prx+AmEjTK1P0jnyqU/UlWnN+hfn6XK0FVsSEnjSJNCVWi1NTCMwtlUH2SnfcOn3UcdFTepkH7Z4j3Exmruaye/p8RkaNrSzv4zeMsqWLnwzSgFcFH2hojKmmyiDx8b9/HG2f0E+52UGi4/2jJDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/AcmAyY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811d363caaso94985b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640861; x=1761245661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfjITJrDrBsj6NyrvMWKq7r/mdAyxrTj8oS5nFcA3D8=;
        b=X/AcmAyYGA+t1YhKP94+NATzTMfT2RmapnyBp+pK1RW/ivJvtADIGOt+BEjkaIO2W4
         JuWbh8C3mYOhYGN2o91ecCQlwtsuBhgDKT72gqJafnWDhEYRX41Ez4nzUutob1/mdjeZ
         UaRCnyao7d+Vp1yXDPWLgiGUnSBZV5/RGDaoEISbEskGsxuq00JA8tpsPBJwHD67CTlq
         7BZvFic4duWbZHwLEK8ogizOFZit4VKsTH9818QTG6BcnDvg3KOXbFA9W99EMFnldMRw
         G7FnRNX7ZRSb8K4uCBMuT8s3V49EKBl1hklAiUk4mzOAy4PwHwbU0ObjJ3EnVST0Ejaf
         DVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640861; x=1761245661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfjITJrDrBsj6NyrvMWKq7r/mdAyxrTj8oS5nFcA3D8=;
        b=ji4D0/ZeS/Xd6F+bTju9jX3phuwtIjARfm6idVbulug2GvDTj+AdWVvEXwMhRHzKPZ
         GteYj/es8XRJcvjEEutn/B5FXsesPHk/7e9Wx46DOutfAhetyTomaWX/hPJVzBXPfvxw
         3AG1XPTxb5+ldIud6GbZ26mmKeZ5l6+iUL9z/PwKqRinzLFzS8wjp/4sbDyywGUeF6XP
         HeEJTd2B+2fqo9+6XgHq5XhA/bDGymIrAXGCJCsdTD0gjfD6w5wbFnBaWrsP1Ly9oF7h
         9NRo6QgtZmKLmEV+TCOEpS+bVsqOjIrs1+/m5sowXnsGmQC7pGEKqZnDI+iE36z6CZDM
         VsAA==
X-Forwarded-Encrypted: i=1; AJvYcCXKPBk8YW8N8JoNCJvkAg5Uk4DSXP+fynX11lqjJtmsBeSUAjtuW7ZuaxDOkdmXlatiTOggSW62xkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNRo4C++gohNiNsybV+4QouWWTGRXx+zEXmRWcR5XyuzZ2sKH
	1e+RwTX6Zvp0yvJKJ7KeEh8Fz41JCLWxoq/uHgoCvNEEucjp6+R2P6x8v2nRmcFb+kAYax6E0hK
	B0OZl1UFR80YUK+yAn8W9knZ+r79yKwE=
X-Gm-Gg: ASbGncuzJUSJ43DELyszOtYtU0QO+WK3gvBvN8TbUqfuJEMyFcOkFqYDP9W9YTe3Ki3
	KWN6DfJNdJ2s6yZA6KIfQUGCsO24r3LRYiMoiyCpQzUbk/oiUzlh9pH4WFx4zoJyVctq8gm0yOX
	CxhJNYSsr+vJjiVJ2oyIRTNDZqOaIpp+Yf6IvC4Cd8KII1dRMH+kC5CyZsD9QHzcOUIVuORNfos
	iDkOpu3IIvQBJv0Rsp0FYIG+RwXRTAChHNNHWk6kjU0LlvKDcjaPghjG2Nzmo7N1l0Att1yTstc
	vhCpIUOBofb/Ibp8yQd/0JvA1m/Yo0RfmPWDho+7AldplmtJYXf0q29HJeHRm+FL7KGit8xoakc
	kAWJqEon79E4XAg==
X-Google-Smtp-Source: AGHT+IEbKwbqFQ/fneIGbpfTlhDpPKZtHqphNXdfbEVmTezUHkwYnzXeQIHBTRMspHOBh02pv2qlfv7V0DyvDzmt1nM=
X-Received: by 2002:a17:903:40ca:b0:290:55ba:d70a with SMTP id
 d9443c01a7336-290c9cf3306mr5986045ad.2.1760640861448; Thu, 16 Oct 2025
 11:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015182118.106604-3-dakr@kernel.org> <20251015225827.GA960157@bhelgaas>
 <DDJR102F5NFB.1X5IVJQ6FK3CD@kernel.org>
In-Reply-To: <DDJR102F5NFB.1X5IVJQ6FK3CD@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 20:54:08 +0200
X-Gm-Features: AS18NWANSYIYYVl5goGbtu4qiEWHeLwDVADFRWSVLvLKuJro8t-8yxzSNbn9BXI
Message-ID: <CANiq72mB_M3GeU8DLg5Wnn66wgUimF1Eg8Vpy50AEZoD23O7Fg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: pci: move I/O infrastructure to separate file
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:35=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Those could also be a candidate for the list of "good first issues" of th=
e Rust
> for Linux project [1].

Indeed -- done as an example:

    https://github.com/Rust-for-Linux/linux/issues/1196

Bjorn and others: of course please feel free to create more.

Cheers,
Miguel

