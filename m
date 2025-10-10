Return-Path: <linux-pci+bounces-37807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027ABCD601
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61AF19E451E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBA2F3C1F;
	Fri, 10 Oct 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kFWqS+QV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE325A2DA
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104767; cv=none; b=AgNukJp5Xz2UrJ3kBoZn5xW1JyWYf7PvWINnz1mKlAi3qbd+Xc1rt7xahtYzW9xi0WCP4/tGsHO7mt42Sxg3o15wFsziSWBxu4haBdeUM68hyHtwtGpfsuxeQYua3eULlc2INsbZQ6/ahHehle+o2IJxVU0/mVHU0GJ5s9GUrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104767; c=relaxed/simple;
	bh=hZPZVS2QtrtI/5LeWNnPEpjPSsnogRA4qP9cGK1n1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqtPAlbf8HiMiURIUW5SX6hzWSzuZaMu1id68XATfIPNPO6OEwLaDRhFOSGsNvn6uIgmhyXjIp6dKxNYW+UZHZxmLzLtDix7FS/m2oaxiDX2gMRgcYxyskrCDcIZBrniMJaIk99vM2JnDQozgocfaS29eohjRkD+LksdpJ5YKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kFWqS+QV; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85e76e886a0so186291585a.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760104765; x=1760709565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNvJ31G0uSRPH3SSYUmcqBJNw8nBZA0aR9UpQ5R7KAM=;
        b=kFWqS+QVbA0HW6ZrpNPV8fF8hLlUwyQ5X7X1ErBcreVmJ9cwGiWYdlaQ71hgyJCTmq
         yUynLNJffYZJi5yyuBN5fYSXbhn1WTEruZ9LhTyl7zd7F1FTh5Z3lo+nM5yB9czVFOOM
         mA1xexk3En/XglDuDGEUR3p3gKaDYRkpqG0WZo1sLtMW+BCjihvxmg6qDy7CQK8JM2mc
         22j6Y8OrYmW1HKeaQ522WZ149rhZlwsvmysakuiDOeDpZDRGdcSPHssnho9/B4PSOiYd
         qfCdFvnOskQ7n+fmxpN8O1tsGJNxevpdcxKbBzytMAboV7gW8qK7n8Nfy3m2I3473GlI
         2RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760104765; x=1760709565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNvJ31G0uSRPH3SSYUmcqBJNw8nBZA0aR9UpQ5R7KAM=;
        b=rgljhNKaR1a7tmiqv/rUdrKSbEcngXpadlUfNh4ELl1WiFZGD3m1LBkoSfpq8jQCBJ
         BYox1J3cneIqhJMBdgbUtfW5l1zIw0Wc+Rm1RaB26QYV0x28e4MXlkSqYSg0t6/04iUc
         hiXx3oSAhWNJsKCxQegVjEkzuFC2LBJOXlJP18diOal8m3EccXQq4cmfahFVTO0Xqzb9
         SpV/FjDQDhl0RGNCoN4d6mQ5VOwaUXGSLhxHxBVXimDY1pBSh8gzkRhw4IdYyKXjqYRi
         9P/QtHKN2sjul0yhhSNYr186drtqcaEnWArGf0Wfxq0SV/h6Yg8btBAj9JO4IIBPlQXZ
         fV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpr/INfj5J3QX4Bea0lOkGTyL0QGLuRsciMbjuf7Lo2CUjaiKiOKZzQBYGLhSNmAPIEZPJpkOJwbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/3fXr3+jpRPhaQkQsSPWXeOOYWzYcHoMMIoHCGX3MVny8xZE
	rME7d9wluER6szatMu9wP53aEgEGcZ7IbYFM71ZWsdB8Xjx261pUUXbZ5tNYnEfF3b4=
X-Gm-Gg: ASbGncsvZzkqkC8tP+oYTYgmoJl8kFRhpQ6VG6+lcUclA4nE55dNRvLm/HxxCr/e1n+
	1NaR1anLXu3iSFGbdsdz5poeKY107x1lT2C/KTfJN4rd8LCTRK2i79ytjY+XanqTvFRHlboJPBu
	5wkhhwXQTmk7ANo7AOv9ohCZt6agMLkTK+iaYsgWTG9rYJZyznAVz56A+Dt29glE/Hcw1QxGMig
	4OtT5T9cxfuSErafMqOEGpBC0oI8MjUWi8ZNfS7vWB7nPcjl7jdXQlOMVVRgfXSc8Ncx46bhMJU
	rn9EO7BR8eIJFx/9/cVsUMzNwuXskWx4zjoGZ06SNkSkubIkZxLYizjPC12PBDj//cL3wxaB2Uy
	fJ6V5JO8sWw0ALSiEG2OQVtOkAHgcT2u8MrEOu0KbISk95x20Q78+40hPPAMMRgBkozDLegL1Bz
	KfoHP/VUFmqVorIq+s37iwOw==
X-Google-Smtp-Source: AGHT+IExPwaL1TTGwP76ooAIbGqIBucYWqZgImMdJPw3egaQEtYFbCr/oHIOKZgGp1qijtOpyq8L8A==
X-Received: by 2002:a05:620a:414f:b0:86f:4009:dea6 with SMTP id af79cd13be357-883527c7719mr1533083385a.59.1760104764491;
        Fri, 10 Oct 2025 06:59:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a293bcbasm413337685a.58.2025.10.10.06.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:59:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v7DeU-0000000GVew-44jV;
	Fri, 10 Oct 2025 10:59:22 -0300
Date: Fri, 10 Oct 2025 10:59:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20251010135922.GC3833649@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>

On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
> > Yes, use faux_device if you need/want a struct device to represent
> > something in the tree and it does NOT have any real platform resources
> > behind it.  That's explicitly what it was designed for.
> 
> Right, but this code is intended to trigger the kmod/userspace module
> loader.

Faux devices are not intended to be bound, it says so right on the label:

 * A "simple" faux bus that allows devices to be created and added
 * automatically to it.  This is to be used whenever you need to create a
 * device that is not associated with any "real" system resources, and do
 * not want to have to deal with a bus/driver binding logic.  It is
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
 * intended to be very simple, with only a create and a destroy function
 * available.

auxiliary_device is quite similar to faux except it is intended to be
bound to drivers, supports module autoloading and so on.

What you have here is the platform firmware provides the ARM SMC
(Secure Monitor Call Calling Convention) interface which is a generic
function call multiplexer between the OS and ARM firmware.

Then we have things like the TSM subsystem that want to load a driver
to use calls over SMC if the underlying platform firmware supports the
RSI group of SMC APIs. You'd have a TSM subsystem driver that uses the
RSI call group over SMC that autobinds when the RSI call group is
detected when the SMC is first discovered.

So you could use auxiliary_device, you'd consider SMC itself to be the
shared HW block and all the auxiliary drivers are per-subsystem
aspects of that shared SMC interface. It is not a terrible fit for
what it was intended for at least.

Jason

