Return-Path: <linux-pci+bounces-33460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B0B1C4A1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5786818A6745
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65128B419;
	Wed,  6 Aug 2025 11:10:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F128A1EA;
	Wed,  6 Aug 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478629; cv=none; b=ZK8kgTL7dUGh86T/s+jnWQki8CgAIMn66RNJnTaLUwBzzK/x+nuTWdqnvGwRtiN94D3wd3ism9CKzBHFihSmH+nio/QiDxd9rc6zBOsr1kFEdON1E+airfPwi6JLsTM05bAgUNF4DYXLfyHsQuze4QZ8xPu9DW3z1iSpCy0+DpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478629; c=relaxed/simple;
	bh=gaDwBpQU47NQs8w+a+b6xuPnTg39iOigrP4eEEIssw0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6cy9Bkg1kmVc0agyY+TVT1wxBrp/4vxF3y4ofTMUqcLAgiihSFEnJr75rvfqkipIXiMnMCBlIxFEa2b6iVMQ0YLqFAhedpgQR3/1VWGsLePkiJuPK1iHXnCxT16MZH1P1T870yskQkbNnsFa5Xf1IdkXdldjfGO26Qn72CVKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxnXG57MRz6GDFy;
	Wed,  6 Aug 2025 19:05:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A6C531402F2;
	Wed,  6 Aug 2025 19:10:23 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 13:10:22 +0200
Date: Wed, 6 Aug 2025 12:10:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20250806121026.000023fe@huawei.com>
In-Reply-To: <6892b172976f7_55f0910067@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-5-dan.j.williams@intel.com>
	<20250729155650.000017b3@huawei.com>
	<6892b172976f7_55f0910067@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >   
> > > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > > new file mode 100644
> > > index 000000000000..0784cc436dd3
> > > --- /dev/null
> > > +++ b/drivers/pci/tsm.c
> > > @@ -0,0 +1,554 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * TEE Security Manager for the TEE Device Interface Security Protocol
> > > + * (TDISP, PCIe r6.1 sec 11)
> > > + *
> > > + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> > > + */  
> >   
> > > +static void tsm_remove(struct pci_tsm *tsm)
> > > +{
> > > +	struct pci_dev *pdev;
> > > +
> > > +	if (!tsm)  
> > 
> > You protect against this in the DEFINE_FREE() so probably safe
> > to assume it is always set if we get here.  
> 
> It is safe, but I would rather not require reading other code to
> understand the expectation that some callers may unconditionally call
> this routine.

I think a function like remove being called on 'nothing' should
pretty much always be a bug, but meh, up to you.

> 
> > > +		return;
> > > +
> > > +	pdev = tsm->pdev;
> > > +	tsm->ops->remove(tsm);
> > > +	pdev->tsm = NULL;
> > > +}
> > > +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> > > +
> > > +static int call_cb_put(struct pci_dev *pdev, void *data,  
> > 
> > Is this combination worth while?  I don't like the 'and' aspect of it
> > and it only saves a few lines...
> > 
> > vs
> > 	if (pdev) {
> > 		rc = cb(pdev, data);
> > 		pci_dev_put(pdev);
> > 		if (rc)
> > 			return;
> > 	}  
> 
> I think it is worth it, but an even better option is to just let
> scope-based cleanup handle it by moving the variable inside the loop
> declaration.
I don't follow that lat bit, but will look at next version to see
what you mean!

> 

> > > +                return;
> > > +
> > > +        if (!is_dsm(pdev))
> > > +                return;
> > > +
> > > +        pci_walk_bus(pdev->subordinate, cb, data);
> > > +}
> > > +
> >   
> > > +/*
> > > + * Find the PCI Device instance that serves as the Device Security
> > > + * Manger (DSM) for @pdev. Note that no additional reference is held for
> > > + * the resulting device because @pdev always has a longer registered
> > > + * lifetime than its DSM by virtue of being a child of or identical to
> > > + * its DSM.
> > > + */
> > > +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> > > +{
> > > +	struct pci_dev *uport_pf0;
> > > +
> > > +	if (is_pci_tsm_pf0(pdev))
> > > +		return pdev;
> > > +
> > > +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> > > +	if (!pf0)
> > > +		return NULL;
> > > +
> > > +	if (is_dsm(pf0))
> > > +		return pf0;  
> > 
> > 
> > Unusual for a find command to not hold the device reference on the device
> > it returns.  Maybe just call that out in the comment.  
> 
> It is, "Note that no additional reference..."

Good point :)

> > > diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> > > index 1f53b9049e2d..093824dc68dd 100644
> > > --- a/drivers/virt/coco/tsm-core.c
> > > +++ b/drivers/virt/coco/tsm-core.c  

> > > +static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> > > +						 struct pci_tsm_ops *pci_ops)
> > > +{
> > > +	int rc;
> > > +
> > > +	if (!pci_ops)
> > > +		return tsm_dev;
> > > +
> > > +	pci_ops->owner = tsm_dev;
> > > +	tsm_dev->pci_ops = pci_ops;
> > > +	rc = pci_tsm_register(tsm_dev);
> > > +	if (rc) {
> > > +		dev_err(tsm_dev->dev.parent,
> > > +			"PCI/TSM registration failure: %d\n", rc);
> > > +		device_unregister(&tsm_dev->dev);  
> > 
> > As below. I'm fairly sure this device_unregister is nothing to do with
> > what this function is doing, so having it buried in here is less easy
> > to follow than pushing it up a layer.  
> 
> I prefer a short function with an early exit and no scope based unwind
> for this.
> 
> > > +		return ERR_PTR(rc);
> > > +	}
> > > +
> > > +	/* Notify TSM userspace that PCI/TSM operations are now possible */
> > > +	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> > > +	return tsm_dev;
> > > +}
> > > +
> > >  static void put_tsm_dev(struct tsm_dev *tsm_dev)
> > >  {
> > >  	if (!IS_ERR_OR_NULL(tsm_dev))
> > > @@ -54,7 +109,8 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
> > >  	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
> > >  
> > >  struct tsm_dev *tsm_register(struct device *parent,
> > > -			     const struct attribute_group **groups)
> > > +			     const struct attribute_group **groups,
> > > +			     struct pci_tsm_ops *pci_ops)
> > >  {
> > >  	struct tsm_dev *tsm_dev __free(put_tsm_dev) =
> > >  		alloc_tsm_dev(parent, groups);
> > > @@ -73,12 +129,13 @@ struct tsm_dev *tsm_register(struct device *parent,
> > >  	if (rc)
> > >  		return ERR_PTR(rc);
> > >  
> > > -	return no_free_ptr(tsm_dev);
> > > +	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);  
> > 
> > Having a function call that either succeeds or cleans up something it
> > never did on error is odd.  
> 
> devm_add_action_or_reset() is the same pattern. Do the action, or
> otherwise take care of cleaning up. The action in this case is
> pci_tsm_register() and the reset is cleaning up the device_add().

It's a pretty obscure pattern but I agree there is that precedence.
In my head that one case gets to be 'special' because it is always
calling the callback, just a question of now or later (in remove).
Here thing callback happens in remove but it's explicit and nothing
to do with this function (unlikely the devm version)

Anyhow, not a thing I'm going to bother pushing back that hard on.
> 
> 
> > The or_reset hints at that oddity but to me is not enough. If you want
> > to use __free magic in here maybe hand off the tsm_dev on succesful
> > device registration.
> > 
> > 	struct tsm_dev *registered_tsm_dev __free(unregister_tsm_dev) =
> > 		no_free_ptr(tsm_dev);  
> 
> That does not look like an improvement to me.
> 
> The moment device_add() succeeds the cleanup shifts from put_device() to
> device_unregister(). I considered wrapping device_add(), but I think it
> is awkard to redeclare the same variable again vs being able to walk all
> instances of @tsm_dev in the function.

I agree it's a slightly odd construction and so might cause confusion.
So whilst I think I prefer it to the or_reset() pattern I guess I'll just
try and remember why this is odd (should I ever read this again after it's
merged!) :)

> 
> [..]
> > > + * struct pci_tsm_ops - manage confidential links and security state
> > > + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> > > + * 	      Provide a secure session transport for TDISP state management
> > > + * 	      (typically bare metal physical function operations).
> > > + * @sec_ops: Lock, unlock, and interrogate the security state of the
> > > + *	     function via the platform TSM (typically virtual function
> > > + *	     operations).
> > > + * @owner: Back reference to the TSM device that owns this instance.
> > > + *
> > > + * This operations are mutually exclusive either a tsm_dev instance
> > > + * manages phyiscal link properties or it manages function security
> > > + * states like TDISP lock/unlock.
> > > + */
> > > +struct pci_tsm_ops {
> > > +	/*  
> > Likewise though I'm not sure if kernel-doc deals with struct groups.  
> 
> It does not.

Hmm. Given they are getting common maybe that's one to address, but
obviously not in this series.

Jonathan


