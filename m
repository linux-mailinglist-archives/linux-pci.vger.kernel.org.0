Return-Path: <linux-pci+bounces-2076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BF82B9EE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 04:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA121F21200
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 03:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365211A5A4;
	Fri, 12 Jan 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emBz+nOb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508281A5AE
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705029672; x=1736565672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H0Rek8aNOSjKplX9S/q8WY7qJ1sXzAjb+oQyvHTG58A=;
  b=emBz+nObAF0Ex+0TlTZEd/GWBee8mM9ASM0XeRxTyRQKscTaBZcQ2AXV
   0xkeTSSEKD7XofKf0J7mt1H14SKs5uIivEQXeDQRJcxDLGj4AccxrUJxs
   arBkK9v8OrvEZXLg/fYtuPK0Px0wl3TnrwEE8B1J0WsOz0Gt6439dSO34
   /vhPzTgJNOitRFPTfQt5IJOX3EnJjd5DFoaugwXZhcavEnGUM8CP/xnz+
   gDUz1AnzJzRbuT3ewnFVJq8y7/bLe7u2ZE4igZbpYbSZsZdRVZtSi7ZJ+
   qopa0vwbHVfRF6mtMsEgAM7xbGSFvsWGz/IeSx7mWNT/8hlrcVUQ9Eb32
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="465455854"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="465455854"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 19:21:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="873247255"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="873247255"
Received: from xliu8-mobl.ccr.corp.intel.com (HELO localhost) ([10.255.31.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 19:21:08 -0800
Date: Fri, 12 Jan 2024 11:21:02 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com, 
	chao.p.peng@intel.com, erwin.tsaur@intel.com, feiting.wanyan@intel.com, 
	qingshun.wang@intel.com, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	"Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 1/4] pci/aer: Store more information in aer_err_info
Message-ID: <r7i7msrz74qtoavvvobem4uklju6nchof3b5qegiwyothnvjpz@kxnpw3shsk6p>
References: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
 <20240111073227.31488-2-qingshun.wang@linux.intel.com>
 <d580ebc1-2581-c1d9-b37f-dbe8595a1ebf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d580ebc1-2581-c1d9-b37f-dbe8595a1ebf@linux.intel.com>

On Thu, Jan 11, 2024 at 01:27:25PM +0200, Ilpo Järvinen wrote:
> On Thu, 11 Jan 2024, Wang, Qingshun wrote:
> 
> > Store status and mask of both correctable and uncorrectable errors in
> > aer_err_info. Severity of uncorrectable errors and the values of Device
> > Status register is also recorded in order to filter out errors that
> > cannot cause Advisory Non-Fatal error.
> > 
> > Refactor rest of the code to use cor/uncor_status and cor/uncor_mask
> > fields instead of status and mask fields.
> > 
> > Reviewed-by: "Andy Shevchenko" <andriy.shevchenko@intel.com>
> > Reviewed-by: "Luck, Tony" <tony.luck@intel.com>
> > Reviewed-by: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> 
> Hi,
> 
> I don't recall giving my tag for this. You are not allowed to make them up
> unless the person explicitly gives that Reviewed-by line to you in one of 
> the replies. That is, please don't infer the Reviewed-by tag from just 
> replying.
> 
> -- 
>  i.

Hi,
I'm sorry about that, and apologies to anyone else whose tags were added by
mistake, I'll correct it.


Best regards,
Wang, Qingshun

