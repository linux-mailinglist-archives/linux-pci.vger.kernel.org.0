Return-Path: <linux-pci+bounces-2721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5128406DA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 14:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56EC1F270DE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED31627FC;
	Mon, 29 Jan 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muodM88X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C4657BF
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534795; cv=none; b=jutbWmYFzC9qaWKi+Sw7d1zahs2R16BkMCFikI+Mtgyzv7x0G5Hr1xqQwefPGoLtABVxelBVicw1WLFIvB1o+Tihf4Bhv/bmlYVMbckwGCZcWktCdZympQSndMOCBSVVN2BtreFk+VErI1jffNZUMWnI+05E0+aS58nboHdQqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534795; c=relaxed/simple;
	bh=PcxchE4ZNtZssmPBftcJ9ILwktGPFCaJ2JO2yfePivU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7uganONRLfaRGQaEcBLrYTZ+6b4wCnc6Rx3cba9z8G1JRuTsBVzAEbSzWOO/pQnq9WLZ3uOCTAiF+kRpGIYIh91YdgETsS0yn5kaPfbVQJGtXfbHrDxJGCS5ZWr+eNRUwf70qJli+89aOezL6nJUTo9WEEjpux6VX9REoiz6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muodM88X; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e1214ae9d4so703711a34.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 05:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706534793; x=1707139593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DXRA559jfhrdZU62M+loTe4zZaiaPNXi8Cm9oJrqohI=;
        b=muodM88XDI0ohkAhOBzRwOqHTpIDKGk7sMjWZvn2nLl3Sc2J2Vu3ytKKLmPnu1osaL
         B0CYdESITwUfhUwOyPCgWv/C7OjPYVUXKeMuSimXcpgsouOrqyN1xADj5k7uEpfzuQqV
         mEsxUB/ogOuWB5viYXgm6Nt63H2qeO8VUjd9n6NZLHDpP5ORVZ6986pL8mD5T9OrA5do
         2bfFwgoJiJKYCZdkW1xbWtr4nYFOf1onFj9h16rHsrdCcyL0u2LMtHcUy0fKAcadPo9G
         goBV86xP/e7XDB6N0MSwTFzsH6cQN9r7T/sQe97u1PVOEKFOboQwfIAdvYTE8YDWE63z
         VI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534793; x=1707139593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXRA559jfhrdZU62M+loTe4zZaiaPNXi8Cm9oJrqohI=;
        b=umt5CDtoHw1MdJDOY4Gk5D14BmO2jC35T5u7loQczVHZc1QWl7LTQSMr16cmuuSPZA
         EW8vVXqP+dCVXTeS6+9Ibh1C4y2EITmd8BmyoEoVUu/VF2o7+U3ptOMLcPjiLg7Fm40v
         rdvWdMZeN3VFRynKNYXPH7ksoUEc5HrvGZoFYjtx1xltxZmZm5S5fJ8O85Z+nUz6a0Cd
         b2OZCr8ITeYyGamsMpPWgQneJtj3jqT6NxtWVyZj8RfHNEXiXy3RWiLuEWLo5fCOLN68
         JdX3XfPymAGoTawcPggZuFR1IQw9ArBXcLWkkd8eHY4WeyqHFZdF1gw3jkCfPdt/Su2x
         NT+g==
X-Gm-Message-State: AOJu0YymL3hdBojM9PDLohcq6c5KjLIYp1OsRxZTpi/5lIsuv2PQMr5o
	35NnQEdI2KSall8f3DgZmEoBb0/3tjY4l+Tr9s7l3TeeeUb09Rxk5890IoalpQ==
X-Google-Smtp-Source: AGHT+IG7oXE2ZM6yFwkkISqqbTBtSu44owGp96zLZ32AGAzl4yakJJmUxL1AqRGe2NgyoCNlrWenrg==
X-Received: by 2002:a05:6359:1008:b0:178:7689:51a2 with SMTP id ib8-20020a056359100800b00178768951a2mr1120244rwb.59.1706534792854;
        Mon, 29 Jan 2024 05:26:32 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id s189-20020a635ec6000000b005d651d4236dsm6286701pgb.86.2024.01.29.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:26:32 -0800 (PST)
Date: Mon, 29 Jan 2024 18:56:24 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <ZbengMb5zrigs_2Z@google.com>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
 <20240119075219.GC2866@thinkpad>
 <Zaq4ejPNomsvQuxO@google.com>
 <20240120143434.GA5405@thinkpad>
 <ZbdLBySr2do2M_cs@google.com>
 <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129081254.GF2971@thinkpad>

On Mon, Jan 29, 2024 at 01:42:54PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 29, 2024 at 01:34:52PM +0530, Ajay Agarwal wrote:
> > On Mon, Jan 29, 2024 at 12:40:25PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jan 29, 2024 at 12:21:51PM +0530, Ajay Agarwal wrote:
> > > > On Sat, Jan 20, 2024 at 08:04:34PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Jan 19, 2024 at 11:29:22PM +0530, Ajay Agarwal wrote:
> > > > > > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > > > > started or not, the code waits for the link to come up. Even in
> > > > > > > > cases where start_link() is not defined the code ends up spinning
> > > > > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > > > > gets called during probe, this one second loop for each pcie
> > > > > > > > interface instance ends up extending the boot time.
> > > > > > > > 
> > > > > > > 
> > > > > > > Which platform you are working on? Is that upstreamed? You should mention the
> > > > > > > specific platform where you are observing the issue.
> > > > > > >
> > > > > > This is for the Pixel phone platform. The platform driver for the same
> > > > > > is not upstreamed yet. It is in the process.
> > > > > > 
> > > > > 
> > > > > Then you should submit this patch at the time of the driver submission. Right
> > > > > now, you are trying to fix a problem which is not present in upstream. One can
> > > > > argue that it is a problem for designware-plat driver, but honestly I do not
> > > > > know how it works.
> > > > > 
> > > > > - Mani
> > > > >
> > > > Yes Mani, this can be a problem for the designware-plat driver. To me,
> > > > the problem of a second being wasted in the probe path seems pretty
> > > > obvious. We will wait for the link to be up even though we are not
> > > > starting the link training. Can this patch be accepted considering the
> > > > problem in the dw-plat driver then?
> > > > 
> > > 
> > > If that's the case with your driver, when are you starting the link training?
> > > 
> > The link training starts later based on a userspace/debugfs trigger.
> > 
> 
> Why does it happen as such? What's the problem in starting the link during
> probe? Keep it in mind that if you rely on the userspace for starting the link
> based on a platform (like Android), then if the same SoC or peripheral instance
> get reused in other platform (non-android), the it won't be a seamless user
> experience.
> 
> If there are any other usecases, please state them.
> 
> - Mani
>
This SoC is targeted for an android phone usecase and the endpoints
being enumerated need to go through an appropriate and device specific
power sequence which gets triggered only when the userspace is up. The
PCIe probe cannot assume that the EPs have been powered up already and
hence the link-up is not attempted.
> -- 
> மணிவண்ணன் சதாசிவம்

