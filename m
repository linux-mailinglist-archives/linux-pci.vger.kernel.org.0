Return-Path: <linux-pci+bounces-38242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B6BDF892
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE808344AB8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4503C2765D2;
	Wed, 15 Oct 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ATErPgd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF110186E40;
	Wed, 15 Oct 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544242; cv=none; b=OCl8obkNh5yBIXHMAcZn1pt7dP2cPXifD5/mOibnKT2Dw2vo6ebTF2cjFVdQM063dZEVamPxp7GQSN8UNjJsl1aFCJDIeb2wA3p6KjzDd5oHZhemWTfctDZLmw2jSw4WAxl2lZEhKaaCAq1E7oPSjoTBKpcm2TkdkLC4Ip+Bxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544242; c=relaxed/simple;
	bh=jdf3R31L7KT+QpiMtzdFC5DBhz+RNOn4RjFGLhJ7KDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESuVmrxR2/x0kFiEGVdc7bDU2J/VqOjCHe4qcyWPWeYk5uXpwsBLo+71FtJvPepet9rqhrT1EbNvJWW48I56s7C7R/jlMJJsC8lL+gJl3s0YtwF2L8kMeHzcyp7ijtY1YZLuV8WqQMrXMlEJGYqxImH0inlcn5LelkcO6AcmN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ATErPgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C6EC4CEF8;
	Wed, 15 Oct 2025 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760544241;
	bh=jdf3R31L7KT+QpiMtzdFC5DBhz+RNOn4RjFGLhJ7KDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ATErPgdssjXDrGXWgPL17G/5HOoACiJhSzhMn12uCxiQCiCzH0pHe271ePcMTY3U
	 Og+CxVYbwmC7EXidz3uICnJp32W3eUtC1BXT9B5Mx6CZ8DKIU86EQcS+39Z32eI6uA
	 +iy81y1HBbCZe+44EndG+L9aSQbJ+D5vWFfKsUR0=
Date: Wed, 15 Oct 2025 18:03:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <2025101519-niece-skeptic-9290@gregkh>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5144c99d7c04e4ad09ed9965fa3512c203b5694.camel@HansenPartnership.com>

On Wed, Oct 15, 2025 at 11:19:41AM -0400, James Bottomley wrote:
> On Wed, 2025-10-15 at 08:50 -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 15, 2025 at 11:58:25AM +0200, Greg KH wrote:
> [...]
> > > The real device that has the resources you wish to share access
> > > to.  Are there physical resources here you are sharing?  If so,
> > > that device is the parent.  If there is no such thing, then just
> > > make a bunch of faux devices and be done with it :)
> > 
> > At the very bottom of the stack it looks like the PSCI interface is
> > discovered first through DT/ACPI. The PSCI interface has RPCs that
> > are then used to discover if SMC/etc/etc are present and along the
> > way it makes platform devices to plug in subsystems to it based on
> > what it can discover.
> > 
> > It is just not sharing "resources" in the traditional sense, PSCI has
> > no registers or interrupts, yet it is a service provided by the
> > platform firmare.
> > 
> > Again faux devices don't serve the need here to load modules and do
> > driver binding.
> 
> This came up for the SVSM as well: we want to expose things that can be
> virtual devices or other resources that the guest discovers.  Our
> conclusion was we either needed to share one of the virtual busses
> (like virtio) or do our own svsm bus.  The agreement was to implement
> our own bus, but we still haven't got around to it.

I think it might be time to get around to it and not abuse other busses
:)

As an example, take the faux bus code as a base if you want a tiny
example.

thanks,

greg k-h

