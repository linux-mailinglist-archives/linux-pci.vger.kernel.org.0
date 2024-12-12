Return-Path: <linux-pci+bounces-18233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE29E9EE1E1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BCA284041
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA031209F41;
	Thu, 12 Dec 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY2/vfQU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D58148FED
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993542; cv=none; b=SaBBRhXLC9FlURDVGliaGk1omP8c508EgGE9xxiID1qEdQD27o4UE959OTNAizBSM+xgcXbaSKlz2fwmTwUbybIoDjNs0O+qbWg0mRGY6fyWaluhuiUQylzX3PmEOT2p+/iuqKc8mwagFVuCRUkgesmIdT2zvhlk7StPlQK59j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993542; c=relaxed/simple;
	bh=LTBq6bEdUNahnJofp8NyH1AeRgYZOHGkjU9xmnhh+Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgkxqlYtttKGee1vBjuXBgD3kRvM2yEA97FZzIHY7Vz0wrMc17OY9+L/NZCcBA3QFtnYmlQWfABaSF7mAXXqsVb5Xv28jxTmhdGy3T80mdpXBZnnhiuSsvDkxVVjCD+gmyzLAQKe3oRagbDxPhe4LrvH5pcdNe/H5dhslQ/WmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY2/vfQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E59C4CED1;
	Thu, 12 Dec 2024 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993542;
	bh=LTBq6bEdUNahnJofp8NyH1AeRgYZOHGkjU9xmnhh+Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NY2/vfQUWJY7stQ+/sX+0FxcI1Ec4BruWZLRav8OcQzMYdGPlmD2Hqdi5Sbh02DF5
	 9/QxpEYvHh4yiUVat94pjPGCNtaENDhRDhhIWp8YUhI1XQdYbgQL/xtBM17Mk7wk8Y
	 YdUbxIeXnfa2WPPk6LrjMNjQeEP3NCIQK7nEZiw8iMRkTqZOQimxfGx6U8d0wKoleu
	 cxOESEQGbC0zjdZlWo1EMRhL9DPArEQVcvUziCBGda7sphGbw66dsBeQJzDxOTob0n
	 jwXfocKhm2RcLf4nUHhDzWyxmI6OVscVUZbReIHKjICTS2rc7PozrOOvjHlBWb0Vll
	 esephjz962Tsw==
Date: Thu, 12 Dec 2024 09:52:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <Z1qkQaVPMVz3vtmj@ryzen>
References: <20241203063851.695733-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203063851.695733-4-cassel@kernel.org>

On Tue, Dec 03, 2024 at 07:38:52AM +0100, Niklas Cassel wrote:
> Hello all,
> 
> The pci-epf-test driver recently moved to the pci_epc_mem_map() API.
> This API call handle unaligned addresses seamlessly, if the EPC driver
> being used has implemented the .align_addr callback.
> 
> This means that pci-epf-test no longer need any special padding to the
> buffers that is allocated on the host side. (This was only done in order
> to satisfy the EPC's alignment requirements.)
> 
> In fact, to test that the pci_epc_mem_map() API is working as intended,
> it is important that the host side does not only provide buffers that
> are nicely aligned.
> 
> However, since not all EPC drivers have implemented the .align_addr
> callback, add support for capabilities in pci-epf-test, and if the
> EPC driver implements the .align_addr callback, set a new
> CAP_UNALIGNED_ACCESS capability. If CAP_UNALIGNED_ACCESS is set, do not
> allocate overly sized buffers on the host side.
> 
> For EPC drivers that have not implemented the .align_addr callback, this
> series will not introduce any functional changes.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Changes since v2:
> -Picked up tags
> -Changed debug print to dump the CAPS register instead of having a print
>  per capability.
> 
> 
> Niklas Cassel (2):
>   PCI: endpoint: pci-epf-test: Add support for capabilities
>   misc: pci_endpoint_test: Add support for capabilities
> 
>  drivers/misc/pci_endpoint_test.c              | 19 +++++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> -- 
> 2.47.1
> 

Since this series has two R-b tags on both patches in the series,
any chance of getting this series picked up?


Kind regards,
Niklas

