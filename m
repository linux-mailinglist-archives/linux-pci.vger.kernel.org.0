Return-Path: <linux-pci+bounces-2049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094AD82AD5C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 12:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996362894F5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2D14F95;
	Thu, 11 Jan 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYA+flOV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA215483
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704972460; x=1736508460;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xXWmYVlMtjwPyMl92YjMvCtv+wmiTuFQ9doXpCwoEgY=;
  b=hYA+flOV/PDfuRdIBFhQd2dU0EFqrSeqCDTEb1LSRgKaTg8ZJmQQhJlC
   IYKJ5yObqp1FRJchCIjyRWRvm1c9b38QsD0TJzTCxBNABmIkh+9RYwDsq
   BkeC1B728+Jn+nEPku8S4AwEbT/KjEwMQ0lTEaxxoO9sAOD/dn/xGiKQL
   fV246eRPnWnOyDBS8ERXwOHLpx+GmWHTcYX2gh2OO6OtZgu78ZcrjaSgj
   16zqtBo4f64j7SiVrMW3z5qVIxiIaFerLmaRbWPpUNA7KchOu86WpLspx
   oqmtyK9Gs2yqbrXfucpnt3fuTAPQaF3ZAAAivItKP2c4L+8d0zy/CBtsS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="398509430"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="398509430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="30968971"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 03:27:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jan 2024 13:27:25 +0200 (EET)
To: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com, 
    chao.p.peng@intel.com, erwin.tsaur@intel.com, feiting.wanyan@intel.com, 
    qingshun.wang@intel.com, Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 1/4] pci/aer: Store more information in aer_err_info
In-Reply-To: <20240111073227.31488-2-qingshun.wang@linux.intel.com>
Message-ID: <d580ebc1-2581-c1d9-b37f-dbe8595a1ebf@linux.intel.com>
References: <20240111073227.31488-1-qingshun.wang@linux.intel.com> <20240111073227.31488-2-qingshun.wang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1098820707-1704972372=:1278"
Content-ID: <df33653e-cd3a-beb8-fce4-39bdbdec3d98@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1098820707-1704972372=:1278
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d496f3f2-5652-f9b9-dd57-fcce27e08506@linux.intel.com>

On Thu, 11 Jan 2024, Wang, Qingshun wrote:

> Store status and mask of both correctable and uncorrectable errors in
> aer_err_info. Severity of uncorrectable errors and the values of Device
> Status register is also recorded in order to filter out errors that
> cannot cause Advisory Non-Fatal error.
>=20
> Refactor rest of the code to use cor/uncor_status and cor/uncor_mask
> fields instead of status and mask fields.
>=20
> Reviewed-by: "Andy Shevchenko" <andriy.shevchenko@intel.com>
> Reviewed-by: "Luck, Tony" <tony.luck@intel.com>
> Reviewed-by: "Ilpo J=E4rvinen" <ilpo.jarvinen@linux.intel.com>

Hi,

I don't recall giving my tag for this. You are not allowed to make them up
unless the person explicitly gives that Reviewed-by line to you in one of=
=20
the replies. That is, please don't infer the Reviewed-by tag from just=20
replying.

--=20
 i.
--8323328-1098820707-1704972372=:1278--

