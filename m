Return-Path: <linux-pci+bounces-39694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F6C1C7EC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1564D62644A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0B34F246;
	Wed, 29 Oct 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c8pjbcQj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932C34CFAF
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758381; cv=none; b=BD/6e6ApXFjm2T2YM/YSzGvYKwrh7VPT8/ewEr1pcGprzp8oOT3Q+u+YvDFinvTOisdb7LyUCxO24MUtGo16XWMg8M1UPpDsdNa8Ak/aPrjy0mdL8JzxRUf93FOwLDoMIaYnK+FSdbE48E/ANeWd6ZX50dkzeBCviJCrhsevsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758381; c=relaxed/simple;
	bh=bSNd3wWUQQy2YBLmw8YBigmBKjZAe88REZ3E0Gos148=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJFkacIIxlICQOFowsX5Sx90wnddrCoep79pidWkhraewkvvTYMdxXw5lfqpS+YYlJIdeDlgEyYhqzYzGOmOAiKyLCuwZ7pdd+Js33ndF+J1Kiry0S4eWTaJWP2pkcF+bVfaJ2dS8xN6ba+XUxlZ6wKhbRyiRRTlelJzEgFs1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c8pjbcQj; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-89ed2ee36b0so4809285a.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761758378; x=1762363178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSNd3wWUQQy2YBLmw8YBigmBKjZAe88REZ3E0Gos148=;
        b=c8pjbcQjxYYDCLYOpUG3c+UetpD9UmMy/mJjP/03CJP8njtwrgRzXB/HgFJGl4wT/D
         jjnTAwdncSiIYxVxS4NKNf+sRZICL1F7MbwO9oyo/kls3vL4lAflySgPYCDmDDVikQ7C
         238vFOO19ldNgXjx63Z1OJyIfwcKIcR6FcKbfAw9VJWXC1VLhbtBWuzxZ45KnHuCyMB2
         Y5HDUegpQuHOhxBr7jp8EuagqA/dgBhHQnkhVlBso6COfgKOzIPeMaa7LV34sV1yIPtO
         t5MnVyO+aMaWUtG5jn4ztju/oLfFp2Jq5oFyC4LbeIX8Z7McFa70Eba5fPcikY0Lh359
         kbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758378; x=1762363178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSNd3wWUQQy2YBLmw8YBigmBKjZAe88REZ3E0Gos148=;
        b=SVQwBSWkIFlsonqeYlW3oZzpO6IsoXfo3QO8GpR6maZUwUEICHRMZf+DXMPVNlx+ts
         LBZEb9SfZ73XDjwzHzqtCzwhfIi7ucykwAlttTyDHCrBMQWwvMzJHbJl6QnKDlJH3COE
         Z4ySLqtJC4RfOsnqedhuvgLb7k3PW1Nn/hUGqplAxjG14M2FOM2s8vi6HckoQ5TrHFah
         hC6WL5WJZHHoDKrLJKyzRZGegOo5e/TlNecqXS860Sm9MT19vleGU7pDF5+tSUQe0ZNX
         bQK3porLz45OtnekRvwiXYOufXfwDVD12UrhCh13gRiUuHlkYHUMT9tyQ/88C2YCNknt
         iBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVqR+vhEGUGvMr+HdhrDVi3cyMj9j7Le5oOTiO2vctUvMhKJ69XxBjciLPYUzdCOFjcXSWwpwqbCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoD0S77BbD0Kbw+YqvEWSmA5ekUWaqIDUrlDupTs2y0BI9jnH
	eosfpNB/aGc6VI50vPrwwQ6zXKQUfGQO7UuB9l3NrLjKa/+jtZ1DVlK2o0jbyBfuugI=
X-Gm-Gg: ASbGncuGWnUkrqBAIpKsLi1hI1qC5kVvhQUJcHrID5CLhvD2BQCxFTNA6+lJ2LBGoM5
	+HtwGlVV4+MlNtPVD856+8tFtinWIIv7TuGUK86YGlHYpDJa3uYQgVGKXylgRavxepTcNg2EHiK
	8ELzO529IbCGL+qanLTmdwoE7Ncnb0gV0GF5wDoYD1W7pZXj2s0+s3qIy3H+fs2o7Iq2OAMhenE
	/DkTM8aeiUt6SsYwDMA5ePB8BcJvUJxl6tmt6S0xwUc9aXI8zxxPwJdhXBqhVwnRr+YYeF9kwsa
	Mh2s9nKShg0ffS1tvOVpu5v6QgV2opYNUdqrI1N1QFefhumVmHWADJWFeUsFqLgs2jinXNCjUMA
	TrDHoOVtRw7w64gG+/7ct+l922zLZDi6rCzSzDByilQgzEtX6QEdgi/THQAJN0nvtglCOUx4Yiy
	D05uupJ7xTiceI0Qpm29BOdbJ+Siw0hIRnvgvI0qu2ZUOwmp2n7QyGomm5
X-Google-Smtp-Source: AGHT+IEE6XGe0cEoiRKL4NLOLkjviUWVkKq1s/Sgdt6ffSSTAqyCXCbcME2UvP5qWSwdJ9Al+rYJjg==
X-Received: by 2002:a05:620a:bcc:b0:8a4:6ac1:ae9 with SMTP id af79cd13be357-8a8e436110dmr482308385a.3.1761758378351;
        Wed, 29 Oct 2025 10:19:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fe594sm1089845885a.16.2025.10.29.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE9pg-000000050Jg-2H4f;
	Wed, 29 Oct 2025 14:19:36 -0300
Date: Wed, 29 Oct 2025 14:19:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 12/12] coco: host: arm64: Register device
 public key with RMM
Message-ID: <20251029171936.GR760669@ziepe.ca>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
 <20251027095602.1154418-13-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027095602.1154418-13-aneesh.kumar@kernel.org>

On Mon, Oct 27, 2025 at 03:26:02PM +0530, Aneesh Kumar K.V (Arm) wrote:

> +DEFINE_FREE(free_page, unsigned long, if (_T) free_page(_T))

Please put these sorts of things in their proper headers

Jason

