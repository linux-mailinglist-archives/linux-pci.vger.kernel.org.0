Return-Path: <linux-pci+bounces-32471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89932B09842
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6027BC8CE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7A241CAF;
	Thu, 17 Jul 2025 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QalwuOgE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357524110F;
	Thu, 17 Jul 2025 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795625; cv=none; b=PpRb/28Xdvuh/m9R+18uVkE2iB5lDK1DV37M2OKCjxoWi/T0sOaODsGZ2xSm2whrJyxPZanUxUjl7mtcuchIABJM2FKHkajznPVpKzfaEfDihB+ehw7S5zv1tb3a57K706xF8go3WyHvooP53PJNNi8ZaJsAHZuNF4h3KFsUscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795625; c=relaxed/simple;
	bh=SLWT0EwWugKFmXyWBecyX2YOOzE33RWcso9rWV+H+sc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SNBVfYJ6hB180lbgI3Z1Ar6i5o6v62M+pAy/1WAXvGxSfZsNC5i6AYNsPGFYutusBMbLkbcUV8LZYOcIZZd8JnQVRleoL85ZtNXBdQMnmKlEJs1dKL15Vv+iORvqtfw+itnLklKXYJeT+AmT0liHPwmhXAyHDoK699wwFprqaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QalwuOgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43832C4CEEB;
	Thu, 17 Jul 2025 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795625;
	bh=SLWT0EwWugKFmXyWBecyX2YOOzE33RWcso9rWV+H+sc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QalwuOgEJQSJY/yW6nKuzzLXbQZLPRKCvV0T1SXwb6GxQdFSJNxowxsAUFlBl4YRr
	 z41IVtyibynhfAmmseTwhzaNDDBW9PDORLw3KO1OV8TCp6HnniX3uH9dYwrvGgNBJQ
	 r0+7c/492WzE+HSMsGR7rmaHkz16QtCYVkK4rknt7z8O8e1B7+vGYlBL/XWeN0gUsU
	 dpU31xZYKXnkJ83x4CT1gOJ4bk4JpvE7tR9YNWmQIDwE4TCiwLbJ14yAaI2OKm4wEY
	 CxViozkMHDpsTqbEJnoOJJ2qzZ13FOxs4a7ZL5u4CLKcOTDgteW0psfSnEBVNAyvIr
	 7CEZ8x2zJLPyg==
Date: Thu, 17 Jul 2025 18:40:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hans de Goede <hansg@kernel.org>, Andi Kleen <ak@linux.intel.com>,
	David Airlie <airlied@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ahmed Salem <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] agp/amd64: Check AGP Capability before binding to
 unsupported devices
Message-ID: <20250717234024.GA2663372@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvShrJJTj2ERdZr@wunner.de>

On Mon, Jul 07, 2025 at 03:58:30PM +0200, Lukas Wunner wrote:
> On Mon, Jul 07, 2025 at 02:53:32PM +0200, Hans de Goede wrote:
> > So I think we should move forward with Lukas' fix dor 6.16 and then
> > my patch to disable probing of unsupported devices by default can
> > be merged into linux-next .
> 
> Sounds good to me.
> 
> Dave is out all week and has not commented on this matter at all so far:
> 
> https://lore.kernel.org/r/CAPM=9tzrmRS9++MP_Y4ab95W71UxjFLzTd176Mok7akwdT2q+w@mail.gmail.com/
> 
> I assume Bjorn may not be comfortable applying my patch without an ack
> from Dave.  I am technically able to apply my own patch through drm-misc
> and I believe Hans' Reviewed-by is sufficient to allow me to do that.
> 
> I'd feel more comfortable having additional acks or Reviewed-by's though.
> I'm contemplating applying the patch to drm-misc by Wednesday evening,
> that would allow it to land in Linus' tree before v6.16-rc6.
> 
> If anyone has objections, needs more time to review or wants to apply
> the patch, please let me know.

Looks like this is now upstream:
https://git.kernel.org/linus/d88dfb756d55 ("agp/amd64: Check AGP Capability before binding to unsupported devices")

Seems OK to me, but I'm certainly not an AGP expert.

Bjorn

