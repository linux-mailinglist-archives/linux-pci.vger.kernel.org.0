Return-Path: <linux-pci+bounces-1301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440FF81CAA6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 14:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03B21F217EA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A9179AE;
	Fri, 22 Dec 2023 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8poIc62"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1971A703;
	Fri, 22 Dec 2023 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703251595; x=1734787595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mxx4sDo6PcjDZ710oTvo2FogUJowOLkApKdPACWpUuY=;
  b=K8poIc62/g5eYVNzRZhyVaDgnIKAKOXYrQb2APdhuF9tmsTbpPyOTo2K
   BT+oBkJaCNt0Za/FpY4WwNOy61wVylOGc0vw5TP4hCkxFHb8w3d8OzVXv
   UmoI/pYLp7FOtKORptWlb9XqvTqR4+z46uDKKU5z4xS3YfblxCkgfVmOR
   LquKJZoqOQyDl9XNe91h5ZNen2ARSIvHw+qM+1B7lcbhhYvXYgfcBx8PY
   +R69vc0qnHf5mj1qmclD3+nnvlEIlRCb3sCh8t1wXm4TQUymJ1m2WF/IE
   UPAh7BfJrpCOGEamS/pwAT9/YO/RFZKlAbDNOUVjxntfEpVll4UY/5SDu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="398900513"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="398900513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:26:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726787891"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="726787891"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:26:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGfXo-000000089yW-0mC7;
	Fri, 22 Dec 2023 15:26:28 +0200
Date: Fri, 22 Dec 2023 15:26:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] resource: Rename find_resource() to
 find_empty_resource_slot()
Message-ID: <ZYWOgwdJDCWkTAtO@smile.fi.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
 <20231222122901.49538-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231222122901.49538-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 02:28:56PM +0200, Ilpo Järvinen wrote:
> Rename find_resource() to find_empty_resource_slot() to better describe
> what the functions does. This is a preparation for exposing it beyond
> resource.c which is needed by PCI core. Also rename the __ variant to
> match the names.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



