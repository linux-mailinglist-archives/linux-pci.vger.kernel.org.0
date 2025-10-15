Return-Path: <linux-pci+bounces-38244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83777BDFAD9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77BE74E65E2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A43133769D;
	Wed, 15 Oct 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OEIxWQUD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60D33439F
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546103; cv=none; b=gqw+VrU7oY8AusXyS5vbAOtgmwd8J/ouC0P+ZaZDH9O4pIWvQd7XETkhMoquzOhX2e9GpO16cZi0xFCz3IF4RVMBX9KLLAjp9Tca8p08RRRVAwA8JhNCjkmxORXSzwZURisMy4rjyDuFdn0ABHghibEQRerK9s1v/76c+Bv9KLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546103; c=relaxed/simple;
	bh=L5tvi7+IQDs+VRJpw8WX5BI2YljAtn95hgbTZZTzOw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG3N8YziR4hs6g0D5OhqCwi6eAv3ZT/E1HmVBHo4woFFtavlSkbZq2nNMKFgk2pC/FUdg18LH4fqjnF0OYWXDLnccZ8yiBVuMjfWPAN6omnGhGxlKDf0fHWkpoDiSXXrncq5Kn5T8bYRoRZ354ODiX4PHeWAmmw2doWMy2A95jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OEIxWQUD; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c12ddebffdso557602a34.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760546100; x=1761150900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCDXpcrAleflJDj99gPUKdddGhphTvnCdBCeqIcXopk=;
        b=OEIxWQUDfufj7+a+GjTW2wPBTT7JEkQ2hlz4BTg7PNG9A70Kxidu1TljrkfeNsVTpg
         ZtbPv8iyNY4ppVThOzwGgKCU5XhR3qjmPwKnCwfG8V2FE2IA6HkS0euvaEX8ZDsr84PS
         1yK+63v6KD++Jy/OzwDDPe01jiHjr06KUgP19bla3ZAnVVrgrXFMPuYqBTnxQAK1GcYC
         S3h/DQsOMzGHf2OUil0x/RSGbpW3G8JqrhctiRDsiDNtdr31KarrcjIL48l5zqscVSWJ
         Ctf6FkeZ9YEZkIl4bkgKhSm+xA/O5L6tHmVsmtFG16nmx9RyLrCdoN3PV8g1UtEkWpX2
         EJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546100; x=1761150900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCDXpcrAleflJDj99gPUKdddGhphTvnCdBCeqIcXopk=;
        b=kbf7ocz6HHR4T/A+VSVKIJz+RXV0vb+TJXIvD6+0kay3ep2Bj6rY7mbJkrJsdAzfCV
         wSrVNRXreyRTpMoD3xCCfV0vzoOzWbarMkdVt+y1lX6ea5QL1eV6EQ7u9I0z32PtTr3g
         0JU9zc6ltNDbyZiLLHUC9fq/WqGzNtdcomRlh01suwrz35MZWHwuycVFPzwP06gt7M46
         rKfKw9MmVY2GY3kSFuKWpYGuvr7rMcmTZNOXZl1e/UT0b091OoFv+5n9R2uhKfX4uDLD
         gDuvyxM7Z7/YmdQ7dT0l3Dorl82px+ZqjyLD3FUA8S+vzE5yOQpPrfeE26MGBNZY3z4J
         7ZXA==
X-Forwarded-Encrypted: i=1; AJvYcCXptBM+/wYv186CG5Omkikv1KJ/SLG0syRVC2mnYlfnEhnqZAAA8SLU6v4m2TvdRVf4vH0V0SCFVLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRoYPFr4lkSZJqSSFYMsDz46hHTEZR7KFcrksULiRDtx+PH/U1
	w6+uNqEbm0RTmfE28SsbMLVoGjvNqdk+InRspYPJZogIdKKsUEnuPUDWBvGz6H4cOyE=
X-Gm-Gg: ASbGncuw/nzTpTZj/DbiWKFpCsLxjT9crDeWvdzpVeqVbVdrbCaMgLNSYP86O+/wQds
	lwU9cVfjWO2Mf0MVUzlojdyUxms0UoSBBYaNf9tKJ+5zW8SAxllDsO1l5zVNRZS5DeEsjIdPvCZ
	EPD3AK9pAN3wgziUS7o6/QKDBsv93uEtCLibBc/U+W6Til7WOBrkVisYbY6Ah7jmMfDGSWbD6tZ
	CaQ6Wd9WR2oR/jsdRjIXNCJIPaTKD0VMguu0B52l4oXyKd6riL83kpBjmJNgE01Gdk3Gp1HZQn/
	JFP+fsmDbWXwrb46JydbPFX1NNmPJhMvaxL+/PJjiH1jToBx5K84uN66Xck9C8u69liIpK0k0OA
	Nvp1QscSv12mBV2qepXyn16+m6A==
X-Google-Smtp-Source: AGHT+IEoFlFxHVOg3TlsEA/EV9K2+7van7rs1mfIHJz6ue9Awll3yFhXypIbfuEYnE5GhO0NQgK8cQ==
X-Received: by 2002:a05:6808:4f14:b0:43f:75f0:3881 with SMTP id 5614622812f47-4417b38b780mr11335099b6e.31.1760546100574;
        Wed, 15 Oct 2025 09:35:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65031fb8ac8sm2365203eaf.20.2025.10.15.09.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:35:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v94So-0000000HS5J-2mCC;
	Wed, 15 Oct 2025 13:34:58 -0300
Date: Wed, 15 Oct 2025 13:34:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20251015163458.GI3938986@ziepe.ca>
References: <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <yq5a347kmqzn.fsf@kernel.org>
 <2025101523-evil-dole-66a3@gregkh>
 <20251015115044.GE3938986@ziepe.ca>
 <d5144c99d7c04e4ad09ed9965fa3512c203b5694.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5144c99d7c04e4ad09ed9965fa3512c203b5694.camel@HansenPartnership.com>

On Wed, Oct 15, 2025 at 11:19:41AM -0400, James Bottomley wrote:
> This came up for the SVSM as well: we want to expose things that can be
> virtual devices or other resources that the guest discovers.  Our
> conclusion was we either needed to share one of the virtual busses
> (like virtio) or do our own svsm bus.  The agreement was to implement
> our own bus, but we still haven't got around to it.

I think your own bus only makes sense if there is a structured
general discovery mechanism that can be used to automatically
enumerate the devices to create.

If you are open coding all the discovery via C tests in Linux then aux
bus is probably appropriate..

Jason

