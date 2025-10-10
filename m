Return-Path: <linux-pci+bounces-37819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43439BCDD07
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 17:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A4B3BC050
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3692FAC17;
	Fri, 10 Oct 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="goPECacJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404C2144C7;
	Fri, 10 Oct 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110652; cv=none; b=D++erl1B4U/oD9ld+3vZAq2gDAmAXIn4sq1nOpriBJmBUK6M5g1M5hd6wUOJa6gJ6QYHAFCW1a8wt883AiT9JUJoBIj5Moqg50VNqP9HbMcUnJak99pnxTXu/5Qx8VbvGutwVU1M6792jcOUqvOAblWFyUWchqeUJKnUVXLGOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110652; c=relaxed/simple;
	bh=zl6oKDVWNj5oKzruZE1KE03VVRh3GBelWw2wOwJP+Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJGJO3FL2Ch1eyO/n7eC4+MzD3usLTpcPw0A6feFZUuizge/QCm5iC2R+ccc+KV4C8iq8YiDSKwpPpxMuNBxgfpVQf9f3M1lLmlYhYGMAP0inw+Kjg6WSM24H5fC7bGzWrmbleqn9usLwg2Tvfv3Un3pGgOwbxGGOoSO/89xFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=goPECacJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054CEC4CEFE;
	Fri, 10 Oct 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760110651;
	bh=zl6oKDVWNj5oKzruZE1KE03VVRh3GBelWw2wOwJP+Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goPECacJuOmxQ7iMp25b4UrWspXd4Z3Le3gJ996F6HyThFjYi9oB1Fbamb8fWVzRH
	 3tdbNEjOW3rwK08zeE6BXB2GwyZNnCDNhqqKhOFK15zMOdgdpniZWeucwdYAl9cBUo
	 l05d4PNH9DnkZJcxbRuQO7jSdQ99XFQ46FcyV1Z0=
Date: Fri, 10 Oct 2025 17:37:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
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
Message-ID: <2025101050-excretion-facing-ff9c@gregkh>
References: <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
 <20251010153046.GF3833649@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010153046.GF3833649@ziepe.ca>

On Fri, Oct 10, 2025 at 12:30:46PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 10, 2025 at 10:28:36AM -0500, Jeremy Linton wrote:
> 
> > > So you could use auxiliary_device, you'd consider SMC itself to be the
> > > shared HW block and all the auxiliary drivers are per-subsystem
> > > aspects of that shared SMC interface. It is not a terrible fit for
> > > what it was intended for at least.
> > 
> > Turns out that changing any of this, will at the moment break systemd's
> > confidential vm detection, because they wanted the earliest indicator the
> > guest was capable and that turned out to be this platform device.
> 
> Having systemd detect a software created platform device sounds
> compltely crazy, don't do that. Make a proper sysfs uapi for such a
> general idea please.

Agreed.  Please do NOT abuse platform devices for this, as this is NOT a
platform device.  It is a random virtual device that you are wanting to
create out of thin air based on something else.

Trigger off of that "something else" please.

thanks,

greg k-h

