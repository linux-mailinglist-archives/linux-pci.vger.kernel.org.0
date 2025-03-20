Return-Path: <linux-pci+bounces-24217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE2A6A189
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B4C18926B2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9EF2063DF;
	Thu, 20 Mar 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0Dc/mcE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557020B803
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459837; cv=none; b=X50lxggdt4QgPbGUdtz27XQLsj6Dr0khxc0iakDEtEM+exqn2HN8Z9oAPiu/HU3XbIuPbh1mQ7Epzfvtcta+f/uTCybD/R3w2bYLhMddPWtKDKfubukuArvD7/VXz82W6inNhTYEK4qpcBqrAM6WkDtM1EatajHCRj/G174F7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459837; c=relaxed/simple;
	bh=7TetEMynBoINrTYyjJw5+oI6pd6od3UUHaaz7qU6eMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxXosJ7ES2oYYD//EplbqQ4rDOXvOCD633EohtZ4fZSIMzCvHZwWW6IHsszubzYIVvskjSi51C59LObn6GyNwagVixg+J00K/qWunoSDLzDrwXkfBFGR+PRW9/HlzVHIFDN3/uRRE84aFkFC6ShbIAVxgl9FZYK4CcLv58e9CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0Dc/mcE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-399744f742bso93634f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459834; x=1743064634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPIWUDVih1Sb5uTelU2ivnCNtpHKvDoc/ZssNjFyHts=;
        b=X0Dc/mcEQl8ue/o3pMYoVVjEzFC2BhNhu5yo3IgcHidLsvJiCh/mMvbQ+oBtdNnd6y
         HULE1fqeS68FZeNLPfymdKpqZeIDI6nq2xFjxrdaRoz+ZPvAgyzwCRMkmS1dJbj8twxP
         u4qfzTV54TbJRQyJTBpV5Hw/dr7/RcX9rOHSyD/W22GeJqOfGcZ/+7GmtQDb+mS7bq83
         Qr8HxKlayAt/BLuKMyR8YQHbNFaNPVZ4Pw1xFewuAk9pa48jTRtaDeEVziCx3Jlre/oW
         mfWPT4wrrwu7PZatTcbYCFlHARsA/IpyYcPEy2llulqvwryzm6q7qc1y0JdcK+U2Ktvf
         y8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459834; x=1743064634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPIWUDVih1Sb5uTelU2ivnCNtpHKvDoc/ZssNjFyHts=;
        b=i9sct+0rMcdcE+9DnNWM0pRumeLqpLqk5U5l6HQ2c3XskWY34m+tB4w1NCmIYXf0Ar
         ogywuCrGS+6vq4RzXT2Eq7vFm9zteBn/0mYDRMH6YLZqt2CFIihqZ9MeRsfbxAj3VyD/
         ww1NrjFBJlO3JT4JQAYhi+z10UIMUR3PPXL8D5/xldZIWJOEajLlK5LCQgxvBIE9wB2J
         dl14gK2KOtTvXAgE0lRQcFZYXDndKIckoof7cjnhNNcLDCVFDyqPik8CSN4glcaA4bBK
         uWY68EbdYOFoeuRKHHKHj2WuefXmV6uG/Ny/fZ+UTPk3NMty3GUQ3b57/pKa7fNomPMh
         iVMA==
X-Forwarded-Encrypted: i=1; AJvYcCWkGxeIUIRd8WrythqrQ8RZ2feCx+KAy9Pz3012lX7/pS33Ch4H201jbaaGs9Thk56hmTkAsrPeKW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIn5p3BPnzhjSaeE3Jy2o4b542ZQMDVkHvQP/WnHG7XdwbvqMQ
	T6+R0nj0aBjJ/fVexhmeQytTXV7qgKyywM6d8OL7zyOb3fK+3EYutLbk/x3wEf12lVxg2GeD7bP
	XSO9ss3d8eAP1kg==
X-Google-Smtp-Source: AGHT+IHuZ/wR4qWvGQ7/uSH0SsJWVQsfNb9EAzn/4o40D7wBbbwOean1AjWxFD4wZ1ijuUOd9CO33V3YtiCdOBg=
X-Received: from wmbgx13.prod.google.com ([2002:a05:600c:858d:b0:43d:8f:dd29])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4025:b0:399:7916:a164 with SMTP id ffacd0b85a97d-3997916a1a7mr2988222f8f.31.1742459833932;
 Thu, 20 Mar 2025 01:37:13 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:37:11 +0000
In-Reply-To: <20250319203112.131959-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-5-dakr@kernel.org>
Message-ID: <Z9vTt2A3eiecQx4e@google.com>
Subject: Re: [PATCH 4/4] rust: platform: impl TryFrom<&Device> for &platform::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:30:28PM +0100, Danilo Krummrich wrote:
> Implement TryFrom<&device::Device> for &Device.
> 
> This allows us to get a &platform::Device from a generic &Device in a safe
> way; the conversion fails if the device' bus type does not match with
> the platform bus type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

