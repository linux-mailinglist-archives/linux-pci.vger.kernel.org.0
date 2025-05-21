Return-Path: <linux-pci+bounces-28242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B50AC003A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 00:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5576E1BC1CA5
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 23:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431D239E6A;
	Wed, 21 May 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iazKkXCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DA1624CE;
	Wed, 21 May 2025 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868384; cv=none; b=T3ngtZgNRSbhqxPOdoLz3Qv9vHaVKP8uBEMjmpAylWuDJ9r2XWb9JKNrvPft1HnuEms8oJcaN/d1ZmXYIkgWGZ/iiiM897zAf1DeyWYHkofl+CO2sGr6J3ABSm5sv3yosWD4Kb3m4nRG3hXDSCvyuNC66Qfokm3pzmrSZwqqFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868384; c=relaxed/simple;
	bh=IbhrjqjCd+IL+OzZrKr4UCUXAEgx35sVZsX2gaP8Cs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o0iWlu665pQXpxfxEMxDIg4Mg1cHt1c6e/f/v2d4ZSrk7O6zMNUG9B/5bL5UstfBhmzTpcLKMntMQiRN87KG8QUE3kG6uH2czZs0nGT1lseF2w3aFMc381m8p6DC4JbqQv4uVPf4Lh02Fn6e6bm3j1168drl+g/eA3cFHuJGmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iazKkXCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7092BC4CEE4;
	Wed, 21 May 2025 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747868383;
	bh=IbhrjqjCd+IL+OzZrKr4UCUXAEgx35sVZsX2gaP8Cs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iazKkXCXaj/wq12Dr4QVfxGACmZ2mHC0jptz6htAaLWZf9BN+4m5ku+D+0PA8AemS
	 B9ycUgm/A7JPDBgVLs+RIf3beXTuqVbQrIWcQbNPP2mhgdmXQnsToMEqxmQkLFo4mc
	 Sxiu/jdiTMhKHTjeRcrzen6HOsu1AdPAri+wB5TPB85CzPopbBUZyT+BQNjaz3LjF5
	 JD6VLT4AfBZJFQPGJtJwQJuQbx1YlTPUWSEnoTAAhJyX4thfIbsgQGlf92hrqUDcAK
	 GtmjihJFKjDmOlHGMBPLgKMHKcgemgh9+R0Ihwj/HxQip7+fGb3HKT8BGlWn8EiKWy
	 igNF5NhEiqbzw==
Date: Wed, 21 May 2025 17:59:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 17/17] PCI/AER: Add sysfs attributes for log ratelimits
Message-ID: <20250521225942.GA1452275@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521114600.00007010@huawei.com>

On Wed, May 21, 2025 at 11:46:00AM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 16:50:34 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Allow userspace to read/write log ratelimits per device (including
> > enable/disable). Create aer/ sysfs directory to store them and any
> > future aer configs.
> ...

> There is some relatively new SYSFS infra that I think will help
> make this slightly nicer by getting rid of the extra directory when
> there is nothing to be done with it.

> > +#define aer_ratelimit_burst_attr(name, ratelimit)			\
> > +	static ssize_t							\
> > +	name##_show(struct device *dev, struct device_attribute *attr,	\
> > +		    char *buf)						\
> > +{									\
> 
> A little odd looking to indent this less than the line above.

Yep, fixed.

> > +const struct attribute_group aer_attr_group = {
> > +	.name = "aer",
> > +	.attrs = aer_attrs,
> > +	.is_visible = aer_attrs_are_visible,
> > +};
> 
> There are a bunch of macros to simplify cases where
> a whole group is either enabled or not and make the group
> itself go away if there is nothing to be shown.
> 
> DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() combined with
> SYSFS_GROUP_VISIBLE() around the assignment does what we
> want here I think.
> 
> Whilst we can't retrofit that stuff onto existing ABI
> as someone may be assuming directory presence, we can
> make sysfs less cluttered for new stuff.
> 
> Maybe I'm missing why that doesn't work here though!

Is this something we can fix later, or are we locking ourselves into
user-visible ABI that's hard to change?  I'm kind of against the wall
relative to the v6.16 merge window and haven't had time to dig into
this part.

