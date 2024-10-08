Return-Path: <linux-pci+bounces-13997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC105995495
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 18:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377B5B21695
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D01DFE05;
	Tue,  8 Oct 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXSjaPcK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68851E0E08
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405458; cv=none; b=USduHCo0GFVtJCVHhB67+ALXdl6syj55NwFvpRNd6yzQhWKBaMm36hogHOcW8KVgn8n95oGI9OIIpuqXS20T6gkhIoRUDCwu6VoY4NqIfTHVUyevap/KYIODc7GUbaTMNuGFKJU/y1H4HKIxb6y/T4Q0iH20Ocohe2x/cZ4kSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405458; c=relaxed/simple;
	bh=rIsDvpg79JVMANiUS0HeTzawj6o7FRI+dARbdd2NWQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnFcY8q/y5p9wUlDlWG4sd9l4IFoLeyiEEo488B0O6fSb0J6zROLqeGanTfqQV2nCbmW1l1eYm2AAVHRqqFpNSiFltOaZxjr8XCPeLL8eKCqvJgbGcTCuNU1iRZfzFdYXjEUKFP/RGMcRebV25sXwwV8ybHt9ce0WpcFHuG9d0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXSjaPcK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728405457; x=1759941457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rIsDvpg79JVMANiUS0HeTzawj6o7FRI+dARbdd2NWQE=;
  b=SXSjaPcKAVg32CUTg/BOMNvnle6fedij+4CsqreGH1gCA8O9yH4wPqZ3
   R22xyfwVa/1Pg37Lzabbyv2zc8r3mDhLddKTTbOf3xG6Ewq+2QecQCd7k
   JyVtDU5Nc+6el+SdAxxTpzpRX8Ey+ZnS3gmprV1Gyffzwc8XibNF1GRUm
   hND4A1VNTmdWZPvgvLsCla2nmP4XC1huO9erfQq1C5NcNKcJ0OATCytc/
   oFmIMcAHzGKonSiuahRkl+4vtgWSyuibkCSLKL1jXYhtGcQboqwLT+DAd
   2c93XVU8dyrqpprfMl1kZ0OCrDVkl0yZC426GsU/7rtybAZts7Zyn1NC+
   w==;
X-CSE-ConnectionGUID: kOkdsU8dQ1iodH1/GsulWA==
X-CSE-MsgGUID: Ke8lBeJ6RRaWBimi+/0vrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27711989"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27711989"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:37:36 -0700
X-CSE-ConnectionGUID: /6PxXlIqRGqjAoKiySfI1w==
X-CSE-MsgGUID: GcaT686cRQm+gN+qUL9PUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80926966"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 08 Oct 2024 09:37:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D0AD920F; Tue, 08 Oct 2024 19:37:32 +0300 (EEST)
Date: Tue, 8 Oct 2024 19:37:32 +0300
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <20241008163732.GT275077@black.fi.intel.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
 <Zv6gT96pHg2Jglxv@wunner.de>
 <Zv-dIHDXNNYomG2Y@wunner.de>
 <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
 <ZwU6ijD8I5hzMv9X@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwU6ijD8I5hzMv9X@wunner.de>

On Tue, Oct 08, 2024 at 03:58:34PM +0200, Lukas Wunner wrote:
> Finally, I'd appreciate if you could send me dmesg output with the
> refcounting fix applied.  As said before, the MTL Thunderbolt controller
> claims that the link and slot presence bits are cleared, so it
> de-enumerates everything attached via Thunderbolt.  I'm wondering
> if it then re-enumerates the Thunderbolt-attached devices so they're
> actually usable?
> 
> I'm hoping Mika can clarify with Intel Thunderbolt CoE whether this
> is a hardware issue in MTL that can e.g. be fixed through a firmware
> or BIOS update.

I think here it happens because we reset the host router when the driver
probes so all the BIOS CM created tunnels will be torn down as well.

