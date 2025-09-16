Return-Path: <linux-pci+bounces-36234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766D8B59003
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2301BC282A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38127C872;
	Tue, 16 Sep 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX0tUzYc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FB21771B;
	Tue, 16 Sep 2025 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010040; cv=none; b=SF4hR0lvx5CMGppj90Oa7IHkjTEfJ+PTizLJ83gn8A9ysU+DUlRa0ntgGbO+beMsgzS00SUU69Mn2DNUi94/Vn5pRpTxhJ8rWdcEwZazURGdy3s1bCX2p7OPrRouUy7WgkJI6GuB0vONy2mY6BgHf44sBWr8igxl2jhfre9Seqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010040; c=relaxed/simple;
	bh=Y8J/F7oKrl3zjCh+oB+s8eg1WIz+389ZWBoMt2NLWbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dY9Ci2S4KlVaRChI2E80hIH8EhTrpgG1FrlYZUY6IAEzDooNo3rRmbiRHXBvK8xawNthFIu/Rv/S9xY73eXpzei3jD/iIp98VDnDSDecVjdnI8PPtY/8mQ6jVYxItHH47b9PdkIRL2uOxeD3HAJ92DZxKP9e16UpydNd1ub8q+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX0tUzYc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758010038; x=1789546038;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Y8J/F7oKrl3zjCh+oB+s8eg1WIz+389ZWBoMt2NLWbc=;
  b=cX0tUzYc03KQe89oXhg/IHQj3nVapsc3yB7A0FetPr1QMYKmFyPjNBIg
   yG1m51yDsJQ8JrxcQKiALq24aaPMUeWxt+LacR/D2YH6yEDcxyBxzWEmM
   izVoNdDdweU9R0kByGY/S+fMmLDB6N0cFbwgrn9RHhCSuPcZz+U6aa86p
   84kByyQ5+q5melLREKdRKpowD2QUV3qsBRNwpOVCih5FFKR9Mrqeyw1c0
   nQChshten2oKEuWL/SFD6vG1IEWmxt71zAOie+Z+q4h8i0UBZX0d75e6r
   i0vxKQ3NWcA4JyLJnfgejUKOkdiVBgf/8o9q09kFaB3nEEhAG4JuHCvkk
   w==;
X-CSE-ConnectionGUID: P4zZmfsGTB+Xt1uR5+zWVQ==
X-CSE-MsgGUID: 4R4oHyf8RTmhA+6yhN3iRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59326753"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="59326753"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 01:07:17 -0700
X-CSE-ConnectionGUID: JyflTA6ySzGmtCMp5c36wg==
X-CSE-MsgGUID: bcQf46JZTxGbHCsvp5kmDQ==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.81])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 01:07:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Christian
 =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona
 Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 ?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <mjruhl@habana.ai>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/11] PCI: Add pci_rebar_size_supported() helper
In-Reply-To: <cduh4ave3lbdgd2kutfhgf3obf3wuskgxf6rrhggsiksw7wrwa@lqly5npj5g3r>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
 <20250915091358.9203-6-ilpo.jarvinen@linux.intel.com>
 <cduh4ave3lbdgd2kutfhgf3obf3wuskgxf6rrhggsiksw7wrwa@lqly5npj5g3r>
Date: Tue, 16 Sep 2025 11:07:07 +0300
Message-ID: <eb0bbfbcb963174bbb625268b0e5385deb8a2c62@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 15 Sep 2025, Andi Shyti <andi.shyti@kernel.org> wrote:
> Hi Ilpo,
>
>> +/**
>> + * pci_rebar_size_supported - check if size is supported for BAR
>> + * @pdev: PCI device
>> + * @bar: BAR to check
>> + * @size: size as defined in the PCIe spec (0=1MB, 31=128TB)
>> + *
>> + * Return: %true if @bar is resizable and @size is a supported, otherwise
>> + *	   %false.
>> + */
>> +bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
>> +{
>> +	u64 sizes = pci_rebar_get_possible_sizes(pdev, bar);
>> +
>> +	return BIT(size) & sizes;
>
> I would return here "!!(BIT(size) & sizes)", but it doesn't
> really matter.

If the patch had that, I'd ask to drop the superfluous negations and
parens...

BR,
Jani.

>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
>
> Andi

-- 
Jani Nikula, Intel

