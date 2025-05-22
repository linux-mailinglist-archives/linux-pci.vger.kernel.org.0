Return-Path: <linux-pci+bounces-28269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D5AC0A85
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 13:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE4117E780
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45E288C0C;
	Thu, 22 May 2025 11:21:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E3238C3D;
	Thu, 22 May 2025 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912880; cv=none; b=Tj+to6+2Z+7+N4d/E2Jhu3nkZCpOQbaPplMzq1mvw8hw7WBGmENx4/FzAYm/kdyos9BfVUrvbswjLDR/e9EDmUtU6V9U+UccpHHp52nmH8hL4uZc4qCHjWw9upHlvXun5SPuCrU1D57gwqB6brrKGjEuDN5dSUMQ2yvg/PoGYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912880; c=relaxed/simple;
	bh=sNrvtk1BUA4pyk8WW5vjsyMF2BGrf0flGH/whATon1k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUNvYUbxdgx7aQSF0jb7xFtKqSFyIdFDYcbjcj7M7fcvbw98yp9G5o7mZUluEfhJNDqbh1N7GmI2yeDOTY2vYGXT4fNk/8z4g+8PnRXpVjWAnItkiyHJOpsSmyxwppTW7tMJua+rTs7Vojkrpir6bkSmGYaWyeAVTY1HRCj4Pdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b35S43W3Nz6GD5w;
	Thu, 22 May 2025 19:20:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C409140142;
	Thu, 22 May 2025 19:21:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 13:21:15 +0200
Date: Thu, 22 May 2025 12:21:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Jon Pan-Doh <pandoh@google.com>, "Karolina
 Stolarek" <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller
	<ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, "Anil
 Agrawal" <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Sathyanarayanan
 Kuppuswamy" <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver
 O'Halloran" <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, "Keith
 Busch" <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 17/17] PCI/AER: Add sysfs attributes for log
 ratelimits
Message-ID: <20250522122113.000030c0@huawei.com>
In-Reply-To: <20250521225942.GA1452275@bhelgaas>
References: <20250521114600.00007010@huawei.com>
	<20250521225942.GA1452275@bhelgaas>
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

On Wed, 21 May 2025 17:59:42 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, May 21, 2025 at 11:46:00AM +0100, Jonathan Cameron wrote:
> > On Tue, 20 May 2025 16:50:34 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > From: Jon Pan-Doh <pandoh@google.com>
> > > 
> > > Allow userspace to read/write log ratelimits per device (including
> > > enable/disable). Create aer/ sysfs directory to store them and any
> > > future aer configs.  
> > ...  
> 
> > There is some relatively new SYSFS infra that I think will help
> > make this slightly nicer by getting rid of the extra directory when
> > there is nothing to be done with it.  
> 
> > > +#define aer_ratelimit_burst_attr(name, ratelimit)			\
> > > +	static ssize_t							\
> > > +	name##_show(struct device *dev, struct device_attribute *attr,	\
> > > +		    char *buf)						\
> > > +{									\  
> > 
> > A little odd looking to indent this less than the line above.  
> 
> Yep, fixed.
> 
> > > +const struct attribute_group aer_attr_group = {
> > > +	.name = "aer",
> > > +	.attrs = aer_attrs,
> > > +	.is_visible = aer_attrs_are_visible,
> > > +};  
> > 
> > There are a bunch of macros to simplify cases where
> > a whole group is either enabled or not and make the group
> > itself go away if there is nothing to be shown.
> > 
> > DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() combined with
> > SYSFS_GROUP_VISIBLE() around the assignment does what we
> > want here I think.
> > 
> > Whilst we can't retrofit that stuff onto existing ABI
> > as someone may be assuming directory presence, we can
> > make sysfs less cluttered for new stuff.
> > 
> > Maybe I'm missing why that doesn't work here though!  
> 
> Is this something we can fix later, or are we locking ourselves into
> user-visible ABI that's hard to change?  I'm kind of against the wall
> relative to the v6.16 merge window and haven't had time to dig into
> this part.

That comes down to Ilpo's question of whether empty directories
are ABI (specifically if anyone notices us removing them).
It seems unlikely anyone will code against requirement for an empty
dir, but you never know.

Given we probably have a bunch of these in PCI anyway that predate
that magic, one more isn't a problem even if we decide we can't
tidy it up later.

So I'm fine with not bothering to hide the dir for now (and maybe for
ever).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Jonathan

> 


