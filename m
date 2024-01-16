Return-Path: <linux-pci+bounces-2198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E282EAEC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 09:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD331C20754
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB5311C83;
	Tue, 16 Jan 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDpzqoIU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AADC12E40
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705394144; x=1736930144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8383dYsXQex3W5WnF0ZGfgQPna6NHZRgLqC1Rl/DLCs=;
  b=GDpzqoIUHqZMSwJnm/iMa6qjvMHc52qfHkZEcwGPl6LgNcWWzIUtd2ST
   eaiNe8itST/GhKFxxLOcKlRCYMavx9GCqztGg/Mrv+ylmoZlV2W+pr1TZ
   ybCSMPYyyK3PCqZ+87Je6UcJ3oMeQrTacvIsYCL57Trb1eKYX4pdhr2xK
   X8sJ7Z+qVrDAKjMAIGZVL9oyVoniACPb2ldGehtGq4yuNqHF5SwzvydND
   CeOs9TeOKZfoI0u1K+kYN6bTB5Dx1mqmUqBb7W0hsDFJeHQ3iFnmW0l7n
   iamvRm4n+O4T9F4DTpK0g/AdXa+qPSjtH2PPL1eBvAj5BvVkVT3rV8p3s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="390243289"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="390243289"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="776955488"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="776955488"
Received: from mindai-mobl2.ccr.corp.intel.com (HELO localhost) ([10.255.31.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:35:41 -0800
Date: Tue, 16 Jan 2024 16:35:33 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com
Subject: Re: [PATCH 1/4] pci/aer: Store more information in aer_err_info
Message-ID: <r4tbuftq7j4b33yba3vsscqaappepjs6xebrf4sttudes2rskh@hsqgvj4yinhx>
References: <20240111073227.31488-2-qingshun.wang@linux.intel.com>
 <20240112163251.GA2271088@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112163251.GA2271088@bhelgaas>

On Fri, Jan 12, 2024 at 10:32:51AM -0600, Bjorn Helgaas wrote:
> Please update subject lines of all these patches to match the
> capitalization of drivers/pci/ history.
Sure, will do.
> 
> On Thu, Jan 11, 2024 at 03:32:16PM +0800, Wang, Qingshun wrote:
> > Store status and mask of both correctable and uncorrectable errors in
> > aer_err_info. Severity of uncorrectable errors and the values of Device
> > Status register is also recorded in order to filter out errors that
> > cannot cause Advisory Non-Fatal error.
> > 
> > Refactor rest of the code to use cor/uncor_status and cor/uncor_mask
> > fields instead of status and mask fields.
> 
> Can you say something here about the benefit of doing this?  This text
> essentially describes the code in English, but we can read the code.
> What we need here in the commit log is the *reason* for making this
> change.
Thanks for the advice, I will update the commit message like this:
    
    When Advisory Non-Fatal errors are raised, both correctable and
    uncorrectable error statuses will be set. The current kernel code cannot
    store both statuses at the same time, thus failing to handle ANFE properly.
    In addition, to avoid clearing UEs that are not ANFE by accident, UE
    severity and Device Status also need to be recorded: any fatal UE cannot
    be ANFE, and if Fatal/Non-Fatal Error Detected is set in Device Status, do
    not take any assumption and let UE handler to clear UE status.
    
    Store status and mask of both correctable and uncorrectable errors in
    aer_err_info. The severity of UEs and the values of the Device Status
    register are also recorded, which will be used to determine UEs that should
    be handled by the ANFE handler. Refactor the rest of the code to use
    cor/uncor_status and cor/uncor_mask fields instead of status and mask
    fields.
  
> 
> Bjorn

