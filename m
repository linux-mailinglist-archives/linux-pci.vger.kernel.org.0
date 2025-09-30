Return-Path: <linux-pci+bounces-37282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B01BAE11A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E7C3BAFA5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165EA239570;
	Tue, 30 Sep 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QxSog5oQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC319FA93
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250321; cv=none; b=dTrp5AREJ3mkWC27BuBD0yTbKIu30ZTmpCJC4yKZYV6LY69KPycJCeJ/Y0PbQPTmW0vFj943Sba9Tq4AtuduwJ3GquI/3n5AIPudSI/lR7wBMsT/H0Lp8jWoJCiyol42yr76sQ+jCueiPqO9/K/DgyXRoZ/DBH6GnLFPkE4Bx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250321; c=relaxed/simple;
	bh=7ZvWWTmbwpz938UNoot7kYAQyxONzvQpdhOgp4f0kCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CktsD6+N4G+H0vVfc+09APrnVaL6mKxmb3P4c1+s4ol/txkYVDlrA0ymYmnqc1glhqQKP83DQck8yOSpQQqLlUHmKWKt03rUwVzgR1kL9Y2uqZcTYFahONVVS6uBauOVowu7IDqdeqW8GoElXSqPWfqfw62xWc5MhPF0C2HWCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QxSog5oQ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8599c274188so599937285a.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759250318; x=1759855118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xMgANQFX+SgjbJ7utrDVcHclI2GXnTTwQrJXxesWGK0=;
        b=QxSog5oQqgvxLnngv8jU+x203/kOQ7zDjATvuDF14qUIVMjHN5ZldBQUXyEXnnU4kN
         uXewgRecH2LdxHNHyZPgIA7NcMm9IH9jwHBlwY+FVw5DfnhkOCQwrxfyatDiN8yIb3nm
         QjWuIdPAppqdsn0s7FbQW3Lqo4aKEwwFlL1rc1Sg259MIgyht5gvEcmREVej/4fgYIHd
         WDXddj5iajsW79DTuJIFWkkJA3ksnFksI0q9eMHcuHGly/AsvGl077KPsLj1bMDoj+nT
         AtB+pxM+QJM4OD7HgOVrAEXhgDdCgfCd9GBia/VUo9cS+4blIE4Cp6eVD9q681zKVQnR
         CgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759250318; x=1759855118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMgANQFX+SgjbJ7utrDVcHclI2GXnTTwQrJXxesWGK0=;
        b=YS/tiJCYILUYV+6oxS2YhtpthHnGtWgd5th7qamQxZ8xovKWODaJ92Jbli054IUvO3
         b8G6nsOU5uoob2cLNlPByLYlX731ButMGhN38kSHl2Zr/mH8Bh5BPIh7ABj9Co7PbkSU
         Cvopf+GsWz4x26wecEBY1jtpMrTeRIZvrDpsk0gEA93MxP8lBMOwEVLlejfJQrKmasGD
         aKAljnvwf6RIe/z0rw/N4nPK+FVDrOMnsMdep4mqz1UdzqvctJcAuQYKyiMeLenRSZfH
         72BJeOcYeCwZCpiexZIIqxqzXMpaNAifUJqbYcyZ+UVK0PY8Jl6x7KsgmTG1jqYQh6wm
         UKRg==
X-Forwarded-Encrypted: i=1; AJvYcCUeSWDdXws6tw3h+jl+Af6ZZOBmM84743DuG+Tu9nZrfK//c9n1cPFQJpOkZl8TrukZ0G07ZobNLjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9zFdXw05HB0ehQkliYSHaXH5sv6QvTo9xEYB2zgfr2XQlIHn
	8mKFI7f6B46DH27zI43zADHuXxQe+oKDlZhxvmBDWHfR4VoVaB6jzh8KLPfMMDsdFmk=
X-Gm-Gg: ASbGncud83SaD/9Iog6ocMPy8cpqCqqZ8EW5BLCu19SV25F3HFSfkhCw5XhlWADsds4
	Q4wf93jrHYO0lSq9icI8a3qNBXdgYVtePBruPslM5Uj7CDdwYTVsKPt0bUHMEPjr5MM1k0jxLOb
	q3fVnSLeLmZmwcop/5rnNXY/k/4LcstwWzTzVXVyfgDqwku46qlnZVpX8TOgNKUp7LeoBF0O/gh
	6bG5nWXz8Kz1M7Mmu4rBxboYDcqTOvPhTTNLZoE4nOStiKQGox4PiT8/oipi8jacDmlppvRI4Uo
	O+7kCCzfCBJGf8z6sAiMX8McnJnd9qrB8EXMnBPh3mbBvfYXipnszKepokal8GruMo3fgt8EZsJ
	aKUY8U0h6ZaszdPI9thdNLaCD7EYVU6g=
X-Google-Smtp-Source: AGHT+IHPJOCF3mi5Y/iQEx0Qz4nnWU+loAsRCrx0f3/7Rw3nO0AV/kHYsW/UKUUR5t5JJw+wAlT2Yw==
X-Received: by 2002:a05:620a:4544:b0:85b:cd94:71fe with SMTP id af79cd13be357-87374cdab36mr68636085a.33.1759250318426;
        Tue, 30 Sep 2025 09:38:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307ad101sm1065322985a.36.2025.09.30.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:38:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dN7-0000000Cbmj-1CPI;
	Tue, 30 Sep 2025 13:38:37 -0300
Date: Tue, 30 Sep 2025 13:38:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20250930163837.GQ2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>

On Mon, Sep 29, 2025 at 07:11:06PM -0700, Chris Li wrote:
> On Mon, Sep 29, 2025 at 10:48 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> > > After the list of preserved devices is constructed, the PCI subsystem can
> > > now forward the liveupdate request to the driver.
> >
> > This also seems completely backwards for how iommufd should be
> > working. It doesn't want callbacks triggered on prepare, it wants to
> > drive everything from its own ioctl.
> 
> This series is about basic PCI device support, not IOMMUFD.
> 
> > Let's just do one thing at a time please and make this series about
> > iommufd to match the other luo series for iommufd.
> 
> I am confused by you.
> 
> > non-iommufd cases can be proposed in their own series.
> 
> This is that non-iommufd series.

Then don't do generic devices until we get iommufd done and you have a
meaningful in-tree driver to consume what you are adding.

Jason

