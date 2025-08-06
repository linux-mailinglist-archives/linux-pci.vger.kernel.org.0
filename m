Return-Path: <linux-pci+bounces-33461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83658B1C4B0
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF554560CE4
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522A218AAB;
	Wed,  6 Aug 2025 11:16:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFD3AC1C;
	Wed,  6 Aug 2025 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478986; cv=none; b=eVuIaRFEVz2+QP7vIZ1LQENAibwwHIAPfG7ICDJfEQevlTgB5AfEv8BmoCXv/+lKAyaWuF+PZScoI3kYDVIpp3vm9HoQMXckkHUdyjl4AKM6Y3yr481Z8WYiHWnVwprOH/pSmbiCO6s9TpxJ3BlVRsOZOMGjPqwHHeK33ReUJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478986; c=relaxed/simple;
	bh=zxm5bDbzQmHdqSW1nHMqa3d8zuFaL0CYxhmDbUIdf20=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU63q5HXWHvIHg0Vlqxo58UX7BuamoGJuUfvqesOiy2wVCDiEVKnWGhxX1aZfdh2RjPSOXsDFWRGZw16kT7fY7H9D6iuDt6oVDjrp6wWP+XcEhFCi9bmcxCszlj/eOUwrAmD2Fw1DnzPmSJ3gXuDoM23VOAA1MEukngYKLswvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxnkM5Ylqz6M4PP;
	Wed,  6 Aug 2025 19:14:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BE206140159;
	Wed,  6 Aug 2025 19:16:22 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 13:16:21 +0200
Date: Wed, 6 Aug 2025 12:16:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI
 device-security bus + endpoint sample
Message-ID: <20250806121625.00001556@huawei.com>
In-Reply-To: <6892c9fe760_55f09100d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-6-dan.j.williams@intel.com>
	<20250729161643.000023e7@huawei.com>
	<6892c9fe760_55f09100d4@dwillia2-xfh.jf.intel.com.notmuch>
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


+CC Gerd, of off chance we can use a Redhat PCI device ID for kernel
emulation similar to those they let Qemu use.

> 
> > > +	for (int i = 0; i < ARRAY_SIZE(devsec->devsec_devs); i++) {
> > > +		struct devsec_dev *devsec_dev = devsec_dev_alloc(devsec);
> > > +		int rc;
> > > +
> > > +		if (IS_ERR(devsec_dev))
> > > +			return PTR_ERR(devsec_dev);
> > > +		rc = devm_add_action_or_reset(dev, destroy_devsec_dev,
> > > +					      devsec_dev);
> > > +		if (rc)
> > > +			return rc;
> > > +		devsec->devsec_devs[i] = devsec_dev;
> > > +	}
> > > +
> > > +	return 0;
> > > +}  
> > 
> >   
> > > +static int init_port(struct devsec_port *devsec_port)
> > > +{
> > > +	struct pci_bridge_emul *bridge = &devsec_port->bridge;
> > > +
> > > +	*bridge = (struct pci_bridge_emul) {
> > > +		.conf = {
> > > +			.vendor = cpu_to_le16(0x8086),
> > > +			.device = cpu_to_le16(0x7075),  
> > 
> > Emulating something real?  If not maybe we should get an ID from another space
> > (or reserve this one ;)  
> 
> I am happy to switch to something else, but no, I do not have time to
> chase this through PCI SIG. I do not expect this id to cause conflicts,
> but no guarantees.

Nothing to do with the SIG - you definitely don't want to try talking them
into giving a Vendor ID for the kernel.  That's an Intel ID so you need to find
the owner of whatever tracker Intel uses for these.  Or maybe we can ask for
one of the Redhat ones (maintained by Gerd).

> 
> > > +			.class_revision = cpu_to_le32(0x1),
> > > +			.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> > > +			.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> > > +		},  
> > 
> >   

...
> > > +static int __init devsec_tsm_init(void)
> > > +{
> > > +	__devsec_pci_ops = &devsec_pci_ops;  
> > 
> > I'm not immediately grasping why this global is needed.
> > You never check if it's set, so why not just move definition of devsec_pci_ops
> > early enough that can be directly used everywhere.  
> 
> Because devsec_pci_ops is used inside the ops it declares. So either
> forward declare all those ops, or do this pointer assigment dance. I
> opted for the latter as it is smaller.
Ok. I guess in emulation that's a reasonable compromise.  Maybe leave
a comment somewhere to avoid repeat of this feedback.

Jonathan

> 


