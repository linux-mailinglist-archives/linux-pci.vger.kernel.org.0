Return-Path: <linux-pci+bounces-482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B9804F9C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 10:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D52816BA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56933FB13;
	Tue,  5 Dec 2023 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3bpxyhK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C135A0
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 01:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701770372; x=1733306372;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TmjliKzVz3Gdyhc9xRdc5jhLWMlIMABKsV+w52WAEho=;
  b=a3bpxyhKwrsq4M8kL+UOKCWaq55QqcfhdIYVGzLpHc9YmIG2H5VF53eS
   eW/t6PP5tggyDJvGgzka+vpJsSCKURXer9amLRmgvDsifEMw/TO1OW56j
   YzFu8/X9fsMeLkjvbqPORb+qxOdjWfv0ktNpjbD663/OiumQf3B3+P9wW
   TNmKXCkq1f/Y1Sjl3oeXhWvzFbn+YEka0vaOlULsJ34uup1dyIiGRttjf
   NbXtqFOx872JRrPaP6tJsNWyBvGvpqu9iGI1zkTrbpmXrC9wk5MDNBFLf
   JyYDo4KyZxSvB/B39R4Lstc/s0I7cuh59xi95JyUtmHX27hnGMvgsaZum
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="753267"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="753267"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="894320489"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="894320489"
Received: from nlawless-mobl.ger.corp.intel.com ([10.252.61.141])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:59:27 -0800
Date: Tue, 5 Dec 2023 11:59:21 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, jdmason@kudzu.us, 
    dave.jiang@intel.com, allenbh@gmail.com, lpieralisi@kernel.org, 
    kw@linux.com, mani@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
    yangyingliang@huawei.com
Subject: Re: [PATCH 1/2] NTB: fix possible name leak in
 ntb_register_device()
In-Reply-To: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>
Message-ID: <ffce9b96-09d-657-37c6-8181d929221@linux.intel.com>
References: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1953797933-1701770370=:1829"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1953797933-1701770370=:1829
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 1 Dec 2023, Yang Yingliang wrote:

> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> If device_register() returns error in ntb_register_device(),
> the name allocated by dev_set_name() need be freed. As comment
> of device_register() says, it should use put_device() to give
> up the reference in the error path. So fix this by calling
> put_device(), then the name can be freed in kobject_cleanup().
> 
> Remove the outside put_device() in pci_vntb_probe() and return
> the error code.
> 
> Fixes: a1bd3baeb2f1 ("NTB: Add NTB hardware abstraction layer")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1953797933-1701770370=:1829--

