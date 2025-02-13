Return-Path: <linux-pci+bounces-21396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F68A351B9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF14A3A47B2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14492753EA;
	Thu, 13 Feb 2025 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvgwKNKp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541D2753EB
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487512; cv=none; b=iLEmddNnELsMKawGUX+4W5ivu80yuNgwvRQRW8L5do02GoX1AjdRKkw6n62vfucaESNS0wPSHMfvzWDJOmPQYNeQJ2jG+JwVniLp45a0IRtyx2nK5BRd6HbpguzJud4mPVUUyBujCHIeNmEbYGx/98Y+tu4b/6oYl1ukNVlPm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487512; c=relaxed/simple;
	bh=7dUyap4nhVN6BUSdVn02soddgeeDD0dWXxxKK4loDXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrbI9NkbuskrA7g3MBCikfXE+kxLhjSLElVg4An7u3uLJ23haV103DWhTf8q4Ns2Jgrg1c4O6s+fKCh7lZ40oJY+0E3GSYw3Ke/Msc5Yxy6Mmo/Goj/8sE/jsEL7h6CpchtJeVbO8MnY3gFf/iMKxeK5sQ33wXao7MkNVVOPOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvgwKNKp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739487511; x=1771023511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7dUyap4nhVN6BUSdVn02soddgeeDD0dWXxxKK4loDXg=;
  b=LvgwKNKpEuS1qCjRacBMbp+G1v37/fnrcK5471D3pkuAB1ZgKUU3JVPf
   4CPFYyFReP2JKVTU98wlmtgNjGnsBUZnkYnQiFhWMpYbVUW6jMCzBFPua
   HSZkCWETzgG11bF4WqWtvn59fINQ49w+ARSA6ivWewmJuZYhP58yITmzX
   F8pH/6DhWxl9pWERuP268P7t8oicMklq1rdx+z62q+PkWeJFSL7E8y78h
   b7sYiMe4tRmEiHyF3kzebUSoH8sDF4dytCwBKJ2McgCKoI1yMeNJRw/MQ
   HJGybkYpMVuyKhTXhw+JqFi+Saua0gCs7hxQirFsTlNd/BYNG8RUgLkHZ
   Q==;
X-CSE-ConnectionGUID: B8Fez8nvS0CXxhu3ApvVbQ==
X-CSE-MsgGUID: zUBGSm97Qlmnciu+6LJZMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51619685"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="51619685"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:58:30 -0800
X-CSE-ConnectionGUID: i+k3LtgHQ5CZyaHnK8WprA==
X-CSE-MsgGUID: PdrRFwlbSqGPT5rwGLz1kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136518225"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:58:30 -0800
Message-ID: <81285c34-1819-4a01-bd49-c9ab319f2609@intel.com>
Date: Thu, 13 Feb 2025 15:58:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ntb_hw_switchtec enable 256 LUTs
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
 kurt.schwemmer@microsemi.com, logang@deltatee.com
Cc: jdmason@kudzu.us, allenbh@gmail.com, linux-pci@vger.kernel.org,
 ntb@lists.linux.dev
References: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 3:53 PM, Maciej Grochowski wrote:
> Microchip NTB devices support up to 512 LUTs shared across all NT
> partitions. This short patch series increases MAX_MWS to 256 and also
> address issues when the number of mw is equal to 0 or MAX_MWS
> 
> Maciej Grochowski (3):
>   ntb: ntb_hw_switchtec: Fix shift-out-of-bounds for 0 mw lut
>   ntb: ntb_hw_switchtec: Fix array-index-out-of-bounds access
>   ntb: ntb_hw_switchtec: Increase MAX_MWS limit to 256
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
for the series

