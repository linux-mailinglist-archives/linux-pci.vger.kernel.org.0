Return-Path: <linux-pci+bounces-17160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF159D4C9F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C4CB27890
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321981D2234;
	Thu, 21 Nov 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIHrsMcd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC01CB9F9;
	Thu, 21 Nov 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191188; cv=none; b=EdXoCtlCHE24vkYW3qt3rQF7jK3lJ9OGZ9Rg9gqcBflgn2MyvhD+Mcqps+6J1x4qj7qOrmJDfSONT7OEnaJA/1pUCoJW7IThaKbFqQHMn4AChdCfBjq/e9OKYwfNvYuyPCaOH+9kQyd2cFo5XPoitaY4znTx/ms1doDZ4n5fTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191188; c=relaxed/simple;
	bh=yTxGHotTP9Cfi8ytVjKpeQcQXcEdP6pX1gOdPNwWNFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GopTNWcwcyEONDvadTNadlcY50FDIcIhrV3RzBMBSCZ1hJ0ATmREvhziYo7xUCCzStxypLM45hGUweoIj7jkwnyOtL89B0seAulo2hQFJ2gsXr9uS31+zQXL9CwKGEbvfcDb4yHBW+lIleEDiJzXYpGwxR95oVDbcQJRyXynmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIHrsMcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D42C4CECC;
	Thu, 21 Nov 2024 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732191186;
	bh=yTxGHotTP9Cfi8ytVjKpeQcQXcEdP6pX1gOdPNwWNFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIHrsMcdTnkUyj/CqWmCL41LE6DEv/7JkW6QlRFsSOzexldecHz0mjk5y7CKX/6kb
	 u+1NSb1GbBwJKPcw309OUV5bgxTTQyDEKfT9hwrd1TCDgHVr88G+n4AMJonlEcm6A8
	 s7PMhcfEsuKsxHK4j2omLyLSQrUagTiliemHJuMiKvVxApzuJuvfxOSLucPcOPxjnT
	 XHOH10UBVGvcE5pJCZlLtmKQDm9ccc8scHYLtU63DYhsdeTv5YlEuf9JOaceqn7BHa
	 4is2v/uoTEG/GlheqEqWPan79sLVjKiZBT54WLssZgWe1Aj1yZ5pJHLMo9p6r3OgEN
	 1KA2fnOurHyLw==
Date: Thu, 21 Nov 2024 14:13:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jean Delvare <jdelvare@suse.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20241121121301.GA160612@unreal>
References: <61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org>
 <20241121130127.5df61661@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121130127.5df61661@endymion.delvare>

On Thu, Nov 21, 2024 at 01:01:27PM +0100, Jean Delvare wrote:
> Hi Leon,
> 
> On Wed, 13 Nov 2024 14:59:58 +0200, Leon Romanovsky wrote:
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -332,6 +332,14 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> >  	if (!pdev->vpd.cap)
> >  		return 0;
> >  
> > +	/*
> > +	 * Mellanox devices have implementation that allows VPD read by
> > +	 * unprivileged users, so just add needed bits to allow read.
> > +	 */
> > +	WARN_ON_ONCE(a->attr.mode != 0600);
> > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > +		return a->attr.mode + 0044;
> 
> When manipulating bitfields, | is preferred. This would make the
> operation safe regardless of the initial value, so you can even get rid
> of the WARN_ON_ONCE() above.

The WARN_ON_ONCE() is intended to catch future changes in VPD sysfs
attributes. My intention is that once that WARN will trigger, the
author will be forced to reevaluate the latter if ( ... PCI_VENDOR_ID_MELLANOX)
condition and maybe we won't need it anymore. Without WARN_ON_ONCE, it
is easy to miss that code.

I still didn't lost hope that at some point VPD will be open for read to
all kernel devices.

Bjorn, are you ok with this patch? If yes, I'll resend the patch with
the suggested change after the merge window.

Thanks

> 
> > +
> >  	return a->attr.mode;
> >  }
> >  
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> 

