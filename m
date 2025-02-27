Return-Path: <linux-pci+bounces-22583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C3A485CC
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED6D1760F7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF811B3943;
	Thu, 27 Feb 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0Ec7Nbc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816D14EC5B;
	Thu, 27 Feb 2025 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674835; cv=none; b=ZOcZBtFmhElx3XeCN39HSBWNpbvq7zZw+CzWTNsAnqV2ieaLGc25N2aaCKmj8zKsRLg6kFBsRPX/rRncLfE/hSZD/7NOswIyDaeIOkj0vv8gNpEKKfIJuWi/5KReZMnEI9HgCVL66GsxcgJ/MhXpRmu+z8wmGxLFFFnToY28oA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674835; c=relaxed/simple;
	bh=PkXZ8moBOc6RsNmidcc+UGjDgfkiuoVB1RmC6o21XW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMe8l1xNbE1F5vsWM54+a+thwRrR2Cf0tARhJz0ceQ/doZg0Xfe2cBqypx1A8g9KDOlsK8+4yrVN21ucDDGRmBtYTAsONMW/RzvAlP7w4ExZJMcMjHj8ciKwMc9BdhKmWEEuKPNlvieDwHO5ufOiITFXoHE+TzeMYKTx1zvMczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0Ec7Nbc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe99d5f1e8so300550a91.1;
        Thu, 27 Feb 2025 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674833; x=1741279633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9jSky1hj2tIhqu9jP7zhhU7JSzIy8xPtEaJx9bRobQ=;
        b=C0Ec7NbcfHFmwRcEPUFc9KUQ0Fw12Nux7MFlkw9/9cgcRBfgQUV4nTCOIFqhrAVS0+
         HEmct8sd+spL5dcK5avwtvH4f1Ekb6FIysBplLM65d98XAqY9Eb9c0NeTwOmAbFCO2Ar
         sDwWZou5xEei4+WJKd9j3+wyFXP4BGjjH4tyUk/t4BFwyph3S5KsDkc6BblmEnVkB1zJ
         yMK3gx/gfN6Lfb+3ewPt29P3a575v207POGbko9sWNqk9UBLpWyLHLswErBYsu81VgXZ
         xoj4FYLXGSGep7IP4+4Wk5b2hMfb1Hr/CPqa6NIiwJXKpTU4+wX3gP8UHW/SCvwBElhe
         tvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674833; x=1741279633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9jSky1hj2tIhqu9jP7zhhU7JSzIy8xPtEaJx9bRobQ=;
        b=AoCWNRGnTH6CEeP0caDN6WbhdAaELAb+krgJejoavnZGTpOEe6P3THtJuhnUc1L/1T
         ckdzmZD/3o6/khjz0NEaCtA3mVok+cFWbNLQBpclUrGNdwbPXNnzdAwHrgMnsBTkAfP8
         9uY3NglFiAHkRZKSbsT5LCWpidhiZcRYjaO9Vv66t3UTMKH4xVM4iOoUjoYN+U01/Rsr
         Ngz4CeL9kUcgSTVivFfdyOEx0Ln1xJUbzr4e0Bzu6MXvXtnzSJeA2zU/VYFLygLzMXp+
         JEvXQg5n5PnkdUek5CQD2blAxqaQGdgxa4Skqdcb09/5pHnIXHEbIIXN4MzoZYI0/uCV
         ABDw==
X-Forwarded-Encrypted: i=1; AJvYcCU9dkNLDVbpjkB+Z43evi4b4N7TQqkIOIoIyr997yKSfxFTl8yQIERscxwAjcX6BhpNISkuSjI0JWYPWrNL@vger.kernel.org, AJvYcCUA3AhAQJAzB61T7dNPSa8EiOYm++ZjNJ6e5CPwc0dLeqI2UaXeG8W4F0SVljsmoCZUU4+t+xVObko=@vger.kernel.org, AJvYcCUE0b2aKbmX2Bv9Pr02XDRVkBxxcsv6xzP+WqJ4yksDRU6evOdqOmnKZ7eBfy8mAHA4Cgzn2A3QsHfrzZ+t258=@vger.kernel.org, AJvYcCVoD5qJ8R3+5negMPajYhVtw2LsrF0l2lPZtdc9gCWwIloRXKxZxd3f2MRlbtfocfWTHbgnZEOctwVi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hqH5sSlJvpVp8netDag9U6zhtA+laXTGY+EeGgd+lqGEdeQt
	lLBNq9LivdpVnfSidgwS0GoqzPxK7jErHbz4G/XtaRmrcYaBOs62yvm+gqBPEQfD9CkwBahichS
	th+NeiqB2nd9BVYy1bvXCJ/RREy4=
X-Gm-Gg: ASbGnctyS5CQlD+d58+XwZgdFyPy+jWUhMR1bHpPvUD8ip6UMIUxsM2DJVAOk54uH94
	E/JcziBOUCsx8AWiYexXJJqamZybkjisL9T5cf3GCJdjBv8vRSSH1uPmUx6pyMOcXcfUHF/J1tK
	mgWpEIu9U=
X-Google-Smtp-Source: AGHT+IFajF7dRCPy5k5DPrcc95sWKa3zdcOgFu+u7rZcCg6jcEy1yjm1f49y8tftlSkNgxdbYDUEmJTmwUABm1pFvmQ=
X-Received: by 2002:a17:90b:4a03:b0:2fe:b1b7:788 with SMTP id
 98e67ed59e1d1-2feb1b707f8mr1033941a91.3.1740674833558; Thu, 27 Feb 2025
 08:47:13 -0800 (PST)
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
 <2025022741-handwoven-game-df08@gregkh>
In-Reply-To: <2025022741-handwoven-game-df08@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 27 Feb 2025 17:47:01 +0100
X-Gm-Features: AQ5f1JrXLnDZJJpbXLybXz3GUfi862adk1qwXJKlDFQtb9StNutkKGNXSf57pXs
Message-ID: <CANiq72n4UFUraYeHa6ar3=F61C_UxEJ1rq92aOF_hH9rtjN+Dg@mail.gmail.com>
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

On Thu, Feb 27, 2025 at 3:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> As this seems like it's going to be a longer-term issue, has anyone
> thought of how it's going to be handled?  Build time errors when
> functions change is the key here, no one remembers to manually verify
> each caller to verify the variables are correct anymore, that would be a
> big step backwards.

I can look into it, after other build system things are done.

I talked to Emilio some months ago about this and he told me Firefox
solves the problem both ways, so we may be able to do something
similar.

Cheers,
Miguel

