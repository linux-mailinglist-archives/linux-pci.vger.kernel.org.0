Return-Path: <linux-pci+bounces-17486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D719DEF45
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 09:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CD3B21250
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128713D518;
	Sat, 30 Nov 2024 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLzFeG93"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C771C6A3
	for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732953923; cv=none; b=Z2ggKpgTY3bDIxi7PY3KGCzJ/sA9x1EbjIefmGQDzGkdKD6S2HVRyql4z/93Wpww5eP9jjacpvzAUAzoELeslEXpBsV7/bXEqbC9c15hR2kjK+EwaJXwyk0v3HtRBmoRZQv5TPYCb70JBMkMBUSfAzyRmdcljyrYQuv7pitznOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732953923; c=relaxed/simple;
	bh=Gf0WyXV9kLoaoChEbcHd1iWboEG1ifCGgQe5JCZL8zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdpQE5xYgWz8/XO77LRxs4zDb+JR3y+5aGec5woq8RtLaXwkkeImcBT9rxzulPGD0HbPznoc0btzDCoUn8LGaGZOuafZsD2Fi5Ln/z+ZEkywGJPqk3NHtwJ73efL5fRp+PF8pK5JSgD5yJX4CjwcE5WqzqpgE1GGSCQ8PfbUnSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLzFeG93; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbd76941ccso1842120a12.2
        for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 00:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732953920; x=1733558720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dOn0b6av/UvSS4GPcdR/Z5Z+qUPHuv1AbzthwgB2OaQ=;
        b=tLzFeG93oBUdU8KKk8zKIvzAw+RfnIv2hpKqcnR7/I7Vtp9140BZaPvmcJ4AuoMHVw
         jP4QDds873tHh7wJMM1F0vOMQwOYtWz5SJlR6VmHU4GdXBMtb2Qhmf9nNWDK1ZBZuXR4
         P/ihanynusVf96ISD9Q8LivdTuL/uCkhydCeZrSefAqgxX6DTVKhudiXmyC8QOA1F78R
         lh/Zjdolu6Cjyx8uEGJxCEA5oZSfd9Sdc2JDLvW5mo+tEif6/4RZoHe9tAlVgAWtS8Ps
         /8dX+EhHmzJ5rBtRvm8D9A+VYYJPlZLWT34Eq0oTEDRVFjw/I3Q/0KreiXUYSrg6uQ2y
         9sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732953920; x=1733558720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOn0b6av/UvSS4GPcdR/Z5Z+qUPHuv1AbzthwgB2OaQ=;
        b=o3QQurT/UBYGE34/Dkd+lrqyCNH7yUmmUDas4L+kM70M0GyOA5fH/G4cshACbwN3Yy
         Qhhy03Kvo93rRmnDvXU57N9pdD/qLYcJvGjwsvFmFm0EAUigB37y4HRpw3v62hmdnbBr
         LNliZ8yAomX/ecsjYJnbSBcvg/NeIorWkmiNv2//2TIBfcm1MjqVaDez6c6B4LRHwm3v
         KrXC42lY6pewDJemjzvOV2ik5xiyGt4CRaSUjk1iZta5DrtJRh6gjZShE40tHdNcE8vQ
         CDtuW4AjmQHwzPyztn40Z6IjXi2XvBeEdsuMdjqxYINtq3l+afEB2XDiaPiKampFqcJH
         m2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVEkOXHFUyy+5n4lLk0uxFp/mUZBlrJVY3S4uXRD/6VXoDIvPUmFBj85zhcewnpsomD8cbqueg4g7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1ZBCQcVVEnd5u+ohrNLELJBPDmgG4qWMpKfbopbldXSDeCFp
	rLVBStbnCVD7QgKoNw6L4bjNRVgNsNNEqZjK86KpbaIV6obqRkbTT7N8wIOhBQ==
X-Gm-Gg: ASbGnct4JGVsd0yoeORAG0yAJVLYNziuG3z/v0EqhyvrOPa7CfeHTahG265loUYy0j0
	N2MUKaA60vnck3eP+M8R99N1dOco5Tv1NFGvh9TuDRj6lkSDIklZurMbjYv1H9k4QUn16sGVoCD
	lGI/kgVBm5DJrXS5Eia2QsM42zMB/aOY9ifIpf2SXqOxxYsg/dxWnsbca4B8SIrozLa2VGqnK0w
	5vPRj8TBJGMnvgeTtyVR9pyic/6EeXLJlo8eILHGRSoi97bNE0pz0pUnfsh
X-Google-Smtp-Source: AGHT+IEo7WezRqbf2bZItwi9K8IvUaE32bga4npJotDCaGHcaUTWm8fJnPVQ/PYwbRPbp3bvhs2W9Q==
X-Received: by 2002:a17:90b:380c:b0:2ea:509b:c877 with SMTP id 98e67ed59e1d1-2ee08e9f102mr19722581a91.2.1732953920597;
        Sat, 30 Nov 2024 00:05:20 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa3069dsm6478069a91.2.2024.11.30.00.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:05:19 -0800 (PST)
Date: Sat, 30 Nov 2024 13:35:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <20241130080507.6lfxwszc525ijccb@thinkpad>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241126132020.efpyad6ldvvwfaki@thinkpad>
 <Z0cBFjK1WgSmg6k5@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0cBFjK1WgSmg6k5@ryzen>

