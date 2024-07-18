Return-Path: <linux-pci+bounces-10511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AC934FBD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DAD1F22ADB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65425143754;
	Thu, 18 Jul 2024 15:16:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9313D533;
	Thu, 18 Jul 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315807; cv=none; b=K9XiNMOpl8iRBMQzmLfJgaL9PCh1oud2x6d9p5cmZTj1NbIBgUGNxcPJzV/Cfy7ik3iBAA3tjXBZe2cSV+al/BIou6Ne0V78rYEj0dF8RFynk7fmK674kJNz0Y/CLAGOGEs3qhujZsiFuxKPYSTETCMWNa2FEyWhPSgEHjxYLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315807; c=relaxed/simple;
	bh=Tw8f5qO0szEWBtfWszYziXTndQcNVeZcrI2qrYjr2tY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amedbh2/9CaLvUumpgV9ODkkXsJp7sLvy3k0ylxNlmLiI98ACHQKlQOZm2urGfLy1pyY+Tj+3/0bi/mHQ37AEhWY9JY/kzSYTl5w6Pnd9817VCEoW2E48rAAEpsAIIwffF2zCscuCwA3HJOUtaYHT9cHBP2sm4lXY6XMkkg695w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPxDp0rZVz6H83Q;
	Thu, 18 Jul 2024 23:14:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 49E92140B3C;
	Thu, 18 Jul 2024 23:16:41 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 16:16:40 +0100
Date: Thu, 18 Jul 2024 16:16:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, David
 Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, Sean Christopherson <seanjc@google.com>, "Alexander
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, "Jonathan Corbet"
	<corbet@lwn.net>
Subject: Re: [PATCH v2 12/18] PCI/CMA: Expose certificates in sysfs
Message-ID: <20240718161639.00006ca3@Huawei.com>
In-Reply-To: <6698815b1331a_1f03d294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
	<e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de>
	<6698815b1331a_1f03d294d6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >  
> > diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
> > index 9bbed7abc153..afba3c5a2e8f 100644
> > --- a/lib/spdm/req-sysfs.c
> > +++ b/lib/spdm/req-sysfs.c
> > @@ -93,3 +93,83 @@ const struct attribute_group spdm_attr_group = {
> >  	.attrs = spdm_attrs,
> >  	.is_visible = spdm_attrs_are_visible,
> >  };
> > +
> > +/* certificates attributes */
> > +
> > +static umode_t spdm_certificates_are_visible(struct kobject *kobj,
> > +					     struct bin_attribute *a, int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
> > +	u8 slot = a->attr.name[4] - '0';  
> 
> This is clever, but the @n parameter already conveys the index.

That's still fragile. I'd use a container structure so that we can
get the number directly from container_of() and appropriate field
in the container structure.

> 
> > +
> > +	if (IS_ERR_OR_NULL(spdm_state))
> > +		return SYSFS_GROUP_INVISIBLE;
> > +
> > +	if (!(spdm_state->supported_slots & BIT(slot)))
> > +		return 0;
> > +
> > +	return a->attr.mode;
> > +}
> > +
> > +static ssize_t spdm_cert_read(struct file *file, struct kobject *kobj,
> > +			      struct bin_attribute *a, char *buf, loff_t off,
> > +			      size_t count)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
> > +	u8 slot = a->attr.name[4] - '0';  
> 
> Similar comment on cleverness, I will note that the way this is
> typically handled is something like this which is just slightly less
> error prone if someone in the future changes the naming scheme.
> 
> #define CERT_ATTR(n) \
> static ssize_t slot##n##_show(struct file *file, struct kobject *kobj, \
>                               struct bin_attribute *a, char *buf, loff_t off, \
>                               size_t count) \
> { \
> 	return spdm_cert_read(kobj_to_dev(kobj), buf, off, count, (n)); \
> } \
> static BIN_ATTR_RO(slot##n);

Or augment the attribute by sticking it in a container structure with the slot
number as data and use container_of().  Either path works fine and avoids the
fragility issue of using the naming.

> 


