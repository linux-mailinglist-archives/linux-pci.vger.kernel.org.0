Return-Path: <linux-pci+bounces-34597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F99B31FC2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0FDA26D0C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233DF2571D7;
	Fri, 22 Aug 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etiPlNKA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBC236A9C;
	Fri, 22 Aug 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877642; cv=none; b=Bfmv57Cx/QeGo141ORTlbWChZ9yYATBLOMmEZwDpojottcadrtoxoFBjnZgIcn8Ya61yrTNQebU5H+xA613fNk/y1oWdBPof5ubZgS23422gm222TI6pydF1RZHtXtxND3OlrHicpmjCSlebDNXdjJut/aoSM5+GNjQJ+u4+Hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877642; c=relaxed/simple;
	bh=31GhkIPjd0R12TcFkZiegKpjjxme0L/N0lxFaAaMUI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VmV7z9c5pXb3DJQdCIYecYHa/MwK0Odct0Su2+khqh8LEiz+ZIqEP763O9GMgmzbg5HNO/G6JUXS0YQIMzPOiTYiT9RM8u8u5Auan3DeXrJLnsbpt+PnjkkSH5vHxWZMJ+BmKqx/YT0sOz3olzaCaLYRpnMFMS6ulUPT+MlPFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etiPlNKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDFBC4CEED;
	Fri, 22 Aug 2025 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755877640;
	bh=31GhkIPjd0R12TcFkZiegKpjjxme0L/N0lxFaAaMUI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=etiPlNKAeVqrgB4O3WHkSRqR7PUQmar6+aBCa3IS9qPi/q1NLPIugVI76cRGkVmao
	 w/9j47CEVe7VNJ6yv27LZxsmGRKBkhmHXrxqQPdOi8VhczQCJ18yUWnruxX0bejG24
	 ER2K0ZVCEymreuvf5D296nhonR9tOZdsBaTdTgJW4hVrd0CRnPxrbSdx0EByybzd/W
	 ODUVBEtzKpHPmw5JSzIU6TifOGOkqcmSbGYPKepufjrc0KP7MIu5b/Iatw/OXQ2VXI
	 arj9+4MkBF4zAWoNUAKs2CBfFxumOtFoMc7JHoiR5YoLXUJAVbaLdEoz7f0RU3ZWvW
	 jfNqD+AYqgc5g==
Date: Fri, 22 Aug 2025 10:47:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] gpio: vortex: add new GPIO device driver
Message-ID: <20250822154718.GA685150@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87f12a9e-df99-4308-9d4b-6dd28911bd00@orca.pet>

On Thu, Aug 21, 2025 at 07:05:16PM +0200, Marcos Del Sol Vives wrote:
> El 21/08/2025 a las 12:18, Marcos Del Sol Vives escribió:
> > +#include <linux/types.h>
> > +#include <linux/errno.h>
> > +#include <linux/module.h>
> > +#include <linux/ioport.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/gpio/regmap.h>
> > +#include <linux/regmap.h>
> > +#include <linux/ioport.h>
> > +#include <linux/types.h>
> > +#include <linux/platform_device.h>
> 
> I realized now that, despite checking over and over the patches before
> sending to the mailing list, I forgot to clean up leftover includes from
> previous versions of the driver.
> 
> I am fairly new to this procedure of merging patches. Should I later, after
> a send a sensible amount of time has passed to let everyone voice their
> opinion, send a new v4 version of the patch to fix these (and also clarify
> the commit message on the regmap-gpio, as requested in another email),
> or if accepted would maybe the person merging it sort this out?

I'm not the person to merge this, but my advice is to wait a few days
and post a v4 that cleans up the includes and updates the commit
messages.  It makes the process cleaner if the patch you post is the
same as the one that gets merged.

