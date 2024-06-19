Return-Path: <linux-pci+bounces-8974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5E90EA52
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CFCB21248
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9D13DDD9;
	Wed, 19 Jun 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnYEBizU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA513DDC9
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798652; cv=none; b=k+3ruylLQq1Olmh4T+TNW1z3ktQpuAPrv15UhRIjrrpDoOTm5S5G7Ipl94n1AjyoRaTkygRjsJsTiEMGHAgOzXgkSYFv+gJ6BX6zcF1g+hcJMD/cmuqnWkldIN5eiBQ0I4hf7ZNyKmt/m5cL9FtE8hdxjj3Fe8dkniR2+lWSq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798652; c=relaxed/simple;
	bh=iyoNUKkEZit1dBDwIaZdCivBqyqgkQiE+7yY8/y9GeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bie/fJW6psiJAD1vqR4pCOLC+2bsuopRhzvqS6VPlhZDsf5A/0W0AtnnC+uewiRbtY5HaBMsjg9Nb5I5EZW4JdT3jJBjvAiPIfNr2tNqjpqaRyttlaQ7nF0M1rtWILBxp8fxrzXonx8ssvIG2NsrRWveGm2tz8j+gvliok3kKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnYEBizU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f9b52ef481so3853095ad.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718798651; x=1719403451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybZxfNo2FtYwv7YjHw1QcLjLtoJHxOIkq3qu0lw7na8=;
        b=hnYEBizU8UYxzGoR1c1kxpjOxnd/nqeLga5VIEqFbtX7tHwyATFfo9MYgRfmThKdkr
         Zk0pQWTIjUcUzwBqD7HV7+hD/qhig8eFmgmPrgrYmWH4SXPSgLhfg/S/IdWzaJxWFZ4H
         3GYH2S5j1/pgPpi1boX1BMf0B3Bi2Po5h3astQkv8H75f2ab4418Zuovo0V6i7HFl5fu
         vL5A5VZDQCL5hyKFx8LoafW8O1SfaF0Tc1q56AlyOStMQJAP2vzOkGGKhXaUDsLDP/hu
         0ASg9TctzSZINMu1CQjw3DlRsjZN5/0BDchLy48YUUA1WsCaww6cSy2sITF7mx5zutTy
         P80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798651; x=1719403451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybZxfNo2FtYwv7YjHw1QcLjLtoJHxOIkq3qu0lw7na8=;
        b=ICLPNueWmMtNYGQHGKGaSYztrkR7clKhBTHGpRpAvFLXIuyDYtOlc4EFPoOxiNUCod
         uFnEGe81iWdpcHG14qwJIksGPYCI9Aa6cfifDYeM4J7mbJlmGILUa9Sk4BQ1sNFek6W1
         RBdaok6yvK2A1CS2fifQArN4dbJM0Mf4Mmu8K1v1eHVitguUkci7Q/yXzPoigNrVagZE
         PShcbdOsGbQ2PcZYjTs1jso/hMH5VAJlXnVme+o0PeslWJ2n35EefF5u9CpNw9ViNBpN
         tH2pz8EJa03tvY1enMJRsmAashrrZra6IlrlI0q3TgLfn/ogx9gkuxBaEEu8jTbzUTyz
         5wWw==
X-Forwarded-Encrypted: i=1; AJvYcCXvK3RKX4Z+hIEGHwsW8w7+saeXeUVm1dH9B3Iaxzfy+LXmW1NAB5GVfnORDUVq2aB3O3vD9RSo8IUalut8jx32N7gY4rcwAeN5
X-Gm-Message-State: AOJu0YzLOcOSrxDS1fUxFTM8NLcxfGZZJlv9EcqwsCw3yXk70B26d+zq
	mYxS1xJrzIJIhixFwixQ7miYKdvtGBcDc0NX72tQ1yqhjtgWp6BDX91LBlVU6O4=
X-Google-Smtp-Source: AGHT+IE2ZZd4OhfxDwoBPs0mWEsUYcQMJICVFlEAvInFFMDu6Mv5FIbUEiAg2iF97pv78mFcmcmtZg==
X-Received: by 2002:a17:902:cec1:b0:1f8:67e4:398a with SMTP id d9443c01a7336-1f9aa3bcab8mr23010205ad.13.1718798650617;
        Wed, 19 Jun 2024 05:04:10 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f32334sm115203405ad.259.2024.06.19.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:04:09 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:34:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 00/10] Device / Driver and PCI Rust abstractions
Message-ID: <20240619120407.o7qh6jlld76j5luu@vireshk-i7>
References: <20240618234025.15036-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>

On 19-06-24, 01:39, Danilo Krummrich wrote:
> - move base device ID abstractions to a separate source file (Greg)
> - remove `DeviceRemoval` trait in favor of using a `Devres` callback to
>   unregister drivers
> - remove `device::Data`, we don't need this abstraction anymore now that we
>   `Devres` to revoke resources and registrations

Hi Danilo,

I am working on writing bindings for CPUFreq drivers [1] and was
looking to rebase over staging/rust-device, and I am not sure how to
proceed after device::Data is dropped now.

What I was doing at probe() was something like this:

    fn probe(dev: &mut platform::Device, id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
        let data = Arc::<DeviceData>::from(kernel::new_device_data!(
            cpufreq::Registration::new(),
            (),
            "CPUFreqDT::Registration"
        )?);

        ...

        // Need a mutable object to be passed to register() here.
        data.registrations()
            .ok_or(ENXIO)?
            .as_pinned_mut()
            .register(c_str!("cpufreq-dt"), ...)?;

        Ok(data)
    }

The register() function of cpufreq core needs a mutable pointer to
`self` and it worked earlier as Data used a RevocableMutex. But with
Devres, we don't have a Mutex anymore and devres.try_access() doesn't
give a mutable object.

I am a bit confused on how to get this going. I looked at how PCI bus
is implemented in the staging/dev but I couldn't find an end driver
using this work.

Maybe I am making an mistake and missing the obvious.

Thanks.

-- 
viresh

[1] https://lore.kernel.org/all/cover.1717750631.git.viresh.kumar@linaro.org/

