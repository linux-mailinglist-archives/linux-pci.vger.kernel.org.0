Return-Path: <linux-pci+bounces-24232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF8A6A877
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CB117A9BE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A66EEBA;
	Thu, 20 Mar 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHSoVI4Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E801DE8BE
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480597; cv=none; b=IrJ6QNGZHJrXsrq2IROffRTYfEfhR+RE7dBJFcLzQEvwZexktzP7PO6U0KhSefD6AWI7H7DcgHzHYYtJt5zkxVk5/pyLNm6Or0s0qSvAhWZgOA4cfiip1irkv9kfj3fdCASvHvQLYbr1wjAOH0ubW6ZBXqxJ95cO8aDB/yTtV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480597; c=relaxed/simple;
	bh=ga0ioJutrCyM1224HqGTkzVFXB4EGNrTfuppzwfy9gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mecweJ01261vZ1RjewHBtAeM8Vf//nJvHFUD/RfdibWqVTwvV6edhu58mc+lhXVzS3qgW7HRz3iRLiv++/n3ZkrV8fz4lm1CA6BHSbVJfTPtHmzC8YX08heI+LrRWUd4hTMMwoTj/dcCxRmEHA5nBdAppP9ZuM0hNgZQxZTARXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHSoVI4Z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742480596; x=1774016596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ga0ioJutrCyM1224HqGTkzVFXB4EGNrTfuppzwfy9gw=;
  b=DHSoVI4Z4UhLTiP5lI/GSjryfzl7FxybClDEOIJc322wj6+wuowzRQ07
   KrZcjMewy5qlNwZmsX7gyrVNL08UDAPVYv3Xnbw/H9Zdll+4EVE60HR5b
   JzrUjmtEZy8qotvtEFBoczQC1f8ogJYDHqeoDw0WQyodb8POz4kfH2ulc
   TShckgZkG1QJbE5yuasdaVe1MZE2IV4JBCBYHJ3az/JQE0xzrNbgzXmk6
   mlxYSVzQMnxgTR0BTmr2TgcT0utq7KH5JUfZw2ftjQnY4kDV0mfTrXfqg
   qalXy+SDhqjxVBC6lqyJU95wPnW5viu5uuBtiR4VIeAZ9UtJSfwTDmdYy
   Q==;
X-CSE-ConnectionGUID: a/T0TAL4QYKJ3yO0Wv0bhA==
X-CSE-MsgGUID: /Y8GU0D3R2SUuGTMD6kdwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="53932788"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="53932788"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:23:15 -0700
X-CSE-ConnectionGUID: b8hAtSOBSXScnURgx4OyNg==
X-CSE-MsgGUID: NfgsXmLHSfiI9I7UqEEPdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123864182"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO [10.124.221.27]) ([10.124.221.27])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:23:14 -0700
Message-ID: <35a6ab6b-209c-46bc-ad6a-d4a1b4f76bb1@linux.intel.com>
Date: Thu, 20 Mar 2025 07:23:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>, linux-pci@vger.kernel.org,
 Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250319084050.366718-1-pandoh@google.com>
 <20250319084050.366718-3-pandoh@google.com>
 <79f4ddd5-af44-4fc9-9f04-4e79f66db21e@linux.intel.com>
 <CAMC_AXX11GcfbOyp4HXaA_9MmzfKPyPFtA470-aCdMqC7zanVA@mail.gmail.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAMC_AXX11GcfbOyp4HXaA_9MmzfKPyPFtA470-aCdMqC7zanVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/20/25 1:27 AM, Jon Pan-Doh wrote:
> On Wed, Mar 19, 2025 at 7:39 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Since the original patch from Ilpo is not yet merged, may be it
>> worth considering add this change part of the same patch.
> Which patch are you referring to?

https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=aer&id=fab874e12593b68f9a7fcb1a31a7dcf4829e88f7

>
> Thanks,
> Jon
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


