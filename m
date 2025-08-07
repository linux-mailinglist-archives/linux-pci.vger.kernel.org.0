Return-Path: <linux-pci+bounces-33540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF02B1D5F0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A6456150E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1269D26463B;
	Thu,  7 Aug 2025 10:42:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EB26561E;
	Thu,  7 Aug 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754563371; cv=none; b=TTukiYImZ69loDbLvUusFMftGgB01idpnteUNTOE/Za4QzVStYIh99tYmVaV9w9fUFU7ua+wZl4U6zrGLgNz3jpxf8L5KT/7QYtd/pRJHFcn0+BSUVqxOk7RrkeM8a+CBdvRHcSLyWHlnSRIq/O5irNpe+ov0ecStMuXlF3OIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754563371; c=relaxed/simple;
	bh=lvs3Xkpt++OhLJ22sw2ONuCbf14O/uMzOeDO84uwhmQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag9ufTR9mqREYajgzoyON3dPONCjdSyLv956s1+Y3tOwPREdrWbLy0eKg0C3vNLBGOO4IxIpKl1bdqkC701DzVglX0gM4sgL5KToN1oDbGojRq0eUvYlqK8uKT5auWrw9lr1X2bAB7xFZHns3lLyfTv4F6yTm5hzLidHL3OET0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4byNsn3rJlz67DYv;
	Thu,  7 Aug 2025 18:38:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4861C14033C;
	Thu,  7 Aug 2025 18:42:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Aug
 2025 12:42:40 +0200
Date: Thu, 7 Aug 2025 11:42:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20250807114239.00005b61@huawei.com>
In-Reply-To: <6893e23f35349_55f0910072@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-5-dan.j.williams@intel.com>
	<20250729155650.000017b3@huawei.com>
	<6892b172976f7_55f0910067@dwillia2-xfh.jf.intel.com.notmuch>
	<20250806121026.000023fe@huawei.com>
	<6893e23f35349_55f0910072@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > > > > +	pdev = tsm->pdev;
> > > > > +	tsm->ops->remove(tsm);
> > > > > +	pdev->tsm = NULL;
> > > > > +}
> > > > > +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> > > > > +
> > > > > +static int call_cb_put(struct pci_dev *pdev, void *data,    
> > > > 
> > > > Is this combination worth while?  I don't like the 'and' aspect of it
> > > > and it only saves a few lines...
> > > > 
> > > > vs
> > > > 	if (pdev) {
> > > > 		rc = cb(pdev, data);
> > > > 		pci_dev_put(pdev);
> > > > 		if (rc)
> > > > 			return;
> > > > 	}    
> > > 
> > > I think it is worth it, but an even better option is to just let
> > > scope-based cleanup handle it by moving the variable inside the loop
> > > declaration.  
> > I don't follow that lat bit, but will look at next version to see
> > what you mean!  
> 
> Here is new approach (only compile tested) after understanding that loop
> declared variables do trigger cleanup on each iteration.

Looks good.


> 
> [..]
> > I agree it's a slightly odd construction and so might cause confusion.
> > So whilst I think I prefer it to the or_reset() pattern I guess I'll just
> > try and remember why this is odd (should I ever read this again after it's
> > merged!) :)  
> 
> However, I am interested in these "the trouble with cleanup.h" style
> discussions.
> 
> I recently suggested this [1] in another thread which indeed uses
> multiple local variables of the same object to represent the different
> phases of the setup. It was easier there because the code was
> straigtforward to convert to an ERR_PTR() organization.
> 
> If there was already an alternative device_add() like this:
> 
> struct device *device_add_or_reset(struct device *dev)
> 
> That handled the put_device() then you could write:
> 
> struct device *devreg __free(device_unregister) = device_add_or_reset(no_free_ptr(dev))
> 
> ...and help that common pattern of 'struct device' setup transitions
> from put_device() to device_unregister() at device_add() time.
> 
> [1]: http://lore.kernel.org/688bcf40215c3_48e5100d6@dwillia2-xfh.jf.intel.com.notmuch

That's definitely interesting (in a fairly good way) as anything to stop people
introducing bugs around the device_add() stuff would be welcome.  It'll take a bit
of getting used to though.  Maybe make it more explicit device_add_or_put()?

Naming hard as normal..
> 
Jonathan



