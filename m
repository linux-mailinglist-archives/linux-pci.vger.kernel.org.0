Return-Path: <linux-pci+bounces-42784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF58CAE015
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB5B93020CFF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422362C86D;
	Mon,  8 Dec 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOwaMTSB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB818C2C;
	Mon,  8 Dec 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219109; cv=none; b=Z7gOqcWPq3ajUpXltiJi4p6YBWuR2RgM+80NTftpV2h8MY0OcWQi1S2I7kyZqE+KuuWCyI3Oj/FQ/s15NhQb2Tmbzy5IL9HFgkAsubKmbmTnvJIbe6CjHaDqTdQSPY/oQJGy73iV0NBcoQ6H98GQeY+LHR5321ILy10q9q2X3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219109; c=relaxed/simple;
	bh=ydaXZ0ra8rkEeltRN93me3dxfoWL9lsW5ThJWQjlveg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sb47VJh+1vq+kLjRn1FguvqpsIrxghKZa+tzQHmMLMptSCZfHRfW5yjdzJ30tGXOtLlC+vaxhUigxDJVzeLiSEWx/n6tl5XK5GejNvJJRy5g2ugE/7gDndDpaDFHUa2kN5iew/RctpMMZisEyf7uJ5KGlhymHn48t2XIL1tzrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOwaMTSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1F2C4CEF1;
	Mon,  8 Dec 2025 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765219108;
	bh=ydaXZ0ra8rkEeltRN93me3dxfoWL9lsW5ThJWQjlveg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SOwaMTSBKAlrJ0yOjzj46ftmlRv8HbzvDyH0uk4GAYs0D0t9J0deWuG8S2sbIJpnx
	 jFuacSTgyDTqYiQKb2OFcf2NC5tlunD4w/sJS/rSHIB3U2M9KPfokmSOeDM3wiP5jb
	 Au0j5VtNVSETSuc0VRuP7OM4MlGn5d0Rw7hGb4i7jD0IBFpiUIUYbg2r4uM5XibzyR
	 8ALIHBYSuiXtdARM2y8x5F5xF/OEuk97nZpfAtHR4xD95gVbuFrbYqSBI7BWN64A+y
	 YRjMyVmT1LfwCbvo1uRIUFEVCxyWNOl2rge9w1V5qJBQiaGqMptSyHgd75KRN9eEI+
	 +fk2GwU+B56Ig==
Date: Mon, 8 Dec 2025 12:38:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 22/25] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <20251208183827.GA3302770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104001001.3833651-23-terry.bowman@amd.com>

Possible subject:

  PCI/ERR: Rename merge_result() to pcie_ers_merge_result()

since there's no CXL content here.

On Mon, Nov 03, 2025 at 06:09:58PM -0600, Terry Bowman wrote:
> CXL uncorrectable errors (UCE) will soon be handled separately from the PCI
> AER handling. The merge_result() function can be made common to use in both
> handling paths.
> 
> Rename the PCI subsystem's merge_result() to be pci_ers_merge_result().
> Export pci_ers_merge_result() to make available for the CXL and other
> drivers to use.

Still dubious about exporting this.

> Update pci_ers_merge_result() to support recently introduced PCI_ERS_RESULT_PANIC
> result.

Code is pcie_ers_merge_result(), not pci_ers_merge_result().

But I actually think "pci" might be more appropriate because I think
this is used in generic PCI paths that can be exercised for non-PCIe.
Either way, make them all consistent.

> +++ b/drivers/pci/pcie/err.c
> @@ -21,9 +21,12 @@
>  #include "portdrv.h"
>  #include "../pci.h"
>  
> -static pci_ers_result_t merge_result(enum pci_ers_result orig,
> -				  enum pci_ers_result new)
> +pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig,
> +				       enum pci_ers_result new)
>  {
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;

I think this should be squashed with the "CXL/PCI: Introduce
PCI_ERS_RESULT_PANIC" patch and called:

  PCI/ERR: Add PCI_ERS_RESULT_PANIC

so the new functionality is all together and the rename is separate.

