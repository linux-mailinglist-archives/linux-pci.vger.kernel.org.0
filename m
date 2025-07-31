Return-Path: <linux-pci+bounces-33249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D58B17531
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20F4189A38C
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559822F770;
	Thu, 31 Jul 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GlvrbcIQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C013C81B
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980378; cv=none; b=qaATFPp/Xlu506DiOF8z8OMhfk0YCY55m+8QkRpzgtkNmFxiu49rOvfhjE6wDkGU50YuSte8tVg8DYVO2Ki72Nj9DPDK1f5NhWn4cInFHVIo+Pz/SQxDEWqi/M3OL46R8JmHd8Q7TjQcz3lWfo55Vbnlw/zdk/p9AdQJFOckDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980378; c=relaxed/simple;
	bh=+FrCI5uL2Giy/28rG23V4GontptDjw0pDWs+MPinD0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgT1gS1OSsf6U8CxEmrg6U/FpCJCXPvl//D1Y83001BSg+v1CSrWXzXBHRYCv7SpxCPvT1BSllc4G3a9ggc0BhLyA+vddKkjxii40kzr5JPfyhaQMfSay6KPSlJ/O7XyWVU8gT8uoZFOuoNFIyz6nfHnIWIp4a4N0q/3KVJfxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GlvrbcIQ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-301a83477e5so989294fac.1
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753980376; x=1754585176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVWJZKfyKQDHRhqzJs/Kg9r++4Vk+GwOwj6f2ybO59E=;
        b=GlvrbcIQsB91z0SNRAJcdHBmDBIulSaEw8/vnv93LzBjGKL0erg/PEC6NcnaANhK37
         kP2VFLTbq7URRvDnxeAYnrpT3enQXQebMwuiMhHhu63LU3ANkFAnRSdn8IVfelOwE1r6
         HMyYiIue9cnAArii7+EizZ8DsUC9n8c+/W506mDnRTkzu+V2o55ktbY8mtap4SRs1Bpr
         v5zTTgpW6ceYy6Itpn5sSu5Vxte+HCbTG4Qx8nV8JdpQ66usTouApqm538nkIi9nzdT/
         NYxQOun2AGLhQ0qflKJeZdF3opeLr5r5ZUpVNH3MYNO8r7cbfNz0/T6Jv3YKt3OToteE
         sA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980376; x=1754585176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVWJZKfyKQDHRhqzJs/Kg9r++4Vk+GwOwj6f2ybO59E=;
        b=UIsNZfCt8SzH676xWkoWU1XVc14mjTJ8gAwX//KaZKy0aMBfdH8Gb2MOPuiHs5kXxa
         4wNWDM7WvzH+Gd8qMTbgcae7szEVJenorpkBaHVKeUzs+OgaBtsOYgE3tL6xsvMOhcYV
         3JOzWMbFwLyPnEtpv3XhEjfAgEA8yL/m+iWklTjT/RnINK2CmKd610iD8ng4jFuHaoWq
         tVHX8PqVDB1iUjkIsbuZdxmtXh/remLLdbjz7QkOJpUXr4Sw0lwLISFufTyauygalJLo
         wUHOZuAmDJm3sbYtuPRTSsiVqBnq0+ynwZRKMSknb+FPq5zry5PhiT/O9+4c8zo2JJdk
         4hRA==
X-Forwarded-Encrypted: i=1; AJvYcCUxmqtr3Jga+tC/3Nr9VYrF41QAck1vrEt+wsvXnt0eBAv5bjwlaCTtwJamOSP+CsM/1agXow9GUzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJkSAeWQ66VQcNQsDC6/RP/+cm2cnFdlOqgCzYLx5nzTh0V8C
	8vizo4rUsmRC54Cr5iaUMobQ0Bfz6bzrYv1r25VEdoRQUxC5bJxRUQUmF6y9UqW9fk8YMz/UZOE
	vjgC4
X-Gm-Gg: ASbGnctfG9mucamAA8x2x0To7PlkygVbrBvmDdzBHlSBf9GIuMWOLZ3spjxZUFDRd2K
	BOWlPaHTvzfSSTAXHc6ErBTgjTs5Pyfq8iQAfaZn9VsTEW0Bh67nTV3lp9DBCSdMgidU0Kg/bKI
	2+8aELw+Tf8hNaR2V26oEDAaDgWagayReAwclF/J/I8SlUWlFbSz/Ch7EYVkmOAnU02HkeDo/nd
	kuGRBVLAZgi1SOKugeCCYXaoZuaCcTHH1QUX19sFPj//x83Xb0e9O8OocwDV1RqVoe8PdFUfZPr
	vIMeW4Rj2mzk8e5/NR1aNgxuBXiQa/E9b05t/NLu5290H7OMpRivlVjXuXZeqaUnvPnpICIDfye
	SHhUA002WqcAMtPlryXT5yWsnRm66cwkzOnZ7UuKV09Eaq4ZbFOnAikctozVwanybKaoi
X-Google-Smtp-Source: AGHT+IEpTxrw+qyeAY5Lp6kRk/WUmkLbgGvbTXBtHkfN647e6IUlWw+YixxIUWu/5H4+fgQL7IJOaQ==
X-Received: by 2002:a05:620a:430b:b0:7e6:43ae:930e with SMTP id af79cd13be357-7e66f3edca2mr1175700385a.61.1753980364295;
        Thu, 31 Jul 2025 09:46:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f70659asm104688085a.52.2025.07.31.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhWPr-00000000qBd-1OwT;
	Thu, 31 Jul 2025 13:46:03 -0300
Date: Thu, 31 Jul 2025 13:46:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20250731164603.GX26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250731121133.GP26511@ziepe.ca>
 <20250731142250.00005651@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731142250.00005651@huawei.com>

On Thu, Jul 31, 2025 at 02:22:50PM +0100, Jonathan Cameron wrote:

> If you mean create a class device with no parent, that's also something
> we are slowly trying to fix.  Reminds me that fixing up more perf devices
> is still on my todo list.

IIRC if you create a class device with no parent it gets placed on the
virtual bus...

Do you mean we should not do that?

> Should be a child of something, so maybe that is a good reason for a
> faux_device here if there is nothing else to use.

Don't see such a big difference to have it be the child of a faux
device on the faux bus than to just be directly on the virtual bus?

Jason

