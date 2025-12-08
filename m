Return-Path: <linux-pci+bounces-42778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB1CADF51
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110B73056C7B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913C228CA9;
	Mon,  8 Dec 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW4deBHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE48770FE;
	Mon,  8 Dec 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217054; cv=none; b=i6dJpBxDOB8nYdLZ9e+PX16MEcJ9zUIDLwgfsXa8WEeT1Z3AQJ9xa4qDt5K99WCq9zI10FeDHRak7M4SArlJgllUykaOB8w+7gyvKbhIn7mQFHpg/Irz0CCBOKbZv6QtUDWVT4XG/IcNAP0Ukgv7Iz+hVAZNzX02rnV3wkSDOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217054; c=relaxed/simple;
	bh=4ShYtDf0Bj1VibKVOieKtO1uL5tTIxKr4zCRGt1m3eM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JviQJcwbbB0q3QZfmuqo2zcllSp+PbUfOt9/fUrNX0r7rW2/NMLtVj20eRkgm9U/YDLQaO0zciDMSgcAmTtVASUZzwzQOHz+hwsVR4aC7wKe/FXAEGpCu8oWCG6fb2BnnzLbvJ6EltTFcsrpoJsIv2u1GGIdawtx/o7axltTvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW4deBHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B58C4CEF1;
	Mon,  8 Dec 2025 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765217054;
	bh=4ShYtDf0Bj1VibKVOieKtO1uL5tTIxKr4zCRGt1m3eM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nW4deBHsH1dTXxsUEXGw8xlLlNVkobzb4CNgCvE6scNtT5rmjtNq/eZP58hRBd4OY
	 cMY9X1860iFJxwr0rJkF+es8LukPI41OcKzw7mGFNUAUbWvr1OybEak1g5R4ZW51X/
	 n6bsj3Jkd7VUucHAWkeGu0zFetZqM8Hi+mtCNCsfvHVHXx71Ucw+xwQ8Cv83eUp/vj
	 rvOg3fYe1AResJlof9m8TCOI2sVew14ioRK2q5gZGDiTTlX2WTYR25clL29d7WIEpg
	 odE5riyad07LOnNVidpIwN8F4tlr6bkZ/oCM8Ozshkm2cQfbCfN13Qyvn7JrURk/dS
	 ofSwqZ6i+qp3A==
Date: Mon, 8 Dec 2025 12:04:12 -0600
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
Subject: Re: [RESEND v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <20251208180412.GA3419469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-2-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:41AM -0600, Terry Bowman wrote:
> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems. Move these to uapi/linux/pci_regs.h.
> 
> Change DVSEC name formatting to follow the existing PCI format in
> pci_regs.h. The current format uses CXL_DVSEC_XYZ and the CXL defines must
> be changed to be PCI_DVSEC_CXL_XYZ to match existing pci_regs.h. Leave
> PCI_DVSEC_CXL_PORT* defines as-is because they are already defined and may
> be in use by userspace application(s).
> 
> Update existing usage to match the name change.
> 
> Update the inline documentation to refer to latest CXL spec version.

Regrettably, r3.2 is no longer the latest ;)

> +++ b/include/uapi/linux/pci_regs.h
> @@ -1244,9 +1244,64 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> -#define PCI_DVSEC_CXL_PORT				3
> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +/* Compute Express Link (CXL r3.2, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
> +
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)

I think PCI_DVSEC_HEADER1_LEN() could be used instead of adding a new
definition.

> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */

Can you use "CXL r4.0, sec 8.1.3" and similar so it refers to the most
recent revision and matches the typical style for PCIe spec references?

