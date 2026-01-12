Return-Path: <linux-pci+bounces-44481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F22D11366
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768B3302D937
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421713314D7;
	Mon, 12 Jan 2026 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6TuTFB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851021B81A1;
	Mon, 12 Jan 2026 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206478; cv=none; b=hE33q4bH2M4A/DKK+jwl1uzAcdKptR0Mml2rGUlC6dakHjdj5QhztFJFRh/cQ5T0BvytjVVwoEA+A8JupAK3p5wpqvyxjka4/8FC3UV5qzKUU6TWaWTZfW/ZOO3u5M/jrN+asUuQCw1xhrw9KvqGn20xuqPihyquKwdN3O6gPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206478; c=relaxed/simple;
	bh=357UM1fpFCDsDCbQ+ibhwxHHOZw7AqkmWhIXRIaT4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7EhtuntHNfA2/FDEWUHq1to3yKEa9qiA+46hWGPAleGKLLw8tTSbc+jS3JB/5DXCjOLFpQec18WhVnZ61D/HepD1RApeAeMdmmuYgLbo1aSNVfoij8lE2kI3H4VOrOc81S0oMgw3IAjqBHs39+caKnQtUEyYc9VZLTpvOCj5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6TuTFB0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768206476; x=1799742476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=357UM1fpFCDsDCbQ+ibhwxHHOZw7AqkmWhIXRIaT4h0=;
  b=m6TuTFB0R6VfXQYZWvjdLlw3w1ruZRoHvvJnJyK+1rKktfNP2ZRQ7FQc
   mAW/LL4Mavx6+isH2o7cFblIfCirahcDPEQleobmNInNIeJQwcgzl/Stp
   SH3Uk6XyDGNURabSDxFrrxg1tRcVBoaLagSShLCSssjJcihPmKY3kcn9n
   SvtoG6+vgN7d9Xue8Teh7eXdOm/SlRDe7Js/uHP7wAQyOXtCsaAkKd1qg
   /eCETlC7GNWg9WowXgxpXH20Mhs43HNwJXbPHYUiN1CgJa5ujRORsJ/b8
   M1oMLhbPyFs/rQzaTVJCJaHY7x4FvWLR7QPQmfVPJRGvnahmTUQzunyB9
   g==;
X-CSE-ConnectionGUID: 1k6oUIacSraeZsZX1PlV0w==
X-CSE-MsgGUID: 8CmWX4EaTO2l6qz4NrcleQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69390385"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69390385"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:27:55 -0800
X-CSE-ConnectionGUID: yUd/ZIhDQ2e1hVjhE67EWw==
X-CSE-MsgGUID: 4nuC2yCvTmqbSpBPsMzWBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204107983"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:27:48 -0800
Date: Mon, 12 Jan 2026 10:27:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	manivannan.sadhasivam@oss.qualcomm.com,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <aWSwgRiEkT9unYw9@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> + Dmitry Torokhov (who was against this patch previously)
> 
> On Mon, Jan 12, 2026 at 09:56:06AM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > 
> > > Because the software node backend of the fwnode API framework lacks an
> > > implementation for the .device_get_match_data function callback.
> > 
> > Maybe this is done on purpose. Have you thought about this aspect?
> 
> IMO, software nodes were introduced to add sub-properties to the existing
> firmware nodes, but it has usecase/potential to go beyond that. More below.

Potential doesn't mean the necessity.

> > > This makes it difficult to use(and/or test) a few drivers that originates
> > > from DT world on the non-DT platform.
> > 
> > How difficult? DSA implementation went to the way of taking DT overlay
> > approach. Why that one can't be applied here?
> 
> Sometimes you do not have any DT node at all.

Yes, that is exactly the case I have referred to. The PCI core (in Linux)
is able to create DT subtree on non-OF based platforms.

> For example, in this series, the
> M.2 pwrseq driver creates the serdev software device for the M.2 BT card to
> match it with the existing OF based BT driver (for non-M2 device). From the
> driver's point of view, a BT device attached to the M.2 slot and over custom
> connectors are both the same. Only difference is that, in the case of custom
> connectors, the bluetooth DT node will have the BT device described and in the
> case of M.2, the device won't get described, but just the connector [1].

So, what's the problem to add such a description? (Assuming you want a customisation
it can be done at run-time, correct?)

> But for the driver to identify the device (since it cannot enumerate it),
> either it has to rely on DT/ACPI or some other means.

Yes.

> In the previous version of this series [2], I used the serdev ID based on the
> product name for creating the serdev device and added a new id_table for serdev
> driver to match with the device [3]. This almost duplicated the existing OF
> match logic.

That's how we do when we want to add a board file, but thing is that we do not
want board files (only in the cases when other ways are impossible or make less
sense).

> Then Bartosz suggested to use swnode approach [4], to get rid of
> the custom serdev ID based matching. When I prototyped, it mostly worked well,

I know that Bart is fan of swnodes, but it should not be used as a silver
bullet, really.

> except that swnode needed to have its own .device_get_match_data(), match() and
> uevent/modalias functions. And if the swnode reused the existing DT compatible
> string, it can work with the existing BT driver without modifications. And this
> approach can also be extended to devices instantiated from the board specific
> drivers.

DT overlay should work without even modifications done to swnode code, right?

> [1] https://lore.kernel.org/all/20260110-pci-m2-e-v3-10-4faee7d0d5ae@oss.qualcomm.com/
> [2] https://lore.kernel.org/all/20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com/
> [3] https://lore.kernel.org/all/20251125-pci-m2-e-v2-2-32826de07cc5@oss.qualcomm.com/
> [4] https://lore.kernel.org/all/CAMRc=Mc-WebsQZ3jt2xirioNMticiWj9PJ3fsPTXGCeJ1iTLRg@mail.gmail.com/
> 
> > > Implement the .device_get_match_data fwnode callback, which helps to keep
> > > the three backends of the fwnode API aligned as much as possible. This is
> > > also a fundamental step to make a few drivers OF-independent truely
> > > possible.
> > > 
> > > Device drivers or platform setup codes are expected to provide a software
> > > node string property, named as "compatible". At this moment, the value of
> > > this string property is being used to match against the compatible entries
> > > in the of_device_id table. It can be extended in the future though.
> > 
> > I really do not want to see this patch without very good justification
> > (note, there were at least two attempts in the past to add this stuff
> >  and no-one was merged, have you studied those cases?).
> 
> Yes I did. I didn't put the above justification in the cover letter, as it was
> already overwhelmed with too much information regarding the connector node.
> Maybe I should've added it in the comments section of this patch. But I didn't
> know how to do that with b4.

Then you missed it. The cover letter for such a change is way too short.

-- 
With Best Regards,
Andy Shevchenko



