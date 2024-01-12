Return-Path: <linux-pci+bounces-2077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75482B9F2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 04:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85801F2348A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 03:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C801A5B0;
	Fri, 12 Jan 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsiCm5yz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349351B27B
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705029818; x=1736565818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7PJpDzLlWyxULrhm+ixsbgxlpZQwAMj9T31M47zxcDA=;
  b=bsiCm5yzT62pgtnTysFek6Qipf4V5yJCeT48BYAfNbTSjtE9JT8jhqOK
   NsH5/j32Ov5CfsQC9NTxC5wD/8OBhzffS7SwZF3UNUeUJup+SVT6cPZem
   k99mZl/XkWZEHnpO7bqsUrJBoGDntdyBt6oRidPtWfg0a1IRdCFxhCsto
   ANOGQLr/EP3TUApvp7n7IPuPp51M/a8fYHg9i14JbK0LXCx/metF7RDZV
   TVRHUdEVgev2JkNCjqhbcjmxSPPENNsqWl1Yz6Dsw+DGZEt2S5/bA55ib
   lN4MsExyTI3IMoczf2EYtztYIrzMpt4e72XFULU+FHDHbslyIpgjKbI6i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="397949457"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="397949457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 19:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="732455870"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="732455870"
Received: from xliu8-mobl.ccr.corp.intel.com (HELO localhost) ([10.255.31.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 19:23:35 -0800
Date: Fri, 12 Jan 2024 11:23:27 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: chao.p.peng@linux.intel.com, chao.p.peng@intel.com, 
	erwin.tsaur@intel.com, feiting.wanyan@intel.com, qingshun.wang@intel.com
Subject: Re: [PATCH 0/4] pci/aer: Handle Advisory Non-Fatal properly
Message-ID: <sesdwoifeewv6usggxabbrp5qea43xjtp33rje3gs43hfpytaz@4cvtqv2lowvz>
References: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073227.31488-1-qingshun.wang@linux.intel.com>

Hi,
Please ignore the Reivewed-by tags in this patch series, they were added
by mistake.

Best regards,
Wang, Qingshun

