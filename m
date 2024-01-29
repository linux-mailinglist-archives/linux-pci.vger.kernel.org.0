Return-Path: <linux-pci+bounces-2695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4862783FEED
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 08:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C932854FE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3564D5A5;
	Mon, 29 Jan 2024 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovO4XykB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2183D71
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512239; cv=none; b=IUc8U3y2l9GtIbEgIJOvWX7cuDqBb+z1PdjQeoIofu4SnPEoCWp6iF9vwGg8vpl34qydmbPVc01AdSpAUJa5zXBgchzCzTpD8EBD/VBYXR5I+XLeYIt3Q3yzEiZW0UW6Or+4DLDHAXJU8TbHxgHlXBrVJxuHuDTl5p1mJJiWT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512239; c=relaxed/simple;
	bh=FnqQssYJIJJ2CeYSjT3zrBgYWf5eLcAzjedsDke8qEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSAsC3vld3ocq7aD07B3kAbuwZGWwSlibBLE9mTQTCIvRZ4Jnr8jWqGFGwI6p/ZbDqD29sN+KIhjvkt8JE7lpdzljaXMauH+YTwoRsa8phi9q5ZmPoz17A6KooUwEA1fblMwkChP9WfNovQ/Eic1R0xtTLu6Gt+qKjeaF22yFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovO4XykB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-429de32dad9so23985711cf.2
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2024 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706512236; x=1707117036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5mmUKkfL50w5Gy44exqzkzq+xInXk1fpuxzVDKyTRY=;
        b=ovO4XykBnOHMOEcQjkcAyTdZ1t1cGz9wVtE/UMuOrOJktT7v0YmHVQJ6fQfqZCsNHK
         8AQIgdZPhdC/YcYNsUqW3Y2OUjKL/y5zEAzwkzUomverjfcbfUIczPP8qdxddxeUofT9
         vqTnq9/nTk/1UA0i0dkS1YcKr4Ymdm6T4vh8iW7rCIOY1xVCNS4mWC9eYkKffikmFYRv
         SXVz4no+dxrxLJRVTi6aEKK79/5tFwfkpAHURQtqmR60QMeiEZnZA/Tw++rGlVOm7RtE
         mYljZNuAclok2lMDeqMOTGxNPFXuQHQ5tdmwewt/A9YaiDHGVlYGlYcK1TO1/P63zax0
         0AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706512236; x=1707117036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5mmUKkfL50w5Gy44exqzkzq+xInXk1fpuxzVDKyTRY=;
        b=ajivj0Le4uovOxU5mv2+Z5wZ9eSAjpBy0BsM03nhYbzgtPwgXh1jieeMoQiF+md29c
         f/WYuWJVCaGsJQL4BqcSyyStltONUlazPBsWqJn023435VZ4WTqEuP4amM3hB5JD9+/q
         89sscj4oyaW+AI5xAjwWIryaerNOsO7FgDinNfIOLzQiU9UJswtrgQ5pjaD4qp1YYrqZ
         chrYMKGlAI/XolMHtwKxMxp8D37JoerFJ3oHBi6AFPJvoc3uVjvuNjc743hpk07SWTMW
         FNWpiw2sv7W59U5sgCGTfKaG/H1K9r1oMNWDpW4xmWi3+F90V4rM30neoTRTFH/xptNM
         GkgA==
X-Gm-Message-State: AOJu0YxHQoOkk3CUVOFc0qITP+HCsgqaOcseSZxUjTyNFns3vUcir8ZW
	R4QS0I0UmPQcDvVwd/z9mPZn4ZICtHdzuvvfNsKBbvq19/JS1zzxEs9hQTzxffHcl6D5ow5BiOQ
	=
X-Google-Smtp-Source: AGHT+IE3Lb3AC7JQL8zADDlWNORf0R3IUfXkKBJB7ySxOJ/+lWqdrWNITS0tXkm1oBsVR+PLq0dXzQ==
X-Received: by 2002:ac8:7d4c:0:b0:42a:9853:20a8 with SMTP id h12-20020ac87d4c000000b0042a985320a8mr4241176qtb.62.1706512236298;
        Sun, 28 Jan 2024 23:10:36 -0800 (PST)
Received: from thinkpad ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id cj16-20020a05622a259000b0042a8e9d27b2sm2280576qtb.0.2024.01.28.23.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:10:36 -0800 (PST)
Date: Mon, 29 Jan 2024 12:40:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240129071025.GE2971@thinkpad>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbdLBySr2do2M_cs@google.com>

On Mon, Jan 29, 2024 at 12:21:51PM +0530, Ajay Agarwal wrote:
> On Sat, Jan 20, 2024 at 08:04:34PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> > > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > started or not, the code waits for the link to come up. Even in
> > > > > cases where start_link() is not defined the code ends up spinning
> > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > gets called during probe, this one second loop for each pcie
> > > > > interface instance ends up extending the boot time.
> > > > > 
> > > > 
> > > > Which platform you are working on? Is that upstreamed? You should mention the
> > > > specific platform where you are observing the issue.
> > > >
> > > This is for the Pixel phone platform. The platform driver for the same
> > > is not upstreamed yet. It is in the process.
> > > 
> > 
> > Then you should submit this patch at the time of the driver submission. Right
> > now, you are trying to fix a problem which is not present in upstream. One can
> > argue that it is a problem for designware-plat driver, but honestly I do not
> > know how it works.
> > 
> > - Mani
> >
> Yes Mani, this can be a problem for the designware-plat driver. To me,
> the problem of a second being wasted in the probe path seems pretty
> obvious. We will wait for the link to be up even though we are not
> starting the link training. Can this patch be accepted considering the
> problem in the dw-plat driver then?
> 

If that's the case with your driver, when are you starting the link training?

> Additionally, I have made this patch a part of a series [1] to keep the
> functional and refactoring changes separate. Please let me know if you
> see a concern with that.
> 

I have responded to this series with my concerns.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

