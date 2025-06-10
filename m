Return-Path: <linux-pci+bounces-29290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEAAD3127
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27516172B2F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9C828A40D;
	Tue, 10 Jun 2025 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxskI7jB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323D280A35
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546311; cv=none; b=WWo8mVmvhWspF5iYCVVjlU2Hq9KQ7v5pJZcRHas0FwmlM8XfG2K08JnScRKAU1jHcSDa6uqmJnY2L8RqWcmOEo0gIGuqkoGPGyfoMaRsi9ZEowSTxtTIsBXokppguMNnlgtt7DdcVpbkXMmbWDffg4V+R/dmRFSE9BUYlxu14wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546311; c=relaxed/simple;
	bh=3GM1WRqVYQXAazSmtHqVXUifnN2sHGlrFP+6YGCoYhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJUBPKBWbAqGoMe43jgvzp76KYDhQ4AhM1M0pmjIU9TpzT7OiZjc8WMVUmxWrOi51tG+JcugkkWvAiF+Sja/biNMFvOBa4PaWFHgRHCNj1XOWi6vVD2Cc09KTnJ/1dWssyntEpdTFQt61pNp2zBN+MXSlp13/DkNTYhbo1NUiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxskI7jB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so1754814a91.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749546309; x=1750151109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=WxskI7jBlYVLJXQyulu04qcMectt4Trgg6Nk4LjbJt8g2h4vWZ2GRPeEbsmOrPi9JK
         YzpstdZ950QKrKYmEb6VAFH5/XcyWkq0D5hYAxGC+2N6UXouQqFZbh7exahs7xADUNo/
         H5AOZ/Uy+OtzFM/s3xyj3Wxj04nKze2tL5UyrltR1DgAmto64ZIIHYNOfqXQ1ayGthau
         VjO13WMzgd9v0SskStzsNi2JiKSzS0n0zBv+g0y9PnLNTM6M2yKDleYrtixyehpz6rFW
         vSCtNnVh7A2jdytMVmH/3xK44kzS7w52aPZpNi+4o40I+WhfQeeG0EyNZ0QyW+Ovdm0y
         vnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546309; x=1750151109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=ujx0tNeYbQS/moLWmX0TkeIYsFq/RCaakau4IPnqlA1PO+uPUPgYCQjcBvEodG8uq/
         epeBG0SOuMSyyhzQUbzdniugmS/SKmcP2ALYJSUpCXac190MQgKOMzkg/dKBAV2VKLVC
         8m9yrZTMc+DyqTvZ1epiYpQALRqhGTiCC+jVsfrWnCWgiZBCf0tuQVRbD99bjXpWLrF+
         9sLn08gapPk6Ey91xcXR1F1qlJ0VE/97fhs9IUL3LgNUxSts2c1FgSndamjkk5y6FHkV
         qQgN45CQcaU5YxLcqiNhZN4XigQnwt8BWKZCUDZk27rhXrtVRh3irZv/GXrSC/Z0kGus
         8TrA==
X-Forwarded-Encrypted: i=1; AJvYcCV8CEgO7VMlYsQ4mU1cejK9Ji7QcXS/f8P3Wf8fJY7X02Uh4xeapttI1HVqRKYYCF2R2fwcdzkVSUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+dR5Dlvne3n6cdIg0YTjlm2ywh1uizXY3BKi5CTrG9YOaXl8
	reRXLQFW9qCaIt0KJl7TOrdSuocqYAPsyA27yBzuA0dgMBYPmGYOS4mcOXKtggqsO7c=
X-Gm-Gg: ASbGncuYXCnGbNDGabENcJ85MaSMR6gcon93VyKzox8ijcCW665sGi3OboP3X8lm65W
	PyfpsqrJ1oUE7SGVz7OpuSq0LyEAohnhS5uMi3+mrk/r6piJYX4ZCSz3O2+tkqGDcBI2+ou+xiu
	hayjK3HbBqmK9qcypNijNCJuFINVs6zPLlkxrvjUN/OMbkgq8ICvR8npcxWViWlSQUkL7XpsLA8
	4/i2FH9OZAYtRjgN1GypvgxOYmlm529VjZ4xsTmbewHAq+6tCobjppoE9Q7RVGD3MMFIf6w2TOJ
	diGWUDVRRwkgvfsfFw6aaA+jpjNxpnY4BJZ1fic5cxh0a7Id62DdwbOwhDTZ68Q=
X-Google-Smtp-Source: AGHT+IHHYZrKaT/gzmS9tsVK3hFeYuSn3Ec8BLsyZRN7hNdemDEI/1VCu0avcGXTkJj/JdBACM9Kxg==
X-Received: by 2002:a17:90b:53c8:b0:311:d3a5:572a with SMTP id 98e67ed59e1d1-313a15739ecmr2416667a91.8.1749546308712;
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc373esm6863637a91.32.2025.06.10.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:35:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250610090506.24lmdltnqldsra6a@vireshk-i7>
References: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
 <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>

On 10-06-25, 10:51, Benno Lossin wrote:
> @Miguel, if you take this, then:
> 
> Acked-by: Benno Lossin <lossin@kernel.org>

Thanks Benno.

> For such a small change I don't mind upstreaming it myself, but if
> Viresh wants to have a merged GitHub PR in pin-init, then we can take it
> that route.

I am fine with anyone picking it up.

FWIW, I have sent a V2 now with your Ack.

-- 
viresh

