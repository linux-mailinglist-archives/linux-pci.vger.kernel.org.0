Return-Path: <linux-pci+bounces-33459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96719B1C48D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 12:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B65560375
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 10:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614528A1D2;
	Wed,  6 Aug 2025 10:54:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A892741D1;
	Wed,  6 Aug 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477651; cv=none; b=iPbqKMRBp16BTBxPRiV//vwX0Ua9J3D5a9wTZy6v6jz9XGWjiFXMFXiO9IVM5UdPzxGFu0JBolkjF0BCbHpbfvsUJ2v8fDUvXSq7grzy/mo9s434TJie6Enm9DszcoQlYaMeSUTqxgxcOdcl38hUJ59nx7gtVz7GLuPLjdq+XfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477651; c=relaxed/simple;
	bh=x4t+ZfwUxSbJeM8NS6DYvF8kE7XAxAfSq+b33ZkfyqU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeBXk8J1r0C67Lwc5BqpUhjSHUHkI4b1gBx1EdnyN8qnTQjBFYLoQzyJhBLtOoqRTx0sNKx/gkdCYE4JJltY3u04V5TVFQTllrF/nJ+aw9ylT/AKLrmE/sYyaPl6QFHruSzYF/CHR2tV5JK2z4wqVyv/mIuUqMomIBRltgk5UCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxnDg67zYz6M4Lj;
	Wed,  6 Aug 2025 18:52:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CD313140159;
	Wed,  6 Aug 2025 18:54:06 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 12:54:05 +0200
Date: Wed, 6 Aug 2025 11:54:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v4 03/10] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Message-ID: <20250806115409.000037cd@huawei.com>
In-Reply-To: <6892993f3ed0e_55f0910079@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-4-dan.j.williams@intel.com>
	<20250729140623.000068a8@huawei.com>
	<6892993f3ed0e_55f0910079@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > > +enum pci_search_direction {
> > > +	PCI_SEARCH_FORWARD,
> > > +	PCI_SEARCH_REVERSE,
> > > +};
> > > +  
> > 
> > I don't really care, but given there are only two sane directions maybe
> > a bool reverse as a parameter to __pci_get_subsys() would be sufficient?   
> 
> I dislike reading:
> 
>    return __pci_get_subsys(vendor, device, ss_vendor, ss_device, from, false);
> 
> ...in isolation where I must walk the symbol to the function to figure
> out what that parameter means vs:
> 
>    return __pci_get_subsys(vendor, device, ss_vendor, ss_device, from,
>                            PCI_SEARCH_FORWARD);
> 
> ...which is immediately clear.
Fair enough.

> 
> >   

