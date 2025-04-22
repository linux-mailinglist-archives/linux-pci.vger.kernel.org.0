Return-Path: <linux-pci+bounces-26403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC539A96E39
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCCE7AC960
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92FF2853E5;
	Tue, 22 Apr 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG9KSP2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C24284B43;
	Tue, 22 Apr 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331689; cv=none; b=IaerzN79a8KXUGKiE+XrgMyk/0qHd8nNoBHsMZ+YAMk2zidCasMFsGepNUTahYv1DJau3O7vWdHINEEIgzPeW8OAfWp8jIh/Y4gDtlgPq2BFN0gOV9y0l1xdNOE7xpHpXkhkCp5qNa51Z/eqJJRxbLKZZ7vPScWHE8v6aNlB9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331689; c=relaxed/simple;
	bh=CYBasdCQGC1UhaurgIOOeFA83OlbtSNsIf8wg9pr4O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVIs48tZ36avX6plC4pFxsbjg89FqOLpNE5kEqZWxC5/YJtVQKKFteg8Wf/U/lJL/51a19RCZVGuO3QYUghJvKwy26fZ6NgiBi6G3AGWzbQZ2Omf6BsV6gncSRj2ekmvX24L1kCdmLaM7urDIVmCC+vhnnnglbZeO6ZTTgUUVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG9KSP2x; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af90510be2eso516048a12.3;
        Tue, 22 Apr 2025 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745331687; x=1745936487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYBasdCQGC1UhaurgIOOeFA83OlbtSNsIf8wg9pr4O4=;
        b=TG9KSP2xe6yxtmRQds4xK1OqwC7lsfjSqcZR3+VKWYbUyIjzfbK1nFl9y6LTzBCilH
         LIODDmav6Nn9vyWYEmc4Q4YRQnnlm9t3eQgMnJpr5AeMItGPs0ND6RzKsThjiB/XX5Gi
         u8p7wB1a3UpNqVwjVGpu64LP4C91wTZ++vkFc0ata4OeLBCQbI7vMojtJbX0CdZTJIzF
         ERsxT8B1yGazk0aWfp6JwPgyIC1ELPVTHAvHXw9l1HtUj3IYc218HGoZICFBkQyUNSUD
         L6BPYv5SuMJFepzAe+PNrvDfulma5LtUD3pnWWMvXsAXx941QCYYzdDrBHMhr9PLo1MB
         tBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331687; x=1745936487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYBasdCQGC1UhaurgIOOeFA83OlbtSNsIf8wg9pr4O4=;
        b=B4DGy/JuXUvVuGSbftluJRk9FSZYuvnA2pAqx+YgZVlD4XH3T+IYs7dSnxsckPUBQw
         39b87KGLfv98oYxR2DgRqzUeFu7De+esuudDjzvE7ES9vTof8z/AHeVMAtbUg0/w3UFX
         jFw0WMpXeS6ldB/PvQG80T7a1YDWVd3WhMqFWzefWXFfH/gXElf2yiGZKVTUAdEg9Ra+
         Res5TybBaEbxewRGrpuHB+Y/GRn4f0YbXYkdcRf/emstuNYA75lbScwO7G7xHWCwtpRI
         hRWwgKf9SYg98KbQWhatFsTqsJRuY/HgQpCLYOnMHCGp5an4fNl0bBbAZoj0cLC6R4ht
         TtRg==
X-Forwarded-Encrypted: i=1; AJvYcCUBSybyK/pMJgUduvyvykrTYDKX3t7J7tpZ3r/AFFf9iKdxfJpcYMCGjmp6j4JJSGgeqFbbG3NBkbzDN3Y=@vger.kernel.org, AJvYcCW1bxJA0Sy/n9FQyHEKArbbfv3kqOghTQnTmu2E/XaMEWF7HfG8HK+E+/m1gxBbn96Sya11wUpsmGinIpcT9NQ=@vger.kernel.org, AJvYcCWbCjtzJFPnbwMNTL6LEo6gm+As4/0B4tBJ4qyL+wBGp8jFWNvXmAOT9Tgs4Iw1HzwkauzYMhRJneYX@vger.kernel.org
X-Gm-Message-State: AOJu0Yypk7AGzzs2CxMPMWGPVpy1pWdzuBFDqmt5KdTc14dykjUDM5VQ
	Ud7X99bBE+bUcckf0Frms3snQj4ABiMz47+KgYcfTNMbwassxPneviU7/bVftMeHPo/cH0wHQtF
	ouscaDDAkyFoN+HS0+VmJhbjMXR8=
X-Gm-Gg: ASbGncuz2+TQ6unRLej8bouzznKHBRO8fmWKHaVsJpgkNaGrRIGKNPBWHx3Ym58AZwu
	sKNcYmcy6fNcUBsmMoiRBDB6LW/Iv1CHOFbE5PrzClV07xG2ddAgW1r0n7NqH96MSRlbB3ZT2kz
	fQLRYBuvZEfFgRaMGz7aLU5x1QVl6NB2pF
X-Google-Smtp-Source: AGHT+IFFGIzmDwG4q5vl7uqENSVklXtsE4ezZA/aMXaaMHZ1/VAuFnRd4HhuyVVV1HQjthGmdvoPglwRR1oJ0G6DAFg=
X-Received: by 2002:a17:90b:3b82:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-3087bb313f0mr8921370a91.1.1745331687645; Tue, 22 Apr 2025
 07:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
 <Z_kV7U0IcebUfGps@cassiopeiae> <aee8924a-d533-4d19-8064-9831e3616013@kernel.org>
In-Reply-To: <aee8924a-d533-4d19-8064-9831e3616013@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Apr 2025 16:21:15 +0200
X-Gm-Features: ATxdqUE5xk3PM1uAf5hTOL0Q2XPafe__dGinAo84yDtIH92K-bUfLIHkt8mkCtw
Message-ID: <CANiq72nRSzFMKa+XGTKP=nFTz1-JD0DVTDrBiXv9P9ri14ESEQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] rust/revocable: add try_access_with() convenience method
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 10:01=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> @Miguel: Can I get an ACK for taking it through the nova tree?

Sure, please go ahead:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

(Sorry, I missed replying to the other one)

Cheers,
Miguel

