Return-Path: <linux-pci+bounces-34598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E56B31FC8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C95DB608CA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834BD25A324;
	Fri, 22 Aug 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiThWL99"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641C258ED5;
	Fri, 22 Aug 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877746; cv=none; b=X6KttMrys29eAaIhkgTrUljOBygVPdxOzVIo+5FEqMz3t7uOupSANGHSMbCSQePq0cPR8LjjV/1JSjxnLxFoMdamqAxcWRVnDYrJtOhqPh7iupPiHOfUzWGJTmIt+WHNXLTIEW9/0IjgbR5TfdPtv68JRI6zSvqOosbEuiWs3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877746; c=relaxed/simple;
	bh=yuxymuE1CpcsqC2aHIQQ3HS4dI9volr5U+I0T5CKNIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ak2HZhBDdQhgUDbPj/uFNNFyFkyYFPEgUTl46LGdRTWEqwg/JE+fRk+22CQoxPI2RqrG66rZGq7yDrRvZrBjlMig/4wHvrzGEFRG8eo0FIs9rHkm+RSua4bsdCkJsWwn48uZb4FWxI9Z8UyJ6aAhmjdGbO2Q57E1D6k9Vl8QITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiThWL99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A25C4CEF4;
	Fri, 22 Aug 2025 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755877745;
	bh=yuxymuE1CpcsqC2aHIQQ3HS4dI9volr5U+I0T5CKNIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FiThWL99EkSv54dHRwvX8V81cKrxpo7ylEndvX8neUCv2wMCQyP4HJt1zDIegyOKx
	 gxwTitvuN6DjhNeLIFs8j95VQRHC+CUpwlMdmAPMLGXm9Roo/l7bzfx9hATS1Gq6Ml
	 nw0gzvr25MXrDIECKcnNOyPK8mJ8sJ1ATWjnFqpZmhiw4oME6yCRgxEYjy4eqXk2aY
	 0dMGXH6viNnoJ1V1FUN5U5ePv2JCgyTlqPaK4JK3zmfZP4XrPhR4T1YVPvQCcoY3gt
	 85tz19w6bW4AdWRi8KEoBVLnqePhcnDStzS1/FuqZ2XCXJUGvz7kt85EpdpSreQBce
	 AlHe3zPkTCvvg==
Date: Fri, 22 Aug 2025 10:49:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] gpio: vortex: add new GPIO device driver
Message-ID: <20250822154903.GA685390@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822154718.GA685150@bhelgaas>

On Fri, Aug 22, 2025 at 10:47:20AM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 21, 2025 at 07:05:16PM +0200, Marcos Del Sol Vives wrote:
> > El 21/08/2025 a las 12:18, Marcos Del Sol Vives escribió:
> > > +#include <linux/types.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/module.h>
> > > +#include <linux/ioport.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/gpio/driver.h>
> > > +#include <linux/gpio/regmap.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/ioport.h>
> > > +#include <linux/types.h>
> > > +#include <linux/platform_device.h>
> > 
> > I realized now that, despite checking over and over the patches before
> > sending to the mailing list, I forgot to clean up leftover includes from
> > previous versions of the driver.
> > 
> > I am fairly new to this procedure of merging patches. Should I later, after
> > a send a sensible amount of time has passed to let everyone voice their
> > opinion, send a new v4 version of the patch to fix these (and also clarify
> > the commit message on the regmap-gpio, as requested in another email),
> > or if accepted would maybe the person merging it sort this out?
> 
> I'm not the person to merge this, but my advice is to wait a few days
> and post a v4 that cleans up the includes and updates the commit
> messages.  It makes the process cleaner if the patch you post is the
> same as the one that gets merged.

Sorry for the noise, should have read farther through my email :)

