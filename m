Return-Path: <linux-pci+bounces-38213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43326BDE815
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5733E1E56
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4551CAA6C;
	Wed, 15 Oct 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhDqNYm6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5011E515;
	Wed, 15 Oct 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531880; cv=none; b=Nt0wmGQq3HbGQyIRyx5tievyNMcBLqdkHfCDFsoDgXaT8kqBIV+k0gEt4vy+zdx6mW1HMTCXSCTNsRAXfeY0+DXPepNT9uJT41Xv6VTA6CVvIOx5CewdFjbOwCoRFfFaWXi6BXc6MrYr/L/lWfvbGlyHYTRG/vPy1SlGdB4hcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531880; c=relaxed/simple;
	bh=AJMzGU5dUCefVcP8by7Txt/BfBamXFy7bJHjHleTpbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/e/S6QUyviwThWu0VINXRCKKYr6WjfLDthn04P3Wc4cKKCGdaQWH2nF9I4MxtHq3xWd+3ikXKPtXufrFV3s9OkoBdySlXwmMY+DXZZY2Mxrn9+Qh54dqLK3L3DzEPzOlKyEpfrjAbCtIa7jVsHDvbFfMc24fWPAfB+i5xahSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhDqNYm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBE1C4CEF8;
	Wed, 15 Oct 2025 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760531880;
	bh=AJMzGU5dUCefVcP8by7Txt/BfBamXFy7bJHjHleTpbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhDqNYm6BU33qGb8wQZWSlgRVIOoHnqX7fJsFV4P33Cj+Ns1giTma51Bl5/cV8+d0
	 lSAZ1hQLTrUXPCGHfIILslUpm38ACyjNjp4+TZcCfyeR26TTko8nHGmkidEZRfJArV
	 d/mmmXDQFtHuuaZN12zcGLnjsM0Q4ybx7WgqFaX4=
Date: Wed, 15 Oct 2025 14:37:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <2025101516-handbook-hyphen-62ec@gregkh>
References: <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <yq5a347kmqzn.fsf@kernel.org>
 <2025101523-evil-dole-66a3@gregkh>
 <20251015115044.GE3938986@ziepe.ca>
 <2025101534-frosty-shank-00b1@gregkh>
 <20251015121533.GF3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015121533.GF3938986@ziepe.ca>

On Wed, Oct 15, 2025 at 09:15:33AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 15, 2025 at 01:57:38PM +0200, Greg KH wrote:
> 
> > If this really is a firmware thing, and you have a firmware device, then
> > I am confused why this was even brought up at all?  Use a real platform
> > device, with the resources that are needed to talk to this platform
> > device and you should be fine.
> 
> I think the issue today is the PSCI does not always get a
> platform_device, fixing that seems straightforward then all the
> downstream things can switch from using more platform devices to using
> an aux device with the PSCI as the parent..

Great, fix that up and it should get much easier.

> > BUT, if you are making child devices that are NOT actually talking to
> > the firmware,
> 
> This thread is about how to bind various subsystems to this shared
> firmware interface.

Great, use the platform device that the firmware created for you!

thanks,

greg k-h

