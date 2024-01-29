Return-Path: <linux-pci+bounces-2697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED39583FFC1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9698281E60
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C848524D1;
	Mon, 29 Jan 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a42W6/nY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625952F68
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515987; cv=none; b=gQYLq6hNBQCI5WZoBLtJoYpan/8AO5KH1K49axrMvWDptxMavHLArBDsFxy1IEpk9hzgGwi+9qjGQQTIusZUgzKDe1xsIa7qABBdk/EqoANxPUi7Ss6dwIa8qlDXsMB2ktXkPyJkT3Rh7meBf/qU8ooH9mAc8vZVfqSd+vL5Xk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515987; c=relaxed/simple;
	bh=BfH/1xN49G1aK/3a14a5uWcXcC3QvafbuagZWE0Ns5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+hB//1Ko3w6ji2e7Nis1wvg4821KN29z9RJEw/k833O+78fEuQjnofAVQ4VHB/lTamE2R4i9FvAibnuxJJrXKY2o18550TCdrynO1CjWtXYAF9tY+pwNw0atpriISn5811l561OFHYfkgErMtcljc21yK8chOo16mxmF0zInsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a42W6/nY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783d4b3ad96so313004185a.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706515984; x=1707120784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W1dxQ8uw33+HU45MXGz7rSF2CFsEggLQSmC60OBN0BU=;
        b=a42W6/nYY6qpKU35gVM2fNk1DbBRNgXtmkQg3q0THDFRgSC5Bg+afEX9fkxithDELd
         BHQKi489Avf/fVLiR8NMv5LAXcRAHPnjQoZD+iI0wH7XU/FZ60OkujwY3cI9PthHyhAO
         6Lug81rZ3OBrHxdhEA2P8lhlj5wIihxvRqHKgMh/0TGtEY7eN7gFC4RXBaxt0jPnghqr
         MdNrylCt8Jn/wSxnJb1pXU5IZPQnDaixszpocDMSqwaoQRCL3rKOwIv8BrKr7/TLZ24f
         apqjSslLgKcUFdsz0QLNSpYyOduHwza1YVTYsusxhKgpu7p4p2TPoHfnV03butJOMgaW
         gIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706515984; x=1707120784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1dxQ8uw33+HU45MXGz7rSF2CFsEggLQSmC60OBN0BU=;
        b=M7ZRCJXFrp19bwr3bm3NBRsVkBsE0CmDW1mTIrQRh1Do4j2FElZkOZy4i1XmIlZekr
         68tm/AczWenxVVgxlODyl8dyTsCScl+1osmKa5/q0wUpHcWW9MFMnwVu5AAxYNIIcnsd
         16NIO9R7+aYtTcTmkNLcqnT5dQI3sPe2tpRY1PMHYwhcnq2zWl1uB65sC8Pb6ZNB2Py0
         dpvTLEho9ogxCsVGlG32hEHcK7rzq+sIw1GDKKTC0UMCGM9gGzeCpo9i1sw+fxZICAxT
         ol7Hx3ne7KBkZV2SXk+0komD60MwSRW4HbY7HESJwNBbpSnC3gJM048nrmyaacoJXabK
         W20Q==
X-Gm-Message-State: AOJu0YxHSReAvQM3dQ9Q0QEOG1LyBP4JkG+9gYaXFJASpT3FSePVy2UC
	6VnWNkW3cbey/bIXMghZoOACV12Quc6hAyIbWUJGNXFkHY4VJVmG1G817W7BXw==
X-Google-Smtp-Source: AGHT+IHKQdB1qByIarAluwnRvhQVrc2VLvmwF4BuMR2JyN04r1fgCbvosobTEFzln23a/bDx1497qw==
X-Received: by 2002:a05:6214:20ce:b0:67a:a721:b1b5 with SMTP id 14-20020a05621420ce00b0067aa721b1b5mr6999917qve.112.1706515984192;
        Mon, 29 Jan 2024 00:13:04 -0800 (PST)
Received: from thinkpad ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id di3-20020ad458e3000000b0068c4f1da09csm738443qvb.120.2024.01.29.00.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:13:03 -0800 (PST)
Date: Mon, 29 Jan 2024 13:42:54 +0530
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
Message-ID: <20240129081254.GF2971@thinkpad>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbdcJDWcZG3Y3efJ@google.com>

On Mon, Jan 29, 2024 at 01:34:52PM +0530, Ajay Agarwal wrote:
> On Mon, Jan 29, 2024 at 12:40:25PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 29, 2024 at 12:21:51PM +0530, Ajay Agarwal wrote:
> > > On Sat, Jan 20, 2024 at 08:04:34PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> > > > > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > > > started or not, the code waits for the link to come up. Even in
> > > > > > > cases where start_link() is not defined the code ends up spinning
> > > > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > > > gets called during probe, this one second loop for each pcie
> > > > > > > interface instance ends up extending the boot time.
> > > > > > > 
> > > > > > 
> > > > > > Which platform you are working on? Is that upstreamed? You should mention the
> > > > > > specific platform where you are observing the issue.
> > > > > >
> > > > > This is for the Pixel phone platform. The platform driver for the same
> > > > > is not upstreamed yet. It is in the process.
> > > > > 
> > > > 
> > > > Then you should submit this patch at the time of the driver submission. Right
> > > > now, you are trying to fix a problem which is not present in upstream. One can
> > > > argue that it is a problem for designware-plat driver, but honestly I do not
> > > > know how it works.
> > > > 
> > > > - Mani
> > > >
> > > Yes Mani, this can be a problem for the designware-plat driver. To me,
> > > the problem of a second being wasted in the probe path seems pretty
> > > obvious. We will wait for the link to be up even though we are not
> > > starting the link training. Can this patch be accepted considering the
> > > problem in the dw-plat driver then?
> > > 
> > 
> > If that's the case with your driver, when are you starting the link training?
> > 
> The link training starts later based on a userspace/debugfs trigger.
> 

Why does it happen as such? What's the problem in starting the link during
probe? Keep it in mind that if you rely on the userspace for starting the link
based on a platform (like Android), then if the same SoC or peripheral instance
get reused in other platform (non-android), the it won't be a seamless user
experience.

If there are any other usecases, please state them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