On Wed, Nov 27, 2024 at 12:23:02PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Tue, Nov 26, 2024 at 06:50:20PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 21, 2024 at 04:23:19PM +0100, Niklas Cassel wrote:
> > > Hello all,
> > > 
> > > The pci-epf-test driver recently moved to the pci_epc_mem_map() API.
> > > This API call handle unaligned addresses seamlessly, if the EPC driver
> > > being used has implemented the .align_addr callback.
> > > 
> > > This means that pci-epf-test no longer need any special padding to the
> > > buffers that is allocated on the host side. (This was only done in order
> > > to satisfy the EPC's alignment requirements.)
> > > 
> > > In fact, to test that the pci_epc_mem_map() API is working as intended,
> > > it is important that the host side does not only provide buffers that
> > > are nicely aligned.
> > > 
> > 
> > I don't agree with the idea of testing the endpoint internal API behavior with
> > the pci_endpoint_test driver. The driver is supposed to test the functionality
> > of the endpoint, which it already does. By adding these kind of checks, we are
> > just going to make the driver bloat.
> > 
> > I suppose if the API behavior is wrong, then it should be caught in the existing
> > READ/WRITE tests, no?
> 
> As of today, certain EPC drivers have implemented .align_addr():
> drivers/pci/controller/dwc/pcie-designware-ep.c (i.e. all DWC based EPC driver)
> drivers/pci/controller/pcie-rockchip-ep.c
> 
> Drivers currently missing .align_addr():
> drivers/pci/controller/cadence/pcie-cadence-ep.c
> drivers/pci/controller/pcie-rcar-ep.c
> 
> For drivers that are implementing .align_addr(), there is currently nothing
> that verifies that the .align_addr() is actually working
> (because the host side driver unconditionally adds padding for the buffers.)
> 
> That is what this patch is trying to fix.
> 
> 
> > 
> > > However, since not all EPC drivers have implemented the .align_addr
> > > callback, add support for capabilities in pci-epf-test, and if the
> > > EPC driver implements the .align_addr callback, set a new
> > > CAP_UNALIGNED_ACCESS capability. If CAP_UNALIGNED_ACCESS is set, do not
> > > allocate overly sized buffers on the host side.
> > > 
> > 
> > This also feels wrong to me. The host driver should care about the alignment
> > restrictions of the endpoint and then allocate the buffers accordingly, not the
> > other way.
> 
> In my opinion, originally the drivers/misc/pci_endpoint_test.c host side driver
> had no special padding of the allocated buffers on the host side.
> 
> Then when support for an EPC which had an alignment requirement on the outbound
> iATU, Kishon decided to add padding to the host side buffers in commit:
> 13107c60681f ("misc: pci_endpoint_test: Add support to provide aligned buffer addresses")
> 
> such that the EP could perform I/O to the host without any changes needed on EP
> side. I think that this commit/approach was a mistake.
> 
> The proper solution for this would have been to add an EPC side API which maps
> the "aligned" address, and then writes to an offset within that mapping.
> 
> This is what we have implemented in commits (which is now in Torvalds tree):
> ce1dfe6d3289 ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
> and
> 08cac1006bfc ("PCI: endpoint: test: Use pci_epc_mem_map/unmap()")
> 
> 
> IMO, an EPF driver should be able to write to any PCI address.
> (Especially since this can be solved trivially by EPF drivers simply using
> pci_epc_mem_map()/unmap())
> 
> E.g. the upcoming NVMe EPF driver uses the NVMe host side driver.
> This host side driver does no magic padding on host side for endpoints
> (NVMe controllers) that have an iATU with outbound address alignment
> restriction.
> 
> Imagine e.g. another EPF driver, for another existing protocol, e.g. AHCI.
> Modifying existing generic Linux drivers (e.g. the AHCI driver), simply because
> some random EPC driver has a specific outbound alignment requirement (that can
> simply be ignored by using pci_epc_mem_map/unmap()) does not make sense IMO.
> 

Sounds fair. Thanks for the explanation.

> 
> > 
> > That being said, I really like to get rid of the hardcoded
> > 'pci_endpoint_test_data::alignment' field and make the driver learn about it
> > dynamically. I'm just thinking out loud here.
> 
> That would certainly be possible, by simply dedicating a new register to that
> in the test BAR (struct pci_epf_test_reg). However, I think that that would be
> a worse alternative compared to what this series is proposing.
> 
> The only ugliness in my opinion is that we are setting the CAP_UNALIGNED_ACCESS
> capability based on if an EPC driver has implemented the .align_addr callback.
> 
> If we could simply implement .align_addr() in the two missing EPC drivers:
> drivers/pci/controller/cadence/pcie-cadence-ep.c
> drivers/pci/controller/pcie-rcar-ep.c
> 
> pci-epf-test.c could set the CAP_UNALIGNED_ACCESS capability unconditionally.
> 
> However, I do not have the hardware for those two drivers, so I cannot
> implement .align_addr() for those myself.
> 
> So in order to be able to move forward, I think that simply letting
> pci-epf-test.c check if the EPC driver which is currently in use has
> implemented the .align_addr callback, is a tolerable ugliness.
> 
> Once all EPC drivers have implemented .align_addr(), we could change
> pci-epf-test.c to unconditionally set the CAP_UNALIGNED_ACCESS capability.
> 

Rather not as you mentioned in following threads to keep backwards compatibility
with old EPF drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

