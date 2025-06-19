Return-Path: <linux-pci+bounces-30152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A5CADFD54
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D895189B694
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A9242D8F;
	Thu, 19 Jun 2025 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKIcXuCO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D228242D69
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312459; cv=none; b=ednBEdyCTRr4grHNMwTbqESFy9OOBMikPvbc4SQfi1PPjsAzFDKeq6ZBxCCZx6+8Pr+pUQPbHlrVgPn1Z9HWWDzva9n9i2CRFhmxySaMaWoEg1R9W6cSQI7JszNrMYV1YOPzIR/0+s4rM9JPz2IY6YgmP0i+ZdEVNRQOjZuPeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312459; c=relaxed/simple;
	bh=fkIz5c3VvVkstShK1H66lgQuGsJWH2TH8Np1JEM/A24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xlz8BfKS4CpF/Aa+8q76SuSeWM6Hk/hmbeWSm+x4EJ9/tc9H8gCIg23eMx9zv4YU4iuR4SBCGl4Q+Bt6qBzCgeRHjRjriT6geiIe9Y89iTkASwpl2iy+Itfg+LmwIEhvbF66wa56Z4XZescqI9tANnD0BV8CpLunAeRjn74qQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKIcXuCO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748a42f718aso358654b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312455; x=1750917255; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNX8x8v1rA4gsmPSGKn+LRzfhgT9AcyvzOiTf8D9D0s=;
        b=aKIcXuCOlkRKptm+3jS28zkHggMih4vYtkCEOExinKKMeSclcQzdyROq65tyxsKaXS
         Ax4oXlekiXh6RpFMB4rkhiv7t3KMeTrWrk+e6ewEFxc6ndT9sBxv8ZIoFOoqNabbItJJ
         wTZcWpQE0n4sgHO0OBwU0a/HKGsDRgdMMlmbBlt8ttfAgJARjQFr1BBVQM5n0sKzdh7K
         j7ZK6ROIvMiNl9uX1JDqqAZSU887fi6JUmuUsbuZKG0Ebv3LJDIz+pvdusK0betcuEz3
         GfLk3CAN2m92AlnVg4QhdCGkCAQE87e55lLCegf9ygtvPH5Ezriq6DNNJtj+7zz5Vej2
         L2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312455; x=1750917255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNX8x8v1rA4gsmPSGKn+LRzfhgT9AcyvzOiTf8D9D0s=;
        b=Xcony2KoPxIKi0qhbdy3T0yEi125vN8H0iQjXFO1ERr2JTg7GBVrXTAkk8A5ZrlC6w
         8rDHjQlcC32cLAQny54Q5eS+P4OXUZdrvUJ5MqhcEJFwhe0aEPyWh/y9HgY2zdXg6cNJ
         wlRU/rk1HH6MwWYltjNNZ/OkN/i6FZcQ2vs0fFaDDoWqIBsrDEhyNyOVDhyJSDKqGwaB
         obp7f6nRas/LrBggF2RRGvujozeg1+M1/rrJPimo2c8b9StPevuCOJDv+HwdtbqrphWV
         Tk2L20E/UVAGWAS48VLd4Q69X2dFDKkHuLQ6kcIVjX0Oh3+Ka+1/7DQb/a5WiOUd+cs+
         AA2g==
X-Forwarded-Encrypted: i=1; AJvYcCXijp+QNFcVpfN1fEwI07RwhISTEhPrYKyT9QlXzs1o+G+nQLbAau/f5VDt5ExuGMZtpGUaoQNzQPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43vVatezqS/ecGGD7VLThqd+169TprWAfENiupHPZCv0BXmQ5
	SzwbesJ8FXHHxmBRzOlUJWWt3khTqkSE+TvJIKYsottdK+EdEowTQ0QCXPcXZoaxHHqpp358rJI
	zHDDS
X-Gm-Gg: ASbGnctc0yM1S3o8wMOkxGLOFS/yoWJX2Ql91rdY/jIv0BkZQdYsEAC3l6gV+eqUIzB
	eCjGMHDZHb7Ud0MLx6ck8fMnyv0Bjsxu798TlmadVi/Oqcf+jSzx9udQ+x2OmfWVldGr4Uc/Lwl
	OrLgvsORQAnVkeH5IOH2QX9KRbgpa6aXWkEhxg1fyF++nspPWM1A+R03vuEquPb/x9rij0Bic/i
	qjNZ7gHgwLDY33xTNMzBYzm1kyGt/FLyndjI01mBY9ag/Oz32t0NVU6mi/XF00GAUEEEBIRY8+c
	Y/iumXD4buFVgCB8KuvCDn+8KCrg1h5sQtAWLP82thfIExLJKzcifwiWSZNdZPo=
X-Google-Smtp-Source: AGHT+IHpBy809k4j/mgtJ3pLZAei1vSVsYHbL1LodLYl1qhBrEB6gEr4Vdl8NOXI+5UF/UVojJEPMQ==
X-Received: by 2002:a05:6a21:8dc3:b0:21a:ede2:2ea3 with SMTP id adf61e73a8af0-21fbd4d2985mr27026444637.17.1750312442235;
        Wed, 18 Jun 2025 22:54:02 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b04e4sm12287505b3a.121.2025.06.18.22.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:54:01 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:23:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Breno Leitao <leitao@debian.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <20250619055359.tormmysgxxcper6q@vireshk-i7>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
 <CANiq72mfjzXj0f4PKPKg7QgbOrhay4CF_+TBgScecKWO6acmyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mfjzXj0f4PKPKg7QgbOrhay4CF_+TBgScecKWO6acmyQ@mail.gmail.com>

On 18-06-25, 18:48, Miguel Ojeda wrote:
> On Sun, Jun 15, 2025 at 10:55 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Apply these changes and enable the lint -- no functional change
> > intended.
> 
> We need one more for `opp` [1] -- Viresh: I can do it on apply, unless
> you disagree.

Please do. Thanks.

> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index a566fc3e7dcb..bc82a85ca883 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -92,7 +92,7 @@ fn to_c_str_array(names: &[CString]) ->
> Result<KVec<*const u8>> {
>      let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;
> 
>      for name in names.iter() {
> -        list.push(name.as_ptr() as _, GFP_KERNEL)?;
> +        list.push(name.as_ptr().cast(), GFP_KERNEL)?;
>      }
> 
>      list.push(ptr::null(), GFP_KERNEL)?;

For cpufreq/opp:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

