Return-Path: <linux-pci+bounces-17951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938ED9E9AC0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3BA281D5E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477241B423B;
	Mon,  9 Dec 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDU4vQJe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172A1B4236;
	Mon,  9 Dec 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758939; cv=none; b=MxYKQ66yED0F5PYmfzWu87xjaYU1DNSjTlpmO7CVE+ulCTUJm++9xkFDA+83oDO8ev7v4kNt6MEbWROf45hwD02yVpII1mXXRrq4U8y4/C7w/dRS2zvapCAc+ltqiUbLwiMVsCwbiIDJeUVAFQ3Uzs2oKyirNDaGs1NywIYKO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758939; c=relaxed/simple;
	bh=P18b2PlB0MwGNJ/eQCw45a7as/FOYe1k97RGjVLARlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as1zyWglSznPb4o50QKAHUrhCHwxN6hqOGtc/Lisjh8IIb2zfZLqFx7y5LxtgscgFsq4t1Re8DxCuJv4u3NyCjE/slwchoObocYiOaL5BwMeRRAYWAAiGZrrp9rYDmSJCBsos532cmjkul9SCYBEL++qGmO1osXQHTcsYGPraVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDU4vQJe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733758938; x=1765294938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P18b2PlB0MwGNJ/eQCw45a7as/FOYe1k97RGjVLARlg=;
  b=kDU4vQJe5tdMQxjtWyK0WwIjSec5WgLrq1g7przjm9GTc8NuLYxlrt/u
   MoboT1M087pzk6arXUhDQiH7hcOUT5Ef7tsT8z2CBueG69W3zsgpR5yGI
   nlZsF+F5O1lnQEc5inTbvN+hPPnqYEmxA3QqW32mmPRraydb7TlyXb5uM
   SiQZ3E87UWdkMscnA2IQvkz/9CuCzGMRb0pOeXgp5X0VMYb4edamNrIKl
   q1WBFtdFM3cOiR2HztUEpYZhsdO+OlxO5vjT00EFk+QuQ/YWHYlgscHQJ
   Rn1S8jnsBrsfQ0AqUMGcoEoc3xjFWbJmnRwkDZwRElBtYn7gmQ5Ua2HV5
   w==;
X-CSE-ConnectionGUID: AO6ovWqXTqWMOYQbOHyaIQ==
X-CSE-MsgGUID: 6lcw4Ev5Rqyd2VPF/oz4MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="45466889"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="45466889"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 07:42:17 -0800
X-CSE-ConnectionGUID: vBpVhrnzR9mGjzDWG200ag==
X-CSE-MsgGUID: ifEavL7+SWa8OkyWYs+vYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94954637"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 09 Dec 2024 07:42:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 18D6644B; Mon, 09 Dec 2024 17:42:10 +0200 (EET)
Date: Mon, 9 Dec 2024 17:42:10 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Schnelle <niks@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Message-ID: <20241209154210.GL4955@black.fi.intel.com>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>

On Sat, Dec 07, 2024 at 07:44:09PM +0100, Niklas Schnelle wrote:
> Trying to enable bwctrl on a Thunderbolt port causes a boot hang on some
> systems though the exact reason is not yet understood. As per the spec
> Thunderbolt PCIe Downstream Ports have a fake Max Link Speed of 2.5 GT/s
> (USB4 v2 sec 11.2.1):
> 
>    "Max Link Speed field in the Link Capabilities Register set to 0001b
>     (data rate of 2.5 GT/s only).
>     Note: These settings do not represent actual throughput.
>     Throughput is implementation specific and based on the USB4 Fabric
>     performance."
> 
> More generally if 2.5 GT/s is the only supported link speed there is no
> point in throtteling as this is already the lowest possible PCIe speed
> so don't advertise the capability stopping bwctrl from being probed on
> these ports.
> 
> Link: https://lore.kernel.org/linux-pci/Z1R4VNwCOlh9Sg9n@wunner.de/
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
> Tested-by: Niklas Schnelle <niks@kernel.org>
> Signed-off-by: Niklas Schnelle <niks@kernel.org>

Makes sense to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

