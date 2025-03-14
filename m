Return-Path: <linux-pci+bounces-23772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BEFA61864
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 18:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D11B63530
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A72046A8;
	Fri, 14 Mar 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVmV0DaC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42342040B7;
	Fri, 14 Mar 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974232; cv=none; b=tLqpb3rN0d3AqSk2i3KhTZil/NkR4HuyPjCmgYeVLIajZCi2NYhgzOvEaMO8A6VDnELwG5mqrPO+1+qwHJ/SG6wW1eVszE1VkQsVgeg+CDXltNkxSRApUtX0rQ+/BhS8Ee/8CJdScjc3PFGiLSQpq5q3/5iK3qeTvnaApxmyno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974232; c=relaxed/simple;
	bh=Pvd+U/B758J51PT82tAAVQVcaOw72or1UnFvj1XL6iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCBTvsROuDu4BGwK4H7ANlPPgfqcaH6hwi/t1WFDCooRmw1/RosTs5mfZfWuEaf+E0D+ckClwmextaswX/KD9sudi49Jw4meoU2eL10tQXRKJj0X3AzUbQ/F59hKX/JUvq8IXeEnmDE/vQq4cKEPuiKABaSdz/88b8wctMfTkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVmV0DaC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so507685a91.1;
        Fri, 14 Mar 2025 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741974230; x=1742579030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvd+U/B758J51PT82tAAVQVcaOw72or1UnFvj1XL6iI=;
        b=QVmV0DaCgcI1zPElhydogsOYd68fGXVuJRrq2BahxrXYRQihk3rB4QFIOF2X3SJKKt
         ssa1DrjLzOvU5wJziXZGux/4UkUm4bd5Z+Zd8tHau1F12jvAV7RXLxtgzPe51TbtA0Wp
         MO6u1l32Wc1Iia1ZqLU+yMuSgAuusEvMCwdCw5SY+NlYu17hfWHA3pvKbxougxO6ys74
         5xzVejLH1jzE7NcirGtBRZDAypC1yiAzNg5HIfZQJpbNvV7POgfgiwh9nMs3jfK92nhi
         PVErm8xTHk+r3d8GhQr2twUTJDt8w7S71/D+PbqQbsrbPqNghEvcjJQNwZiNA7prNAZx
         73Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974230; x=1742579030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pvd+U/B758J51PT82tAAVQVcaOw72or1UnFvj1XL6iI=;
        b=dL/rXgUPEoq0QkQz+7zg5nMmsfJFCASiIv0HBCIkAHhxF+KPr2HY5CmGdjQPwHq9NR
         gtAynYzyjOKslSp2vE66jd1j4b+kyVCWnrEH96vHmNRPP0DWALJ79Tu5utgUMvSuTRoq
         9Ndz9CZxcz6pBHZ5a751Ij2MAjqqvgVMdoZzJZVf/b7s9MOVT2VYyalxBtQJ74KOJ0QV
         fQBCL1xkeTcXIVrmWUo5URdqJRvjLNVv83weEZviNEuu8GIz/Nx5RuUDG4bRgC+poHbo
         Ao6cApIHUJp1Mnsqd5EpS2+X/fSb+vpE5oLXpR3FBH0wAqX3Le3cI9skHXhmIEM62TTf
         ZmNg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8tMWr+FgnXQpJ+xRqnxy5UPBtrwx1yNVrpmTZs+DT5G3kPKQ7HlijeaeVknRT6fLaQ0U+YUERV4GVWQF/G0=@vger.kernel.org, AJvYcCV+tfJhVucgp22zc9WIXGfZy2dTSXy2xMxm0BFwbKwyN1D4lJ4ulZgYJpUUM2zYLk04wwFT+waIM1Wdq3I=@vger.kernel.org, AJvYcCV9tOQYrF6as3YFd9/G3exGqlx6P9D1z77nO+lAai+Qd+nfWf4cdJoBs5zg5vcqdWBI2xY5U5e4MsX7@vger.kernel.org
X-Gm-Message-State: AOJu0YwWM2Np/1KlF5Ih0Ajk5m7gmSShcNo3KamX+r/NgTa3tJA+8hR1
	6v1QJN7t/xVV8w8yQcRcU/rte0wh0Ren62NhO9S7N+YdPYTSYT9DywvA7DAGpu0lwh2OcvA1/1c
	RObO2QObSxMk0Ox3GqMLVvfG1qPA=
X-Gm-Gg: ASbGncvQCjNvpE8jYP0xQNxFSxFn3Xq6hojnqzk7E6JFEKlKggLP4aoWPienKUwJh0y
	d7CNo7YjFTZ0fpqDGyORDMyYVeQhD4WfX5UrFykU8HT3cVg2W5kSslD0gFMvxk+zJdLq+0GpLID
	SkdtdgSjEXyduhzu0eh+q7dp/hzw==
X-Google-Smtp-Source: AGHT+IEFMKTnZsXD1N7gp122JLHbaHf+AyuyKncnBLfBmhFa2lwgM7dKe1dhiXGUYDRCm3fIEHUt0lv9Z+b6dH2DdPQ=
X-Received: by 2002:a17:90b:314b:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-30151d6e018mr1772213a91.5.1741974229831; Fri, 14 Mar 2025
 10:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314160932.100165-1-dakr@kernel.org> <20250314160932.100165-3-dakr@kernel.org>
 <67d465bb.050a0220.d2e19.8fc9@mx.google.com> <Z9RoBMXWsrjg6jjg@cassiopeiae>
In-Reply-To: <Z9RoBMXWsrjg6jjg@cassiopeiae>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Mar 2025 18:43:37 +0100
X-Gm-Features: AQ5f1Jp2xaym3ZDWxg08bHWjXMx_pYmpOVAYBLzoboLKA1FyFJlaopGk6TKUetU
Message-ID: <CANiq72n9Toi2gMQyADnV+bGcOUFGs7LCNeK+dFpHmaYv=QataQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rust: device: implement device context marker
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 6:31=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Is that a thing? When I apply patches I usully keep ACKs, RBs and SOBs to=
gether
> at the bottom.

It depends on the maintainers/subsystem. Some do chronological, some
do groups (even to the point of having a defined order). Chronological
loses less information but "looks worse". Some consider RBs should go
on top, others below.

I think most people respect the SoB boundary though, when applying a
patch from someone else, and that is likely the most important part.

Cheers,
Miguel

