Return-Path: <linux-pci+bounces-43002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC8CB9061
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 16:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7481C305A3E9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4191531F9;
	Fri, 12 Dec 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnze0ga7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F974A01
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551728; cv=none; b=WuT/dACkKnMb7Dr5pPcys9/feCmAAwiHLtoUanbCps2tGv9fRLYfPRH2MMuBdQjnK8Ohwlz/Oa1Di67CcD3mIh1ws1WWoX0hXw0EQrJigtOujA5wA+urB13cAjugddpgeLt1pYDmoR6top5/3namWqZ+OCHQ6cC2HYg2XmfTOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551728; c=relaxed/simple;
	bh=Yo4go21aI6itIYN+C2wnrM6uZ63GALuR+evn65hRgWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvIK0pBMzEtQ9aMbuS8JQuxDpbZjwwsK8WQxPPAnKAXXKDfyRBjyeBxl06qQkwzlOs7embsbwWPacCdJsT5L/0HWnLm42hcNxxC8guAg8bhfgNr70qo+gy16uWYyR1cKC9B5zD1pnGt48ui+FBzW9c1ccDflf1LeK/gSdc631Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnze0ga7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765551727; x=1797087727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yo4go21aI6itIYN+C2wnrM6uZ63GALuR+evn65hRgWE=;
  b=jnze0ga7RGWPowuiQAnt1KEYUfP8pP2ieBN+g38cdq8eEA1+qa8U4F2W
   7HDnuBuWJwRPMDuO7kCGTWfED8lMx98YbCHtQtWNdxZc7ySG3SpXwkAZa
   mXIZyPrSlof1CfvS4lkQzmwB/4VJkXjeUhRgbeYWBfRo0HZ2zoy67PviT
   F5Pq0Y5BDCQZSTVU7cxPmTgZrHfuQ+ZSAp67EjodhbOhGcsvvr531PCui
   kIHNTtkoz1FG9kbhPoGzth9B5Jw/rMa85AKMY+FSZm/8ATphsyNC49IdW
   l1ts3KOcUkxgdhyIlZZ9PRnlQcGHHp6gvqZMoMonJL2olH2idcMFLScGb
   g==;
X-CSE-ConnectionGUID: wNStKbprQQWecuL2mE6vrQ==
X-CSE-MsgGUID: PGCw7s9oQqCKNRbzb4QSKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="77869320"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="77869320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 07:02:06 -0800
X-CSE-ConnectionGUID: 1WMM752zQOWY3KU2slTxvQ==
X-CSE-MsgGUID: EjReHHOnSdeX6zAjKiT8bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="227776068"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 07:02:05 -0800
Date: Fri, 12 Dec 2025 17:02:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 1/2] PCI: Introduce named defines for pci rom
Message-ID: <aTwuatZYJEerx1cL@smile.fi.intel.com>
References: <20251212093711.36407-1-kanie@linux.alibaba.com>
 <20251212093711.36407-2-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212093711.36407-2-kanie@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 12, 2025 at 05:37:09PM +0800, Guixin Liu wrote:
> Convert the magic numbers associated with PCI ROM into named
> definitions. Some of these definitions will be used in the second
> fix patch.

Now this LGTM, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



