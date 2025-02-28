Return-Path: <linux-pci+bounces-22620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4AA493F9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DC43AAB13
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 08:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5357253F30;
	Fri, 28 Feb 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcpyctfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC91FE451;
	Fri, 28 Feb 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732599; cv=none; b=WtlOZqDo5ntxxM/69cRlnRygx5LuXdIo9gPEvOsH4U8pcqit6G8mqRLQM3FAk8ZI0E7cB0HBU751sSY7E/0mwUNR29k6loGnmN653XFTvw2H4fh+Sp5fQd3MaCPu7SUk5j6jv4NhRG8hb8WL7f2r6WcRaxir//lTwDlvhZyLVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732599; c=relaxed/simple;
	bh=OkZ7viSAwThO1HuTRwiMxo7YV5UdLi3crU2EgETs0CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQKKZFNrN0qJMOI41UGU8Qn/iLHKS+nbhOukL0GTZ6V/VAeM1zc/zroJS9hXaMZhCpKOGQ2ZoiOjTwzWv2EER76taPYmnLoMhGY/Z7k7h+vFp3Ys3nqnH4+1am8gry0GOn7IpfCL6L0jQ8jL/cUBpbRzq/+092tn1srMA+CeHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcpyctfZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe5d75ff8cso488221a91.3;
        Fri, 28 Feb 2025 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740732597; x=1741337397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkZ7viSAwThO1HuTRwiMxo7YV5UdLi3crU2EgETs0CE=;
        b=TcpyctfZMSRchhdwqBmPtVTfU9tQ2IZIZJbWpqtK9IsjEiKLXXx9i8l0UeCMnjTPA1
         m5/6uhWcQYEnbDwNwjxj+ip/F4uQbKLv9M2to9Ki2OH4rVMiUOpnuRjsIUqe9fLLpll5
         4blvefZfRRZuEblUo3NlaUvs0O5WuwwEyBhT2W99rE9qd/EDMRVxqWcGRB0oMv4u9a9R
         1BEzQF4kclE+1s12YbInQYUcb970IvTrtVnwwhK+h8nEoUiIXcGTArA1LUzZxiLLu6YG
         6y3+WitEEK/U1SS8oRzBkdponxeOJMaKrkSaHxpCTh0O+ccyNQaGPgm75I6vHp+gTPXH
         R/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732597; x=1741337397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkZ7viSAwThO1HuTRwiMxo7YV5UdLi3crU2EgETs0CE=;
        b=m2LNAPOa47YHM4EgK5UDU9wWYgw4PiT2omnoPPXhhVKaWMD47VmMTafrak76616UOI
         S0mDvChEEa9oTzjuYYkaOeW+LCU0zYnVU6m76oHJzhY5INYT0236klwFSxbpqEYvjldc
         b6A12RRJQh1q6Ktgx4F0GwW8VeGU2PY/5Z0tVMS4C272UOJDfLsWRLCW44AlJWp7yURX
         45FP40GhULGytZyQd5PqKVjWZwyVHscfJ+VjLJpOxD603jmjosMf/zyQTp8mD5mt89/Y
         S9flo7dUyOqH2kNe0E8uZpL7+8Q6wRY6YfOYDMirYP//lO1QTKDC12YhHFEZRaE/ZJt/
         O+ug==
X-Forwarded-Encrypted: i=1; AJvYcCVnuMVuo/Q13gkRjfFfyTyeJH6tERlRZmBkkwohNyC/y/Vx6JpS1ii65eLJo5891kze6+0ibGjrPmLssJ+G@vger.kernel.org, AJvYcCVrncKYtrIialFaLTkaF43XvOWi6l1SLgbRQyC57CgscZxEDWZ07FdTIOvpVGUeKkbSv5Ozd5AB4hMx@vger.kernel.org, AJvYcCWfa1iWb5UAg752Uzc1reinICYFEyeD8cWL7qCZOsYM8YxdUIaQqkG+y0S7WEoxKcaJykWi1e8xnQiTXwIsnpM=@vger.kernel.org, AJvYcCXD730TM8vPldVZBK2cse+ehEwUkGR3YayqVOwAUw9xoyfPoPo4Q13BitK4l5f2DC7PksK5AaxmTE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAOCl2hXqSev2rGrAoKfwYgL7o9yFDy1Yic2P8TayaFksa2R5
	bvkSQHmtLZEDw0+puyx/cUr8ylsIYbsRq+WinXhFpwB68VCNZoiASxT9KPJ46KcjFUQsbbMKyVg
	TOdiK1xZJsocjJCY2N4ZL1d6Ok9I=
X-Gm-Gg: ASbGncsbudSzaSfecCzfwj+R0wexc9DJztA4LGuy9StJ1CpNXZ2rHspM6bXNHrW5P5B
	Dw/l5QHcmQN6+lkw6QL4YY6CIBS3KAAPJeOPrCklFkI0B3vnrcLAuOuIgBPb7Clif75JRsJRlBO
	MCtfNUuc0=
X-Google-Smtp-Source: AGHT+IF+NOfClpb8U69CQGZooKOQR4Nu2Rj1Fl87Jywmv1/rEuo/WfwllvXTrT8EBnKPwmf2/FPXZ6Bosl0KS72P1KA=
X-Received: by 2002:a17:90b:1c0e:b0:2fc:25b3:6a91 with SMTP id
 98e67ed59e1d1-2febac0576amr1696622a91.5.1740732597434; Fri, 28 Feb 2025
 00:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me> <2025022717-dictate-cortex-5c05@gregkh>
 <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
 <2025022752-pureblood-renovator-84a8@gregkh> <CAH5fLghbScOTBnLLRDMdhE4RBhaPfhaqPr=Xivh8VL09wd5XGQ@mail.gmail.com>
 <2025022741-handwoven-game-df08@gregkh> <CANiq72n4UFUraYeHa6ar3=F61C_UxEJ1rq92aOF_hH9rtjN+Dg@mail.gmail.com>
 <2025022731-culprit-pushpin-58e2@gregkh>
In-Reply-To: <2025022731-culprit-pushpin-58e2@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 09:49:43 +0100
X-Gm-Features: AQ5f1Jrt6fRsN8RCE3WNcebza72iRpvX1psFHMFlrLhwWAJuvkdD55CLaLlLLdg
Message-ID: <CANiq72kksJSOPzQTx_eGm92Od3qtwhxz13oALXyvueEvubj4kw@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Alistair Francis <alistair@alistair23.me>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, Alistair Francis <alistair.francis@wdc.com>, 
	=?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:32=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 27, 2025 at 05:47:01PM +0100, Miguel Ojeda wrote:
> >
> > I can look into it, after other build system things are done.
>
> Looks like Alice already sent a series to do this, so no need.

Above I meant the having bidirectional bindings as automated as
possible, which I suspect we could eventually want if Rust keeps
growing. For the time being checking is more than enough, yeah.

Cheers,
Miguel

