Return-Path: <linux-pci+bounces-7160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F938BDFD2
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B78A28804F
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2C6F525;
	Tue,  7 May 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjm5bEU8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F57450E2;
	Tue,  7 May 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078226; cv=none; b=UXT903db4q0SXCZCOYdcROS+fQ5fdWNj++qFtcLJrC1cGWcC2TpBDbkvzXp99bZUEeZZS/xgEXVUgxgKlVVXX1jwjxNfHGRn3lRnvvSVaP12B+aVy7oTq8F+Qhy3QFyZkzKJy99uoc/Jw4eXEz0eO00Kqx1XQUSItRAHMMGcY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078226; c=relaxed/simple;
	bh=M2c72z9VDtx2Xhtw/P3InupAnKn0oF978VyL0WkulAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcYpcQz9WjT4t0AsRn3x676L1BbzwBUPsIGVK0hmPT14/i54zw3oUYKcujEyS8YKIDBWP/AE2Kza3hxuhiU+KGj+H6pJd5GIYj9ZE9YASYRErxdOB8lrbLmTO6c6HsxHmj1o3WUcNI9S/yIez7+9vErWMnPIz+aFLgoKrJlDGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjm5bEU8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715078222; x=1746614222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=M2c72z9VDtx2Xhtw/P3InupAnKn0oF978VyL0WkulAE=;
  b=hjm5bEU8eb+cMHnEE+BRFTmV+s9IsEWZFEQGSntBTCh/nA3gXf3dR0ew
   gIL+aBjrLrqfNt7TrNhnakX9kzi9JRbRNQCFErG3lnH9MsR70cquVG/33
   mgvwz8vhKrMydiPk2gq40GUxk0fWYJpP/Zz0pXgNxQnT2rhdWkNmhTuar
   gXhVGy+9m81HD+gV4An/4+YoVY+GW0s9djCw/35F0rpn7RFvtpPie2JC6
   923rYknN80p2Db25axX4bOWXOlf5giN3g8OVZ+UoQpwKXzN4eYL22/dFK
   i6+jJ2fl/FwsaocE2HOc5PigYgklMqXyS3d/SjPJoaD+TME8gLF1NJ+fB
   Q==;
X-CSE-ConnectionGUID: pGk/LiaJRHejpPOYkXTogQ==
X-CSE-MsgGUID: Jj06BBsvS4epfPfuZoIoEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11018774"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="11018774"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:37:01 -0700
X-CSE-ConnectionGUID: QviMUWFgQAir8cM99ZWv9A==
X-CSE-MsgGUID: RmBeIrrfQTqkxddJ4gbDVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="28455316"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 07 May 2024 03:36:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0228B27F; Tue, 07 May 2024 13:36:56 +0300 (EEST)
Date: Tue, 7 May 2024 13:36:56 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] PCI: Make minimum bridge window alignment
 reference more obvious
Message-ID: <20240507103656.GA4162345@black.fi.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
 <20240507102523.57320-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507102523.57320-8-ilpo.jarvinen@linux.intel.com>

On Tue, May 07, 2024 at 01:25:22PM +0300, Ilpo Järvinen wrote:
> Calculations related to bridge window size contain literal 20 that is
> the minimum alignment for a bridge window. Make the code more obvious
> by converting the literal 20 to __ffs(SZ_1MB).

I think that's SZ_1M not SZ_1MB :)

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Looks good, may be even add a #define for this but either way,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

