Return-Path: <linux-pci+bounces-25857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66015A88A98
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 20:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A847AB294
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E5191F84;
	Mon, 14 Apr 2025 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV4kKwqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81B28B4F4;
	Mon, 14 Apr 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653630; cv=none; b=ZW0usRz6Da+dFqWlU0bVYt1APQBR40BBhngCBMLroo8AwxNKSzQji2jRN+KsvkNSrIHTplBA0pd+QJ2+hO8FCIjUw8TGJwsOZGtOlyghS/P3F1s4H86j3hBW0LfiufqgW6zJIR8xoITvDWIwt+HUs2d0fRrkn2KvenHYZljjyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653630; c=relaxed/simple;
	bh=kiJwNsUZMsTKiGo6V3qo7yMyyjByd3UlhLm4x6n9qeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIYrDMVxr+L6IIGPYduTxBhwh2+1It+UUixYc2T6pk0z3TYBPWBuhYf4rpzTrauS6wxq0v+MqcPCVvtoab+mYH3gsEVabSQL5dn3dC/IA9tRVh9guVT+sakHYJAiplmCb/IXesyGRIymSEb8MRHHil6wxGr1RqtatJdJ2IThSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV4kKwqJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf1d48843so39944511fa.2;
        Mon, 14 Apr 2025 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744653627; x=1745258427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhzE62VPzaOOXDpCyoIZzvPsWZhdAibhD88NlM2R3jE=;
        b=WV4kKwqJMFtul3rLzHxDlYM8XNttgAOUb0T36ITO2/PJ1nPiwpYGepPrfuZ8gy06KY
         8liZWBn+W6FV7PUzvMXzhAVDgj3NM0PlY1kh6zUCf8HTKfasgdqv5kdHa4EGUXr96wDY
         rQmJPClVK0cWyWnL/YY1tRkRvfqKqDZBRqYkN6ncepHz10JfsnATib0w8z89nuqFfnU4
         QCPUdceq7bnPS7lLHXDd5cXiYD6UfFL/jhpgKuaBxgu8ykrQ1facPDp5A/7hydHEqwL2
         OrBBvO1Tjsd9WROKlv0AnE8uMvT6AJS90eYSe0zg7F6/+3L6WV0nGhA67sh8Ksu+V+cm
         9SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653627; x=1745258427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhzE62VPzaOOXDpCyoIZzvPsWZhdAibhD88NlM2R3jE=;
        b=B4qChz8tLa28TeLMnpFQCdvqz5o4fY+0rj/6oxRRWsS0VHXmnce/oavE9uqW/cuEOA
         5u2vajm7HwX0uOYaQ9gQvEWZZWeAqrczSrezKQigMXCeEB2JPnZboNf+2cO1uirrRORI
         EGRZ8A87keJcWuRdChp7tOWR6GcDm7QUVhDeHG5ycM+F1zYPf0lqInF6u/Y3sCOco+oW
         H8SGhGgL5EVYbCuPPHGW9chUN9OxXjdccJHZAvbNPtPsueuYk94oY2Ng2xtQU8OSIxx8
         vjTcUMRQ7YkWKW1zZEY5DYZK4Id5d7oiMX4sYAj2pZusH/F43qZqU54F3+q2WKGX20GS
         1afg==
X-Forwarded-Encrypted: i=1; AJvYcCUEucBL/fnuCz5QYrrYug1s66F+WK8LcmmDCCfe+SRwVKo+dFq+J3Sb/4BcjYaTpbAMp/wpz8x7X4eEVzd37lI=@vger.kernel.org, AJvYcCWJADdoiwIFRZC2jFjbjkU5WOnk4A6+BJvyl4sB+hiBf9Y8TpjUOXeN4hLnk1ApRhzLSBaT7zLRcSx5ek8=@vger.kernel.org, AJvYcCXJNHNrNNCCIp/lH8A675YYW9/xzCVUW/WclJNvn0mOv5UVvExWA8djbXm00wOjz8S1I64k40aAy9jO@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQoXP36QjHXsjXBlEJ4QdtBEGNVplwO6EnJlwWRSUADtIsBS4
	lnfhr7gZb7PzF68OFTfhyIT2XnWkM1kG1yB/jtxIwRyHkM0LVIgVkLwq02n96438h+E4bHdFMM1
	YogJP9CnRk4+dDHhWs4mICYjuS64=
X-Gm-Gg: ASbGnctjA64Z3bN4Y8Iig9M7D+7ujQ7CmwOXKZW6jWdyiVOCh53/B9JpTqojQuh0JqC
	VBtS1ZdXn/C8Hdq//7RNq8kXnfnT+eHrdwSFVU8DTD/U6RGavlJ1xuARGxj3bMqvxw3ewM7aZzR
	Nm/OT0uZY15Gx0ZirWPYBeXKHPDiWXW26dtDB2hg==
X-Google-Smtp-Source: AGHT+IHeK5M+rWRuncu4XqUjARbWEaKLjfE38YaMcd9g3MOj7v7EI7OGvbYQ8mSLK3Xr7M35AfuixgFnjK8Kbu/zaQM=
X-Received: by 2002:a05:651c:905:b0:30b:cc6a:fff7 with SMTP id
 38308e7fff4ca-310499d1794mr38730641fa.6.1744653626427; Mon, 14 Apr 2025
 11:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
 <Z_1E2z-l1xG--BSc@slm.duckdns.org> <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>
 <Z_1H6KkIt0YnkeLB@slm.duckdns.org> <CAJ-ks9k2FEfL4SWw3ThhhozAeHB=Ue9-_1pxb9XVPRR2E1Z+SQ@mail.gmail.com>
 <Z_1KR_b0KEcqF4K8@slm.duckdns.org> <Z_1Kr71BMpXPoXS5@slm.duckdns.org> <CANiq72nDtMKNYqxrxj6gNYaJwPzqe0U6CkSQakRrV2rDKF1ZJQ@mail.gmail.com>
In-Reply-To: <CANiq72nDtMKNYqxrxj6gNYaJwPzqe0U6CkSQakRrV2rDKF1ZJQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Apr 2025 13:59:50 -0400
X-Gm-Features: ATxdqUGmWjm0SUQG5y1c12_FGKOvLlpbT94T5OAU--i4mBB7oYpSF7XZjN5tVdw
Message-ID: <CAJ-ks9n-Z7K1ZbVnQPxpEBovQiBmqTWiNcdzoD-VmkPSDaXZjg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:57=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Apr 14, 2025 at 7:49=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Miguel, now that I thought a bit about it, I probably shouldn't be appl=
ying
> > patches that I don't understand enough to tell which one depends on wha=
t.
> > Can you please apply this series and the delayed_work one?
>
> Yeah, sorry.
>
> Tamir: I know you the "prerequisite" at the footer, but it is best to
> explain what has happened in words. If I understand correctly, the
> last "version" is:
>
>     https://lore.kernel.org/all/20250409-container-of-mutness-v1-1-64f472=
b94534@gmail.com/
>
> Right?

Yeah, correct. FWIW I was hoping the automatic prerequisite handling
in b4 was sufficient - I'll also include mention of prerequisites in
the cover letter in the future.

Thanks all.

