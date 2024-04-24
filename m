Return-Path: <linux-pci+bounces-6630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3C8B0C79
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF96285E8C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A715E7E2;
	Wed, 24 Apr 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Go2vKWSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880815E5DC;
	Wed, 24 Apr 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968912; cv=none; b=U+8Lppt3TVG9wIFIDLSaIu7w7vWD0q57tZX9k76Zu+fzFH+8uVNQTjqXzoEUH9SFjmW95mlH0GWzWMNqgPxbx6Fy7Hlej5NRJICRDgul7NDAShcCw8H34CiXc5AUm8sAXJtS9pl/etKPGN9UZqNnixI8HmyKZrjHZrLnOJUQrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968912; c=relaxed/simple;
	bh=ZGUBvVU+wUeold3VQ/v7Mrd2/TfD5M94jQA+X7DngOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCWNMOgpyew3p908D26irs6Ig07dzOKS40+GGa3vI6D+fx0wYJ5Sm76JQZccyHJXHJp4Sa4zlnvdtEhsMk4EKmoJ9hBT2hQovyB/ynmTBQsVoWonjg4Xn5/IkAOcsSTNFPjKSTzFwfASI6bjHDHJulTXIGnf2/Xmn1s9JBwN6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Go2vKWSe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713968911; x=1745504911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZGUBvVU+wUeold3VQ/v7Mrd2/TfD5M94jQA+X7DngOg=;
  b=Go2vKWSeungmNS2llwsqDKAFBmLRR3K2ZYLGC9jiiS2khVzOStQEtAg0
   /wm9fqLGBJuIsBwM5q1AnXaiOge6ZBAMsGLfoa3ijdp3o/6qUP0nIvqri
   LLmwnD0Uq/2QMibI5/bQqiT+TsQ5i3CWOo0hyJRtOrfST5eGb5nQjA6Vs
   G79hcCaaeUh67s6UJ5/31VY8f+RG948X6XyAud4G1lKPzw5zmiAr1VD9j
   7zKnTGyX1ndQNFgl3Q8NaNwaE/g8lqc8FzCpqp3Dqw834Rbrhr5YgfWNe
   IrniIRH+RvYqHo92qGU2hE03M9BuS+PeDdB8PwU1dfoWBP8HIZoWU06U9
   Q==;
X-CSE-ConnectionGUID: QZo0Ngn2TuqcWdJgVKp+vg==
X-CSE-MsgGUID: 94fFlIX1RAqDEgYASaq+7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20218493"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="20218493"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:28:31 -0700
X-CSE-ConnectionGUID: l5bvbc+iTUqK+RtYtKYzWQ==
X-CSE-MsgGUID: wDZhpXciQBqy7isSHuYenQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="25244369"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:28:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzdbk-00000000fuA-1MMn;
	Wed, 24 Apr 2024 17:28:24 +0300
Date: Wed, 24 Apr 2024 17:28:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: dra7xx: Add missing header inclusion
Message-ID: <ZikXCMgYaQn_DGXw@smile.fi.intel.com>
References: <20240423211817.3995488-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423211817.3995488-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 12:18:17AM +0300, Andy Shevchenko wrote:
> Driver is using chained_irq_*() APIs, add the respective inclusion.

This should be part of the series that I sent previously.
20240423172208.2723892-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



