Return-Path: <linux-pci+bounces-12840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F596DDF8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB341F2299F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAF19D89E;
	Thu,  5 Sep 2024 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTxpR8Vu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F28194AC7;
	Thu,  5 Sep 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549770; cv=none; b=WUyiruQS/C09UUmoyNVF77oHqfOR0sjb/xLkw1sIfmJZRBaMUzFO9hKcSVwQim7sShMGgsl2bnOJKUETWOkLpTcLEAPCaKfbPFCKNViA4wYqO4G3aEYbFA8OEO65ii4B0h5dUeXidFWKlwBYHM4umSvTVCJL8vIr685Kh5acfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549770; c=relaxed/simple;
	bh=3hpaZRK/ZZSFn7LzGeNNeWHg5Sy6bZhsK7TnJ4G1OaY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b1i2W5yBv4P6VtGNeo979R/MfjVow5eNCgtyfSQtX1/kLV6b3MbGkV/NzdYesPWkXQCuPlHz+FclRtgwtZzzytRCXrcwPU1ltrWx1RFVPMYIcGwNyt0j7+kjBbohXqAzU6Yn2NRF3gSsRGM2a5rOyDDBA46MasXPxl+PKI+XF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTxpR8Vu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549770; x=1757085770;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3hpaZRK/ZZSFn7LzGeNNeWHg5Sy6bZhsK7TnJ4G1OaY=;
  b=FTxpR8VuhsetPMLS5U/mzffjI04icn7YdUhAMwKJ69H+MzeMZwavgXib
   FhEBU1Ekc5sg4QDf7eQihwdYFtHC2uNhg13zIGBWhjFdv1I+l4uOOW8Ug
   Y7qEMVOvmdsBRUnbA5wl5iyaYFk9oBUKUPivZHvppeWxa0myu6Btvilh+
   8WpbFJhbUMNshAcMuomGLhxTzYtW/rT7kvUmUyLwfcNGGjFWRX16tIP26
   R0cCkGPSv6iGi87mKxwoBfkWdd5GrD9M+lOIQiDtkyONCyLMT22V4rwML
   hrTaImpQwiiq+9enoi+fxV4rm95i+zR/vujYf1j0/Hl5oRixhEdX8GDr1
   w==;
X-CSE-ConnectionGUID: UD0YTVajReaInRlqFbnQqA==
X-CSE-MsgGUID: 2U3+rILITjSpkKXzdjoe6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="34879316"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="34879316"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:22:49 -0700
X-CSE-ConnectionGUID: L7Bh2tysS1uSP32f+AazuQ==
X-CSE-MsgGUID: FNNThPIQTDKegB0POK+icA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70236666"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:22:49 -0700
Date: Thu, 5 Sep 2024 08:22:48 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
cc: Conor Dooley <conor@kernel.org>, lpieralisi@kernel.org, robh@kernel.org, 
    bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
    joyce.ooi@intel.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: altera: msi: Convert to YAML
In-Reply-To: <20240904161053.GH3032973@rocinante>
Message-ID: <e8a5522-de9b-68e8-a24-e07fc06d4944@linux.intel.com>
References: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com> <20240718-pounce-ferocity-d397d43e3a3f@spud> <20240904161053.GH3032973@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1679348232-1725549768=:3658588"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1679348232-1725549768=:3658588
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT



On Thu, 5 Sep 2024, Krzysztof Wilczyñski wrote:

> Hello,
>
> [...]
>>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    msi0: msi@ff200000 {
>>
>> nit: label is not used and should be dropped.
>
> Which bit specifically do you want amended?  I will do it on the branch so
> we merge the final version.
>
> 	Krzysztof
>
The label, "msi0: " should be removed.

Thanks,
Matthew
--8323329-1679348232-1725549768=:3658588--

