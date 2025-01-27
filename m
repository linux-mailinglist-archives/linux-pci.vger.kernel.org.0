Return-Path: <linux-pci+bounces-20420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB54A1DC4F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 19:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B4B1881D7C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202218D649;
	Mon, 27 Jan 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRdDu4I8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9518A6A9;
	Mon, 27 Jan 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004336; cv=none; b=NegThC0vVC/3SmIRwXxHdYDiXyPZjgLXox573+smNl+wvbRIiBiXNebe7TCcxKShMxyBM83MtfdQk8Yns1JtnRksbuoEMx5GgFfZRTogWcaOwzzn6UUSgUBkwFW7j+H5YP/ZYY45tkkfyFXjsf4jF+ceEq7z0otjjtIbq1MtoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004336; c=relaxed/simple;
	bh=8po7i00y17RimMFDy23j4ASQpjy8d79DKdJpOqhfyq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NPfNdoVzyVqNaHNAojdyQhtegbHFIFMIxWnZhGnXaIyJzUsMiCsEI8rq25uj2D57byhAxbysTbnyg+HEbTw0PLy8w4CeL0NmamLc0ruft6ZZFgkziuFIap8RTZMeNncc5hnTzYmeUH0kZLzo5Oo3oBoxrzz33hxaRaql6eO2x/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRdDu4I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D8C4CED2;
	Mon, 27 Jan 2025 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738004335;
	bh=8po7i00y17RimMFDy23j4ASQpjy8d79DKdJpOqhfyq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VRdDu4I8nuHM7MUVcG6r3jUjt2XHRFqB0XJdrXGqwaELjYZW4K/mBYzrQR2BuvbZf
	 SryIu59ShYlQVD2Qax597Z7EF4CJm/ljvwOe7nhlcxdekDu03957/yW+O3ZFzEoAHm
	 +N1uLz5pH5cGX/pfabczE2FkH5mUuC99wYrmDbn+sJKAj3KeqEeINbadul0ah+n8AJ
	 LsOVtcEkKtwXE+Yqf5Sktt9ORIm/RTXo5SbsRwhdpprhy/I9+zrJzcaCATgg+V3xml
	 Y7AqySZ3RgWohMDwUbldMKiXieUTRsIbbm1yFaY0edlgmumjo5bHQ6I0gcRxlQbYGi
	 KxnkfeNusJ06Q==
Date: Mon, 27 Jan 2025 12:58:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Restore the original INTX_DISABLE bit by
 pcim_intx()
Message-ID: <20250127185853.GA127679@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikq0b61y.wl-tiwai@suse.de>

On Mon, Jan 27, 2025 at 05:00:25PM +0100, Takashi Iwai wrote:
> On Mon, 09 Dec 2024 14:15:19 +0100,
> Philipp Stanner wrote:
> > 
> > On Mon, 2024-11-04 at 10:14 +0100, Philipp Stanner wrote:
> > > On Thu, 2024-10-31 at 14:42 +0100, Takashi Iwai wrote:
> > > > pcim_intx() tries to restore the INTx bit at removal via devres,
> > > > but
> > > > there is a chance that it restores a wrong value.
> > > > Because the value to be restored is blindly assumed to be the
> > > > negative
> > > > of the enable argument, when a driver calls pcim_intx()
> > > > unnecessarily
> > > > for the already enabled state, it'll restore to the disabled state
> > > > in
> > > > turn.  That is, the function assumes the case like:
> > > > 
> > > >   // INTx == 1
> > > >   pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct
> > > > 
> > > > but it might be like the following, too:
> > > > 
> > > >   // INTx == 0
> > > >   pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
> > > > 
> > > > Also, when a driver calls pcim_intx() multiple times with different
> > > > enable argument values, the last one will win no matter what value
> > > > it
> > > > is.  This can lead to inconsistency, e.g.
> > > > 
> > > >   // INTx == 1
> > > >   pcim_intx(pdev, 0); // OK
> > > >   ...
> > > >   pcim_intx(pdev, 1); // now old INTx wrongly assumed to be 0
> > > > 
> > > > This patch addresses those inconsistencies by saving the original
> > > > INTx state at the first pcim_intx() call.  For that,
> > > > get_or_create_intx_devres() is folded into pcim_intx() caller side;
> > > > it allows us to simply check the already allocated devres and
> > > > record
> > > > the original INTx along with the devres_alloc() call.
> > > > 
> > > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > > > Cc: stable@vger.kernel.org # 6.11+
> > > > Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > 
> > > Reviewed-by: Philipp Stanner <pstanner@redhat.com>
> > 
> > Hello,
> > 
> > it seems we forgot about this patch.
> > 
> > Regards,
> > P.
> 
> This has fallen through the cracks.
> Do I need to resubmit?

