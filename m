Return-Path: <linux-pci+bounces-32384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A2B08C98
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28B117992D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF129DB9B;
	Thu, 17 Jul 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Qt6Z4X1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB1288C12;
	Thu, 17 Jul 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754307; cv=none; b=VEeOKMwsVdO2xz/HKJykigcVoAuxuz70NbmcJud/jXAF2oRw+gtWUxgjOv3c+4Owm3DGVD34KCxdtmqzs2jCRfrRC2e7zu0d5T/fx8LC29Moq4isXQrsMkU4beiwU2srsxEsBT/lBvH393OVaXHka2ii6OcwG0B40KWzPZ8ZulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754307; c=relaxed/simple;
	bh=u7SEQClQAB7gDVI1zZ2Aqc9od3vbr6CRMh/fPM8fFwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArdXTH85FX9CJ3p0BrkLjcDicb2FdcHqahZT4yKOErT6WehUUi1W8p12BNko/WzoNZoWqbS6D9eo5Ev0ZUN1sm1oypnJwGPR0bDzTOKur4PK71G9gi8/4Wm3DCGxKIluyGOCnHYxVqHal46jDhQ9XL1yDU1OrKlWJRrg9ZwrcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Qt6Z4X1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D5C4CEEB;
	Thu, 17 Jul 2025 12:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752754305;
	bh=u7SEQClQAB7gDVI1zZ2Aqc9od3vbr6CRMh/fPM8fFwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Qt6Z4X11YhogWwmPVhJNTezRMtYrXrmvZKzpaNeXXzrRKVkm27yaCiy5/7CxAvjd
	 YkN/PYtnuacWtPoixP/hG2zdXON89AXUdXcpob0TSY8888tb0EIehkEW0RBPkmwf/I
	 5rwizpj+UPQM+PsLiZ95EScAmEzGwG7w2hBjdInI=
Date: Thu, 17 Jul 2025 14:11:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
Message-ID: <2025071716-phoney-object-1648@gregkh>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717103241.2806798-1-thierry.reding@gmail.com>

On Thu, Jul 17, 2025 at 12:32:34PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi,
> 
> Something that's been bugging me over the years is how some drivers have
> had to adopt file-scoped variables to pass data into something like the
> syscore operations. This is often harmless, but usually leads to drivers
> not being able to deal with multiple instances, or additional frameworks
> or data structures needing to be created to handle multiple instances.
> 
> This series proposes to "objectify" struct syscore_ops by passing a
> pointer to struct syscore_ops to the syscore callbacks. Implementations
> of these callbacks can then make use of container_of() to get access to
> contextual data that struct syscore_ops was embedded in. This elegantly
> avoids the need for file-scoped, singleton variables, by tying syscore
> to individual instances.
> 
> Patch 1 contains the bulk of these changes. It's fairly intrusive
> because it does the conversion of the function signature all in one
> patch. An alternative would've been to introduce new callbacks such that
> these changes could be staged in. However, the amount of changes here
> are not quite numerous enough to justify that, in my opinion, and
> syscore isn't very frequently used, so the risk of another user getting
> added while this is merged is rather small. All in all I think merging
> this in one go is the simplest way.

All at once is good, I like the idea, but:

> Patches 2-7 are conversions of some existing drivers to take advantage
> of this new parameter and tie the code to per-instance data.

That's great, but none of these conversions actually get rid of the
global structure, so what actually was helped here other than the churn
of this "potentially" allowing the global data variables from being
removed in the future?

So how does this actually help?

Also, small nit, make the function pointers const please :)

thanks,

greg k-h

