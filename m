Return-Path: <linux-pci+bounces-14393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E499B4A6
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE61C20D83
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12E1474B2;
	Sat, 12 Oct 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvmRoBje"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA93146D57
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734265; cv=none; b=XCRSqKEx4cr2/IwQrjMNWn7yVH2UBTWXIo+K6sdiz9tNYi20kSLD/J8H7mNI2afpWfi158BGPLRoIwe7OoRNJ+ixrGpE2jrUfJrC117jq2H7VqDSQuY7BVBXERGttGOqRNEfKOuGW1vOIE8FDaAp6JwuJnlVqZ2RVDAC5RLbm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734265; c=relaxed/simple;
	bh=n9lyRkyoW0CopG9ouMGhvVOOJfofruhqHRXkDPutUsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMau2oZX5WBhK/INvraa9pGUylzGDCGzAZwMqf0puNDi3znfIRwjYizN/UHtT0eEzFROWRBDmgy3QxHpjHHv5l0Hv5tJMe9M/F5e+miIHyIhnCxpwlgMqjm6y1INh8QFt6jAGoqWkDvdxYCK15J6sd0ZdL0sd7OzkwyY3c4ul9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jvmRoBje; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b64584fd4so27663145ad.1
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728734263; x=1729339063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S7G6dWAEYSkc1WElXQ2pKIG++G4HBObsPMNbF5Q/O90=;
        b=jvmRoBje/M7tp40TMzX4OSliEXrPwt9WO1S7MSWCQsOuohLHf60AtOqpXhHkD6YomR
         hrX9r+zsJQQoYWWSqm9idqOnK/U8feIFgSmNe52cFgH8LrD6K6SgIxfYSNIhLQLXhfBn
         aJCXjUr5JgVLhZwl5WzrxyYDE3nL6RbXPTvCyUreL6wZqIVRo0w6t7QM7Gyb8XDP/7Xi
         CPRW7cJyF2PzQVlftRksiwzlKOrrdD0heOe1ii5BgkLdXATIKfV49o3K4cJW7uSLXxgD
         TA8HUSoT2BbJwT/zUjClnZFIZteisaTZ6CGKX5SioSTOiXmc/GV1mS5t014i/nBDDZzq
         upAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728734263; x=1729339063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7G6dWAEYSkc1WElXQ2pKIG++G4HBObsPMNbF5Q/O90=;
        b=iyji/ILGcjx99S/WBdvL4ReRaWfiQqSavYJ7VRma2MOuMWSDQhrN+8cczUjNG6fGEP
         zEcfD8IjsvDkKt6rAKK7gPqyIxYI9gwMizcBmWoUggO/Oi6wwhJ/stsICHo97iBaokTN
         kfSSPR8qR+oqpHyNxawcPw2M8GfGKr7YM/Zd9zVhl2lquh3rbC2vlX7YKArndBwOR5Si
         Atuty4lrepXdsRm2fwr9Ikxwj9A45QWqhowdzoZ3pSVQwhwQwyLKXZ/Hgf131LwF/gL2
         9xHkuDKt7wJL9atqexo+9ymuy60t0VG9y+mDDSxuRc2HDVtCgOLLFTKQ5yrba96vMaoN
         lU/A==
X-Forwarded-Encrypted: i=1; AJvYcCXhIjJNBrFmhwIsNd4X2L/RlZMIIyTUpUHOfP5GCBgG62FAcRTcJAzIBp+SRsj17xeJdNARuxl31YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt08Fw2Zn2B7mpHl77KcbJLBEjxAlT9IzL37qaihAfzhxQ58vo
	z7/qKoEBhXd4wo/HXFveKSC0nb8ei/SMquDtQwaVteF4uy1Sov206jGI14nQ3g==
X-Google-Smtp-Source: AGHT+IGCn51Kg5LGR4Vf6YRxsQyA3gogtqBiRzo+cLBfwrIfAzh3C5H2xAtVmMirTePohIr8Rfzylw==
X-Received: by 2002:a17:902:dac6:b0:20c:a0a5:a171 with SMTP id d9443c01a7336-20ca1676edfmr82618205ad.26.1728734263075;
        Sat, 12 Oct 2024 04:57:43 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7866sm36401505ad.171.2024.10.12.04.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 04:57:42 -0700 (PDT)
