Return-Path: <linux-pci+bounces-3429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1559854325
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 07:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1892819C7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 06:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886D111A0;
	Wed, 14 Feb 2024 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWbPeKK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2A1119C;
	Wed, 14 Feb 2024 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893956; cv=none; b=iBLBr7YbPeERzOSJ5aTGoofATEh7Mg5sQfIZRNvMSBQddvbqQCchXSK5ddaboHamOLj2yNBcu1r3AsNR4eLPaUuSE8RkHFl7uVonmhMpiQ6nRyOTRhEwKqaK7JhDiKh1J5WobZ5FSMJ4G8UsXSDUjCbnPOzJj+TVpKUDLcyZm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893956; c=relaxed/simple;
	bh=NFdrGOtMllbEA7m7PeDgmPLNj3yRtazcQgFg1SMEcSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uI8jjXfyJNYzT3dJgyoU5F40ly7Ie5adWW78s1a0Hsf6vsmPjlcZ0658gK8pATzHQGQ41f33MKeuhj4ec1dsuXINfDSKuNzzONY7CSWRj+NW0PZTEjkWHg0NZP5a9ZXTYgCtnGdqD7jWHlwXc7nu0h5wFDaNSaJQQyLkFrQimdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWbPeKK0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707893955; x=1739429955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NFdrGOtMllbEA7m7PeDgmPLNj3yRtazcQgFg1SMEcSE=;
  b=gWbPeKK0X9rz/xB/iRb0WZAlyN08dVOMUTEx4W83PuyRyAPemyyuLehV
   IJRcaSFP8mDp+4G1L0ntg8caj8idyLG9ldtJh3Arnc08oyZUkSdeCVLXw
   ghLmjrj8RcNJIr66APnYItn/sVDnjQQqJ6YqvoSBiRSgK5Pjh/HyLUKZx
   Wlljiwjp9zxsrmXym+iZ7QD9oYWbk1QzqoHU5/8wcYzneA75VsSosekRJ
   9M5VtFwr1ET8xtg5sDaIgzMBRm1/ThfuhpzzsH5jJJORmuU/csId/gbNd
   XKQEu1ttL775igfXmAmif38//F/bSoXMk9JljzSZM1RPLmkLaSvz1nJfy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12646627"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="12646627"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 22:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3429746"
Received: from jhogande-desk.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orviesa007.jf.intel.com with ESMTP; 13 Feb 2024 22:58:50 -0800
Message-ID: <93c77778-fbdc-4345-be8b-04959d1ce929@linux.intel.com>
Date: Wed, 14 Feb 2024 08:58:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com, stanislaw.gruszka@linux.intel.com,
 lukas@wunner.de, rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
References: <20240213200648.GA1219964@bhelgaas>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240213200648.GA1219964@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 2/13/24 22:06, Bjorn Helgaas wrote:
>> Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Sounds like this resolves a problem report?  Is there a URL we can
> cite?  If not, at least a mention of what the user-visible problem is?
> 
>  From the c5eb1190074c commit log, it sounds like maybe this allows
> devices to be autosuspended when they previously could not be?
> 
> Possibly this should have "Fixes: c5eb1190074c ("PCI / PM: Allow
> runtime PM without callback functions")" since it sounds like it goes
> with it?
> 
I don't think there's known regression but my above commit wasn't 
complete. Autosuspending works without runtime PM callback as long as 
the driver has the PM callbacks structure set.

For example the drivers/i2c/busses/i2c-i801.c has system suspend/resume 
callbacks. I tested this patch by hack-removing them and yes, 
autosuspend doesn't work without this patch.

Raag and Mika noticed the issue when cleaning up empty runtime PM 
callbacks from an another driver which doesn't have any other PM callbacks.


