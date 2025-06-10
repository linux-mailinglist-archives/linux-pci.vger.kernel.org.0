Return-Path: <linux-pci+bounces-29317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A3AD351A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28A916F1DC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877232857FB;
	Tue, 10 Jun 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFc1rpd1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06B284B33;
	Tue, 10 Jun 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555436; cv=none; b=PSSazpOgQwMWAfQ4Ljp132AOdjRmPMSfH1MF39U6lQ3YcqoinD2UkR1sPk/jHloeqCyNLrMyEHTr/WLHXrDJIsUg3IWLV1Bsh2/d+Ox1s/iCEgLiZjt3LrvD02JfsmEY+fS7a//EGLSbhxsdZ68jsdRAy1htE9FXaa9ISH5VVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555436; c=relaxed/simple;
	bh=Rl7gmhD68pvqAuq1oLbdvzcfcB7ehPXp9x+J0gUw+fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My6+L5AjVqpj4QBkZY/byHuJitvPpyuzP0MEHlXakC0RsTXWW4hOwSSicF40MUPbyYH8VOaDDtcoiII4kcGjbCei9vcSw51rPYjb1+MLB3XKKzjgdIq+8KBYvXY7hLnyNHKur2IJ5Lc/JJOxiFSDXyGQ7FxUtZPPGIgT7VqtCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFc1rpd1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2363bd24891so694555ad.3;
        Tue, 10 Jun 2025 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749555434; x=1750160234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl7gmhD68pvqAuq1oLbdvzcfcB7ehPXp9x+J0gUw+fA=;
        b=UFc1rpd1lkhKrucPlt5c26VKWx5ThwhCFx0E4VZMqQeDmB2Pq9JaqXVWDqquSlTVOf
         8PQ2HT/LQSzKHo5EtXHNi9dpFcKfYWd6PRupdS81XxaOyPMYnKslK0pWkRguA2N4ZqsP
         JSPeUGO0tA766TduE1rVK6eHkuI4Z3Eq6FEuhpJk2mAok01fIkMNDpZ7Y9kYeaGNTjht
         Dj7rZlTydCIdeAMVP67wDQODBJgIfsDKkCHPhsqNYvNyy/rd+yNwy+bfNyRgFXYVJAZw
         ErFvZfLVlzGCWD2BRTs/mlzQU709zg63NTVMCUv+nCOUKkolXcL/S+KDgFBB6JMYOGgH
         ew/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749555434; x=1750160234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl7gmhD68pvqAuq1oLbdvzcfcB7ehPXp9x+J0gUw+fA=;
        b=jsXNormlN6G/gVr4gnwHgrWPCjxz3l9aVo5xyosv4lB2bfxvSb6/0u+NbKWksSbngd
         UrNhNe9WJ2wt+HeglT8Zy13irSxme02aXz5MYP8exuxCxDZY+x3K8zcC5mLGk3iDKkTm
         lzJ6ZWBCErkE47QJ58sANQPJ2fKGdcV6pETCTAoNNnix2RC+SgYDVxDCx0V2cFwdXEAi
         VkXaHlbIWm3ZbufEU+xmP0Xjvbb+OzPUbtU/pnEu+uFciEkOUz+tsgtCAZVZcqfqCid0
         un0DHlHtxFqbBd1GUZ2v/pAFQPVyjXkNMsLBFPd8HcRN5ZG7cBCN2JYFk7JqLoN62MYj
         wmpg==
X-Forwarded-Encrypted: i=1; AJvYcCUcKpRl33QvsTxGDIoBN5pq2LUXnjNLEV5omOzQfmTeZWP9JKgRf6KqIQlw9ezXJJwli6Ch3Q5XnBsXmYtiwyk=@vger.kernel.org, AJvYcCVT5ka70VxJdXjIbl2r1X8MsUQpEAPQ3Nbv3IzN8lMEejMHRx90/O5Ki4aJcJ39JZJNox4Macr1SCEP@vger.kernel.org, AJvYcCX6m31F6t09lKk0x0dLTjscGdAnQH0TEvDRbOX1djMHBVjeDIwPhgsPSNBuahGFxiehAdviVBmTOLlmpDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZb3TSkCgnLjdozq60aTg8F+fq1+U/0RhqbK+efdGdLxNOLBa
	WA8ShRdiDMvmqAjdPXSSIXaeeBtPMNtPa74JcKWOJDN7A2926Vvd7VkQa+KHEPAH4qsTHAV/OgW
	vqvptXl0rKEol+yO4lcx+VvfzuWw6k1w=
X-Gm-Gg: ASbGncvTcDCRW9Hv/hz4EtcYLQ1lwYxQ79HR/7k8aHYz5S3JcLscyklUK3rUXgbZ7Iv
	FGA6YtJogcD83RinHm/xwmPKgViezBknXsyuAUOa3z3b6aXa5FMKnPEfV04gFzjfK/c+yM2+rwn
	hGiDZnQId18dI6vfRpQEPaQT8oyOs2Pba820Ywiz2Z+48=
X-Google-Smtp-Source: AGHT+IFfuQ7vMN6M8ZvhnQLxwH8KNArPOlKCobbwxMJm3CCS6PtixmtxNtAsnC9Q9jpXqWWOz2VR+IGLAcqe0lsnDF4=
X-Received: by 2002:a17:90b:3a87:b0:312:db8:dbd3 with SMTP id
 98e67ed59e1d1-3134e422457mr7738333a91.6.1749555434300; Tue, 10 Jun 2025
 04:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
In-Reply-To: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 13:37:02 +0200
X-Gm-Features: AX0GCFvrBYeRkqsyvCDMs82Yt861o90yEZsxAJ_1-2gnoBEMGVP26IUEfqd8g5M
Message-ID: <CANiq72kYdtozcN1U1yGhi_orh-OVO2xp3=wQPAhwgx=wTi-neA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 1:32=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> - Replace qualified path with `use` for `crate::ffi::c_void`.

Hmm... I think parts of the patch still use the qualified path?

Cheers,
Miguel

