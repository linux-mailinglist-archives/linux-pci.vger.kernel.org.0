Return-Path: <linux-pci+bounces-32594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49DCB0B23C
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 00:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AB3B172A
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 22:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C6A226CE0;
	Sat, 19 Jul 2025 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hilh6LCP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0B1C3BEB;
	Sat, 19 Jul 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752963418; cv=none; b=EF3w33ht+/k6cjnHmleKGuORRfhhMgJRNuoyRe5NyLaz89zEa/3r1aVP5+7uqlem4aLKziamFP4Sr37E0gd06tfCZHUPCUi+zQ0qtI2RicwL2DERqUC1pa4tZ7kcXSMdj9YmQ0DJOxPCTQoteP16WCHGLHZeDQVKG3kElOO7Q9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752963418; c=relaxed/simple;
	bh=576aABal2kWrgo5aU2DC92UJV06aKxVr5p1vVjwvRzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqQehYwX8FR3YnFQ4oULXv7eJ1H0E2tX/5+P+j0yEYK+GDLEtDBEROXCfiNBiWU8sJ/Fx1gDene5txjlXpmf/rj0kG3J1GqVJF+x18qeCmMMoZWjB7/AUY2w6APQIJyRhu/Q0CY3XE96IVx+IK06PP/GMSwbC5FuJ5Fxa9uGsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hilh6LCP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31306794b30so587354a91.2;
        Sat, 19 Jul 2025 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752963416; x=1753568216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+ucaLZRGzfkN8WY40Gpu2iSux2CanOUii2WClPgLvY=;
        b=Hilh6LCPL+qMQgrudjop2DZK/87oOeUT2e2BKzwyOocgFsagYWO1ea3Rs8R3PiLt/5
         pyCpZToqxQIL8IVc2vhWR9GVBcfaBuiSdYRXrn0MDsiyjbrNsGgyg55zLMz/LRu0krx4
         vMC8OEwtsaFnjUgTi47l0nPUsaw0T0JYi/ru5R+EXIwS5jMMD1M8bKcim9I2zDz2x1LU
         wSwpHIIStvB5KX+xEyLeeZDoRtUUZvNdm14ZTxzMhga2Op1lu8Ypui7n+JBRamkxWuhP
         PyFQksGPbEwX/3MXidf0Aw6sj4FpWbDElBiA9pVKnRzsSEHrY0HbTeipuU+SDhyjc1ZU
         o/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752963416; x=1753568216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+ucaLZRGzfkN8WY40Gpu2iSux2CanOUii2WClPgLvY=;
        b=iT7vg06CXzRnlzPCoiuA91iW6NzcDg76rTs/EyUSmENdoHIYOXYDow9x0jgmFZ7g/C
         xq8iJH2uY1W/5iXrFdy8OpCo8nPEeT2tNBv3MX+kUQmZ3Rf55otou7xPhGIMauveM9az
         ewrxki3HsqdpHl4w4yxP7xjiFEYDJye+DY1TBEoD8ItDNgzEwxjO4/ohv2QqYCZQs8VD
         hrsfKfBzIiRoZPYjt81l2sxWHxtURoRhdFsS+6AyAkllohHN5ojQgXv1j9RoW2k082ko
         NTBwCmTmj0O6ZG/SWTaNVlCNesjvg7Uc/DS+OM0cfSUkwclDnzybi5YiaHSHafPdoDU+
         ++4A==
X-Forwarded-Encrypted: i=1; AJvYcCUY+Ol6go8lVmeHSMqYSlWP5RQtAAo77ULO8yJCXsIgsTLhCLYEs2S7l5hGU71ZWUXSt/uco5YB2iLwXM0=@vger.kernel.org, AJvYcCUh38wBAOFwLMgqJOHi+RsC5mNMdkkNd7TaBcOiqWnfUjZfb9qrKQ1DRbxiIHny76D1PYzm/WWr8Typ@vger.kernel.org, AJvYcCWyO38OdxBIltWP0GNbkGwpJ1CzUK32l1PEGVfLKfVskRjLpe2cTaY/VYZK1FDQf9UxmkvgFXY/NZSOOn8zWHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfgW12GZfbU9mofGP5LvrFv8RXkEo3dHEkUicg9ZrtUk4pcSeY
	rqPzx02WXufs4MhBzYStzN3imTpGXogeMm17cu3iD01xjXQZM63J0Z3hQtZkerNk/w6EZgXn+lv
	Z5GvS4m91Vn2gkgBQnBD6Yzv35EGSuSY=
X-Gm-Gg: ASbGnctly0ojNET2bV1x2gP4jegH78bpgn1v53+p4QAVvs7WCGyqcmTZu3QaTxc+RMr
	ztT5oy4dkMJD43t+J4gLpIs6RaYEAKJ798BK4Hf5iM95V3yA2+FfMnIIlkjVWBXPjJiR2kQUNGz
	EWhhQA5ujRsH3/ct65t7PVIJ7ptlIYdwXRBDsVPZLdJQHZlUlEnHCtFviadLe4QREIUUGSXATHu
	cgXBipQ
X-Google-Smtp-Source: AGHT+IFlTpbotz49/yeQzolj8+FNugmPuDoUVVk76ef3MsMTyoEYJy137/TZ9lz9GfFWg+iEs97te9qyWaOjDRBxFEI=
X-Received: by 2002:a17:90b:2542:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-31c9e760d63mr8447543a91.4.1752963416517; Sat, 19 Jul 2025
 15:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
In-Reply-To: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 00:16:43 +0200
X-Gm-Features: Ac12FXwVRDc-IhJHNZEHAIhMFeu1fLk1rOh812ZBFz56c25rfIJrWsaeUqHWEi4
Message-ID: <CANiq72mUijdiCLNDT_+WEgHV6M_hUQwm3s7=T0xvov0D3YoRxQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] rust: list: remove HasListLinks::OFFSET
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Christian Schrefl <chrisi.schrefl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> The bulk of this change occurs in the last commit, please see its commit
> messages for details.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Fixed Rust < 1.82 build by enabling the `offset_of_nested`
      feature. - Miguel ]

    [ Fixed broken intra-doc links. Used the renamed
      `Opaque::cast_into`. - Miguel ]

Cheers,
Miguel

