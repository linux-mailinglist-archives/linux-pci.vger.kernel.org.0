Return-Path: <linux-pci+bounces-15392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504CA9B1C2B
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 05:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE18E282313
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 04:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD42D05D;
	Sun, 27 Oct 2024 04:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/nYKqSg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718BF2A1D1
	for <linux-pci@vger.kernel.org>; Sun, 27 Oct 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730003912; cv=none; b=OyFovO1DrF5VbyiYq2mnxjCt+fanhH/KW4ZkfCgJIzErEqQ5vhprwm6IEuyBfNgl4D50yLH0A0yZJ5Xr0dCeQMhcmR9tUZDfy1GMcBn0M6A3pvotPxDME35hAhg0jhEUTOnYDT9pizohjeKalBmu+xm9Kbh/YwXM2ueIZzbjQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730003912; c=relaxed/simple;
	bh=9a894voPSeKCWDpJXy575tccinogzHEiPfzfOZ7KaWk=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuUxwTP5MJ43oIUbNCbBrY/m9vuOLZbimvh5n3f9/pDzpI6cHSTIsPMKTJ8YzJ0xQjI0bleqk8+MbNoTZq70cqmXHAj7LfuMTokQ0yx2sboem5feX0iCtjMNB7xbWZKB5yyz+zWciryRDsSi3vqwbo/8JlPO92/DQx4lb3Qp5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/nYKqSg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2287834f8f.0
        for <linux-pci@vger.kernel.org>; Sat, 26 Oct 2024 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730003909; x=1730608709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9a894voPSeKCWDpJXy575tccinogzHEiPfzfOZ7KaWk=;
        b=j/nYKqSgrHJ7komN/lKf2nLp04jiVuC1JtUzsTodyZpXotbJBwRSaeEyh38pbTt658
         1o7tY4+AuaXIAsb8b22wuxJSI43ivZVdzv6BSL5smM+IOU0XJclTy0nC8+q+hNX+IXFR
         LsWqD5W3JCx/XaUlrOTIO5zdq1G6SouKgCbUidxE7Ye/UQRgf3kKOWfgnvB40bvJbsHs
         0BQvAcfqreMrTCR0PJowU67iRdVpQackv7tcfOxu6BvLNu4XofkIVBRiFufH+X91r1Da
         +amfterwgWvl+FXUsaKhiJDApWD60olKLdltEMTVKUvlz9OQDWTm5SM0rzfma1uGfba/
         PDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730003909; x=1730608709;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9a894voPSeKCWDpJXy575tccinogzHEiPfzfOZ7KaWk=;
        b=fHXREds/tGlibBSXmsxTB0GwbCyti4jDTzUarICXm4nUJ32k57sorqPKI3Z0jD1+TO
         QSIRy6rzasUZHG0PJ6Nb4gLq4fGW9mrimd+GgOweGFJ47TiSEI+ADah+Kg+g/vt7pNU8
         UiXK28rf9gAz9RSMKr0WIYYZEdZ3JdKSLfoZoLqVSxljHh+gU6iJfvuXsgPXOIlphoK5
         O8kFM1uK4fnBMPC3Cnfdo3kFdWYwdqU73dnhGD2CnGWYMuqba3hLoFf7qNEXRRW47CFa
         ykLBhVvtT+gf2svV6B31vpjRpi0zG9PFODsqSwxwtcvyPfmP+HqVXLUxkDp3Dmz4Hjx7
         R92A==
X-Forwarded-Encrypted: i=1; AJvYcCVKjHvNYRqXVYt9hi00U2NrW/QWhCZEVEs06CFYT58z2VRPzo1+tfYnJsrZhc/fbjfdIwACoBdbAHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjV261YQDj3BOYp+xbLV2AFZNQO+teaEkGpkWA2PmsYPHxrO4
	o6rXMYvj8dQwN5mFf86RMQM0gigjE+e4OtQkArkAj9Z3qz6RhMyaV18zy62xt7J4qQvhd0zpWmP
	Fv4S+Vj0GAsV+TGFTR6ExKbmbI2PK2168u75NjQ==
X-Google-Smtp-Source: AGHT+IGrmepASh+YocMFUfgAy92GhVR+klP9wWMNEuAWzRuq4yxkKFPU9cJ/lzmrPpvIIX5JE3SRzZGJH1Ndbg/FpAQ=
X-Received: by 2002:a5d:5743:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-38061005dbcmr3261878f8f.0.1730003907260; Sat, 26 Oct 2024
 21:38:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 05:38:26 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Fabien Parent <fabien.parent@linaro.org>
X-Mailer: aerc 0.18.2
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-15-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-15-dakr@kernel.org>
Date: Sun, 27 Oct 2024 05:38:26 +0100
Message-ID: <CAPFo5VLC3QT3r2CYw8K7Nf7p7xhWJ0+PPTHYN=8a8QQeGiYfOg@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] rust: of: add `of::DeviceId` abstraction
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com, 
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

On Tue Oct 22, 2024 at 2:31 PM PDT, Danilo Krummrich wrote:
> +/// An open firmware device id.
> +#[derive(Clone, Copy)]
> +pub struct DeviceId(bindings::of_device_id);
...
> +// SAFETY:
> +// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and does not add

DeviceId is missing the `#[repr(transparent)]`.

BR,
Fabien

