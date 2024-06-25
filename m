Return-Path: <linux-pci+bounces-9228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D499165A3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B88428410A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04314AD2B;
	Tue, 25 Jun 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="bkLoWZUo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5D14A60C
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313177; cv=none; b=eGso0ENfstTwdpO/kf+Ce8ZZYHIALgFzNqbH3banNWduoAmk0DgbMTjcsGinw15IIS9OwNmFHFoqARms+sfxlb86wt/1aQ8D1tTP8UbSBXzGNX4hiYJASuyUU8lGstcGZMx7tAfL2+g7/lno5daRg+iTtvobsp9FT3Csime2lJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313177; c=relaxed/simple;
	bh=lS6ZzIyA3oNbhwFhi747Z/Q7sqPWYutQ9EFInl96aPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ODpDu9vagywwUC+oBcrgz+/Apj54QZbxBp+YsrERFYD8OCGrBdLq9iWyw1802SI5blBNG571CpBAJFFFWZYt6rcXIWEvr5TcIOSLi/j8EtpAcb1vSft3+7vzyNf/Og696pGSMdKSLoa9kMsSx4dXA6SqIDv/T9t/T39bILPix5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=bkLoWZUo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so1052768866b.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1719313174; x=1719917974; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIKlAQmoOg25cYHG9vFy5f/Rq74IjJJuVh/PhSpJzXI=;
        b=bkLoWZUoOKQ9UHVdVRpkMWfMT0phpxClzjG0HYDY5qgS37X+sQxblfk/FwBzIk+RX2
         2DpJqjhMTY08jEOqYI9gVgpofiAy48u4+x2k90QwazIv4XdJbT7V1V3otblLRvxfXbth
         kKGColXPgL6Y6rKIiPElfdCVswKQldDPwUVGydusv+fDYr9B/AejqxqKHE1IbHDmP9hu
         S5huPKIuxUR3fzJ0a/qx7YglEpWvxVxWbRyqHyOWwGV0cEWxdx6oSAaN1eG7laa89OCi
         /foFoM6vP07smrAltj12OCV98EpnzkpHEo0KxrKESO6lTjeqTKhDV1YxL+IHOpOH5iUV
         4Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313174; x=1719917974;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIKlAQmoOg25cYHG9vFy5f/Rq74IjJJuVh/PhSpJzXI=;
        b=izAzGQZPY5QH+XQPakgWJLIgAfW0Rphfa3F+rjIzGV3wBj/SvLdOhoNzVEFhuI+n/K
         jiqHRh5cva2mccrWLXJWw+ZjrP/1kPegiY4/MjjJCLkvAfDTlrwrH+tebWyIq1XUWIWr
         AWa/KQUsKmqkxJJnXkD0l+kpjPZPwTvdUtSoKPcU/a79wiNpcYzdZXReE1oIhqvVLKby
         45O6vt4HSQyLZepensC8rMXUcB3ZgWo5iKwc4PCbhcyUfeXtTz2xYeVMt91H+TS5qdA+
         40oJ4ozBjFYPJWwNwHhw/g2flXn/LsyOjXPdL/Vlp0aHd6p/ncSUm9ElrQog7iVoDdtu
         StDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwaZCsPmfroQC4D+kcULqEpAW/bwcqinQQZEoakTR0fuGAnD+nBEqlF9I9SemSsWoCslReP6/xsvVI5tpBRDi93HLBQiHkYs4p
X-Gm-Message-State: AOJu0YwGRNyvpz5PCS1li37j/Oy/7RJYpUfhzNVMVNvvOBdV5wyoacvN
	sOWOXDrx7o1SnrO46qo4LH4VVfQ4NXND7l5YEqSs7PbnGfv80TZJp2utOcCojKc=
X-Google-Smtp-Source: AGHT+IEE2Iu1qYKOZCpHug50kXCaLoAfzlnzKDJxNZSjGlNOc+Pt6AUUN+WtSi84pdVmVnNB8Rjk1g==
X-Received: by 2002:a17:906:57cb:b0:a6f:e3e4:e0b6 with SMTP id a640c23a62f3a-a700e70884emr689926266b.27.1719313174154;
        Tue, 25 Jun 2024 03:59:34 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303da3edsm5812269a12.2.2024.06.25.03.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:59:33 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org,  rafael@kernel.org,  bhelgaas@google.com,
  ojeda@kernel.org,  alex.gaynor@gmail.com,  wedsonaf@gmail.com,
  boqun.feng@gmail.com,  gary@garyguo.net,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,  aliceryhl@google.com,
  airlied@gmail.com,  fujita.tomonori@gmail.com,  lina@asahilina.net,
  pstanner@redhat.com,  ajanulgu@redhat.com,  lyude@redhat.com,
  robh@kernel.org,  daniel.almeida@collabora.com,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 07/10] rust: add `io::Io` base type
In-Reply-To: <20240618234025.15036-8-dakr@redhat.com> (Danilo Krummrich's
	message of "Wed, 19 Jun 2024 01:39:53 +0200")
References: <20240618234025.15036-1-dakr@redhat.com>
	<20240618234025.15036-8-dakr@redhat.com>
Date: Tue, 25 Jun 2024 12:59:24 +0200
Message-ID: <87zfr9guer.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Danilo,

Danilo Krummrich <dakr@redhat.com> writes:

[...]

> +
> +macro_rules! define_write {
> +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
> +        /// Write IO data from a given offset known at compile time.
> +        ///
> +        /// Bound checks are performed on compile time, hence if the offset is not known at compile
> +        /// time, the build will fail.
> +        $(#[$attr])*
> +        #[inline]
> +        pub fn $name(&self, value: $type_name, offset: usize) {
> +            let addr = self.io_addr_assert::<$type_name>(offset);
> +
> +            unsafe { bindings::$name(value, addr as _, ) }
> +        }
> +
> +        /// Write IO data from a given offset.
> +        ///
> +        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
> +        /// out of bounds.
> +        $(#[$attr])*
> +        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
> +            let addr = self.io_addr::<$type_name>(offset)?;
> +
> +            unsafe { bindings::$name(value, addr as _) }
> +            Ok(())
> +        }
> +    };
> +}
> +

I am curious why we do not need `&mut self` to write to this memory? Is
it OK to race on these writes?


Best regards,
Andreas

