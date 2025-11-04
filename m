Return-Path: <linux-pci+bounces-40189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A1C3009C
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 09:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A421882DC8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0F3164D3;
	Tue,  4 Nov 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skcmRH0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1E316199
	for <linux-pci@vger.kernel.org>; Tue,  4 Nov 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245618; cv=none; b=JaNmfLqKUWVtsKWGvSLn/gOkQHqgoM07DbwJNTWV8lD9wspJhD563ZI/6lmhM1D9DeGuUHpyKLqXnIuwLxLztECNyNyqnEZx1MD2LPxDrGWjltUavNuHiTp25qkK4ftkNmgMXwZMg5hVLuBP4u7yVbh10DX8uaErXLhtunWA5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245618; c=relaxed/simple;
	bh=861Choy3GbkM2iT6DyDZedv9XDJesWVVc4e/eJiX4zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ujc0Il5dDAdX37Plrnf7DhQYZ37tPNssn013jBBeL8dClj6CXjaBupvEmnevlb0IPh0r/Df+/GOoNtfVqj/Rmini1z5UUKeFBqUNyELLJP54HKo/uX3yHGotgnrSmBfqaUgrXdxECjIn3K5sAIz6CN8kEUcJPqmZBvY3PodeSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skcmRH0a; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640ace5f40dso2915886a12.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762245613; x=1762850413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwmZ+6WBy0DpH/2X1JFXWHRC2GMTvQN+STo8LsdNvJ0=;
        b=skcmRH0aOLQ1hLBbunxWeRC9fLyO0lK6ev8k3Uu03Vt1rbShUXQ8zHMKcCmhFphxP6
         49w/NJ0QrZWplafLABqV03O+uZWvjXF/swrS6TdakfxDjLaLN7thhv4Wwmux25SccEoR
         qNJkH/qzpu8wWGlF1QHqUH2yQs/BSmeWL++bTNXxf9abflQjmmMaN1aNmteMQUZhG8ZS
         0NqhulUNLNV3X21WEIeEkS1uJcQWTTGYRnSRlb+5PBs3S7bY6Vd/t1g4s4cAt23tMmHI
         5fgmPRTfmlUrbLI4QEyZ4fwpMVnerVk/eyliAiGJcghzcmO7BVEaJO/deKmvxbXLv6IZ
         Wd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245613; x=1762850413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwmZ+6WBy0DpH/2X1JFXWHRC2GMTvQN+STo8LsdNvJ0=;
        b=TOzfUANd69OZ4Xoz8J5+dBPBS9bNCDkS5DUfORs99lyEL6y0fFPgLU9SFFfEE7HJ7E
         JudNpJu1fI3sA7uejjLyEGSIgnYQoKil+PF5PSJx8VlHw3cyAcEQzmSGcfvg6UegPWzK
         W8TbacmzFqE5oOszDtV/4Je0aNgYwkg3qSqmLcDhfpAE1IUA7Mph3e5hju/OEwVnjJfk
         GRqUBgBIy8eUesVvJLmz4VAcvU0HnFrLRcekF5Rs+LlMnPt5zvZP4MzMVgo6QKk5tMNK
         hi/rqCeV5IHZHeOxeu+B/v6mXKEcPD1w10DThhAVyhhIqqy0rYpAWUamFJ1GIbEPlhCV
         Rlrw==
X-Forwarded-Encrypted: i=1; AJvYcCXmVfH7RkktRluhHmpkFH1mgvkcNbNhLQE5S2owGZCSXQqiBKZHmYdt80TpqJs7UhASKkefdGW2k0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Y7X1hr49gNkWku82Xc/+783ZmQOYJ9QkLBjSD/zAZkY6Xld4
	jL+1jHmIe6X3SI1A18UDy5NJTfu+P+X8IZFtqpDgqMsokJiNZRmtyv8kBmvdyWA1gCB5TCr5xJL
	pKaK5esGbJom7PG7+fA==
X-Google-Smtp-Source: AGHT+IEI2OOsck3lPELYTHDmiUDPX23aQ0zOxe2XMSiUyFnIXk35xi7d9IgnDvvQ2t8WeW+/QGu3reFub1xwlLE=
X-Received: from eddp22.prod.google.com ([2002:a05:6402:46d6:b0:63c:592c:cf21])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4310:b0:640:b7f1:1ce0 with SMTP id 4fb4d7f45d1cf-640b7f139abmr7115706a12.23.1762245613116;
 Tue, 04 Nov 2025 00:40:13 -0800 (PST)
Date: Tue, 4 Nov 2025 08:40:12 +0000
In-Reply-To: <20251103203053.2348783-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103203053.2348783-1-dakr@kernel.org>
Message-ID: <aQm77Iv8_odvASCV@google.com>
Subject: Re: [PATCH 1/2] rust: pci: get rid of redundant Result in IRQ methods
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 03, 2025 at 09:30:12PM +0100, Danilo Krummrich wrote:
> Currently request_irq() returns
> 
> 	Result<impl PinInit<irq::Registration<T>, Error> + 'a>
> 
> which may carry an error in the Result or the initializer; the same is
> true for request_threaded_irq().
> 
> Use pin_init::pin_init_scope() to get rid of this redundancy.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

