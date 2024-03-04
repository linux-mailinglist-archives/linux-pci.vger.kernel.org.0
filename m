Return-Path: <linux-pci+bounces-4387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFE586F9F8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 07:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C510DB20B2A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 06:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26BBA5E;
	Mon,  4 Mar 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkdwZ0NJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FEC13D
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533151; cv=none; b=GYfm3rdO9MfhDmTpWTCxLzrw0NGcivrERayFrhNG8TnHalT9W3AaSuklWP358ThMO5FBnjspYh85RHHlhL/B1+QNv3bVqXoLs9d00/XTClY3JFqJ6DgpB0E6gK/UmkiSapWbJg9Azj62fo9Y6LtB9gqMrE5oFth6pejnxMX5CSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533151; c=relaxed/simple;
	bh=oDnfxJ4A8v+Y+oMepOulbgQydBSN2yDgubk57DJ4nVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYR/iTDCYepEfg+1r5Cap4jktwWtDJ7ekUbJvyuysd0j61/aYKYMIQRYt+JFMjh6MLx8wWqQa2eP9pjkLcif2Hx1OgtFgfTpZkL34QmM+WGzbKcJOOzQnCmVMSXpW8lMxlx6MKx1EqFLiGTUieZwz9PVr/pzFEXN1lR7eMmEJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkdwZ0NJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e58a984ea1so2603563b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 03 Mar 2024 22:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709533149; x=1710137949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yY8EnFgYAlXlPqttQTMQ9X4CPIclgM7lc+6szk0vfN0=;
        b=UkdwZ0NJO/t+VeRQ3jJaAJWmtWtHhKKNpJDL8AnzczA5poxIkP82dlz2Nz3ZvQaA5j
         042n+WMa/w1Z1PmxEDdZ+r7jrAX6o+4erId+uuiw40c6rNLfagxqvvs3sCp7PmXk3oY+
         p7z8YX5yAkFjrnDGq4yUApovsYKc/v106gUdPYksnuaFAz978pmQUBVm484eaJhbCZN4
         Sloh50Q44CSXV5G67vSnWWKOJ4ho0R4hNbViDYrKxyBJvG+htd+UdGVJjnMNBkHMLpOf
         jJW8OKwZmqof6MZl+/eLJGjheZqCLf3+NQiWtBMgLVBw7JTZoK8fvHx7ixno2eS74MnX
         6jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533149; x=1710137949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY8EnFgYAlXlPqttQTMQ9X4CPIclgM7lc+6szk0vfN0=;
        b=ixO0mpU3UAQ3kENbT8CAqX5CVw5DUzUWFeD/y+MBB3x4u36nQUl5lF4TfJhETAQb9L
         FooS81sfCZzi9C+0viLq++mxAV4acGFZ3037D7Mp3XLhqRc6AaUwORNtfCQ+dEyfrCSs
         Xa9K9S/DcIc/CVZ4kq6JalIoJrEHWlWl8i9OSwWwYvEicuQjUrZ9RYXPhJJQfCj5Bt6r
         nGdIVLadZaQvECO2uL6Bj2+4+k+aiDgDpu6d6gbTff/lPgv7xBEDqOCxjtvY3P7xjp81
         uK3vFDToRPjIYHZML96jHzvxBpTyZAVCLW/ZZpeqK9tkFjWPlwiGCzt0wdyN000hjJOq
         H3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWSNIfZEGRybXZ3zKMiznrOOIAuR+7q5+UzdvhURxaz4oQyYLZYbxOVGDg/7zOCwC/cNm/+rYY8va9phfe0e3iWAUxned8L8C5
X-Gm-Message-State: AOJu0YwGQCvYvvmOCJ5hmEOed29WWaW4HmcWt9iQFQsB45r202p08nL1
	AbL5bzKynBQex31/JkV+VG91kUxwg9qMDYTzMrZCrLxef4plaNd021GZrADgDQ==
X-Google-Smtp-Source: AGHT+IEGGhWfMbQLfvF9uJtsc7Y6qkosURA49AQc9jMC4u8Vp5VihTolBAdcYaH2nlvvK6/zVXQicg==
X-Received: by 2002:a05:6a00:2e26:b0:6e4:f32a:4612 with SMTP id fc38-20020a056a002e2600b006e4f32a4612mr8718386pfb.16.1709533149188;
        Sun, 03 Mar 2024 22:19:09 -0800 (PST)
Received: from thinkpad ([117.207.30.163])
        by smtp.gmail.com with ESMTPSA id k19-20020a63ff13000000b005cfb6e7b0c7sm6825218pgi.39.2024.03.03.22.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:19:08 -0800 (PST)
Date: Mon, 4 Mar 2024 11:49:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Message-ID: <20240304061900.GF2647@thinkpad>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-3-cfcb8171fc24@linaro.org>
 <Zdy8lVU6r+JO6OSJ@lizhi-Precision-Tower-5810>
 <20240227074533.GH2587@thinkpad>
 <Zd4eLBXscaV1WkbV@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4eLBXscaV1WkbV@lizhi-Precision-Tower-5810>

On Tue, Feb 27, 2024 at 12:38:52PM -0500, Frank Li wrote:
> On Tue, Feb 27, 2024 at 01:15:33PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 26, 2024 at 11:30:13AM -0500, Frank Li wrote:
> > > On Mon, Feb 26, 2024 at 05:07:28PM +0530, Manivannan Sadhasivam wrote:
> > > > Instead of maintaining a separate capability for glue drivers that cannot
> > > > support auto detection of the eDMA mapping format, let's pass the mapping
> > > > format directly from them.
> > > 
> > > Sorry, what's mapping? is it register address layout?
> > > 
> > 
> > Memory map containing the register layout for iATU, DMA etc...
> 
> the world 'map' is too general. can you use 'register map' at least at one
> place? There are bunch 'map' related DMA, such iommu map, stream id map, 
> memory page map. The reader need go though whole thread to figure out it is
> register map. 
> 

This is what used from the start and also what "mf" corresponds to. So I had to
use the same terminology.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