Date: Sat, 12 Oct 2024 17:27:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <20241012115737.qxwnsxy6pts6iyza@thinkpad>
References: <20241012113246.95634-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012113246.95634-1-dlemoal@kernel.org>

On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> This series introduces the new functions pci_epc_mem_map() and
> pci_epc_mem_unmap() to improve handling of the PCI address mapping
> alignment constraints of endpoint controllers in a controller
> independent manner.
> 
> The issue fixed is that the fixed alignment defined by the "align" field
> of struct pci_epc_features is defined for inbound ATU entries (e.g.
> BARs) and is a fixed value, whereas some controllers need a PCI address
> alignment that depends on the PCI address itself. For instance, the
> rk3399 SoC controller in endpoint mode uses the lower bits of the local
> endpoint memory address as the lower bits for the PCI addresses for data
> transfers. That is, when mapping local memory, one must take into
> account the number of bits of the RC PCI address that change from the
> start address of the mapping.
> 
> To fix this, the new endpoint controller method .align_addr is
> introduced and called from the new pci_epc_mem_map() function. This
> method is optional and for controllers that do not define it, it is
> assumed that the controller has no PCI address constraint.
> 
> The functions pci_epc_mem_map() is a helper function which obtains
> the mapping information, allocates endpoint controller memory according
> to the mapping size obtained and maps the memory. pci_epc_mem_unmap()
> unmaps and frees the endpoint memory.
> 
> This series is organized as follows:
>  - Patch 1 introduces a small helper to clean up the epc core code
>  - Patch 2 improves pci_epc_mem_alloc_addr()
>  - Patch 3 introduce the new align_addr() endpoint controller method
>    and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
>  - Patch 4 documents these new functions.
>  - Patch 5 modifies the test endpoint function driver to use 
>    pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
>    these functions.
>  - Finally, patch 6 implements the RK3588 endpoint controller driver
>    .align_addr() operation to satisfy that controller PCI address
>    alignment constraint.
> 
> This patch series was tested using the pci endpoint test driver (as-is
> and a modified version removing memory allocation alignment on the host
> side) as well as with a prototype NVMe endpoint function driver (where
> data transfers use addresses that are never aligned to any specific
> boundary).
> 

Applied to pci/endpoint!

- Mani

> Changes from v5:
>  - Changed patch 3 to rename the new controller operation to align_addr
>    and change its interface. Patch 6 is changed accordingly.
> 
> Changes from v4:
>  - Removed the patch adding the pci_epc_map_align() function. The former
>    .map_align controller operation is now introduced in patch 3 as
>    "get_mem_map()" and used directly in the new pci_epf_mem_map()
>    function.
>  - Modified the documentation patch 4 to reflect the previous change.
>  - Changed patch 6 title and modified it to rename map_align to
>    get_mem_map in accordance with the new patch 3.
>  - Added review tags
> 
> Changes from v3:
>  - Addressed Niklas comments (improved patch 2 commit message, added
>    comments in the pci_epc_map_align() function in patch 3, typos and
>    improvements in patch 5, patch 7 commit message).
>  - Added review tags
> 
> Changes from v2:
>  - Dropped all patches for the rockchip-ep. These patches will be sent
>    later as a separate series.
>  - Added patch 2 and 5
>  - Added review tags to patch 1
> 
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags
> 
> Damien Le Moal (6):
>   PCI: endpoint: Introduce pci_epc_function_is_valid()
>   PCI: endpoint: Improve pci_epc_mem_alloc_addr()
>   PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
>   PCI: endpoint: Update documentation
>   PCI: endpoint: test: Use pci_epc_mem_map/unmap()
>   PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation
> 
>  Documentation/PCI/endpoint/pci-endpoint.rst   |  29 ++
>  .../pci/controller/dwc/pcie-designware-ep.c   |  15 +
>  drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
>  drivers/pci/endpoint/pci-epc-core.c           | 182 ++++++---
>  drivers/pci/endpoint/pci-epc-mem.c            |   9 +-
>  include/linux/pci-epc.h                       |  38 ++
>  6 files changed, 415 insertions(+), 230 deletions(-)
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

