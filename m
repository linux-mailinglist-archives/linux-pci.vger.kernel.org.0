Return-Path: <linux-pci+bounces-9609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE89248B9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 22:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AA81F22E97
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5411BA879;
	Tue,  2 Jul 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5IP6eEV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE261A28C;
	Tue,  2 Jul 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950596; cv=none; b=Ip2FWlYwnv0SXPN99NPbk6UBc62O7/uPgj5rJRQ96AWMYbcnVUzQHNK6cyWe7i08ZlOww3MmptaH/zOcrLcuzJeGn4qhgbTJ2OAGv473/GRK4hhas9cirRliu1MvKBO3UM8p8pteLc45ZlKZU7jRBPaiV7Tx/J9jfmStnYayLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950596; c=relaxed/simple;
	bh=ekl6mRzAwQ942emzj+MLTEaDcCvx+v/IdHHZ6sBbaJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJhtjRZHWGvXq+6uIjH8McOgv0+DQgDWqVV2jrmkvf7EUnadEdhz5g9NV0W/t98SzDnaFA1+aqnUsXz5HiEp0ZaJcEkhY7+7ycreJ0K0dxaCSoZlON6+MZVy6X3/4EaxA7560qEN8BwaWVXKebvsEl54+HxW8BYcdVRRkX8+PrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5IP6eEV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719950595; x=1751486595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ekl6mRzAwQ942emzj+MLTEaDcCvx+v/IdHHZ6sBbaJs=;
  b=K5IP6eEVmX7znG8lqosvNFG1jDUcsDdFPiz7TizFO9B0RSgN368sGMpf
   ODdi9y+3Oe649PMIekQby9Y7niMg0u5AmNPKJgLBy6cHNGQ8PyEuegND5
   uJzMTPylrWVHwJKzbbo1tkbXP3428QeMT2+11Lk61dKjl0X2In0AC8lSF
   wdlfBW7rvy0nERQssUyZhRqdzYQaIDYjf1+wg6XWHDG0OOtT+ev2Y40Di
   IDukRdb/G9y6bP/+tMSjRmXsSKgcsaEfAV/ZF+A+XEwJtJpCT+pT+Mb4F
   5HWVYGfkGeLI+mx09j4pqJuLsx1htfYjaUibDEvcleFi8ic7X+c8GFkAg
   A==;
X-CSE-ConnectionGUID: 8M7bwJ3hQcOUWGsupL4b6Q==
X-CSE-MsgGUID: uZePEOTsReSv1T7TnoDvVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17285711"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17285711"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 13:03:14 -0700
X-CSE-ConnectionGUID: oSb6XTfARQWTS4aqULYCpA==
X-CSE-MsgGUID: 7PKNMjRfQPa0szHXknFAUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="83562899"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.143]) ([10.125.111.143])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 13:03:14 -0700
Message-ID: <176fa351-1922-4e62-a1bd-c620d97b955f@intel.com>
Date: Tue, 2 Jul 2024 13:03:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] cxl: Region bandwidth calculation for targets with
 shared upstream link
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240702164718.GA24910@bhelgaas>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240702164718.GA24910@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/24 9:47 AM, Bjorn Helgaas wrote:
> On Mon, Jul 01, 2024 at 02:49:13PM -0700, Dave Jiang wrote:
>> v6:
>> - Update kdoc in comments. (Ira)
>> - Various rearranging and cleanup of variable declarations. (Jonathan)
> 
> Housekeeping nit: it's helpful to include the diffstat in the cover
> letter so I can tell whether I need to look at this, e.g., does it
> affect the subsystem I worry about?  Also nice to have URLs and the
> brief changelog for previous versions.
> 
Thanks Bjorn. Will do. stgit email used to include the diff stat. Not sure why they dropped the diff stats addition when they went to rust from python. 

