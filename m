Return-Path: <linux-pci+bounces-38416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7682BE6406
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 06:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F9004EE48E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 04:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E971C862E;
	Fri, 17 Oct 2025 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH3HiPNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331542DECA1
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760673904; cv=none; b=pQhYAnF378z6E76DBZm5qItSGK4ZcUV751ojzP3GZeFfDmTo0rNek7iW8bHZt253j+OvaZKC52jEiC/ixQVTSn0onx41+nW8QVgVDpzmyaF6DvDKpY6Ul7ED5EhmM2Lgn1pPN4Uk4LUQcsW+4iWiTmNRiWvSIV8GZ39KPjhiIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760673904; c=relaxed/simple;
	bh=if0Z65l0iVhtqX7EJ2LAVIPGjJ2azbvYwOOzwnLay28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF8ZdHzIRoJZuqRcCJN+JzAtP9w5DK3gXIxDmmZX8um+T4c/gm6zrZZ7LVNofF/Zen0wpt9HpZKAFzvd4m1UniJ+nH60UNyX4rQ5SAfTFYjg3xj7YMt4mJNUhFoCQsI8I/ZNb/ROXa80YBwuLbPWU8ErgwrQvp1DX+p3snMIjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH3HiPNV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eec33b737so22654745ad.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760673901; x=1761278701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yTr8XYfVKTbUORpK+gdA/VSO6LmqQtreJ6mNFyN7AA=;
        b=yH3HiPNVqT7TeMPYZQ8eVgmKeW2i6SOA55ddHBELyM89fNjkyuP4hqXPVItkNThNJh
         mZ3bcpFim9K1Bsygvbqg1wm83Y5WQYhG/yy1vlNtNwGa3cFI/l6RL7Gtt2mdd0V1wBI4
         GAbSqmHJPSzGW12Vgl9gW3dIRMBgUA3Jvm80k1QPpBvQ6EJczV+Zn1/gkobOs3L0rc3K
         6QzbnsOLVYOnyjWUzOLg2XppJzD4C65eCBPgL1ncrPdWmY+a2NepMMlG7b6KCYMetZV9
         4OfQgGd45kS2wkxO9Ga6GcoY8+5bgvJ1hkXudq3XcKwKpgOCJVzNOxuXFhcPYpvsqJ/h
         TCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760673901; x=1761278701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yTr8XYfVKTbUORpK+gdA/VSO6LmqQtreJ6mNFyN7AA=;
        b=NSyAk12y9EFbphYAKAd+mtv5PCQgsG8kVE39rQofjAPCRBrwI494aQh6Jv9z7hCMQe
         pNyC1m1QuH7C4vLifHQAiHdbdt3ao3HrpmPNNgHJ8+ke65Kzqed2sJ6hJ0pqsaPGktQ4
         TYJK9JVhfJ/oCA6bkvaQlztc1rs3HjvEOGdA+D90kGgtcAoAp/di+DJEAeZ8iZTlTMn9
         rhZQHWc9A5n8ikYTj9GQaDz1Jaw6jMOENsep69wY6uKoMfit106UzyvU+rCSFzQYdmYq
         z/4I6fvwdVylCXTbLHFLf2PzNop88nc+n42c5URGiPUTaDpnm66SpiGidCSzVoCuXNSh
         chvw==
X-Forwarded-Encrypted: i=1; AJvYcCXIF3fcZz0KPSP+SMuFK/vdlFD+uwI9G312cRSVslCFEcnhREA6Uy9v9MpaUGHjgctJBdE+6a8lP8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0GOSOogg7kJpIU+crspJJth9GfE2uFfkXPMJAHm94wRVO2H3
	oLzEMpvTiIEDskbVPeucs3wKKzrywh440/jr8zskv6zQQY4AwUjCh1n0Qpe+VbaeY2k=
X-Gm-Gg: ASbGncsEJo/I9nt5Z20QXwXcpgM+5rv7XFbbmyFRXunLgtjy2tq598KT3MP5qJJwnbl
	9Rd3CtB78RHMrp3UFVF7aQv3M0MUBxpcef3kEjq9Kq1BgEMGKJQPf1UV1JJtGFolMmbt9SY43Yc
	ckq1JaM8hK/V271lzuGg2o/eCmAVcvxsnErCxrd0Igsijz8O8Z3ppaTKkO0iZXZFKP7EuvTA6ff
	6BTtreWUjzKiJMAra+ZbkoCHb86l+mlEbhhYJLHf3cuOHLVtUiovcIIOsTy8jwAHogzfFwbiajU
	8BuQM3ZtmtlNPGRqw48WGMkmEDSgwHysYvyA7UOb4p8otM25GYPJrM2oHgefoTAnulRGrlx76Uz
	ReZzj+7HophQHV0F09MirEql16vzR6L+62VqN9xeFDAiwKJ3tC+f9h098YUWCMoIlqKIe5grtsB
	B2Hw==
X-Google-Smtp-Source: AGHT+IGPSjlNzo0y0i/+GbYPAiFlc7JbgHfBpNrj/C4bxPOi+I7rIKsQiv4+wobJzyD79esO6O++kw==
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr27595565ad.46.1760673901015;
        Thu, 16 Oct 2025 21:05:01 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290cd93f570sm13832535ad.25.2025.10.16.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:05:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:34:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
Message-ID: <co76tfqycdxhrigoxv5expmozqzgq2rjzxvfkfwqzyvlplrfih@gsi5yarmilut>
References: <20251016125544.15559-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016125544.15559-1-dakr@kernel.org>

On 16-10-25, 14:55, Danilo Krummrich wrote:
>  drivers/cpufreq/rcpufreq_dt.rs        |  4 +-
>  rust/kernel/cpufreq.rs                |  4 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

