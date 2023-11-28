Return-Path: <linux-pci+bounces-221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB27FB81C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 11:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45EB1F20F5F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4A18C08;
	Tue, 28 Nov 2023 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLWn5U/5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB44182;
	Tue, 28 Nov 2023 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701167949; x=1732703949;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MXwHFEX9kq9p9CKpYfhWlu3F+DrEniFzh7s8EukFtrw=;
  b=JLWn5U/5nrgCEUJm+hT+CdPXdkQ+tnIqBcPSAKsZK4U/ep3PrdY7f2ZZ
   uV5tB1AFV6v1xYeY4kzrLiYAXzsZ9jbRw+dRHO0Kvrp/+09KmT1hRbiFb
   vgOMs4ds2j2Fz40t1UHPLD0w9jWLYg8eDXi/rAGDQ1Uu12BFTmld5j8f+
   QezsABJISwpkxko0Or2cyuGvPEcifd1l6H5SKpKX7Z8/WVmL+D40RPJr6
   FtEaYlF46ZREXXu42FuEveTruwopYJpT8pe/mBWU2LIMhsEcLo41UHa7J
   w0zvgVmtmB3jXD19Kily2j4SsGrOo/80MRe0NAxzrAAw9hUG+AoYrAN/H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="377923317"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="377923317"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="16898587"
Received: from mravivx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:39:05 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Vignesh Raman
 <vignesh.raman@collabora.com>,  "David E. Box"
 <david.e.box@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: daniels@collabora.com, linux-pci@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, helen.koike@collabora.com
Subject: Re: [PATCH] PCI: qcom: Fix compile error
In-Reply-To: <20231128065104.GK3088@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
 <20231128051456.GA3088@thinkpad>
 <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>
 <20231128065104.GK3088@thinkpad>
Date: Tue, 28 Nov 2023 12:39:02 +0200
Message-ID: <87a5qy88mx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 28 Nov 2023, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> On Tue, Nov 28, 2023 at 11:44:26AM +0530, Vignesh Raman wrote:
>> Hi Mani,
>> 
>> On 28/11/23 10:44, Manivannan Sadhasivam wrote:
>> > On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
>> > > Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
>> > > to acquire bus lock") has added an argument to acquire bus lock
>> > > in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
>> > > without this argument, resulting in below build error.
>> > > 
>> > 
>> > Where do you see this error? That patch is not even merged. Looks like you are
>> > sending the patch against some downstream tree.
>> 
>> I got this error with drm-tip - git://anongit.freedesktop.org/drm-tip
>> 
>> This commit is merged in drm-intel/topic/core-for-CI -
>> https://cgit.freedesktop.org/drm-intel/log/?h=topic/core-for-CI
>> 
>
> Okay. Since this patch is just for CI, please do not CC linux-pci as it causes
> confusion.

Agreed. More on-topic for linux-pci is what happened with [1].

We've been running CI with that for months now to avoid lockdep splats,
and it's obviously in everyone's best interest to get a fix upstream.

David, Bjorn?


BR,
Jani.


[1] https://lore.kernel.org/all/20230321233849.3408339-1-david.e.box@linux.intel.com/




>
> - Mani
>
>> Regards,
>> Vignesh

-- 
Jani Nikula, Intel

