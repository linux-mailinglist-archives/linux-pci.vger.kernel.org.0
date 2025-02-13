Return-Path: <linux-pci+bounces-21364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69FA34AA7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71693BDED7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D05201271;
	Thu, 13 Feb 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy0f0yFg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC36200120;
	Thu, 13 Feb 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464732; cv=none; b=Lv0nY+pXN+xWwGkFqIJ0TmGpLUEPaODsVqU4x1vKzCmOaVrcJJBCbnwfuLc8USxfv8jispK92NWmz1g2G4VYK9lDFuzOqMWlHvno34Xe6cTR6p3J16roDIrzenHqQ7bW8NHxVdxWvDixUSoH8EZniGo+CTV7lHkxbZ3JrbwJKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464732; c=relaxed/simple;
	bh=sFwHX9CTm3DdV1wJQCyFsFmsgP8cMMqWejD1WdV7oY8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FkSCmkrv74OQ73StKLc51erHVfoPy6gYxnQS/4oFhVz9AoJgK07AdnSxAP2rpXNqawCN8mrF7VSQZ62PKDjTf6ig11T/XtqGym/jIFkNK5CdmOZJtnw/YT7UuMkEDt3GZgLfIPGqfnU5B8S+9WBhUtm8jD35IEhRjqXoP5jFv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy0f0yFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE30C4CED1;
	Thu, 13 Feb 2025 16:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464732;
	bh=sFwHX9CTm3DdV1wJQCyFsFmsgP8cMMqWejD1WdV7oY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xy0f0yFgmhbZt8YZ0tcbVcXgjP8tiuEvpkU846dmHLfZCpU0ZaXmhmV58E5DofWFY
	 W1X5I7nN5sa01M4VkzZDADENlB4nioJkUxyB8KElPQCmc3pYhEiTKu/9/cwveM55ju
	 KosfVve2XA05wEX9YK1rB4elcsQMBVmAzq5LIUjfoToy2MRbcfZrIqX8MQjHk3yTBo
	 WwsifM9HnaZLsensA+A/qA8IpIQ7+AnC1qwid1W3Xzlckpz3tvZM9twfp2XzzsGgy5
	 ihQ/7WAYmi6ZxuKuio9AxgfVp9VYe6QdQ89MLcCP9dxWdBfq9wpFnQLxYGRVG8v5I6
	 dZKfqFQfHIQ5w==
Date: Thu, 13 Feb 2025 10:38:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: Avoid pointless capability searches
Message-ID: <20250213163850.GA114277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dbb0d8b-3708-60ba-ee9e-78aa48bee160@linux.intel.com>

On Thu, Feb 13, 2025 at 03:52:05PM +0200, Ilpo Järvinen wrote:
> On Fri, 7 Feb 2025, Bjorn Helgaas wrote:
> > Many of the save/restore functions in the pci_save_state() and
> > pci_restore_state() paths depend on both a PCI capability of the device and
> > a pci_cap_saved_state structure to hold the configuration data, and they
> > skip the operation if either is missing.
> > 
> > Look for the pci_cap_saved_state first so if we don't have one, we can skip
> > searching for the device capability, which requires several slow config
> > space accesses.

> > +++ b/drivers/pci/vc.c
> > @@ -355,20 +355,17 @@ int pci_save_vc_state(struct pci_dev *dev)
> >  	int i;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
> > -		int pos, ret;
> >  		struct pci_cap_saved_state *save_state;
> > +		int pos, ret;
> > +
> > +		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > +		if (!save_state)
> > +			return -ENOMEM;
> >  
> >  		pos = pci_find_ext_capability(dev, vc_caps[i].id);
> >  		if (!pos)
> >  			continue;
> >  
> > -		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > -		if (!save_state) {
> > -			pci_err(dev, "%s buffer not found in %s\n",
> > -				vc_caps[i].name, __func__);
> > -			return -ENOMEM;
> > -		}
> 
> I think this order change will cause a functional change because 
> pci_allocate_vc_save_buffers() only allocated for those capabilities that 
> are exist for dev. Thus, the loop will prematurely exit.

Oof, thank you for catching this!  I'll drop this for now.

It would be nice to make pci_save_vc_state() parallel with
pci_restore_vc_state() (and with most other pci_save_*_state()
functions) and have it return void.  But pci_save_state() returns the
pci_save_vc_state() return value, and there are ~20 pci_save_state()
callers that pay attention to that return value.

I'm not convinced there's real value in pci_save_state() error
returns, given that so few callers check it, but it definitely
requires more analysis before removing it.

> >  		ret = pci_vc_do_save_buffer(dev, pos, save_state, true);
> >  		if (ret) {
> >  			pci_err(dev, "%s save unsuccessful %s\n",
> > @@ -392,12 +389,15 @@ void pci_restore_vc_state(struct pci_dev *dev)
> >  	int i;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
> > -		int pos;
> >  		struct pci_cap_saved_state *save_state;
> > +		int pos;
> > +
> > +		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > +		if (!save_state)
> > +			continue;
> >  
> >  		pos = pci_find_ext_capability(dev, vc_caps[i].id);
> > -		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > -		if (!save_state || !pos)
> > +		if (!pos)
> >  			continue;
> >  
> >  		pci_vc_do_save_buffer(dev, pos, save_state, false);
> > 
> 
> -- 
>  i.
> 