Oops, sorry, I did miss this.  I added to pci/for-linus for v6.14.  It
didn't apply quite cleanly, so take a look and make sure I resolved it
correctly:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=d555ed45a5a10a813528c7685f432369d536ae3d

> > > Nice!
> > > 
> > > > ---
> > > > v1->v2: refactoring, fold get_or_create_intx_devres() into the
> > > > caller
> > > > instead of retrieving the original INTx there.
> > > > Also add comments and improve the patch description.
> > > > 
> > > >  drivers/pci/devres.c | 34 +++++++++++++++++++---------------
> > > >  1 file changed, 19 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > > > index b133967faef8..c93d4d4499a0 100644
> > > > --- a/drivers/pci/devres.c
> > > > +++ b/drivers/pci/devres.c
> > > > @@ -438,19 +438,12 @@ static void pcim_intx_restore(struct device
> > > > *dev, void *data)
> > > >  	__pcim_intx(pdev, res->orig_intx);
> > > >  }
> > > >  
> > > > -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > > > device *dev)
> > > > +static void save_orig_intx(struct pci_dev *pdev, struct
> > > > pcim_intx_devres *res)
> > > >  {
> > > > -	struct pcim_intx_devres *res;
> > > > +	u16 pci_command;
> > > >  
> > > > -	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> > > > -	if (res)
> > > > -		return res;
> > > > -
> > > > -	res = devres_alloc(pcim_intx_restore, sizeof(*res),
> > > > GFP_KERNEL);
> > > > -	if (res)
> > > > -		devres_add(dev, res);
> > > > -
> > > > -	return res;
> > > > +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > > > +	res->orig_intx = !(pci_command &
> > > > PCI_COMMAND_INTX_DISABLE);
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -466,12 +459,23 @@ static struct pcim_intx_devres
> > > > *get_or_create_intx_devres(struct device *dev)
> > > >  int pcim_intx(struct pci_dev *pdev, int enable)
> > > >  {
> > > >  	struct pcim_intx_devres *res;
> > > > +	struct device *dev = &pdev->dev;
> > > >  
> > > > -	res = get_or_create_intx_devres(&pdev->dev);
> > > > -	if (!res)
> > > > -		return -ENOMEM;
> > > > +	/*
> > > > +	 * pcim_intx() must only restore the INTx value that
> > > > existed
> > > > before the
> > > > +	 * driver was loaded, i.e., before it called pcim_intx()
> > > > for
> > > > the
> > > > +	 * first time.
> > > > +	 */
> > > > +	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> > > > +	if (!res) {
> > > > +		res = devres_alloc(pcim_intx_restore,
> > > > sizeof(*res),
> > > > GFP_KERNEL);
> > > > +		if (!res)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		save_orig_intx(pdev, res);
> > > > +		devres_add(dev, res);
> > > > +	}
> > > >  
> > > > -	res->orig_intx = !enable;
> > > >  	__pcim_intx(pdev, enable);
> > > >  
> > > >  	return 0;
> > > 
> > 

