Return-Path: <linux-pci+bounces-1445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E551481EFE9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D251C217AE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54745976;
	Wed, 27 Dec 2023 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKFJvYrq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3545944;
	Wed, 27 Dec 2023 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703692496; x=1735228496;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kt+PoKLue3EeaX8V4OySRQxkfd3AdJlStYxInfcd38Q=;
  b=kKFJvYrqt+/8o7hqlHfxrSZ05Jl9d7aSW7O1ywZVf719BQ3xKFSrjNz2
   O46i5prgdSAQqbz6WbKQDQ12m1utpPBLcbFbmJuh8zeRJpUNPTWZjKb18
   ix6P/+RGfNvTjqkf8wtuoUz7Z9WQeSP2vZexJZuC0bqy4MPrQPcLWZWfD
   oSawrzPuyeEgdNn/xYFXQQ8AdaAOVKXNBZ5H0PIjfj9vU9hf+6mmQGHt5
   L6ZdBJLcQx0q59tk5thuyo/iejAoCUi3V8aKXgFfARAV93692ObCVBZAK
   ZHJy6Ytap91JHG2ONzpawavzRt+G6ZXrUfzlRWyYkxoGBnurT7wWvXd7P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="462878155"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="462878155"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 07:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="951528702"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="951528702"
Received: from hrmarapi-mobl1.ger.corp.intel.com ([10.249.35.233])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 07:54:52 -0800
Date: Wed, 27 Dec 2023 17:54:50 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] resource: Use typedef for alignf callback
In-Reply-To: <ZYWPaGc4rjymcm75@smile.fi.intel.com>
Message-ID: <8161e59d-2122-562c-dcc7-f772ddbcbdf@linux.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com> <20231222122901.49538-5-ilpo.jarvinen@linux.intel.com> <ZYWPaGc4rjymcm75@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 22 Dec 2023, Andy Shevchenko wrote:

> > +/**
> > + * resource_alignf - Resource alignment callback
> > + * @data:	Private data used by the callback
> > + * @res:	Resource candidate range (an empty resource slot)
> > + * @size:	The minimum size of the empty slot
> > + * @align:	Alignment from the constraints
> > + *
> > + * Callback allows calculating resource placement and alignment beyond min,
> > + * max, and align fields in the struct resource_constraint.
> > + *
> > + * Return: Start address for the resource.
> > + */
> > +typedef resource_size_t (*resource_alignf)(void *data,
> > +					   const struct resource *res,
> > +					   resource_size_t size,
> > +					   resource_size_t align);
> 
> Never saw typedef kernel-doc before, so hopefully this will be rendered
> just fine.

This was a good point. It seems that one has to prefix the name with 
typedef like this:

/**
 * typedef resource_alignf - Resource alignment callback

...otherwise scripts/kernel-doc attempts to parse it as a function 
kerneldoc.

-- 
 i.


