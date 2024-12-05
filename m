Return-Path: <linux-pci+bounces-17796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B89E5DE1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 19:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC674281FC5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 18:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3EE224B0F;
	Thu,  5 Dec 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3+JdWhe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180461922FB;
	Thu,  5 Dec 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421845; cv=none; b=Pm1SSRjQ8/X9YGTU613EWMadCb+MZYvgKcXfXZ+dEgk/UiAmBdT9DT15mQ86/RSJRAzch9sSdOEBht87QNaoLuPqS1GTlKuhV+u32SweA4C14wyi3LfxsT7StV+r7TqiZsOB/tefW3UyuIUnaEhnFOOoKIY3vQj7RbaHf0jTlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421845; c=relaxed/simple;
	bh=4hKXmeo2QAswokpLmKjxilzAKe8Ymm1godEgGWglAsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUOQYFtxUvR+NMJ+eDiy70nwwgmuxHwX81FocroFxFDR2Z52NOIZRsjAdvap0XvyphjB3wO73Cqsf5ltiYIOmyCIGKQnEkAE9bYmijalU7tPusHRV+oWi6tK6rqVp/RkjnClV/ewug+PwtppRRm6cbhFsqKKcdjgowpPZvug0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3+JdWhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4ECC4CEEA;
	Thu,  5 Dec 2024 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733421844;
	bh=4hKXmeo2QAswokpLmKjxilzAKe8Ymm1godEgGWglAsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s3+JdWhepFNQK7oC3N4HHeBfDaBOu3ejfoauQoTEkHsTtiGYY7L9y3kGolx8smyAe
	 qTvqVtW1mHTq+IgmbAGDr4ppQnYoeqWwxPW7M8zE7CTk7ZIibgupv8CsQ5CVgnqA17
	 +tKIj3jrRlZER2JrBHmbS2MDmhPATvH+vWnVb50pzcfWs3zvio/+UDsVknl3qWHmUh
	 gBBmbujjvP1Basb2ptycOuIVuIr7GaSf/YsmYyehdcuheH1DkqHKWVUMpPW/T1mAZy
	 3lMDmeUTiYWJeYZ4RN5AHxzroBL2Va1AlBN2yAZghNlr+Adeq198PGtNpase4PYiuy
	 F6yBPqhzcXjaw==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e39779a268bso1389564276.1;
        Thu, 05 Dec 2024 10:04:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMOijCTjLOJAnSgOkVKKayvsgwzYl+OWhk4/yN4utR5OK+Zf2B8XJU0hALVy+C+tb80aFYmqioYS42Uh5Y@vger.kernel.org, AJvYcCUsZCvOlMUVpeoVXVeGjeVoTputtxpaqQS3AajHj7ak6jvaEi9ITkO70qSWr9ecNmLi3hM/YhmSGbq/bZADuxQ=@vger.kernel.org, AJvYcCVZItE1a2AM+Fc8u3VOVj6SaVtK2TOXtPP9ArqNXIpRmfmYxtr0o3ImF8MIA1PCM3KDrsTFyDQRph7b@vger.kernel.org, AJvYcCX3EPmtxzBvg2cpHFTGlyBEFFhvM32WPhVLXwNVNfRmGM6ymnKDp4G/83zmn2SkgQ2Xtiy0UD74JZ6K@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoE5aA1IJymJTEQlnqT2s60Zdkc3vyPfHXwoCNu2S2APFJDqJ
	995o0C0Im4CXoj/SSoWinSsFVS+lvjNAQYIzhPWXYVcF8u2Qkdi6ShOxCnZIfZmDoySQzxxARnj
	PV0r0UYUx/3JHZC1N4s4ObhmE3w==
X-Google-Smtp-Source: AGHT+IFsWbuyFC0xdJvNwlNttO6yOetIWR+HbWMrxqTLlO5vtCqRzBs0/Ntdi9D7d17+ieU38U/ZVt62znLLQBIjCTs=
X-Received: by 2002:a25:b784:0:b0:e38:2a3b:ea58 with SMTP id
 3f1490d57ef6-e39f23d100dmr3886681276.20.1733421843375; Thu, 05 Dec 2024
 10:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-14-dakr@kernel.org>
 <e2c202c1-6bbe-4b6c-ae97-185fe2aed0e5@gmail.com>
In-Reply-To: <e2c202c1-6bbe-4b6c-ae97-185fe2aed0e5@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Dec 2024 12:03:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJn=bAF4OYVJNDmiyCNQTAte4wmLhpo0Ca5Pv_oGTg73g@mail.gmail.com>
Message-ID: <CAL_JsqJn=bAF4OYVJNDmiyCNQTAte4wmLhpo0Ca5Pv_oGTg73g@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] samples: rust: add Rust platform sample driver
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, daniel.almeida@collabora.com, saravanak@google.com, 
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org, 
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:09=E2=80=AFAM Dirk Behme <dirk.behme@gmail.com> w=
rote:
>
> Hi Danilo,
>
> On 05.12.24 15:14, Danilo Krummrich wrote:
> > Add a sample Rust platform driver illustrating the usage of the platfor=
m
> > bus abstractions.
> >
> > This driver probes through either a match of device / driver name or a
> > match within the OF ID table.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> Not a review comment, but a question/proposal:
>
> What do you think to convert the platform sample into an example/test?
> And drop it in samples/rust then? Like [1] below?
>
> We would have (a) a complete example in the documentation and (b) some
> (KUnit) test coverage and (c) have one patch less in the series and
> (d) one file less to maintain long term.

I think that's going to become unwieldy when/if we add properties,
iomem, and every other thing a driver can call in probe.

OTOH, the need for the sample will quickly diminish once there are
real drivers using this stuff.

> I think to remember that it was mentioned somewhere that a
> documentation example / KUnit test is preferred over samples/rust (?).

Really? I've only figured out how you build and run the samples. I
started looking into how to do the documentation kunit stuff and still
haven't figured it out. I'm sure it is "easy", but it's not as easy as
the samples and yet another thing to go learn with the rust stuff. For
example, just ensuring it builds is more than just "compile the
kernel". We already have so many steps for submitting things upstream
and rust is just adding more on top.

Rob

