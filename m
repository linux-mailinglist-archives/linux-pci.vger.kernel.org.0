Return-Path: <linux-pci+bounces-21352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CADEBA342E5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B111892C42
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241A221710;
	Thu, 13 Feb 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfa4GGaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6E221552;
	Thu, 13 Feb 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457562; cv=none; b=X7cDwCtAR8lV6DX80gxEiv3ayxFi9jf5CZbGKQa5KPtBQd80RxIaBeYV6RnuIGnYS4WI8Qxs9olKo5+Spf8i3ujkiMzr+yt0d9ju6ITmpYUBA55FY0aycFHUGfPgKikJOTAsoUJX6SU/u5mjsPRpbRP0BT8JXX6GcA5lo5SkI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457562; c=relaxed/simple;
	bh=mljex6fF/+V1lN1/JEaG7T5L9mO4fXa+fKxBcu5YfGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snWRrZaKsXkI2IUMQNWBNKDRgAfbK/G9DVs8lSOMaGnvV5qna7V+vdz5ozIQhKcRzjl1ovMUHnAgLtR10RGJqrvGYHBlrzITR+M30Q/rFWqv54bvrHH6d48FSEHbMwCeoIQOE/IYYdQOQ7e6yvFRfFilhtysw0Ny+zfi15lgoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfa4GGaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5A0C4CEE2;
	Thu, 13 Feb 2025 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457562;
	bh=mljex6fF/+V1lN1/JEaG7T5L9mO4fXa+fKxBcu5YfGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jfa4GGaDEqqfKZFf9i1BLECTwiIFy9spSG+YcDopF/6/mYWQ5ezPRlqv5UUsQ9/Hr
	 j0LWzW+MkhFX5p+SB7yFuiQdGPwmareQEb+7DFw/cXxvqov2t8TUwswlu58DQCbLtp
	 mB8ZCS8LwnZ9vcciWy3gis3f0EtgJ25z8Ky+eCsL1VxHgwEK2Qf6rg6Yw3UuR3D+Ae
	 yhHW4GJ0uX//c4o4UZkztSP9dM0zWGuM9JJLsotCNqJilM2B6tEoAmYbqDKnK6G+2H
	 xY9XvVjrvRK80IxbwtPfWwAWxfWR0Q6gl14O2rQir14iAPAu9X+h8apd2RZ9g4cUXS
	 /fcPI1gUPQbTA==
Date: Thu, 13 Feb 2025 15:39:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 0/4] Add support for RAS DES feature in PCIe DW
Message-ID: <Z64EFN2QZ2AOF11I@ryzen>
References: <CGME20250121115157epcas5p15f8b34cd76cbbb3b043763e644469b18@epcas5p1.samsung.com>
 <20250121111421.35437-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121111421.35437-1-shradha.t@samsung.com>

On Tue, Jan 21, 2025 at 04:44:17PM +0530, Shradha Todi wrote:
> DesignWare controller provides a vendor specific extended capability
> called RASDES as an IP feature. This extended capability  provides
> hardware information like:
>  - Debug registers to know the state of the link or controller. 
>  - Error injection mechanisms to inject various PCIe errors including
>    sequence number, CRC
>  - Statistical counters to know how many times a particular event
>    occurred
> 
> However, in Linux we do not have any generic or custom support to be
> able to use this feature in an efficient manner. This is the reason we
> are proposing this framework. Debug and bring up time of high-speed IPs
> are highly dependent on costlier hardware analyzers and this solution
> will in some ways help to reduce the HW analyzer usage.
> 
> The debugfs entries can be used to get information about underlying
> hardware and can be shared with user space. Separate debugfs entries has
> been created to cater to all the DES hooks provided by the controller.
> The debugfs entries interacts with the RASDES registers in the required
> sequence and provides the meaningful data to the user. This eases the
> effort to understand and use the register information for debugging.
> 
> v5:
>     - Addressed Fan's comment to split the patches for easier review
>     - Addressed Bjorn's comment to fix vendor specific cap search
>     - Addressed style related change requests from v4
>     - Added rasdes debugfs init call to common designware files for host
>       and EP.
> 
> v4: https://lore.kernel.org/lkml/20241206074456.17401-1-shradha.t@samsung.com/
>     - Addressed comments from Manivannan, Bjorn and Jonathan
>     - Addressed style related change requests from v3
>     - Added Documentation under Documentation/ABI/testing and kdoc stype
>       comments wherever required for better understanding
>     - Enhanced error injection to include all possible error groups
>     - Removed debugfs init call from common designware file and left it
>       up to individual platform drivers to init/deinit as required.
> 
> v3: https://lore.kernel.org/all/20240625093813.112555-1-shradha.t@samsung.com/
>     - v2 had suggestions about moving this framework to perf/EDAC instead of a
>       controller specific debugfs but after discussions we decided to go ahead
>       with the same. Rebased and posted v3 with minor style changes.
> 
> v2: https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t@samsung.com/
>     - Addressed comments from Krzysztof Wilczyński, Bjorn Helgaas and
>       posted v2 with a changed implementation for a better code design
> 
> v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
> 
> Shradha Todi (4):
>   PCI: dwc: Add support for vendor specific capability search
>   Add debugfs based silicon debug support in DWC
>   Add debugfs based error injection support in DWC
>   Add debugfs based statistical counter support in DWC
> 
>  Documentation/ABI/testing/debugfs-dwc-pcie    | 144 +++++
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 561 ++++++++++++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
>  .../pci/controller/dwc/pcie-designware-host.c |   6 +
>  drivers/pci/controller/dwc/pcie-designware.c  |  19 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  16 +
>  8 files changed, 762 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
> 
> -- 
> 2.17.1
> 

Shradha,

Thank you for this awesome feature!

It would be great if we could get it included in v6.15.

Are you intending to send out a v6?


Kind regards,
Niklas

