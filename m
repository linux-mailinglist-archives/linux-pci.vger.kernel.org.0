Return-Path: <linux-pci+bounces-16616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8649C6561
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 00:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119DE1F26A69
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454C21C168;
	Tue, 12 Nov 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1ZNhDxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1E1CDFBD;
	Tue, 12 Nov 2024 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455075; cv=none; b=aTsm2NaxsvgaEg2tcyXVX2nRoCgg+ATFOvDLdAtrCSxXWko6+35ZFJolbMgTM21U/eb/FYxCMyc1FSAeVy6QIEt1oF/uYeDys8WXFa02sDwyRZxRtwqE/kiFdwXDzRqiQlnILNPW51ginM9MeNd57i6rQFkGUIXNDa168t/9rrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455075; c=relaxed/simple;
	bh=UZCb9fS+hhkL+JEKJ9NO1EcmESMvQfEetmouChM+sds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f7H4I7srXgyvwFrx0/tmaE/qJJ3MVvGDCwadehbJrveS0DyBE8YzQZv1i5bw9h7w+Mn3PstyTELI8VQcWbLFlBw3sgRDApTbsXHykvKDDfkg1iF0D0wfp1NxfrPv7KWEC+LP87LcLzpPkviT8fKDoKcVUJKyYQBa4I92T6JWVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1ZNhDxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAE1C4CECD;
	Tue, 12 Nov 2024 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731455074;
	bh=UZCb9fS+hhkL+JEKJ9NO1EcmESMvQfEetmouChM+sds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o1ZNhDxJXEmxRM8biQl6+CgCrq0SZXFtzfdxz6TZkf6DVzK1ukp5fpuifm5toup8b
	 A2fO0wjA28nsV0jV7mH5RUEe/pDgETnDXQQVQ2NB6rLrsVwHJn1kkZ5pHIuDZqOHms
	 XLYoPAZNHy6ZKdvT06cBA8P9BCFGco/QnYJ6wQ87AVWpZA0UrC9JfUxnzEr/pHJnt0
	 gUFbQz9RWPrGG1Dev0o81RunTyRk5zABaSP8+YCVI+0N+BmNw9RKaKQj4SXVE2EOLC
	 Wl9z2e2H2UkWPGlbcaV9jLpsIMT/+XK1w6XgkunBCEHxSGv9qsHauSdhnX+jRsGVoZ
	 NFzImbUJit/VQ==
Date: Tue, 12 Nov 2024 17:44:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20241112234432.GA1868852@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>

On Mon, Nov 11, 2024 at 02:11:51PM +0530, Krishna chaitanya chundru wrote:
> It is a property of the runtime PM framework that it can only
> follow continuous dependency chains.  That is, if there is a device
> with runtime PM disabled in a dependency chain, runtime PM cannot be
> enabled for devices below it and above it in that chain both at the
> same time.
> 
> Since runtime PM is disabled for host bridge, the state of the child
> devices under the host bridge is not taken into account by PM framework
> for the top level parent, PCIe controller. So PM framework, allows
> the controller driver to enter runtime PM irrespective of the state
> of the devices under the host bridge.
> 
> So enable runtime pm of the host bridge device, so that dependency
> chain in maintained between endpoint devices and the controller driver.
> 
> PM framework expectes parent runtime pm enabled before enabling runtime
> pm of the child. As PCIe starfive device is enabling runtime pm after
> the pci_host_probe which enables runtime pm of the child device i.e for
> the bridge device a warning is shown saying "pcie-starfive 940000000.pcie:
> Enabling runtime PM for inactive device with active children" and also
> shows possible circular locking dependency detected message.
> 
> As it is must to enable parent device's runtime PM before enabling child's
> runtime pm as the pcie-starfive device runtime pm is enabled after child
> runtime starfive device is seeing the warning.
> 
> In the first patch fix the pcie-starfive driver by enabling runtime
> pm before calling pci_host_probe().
> 
> All other PCIe controller drivers are enabling runtime pm before
> calling pci_host_probe() which is as expected so don't require any
> fix like pcie-starfive driver.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Provisionally applied to pci/pm for v6.13.  I see a typo or two, so
the commit logs will likely be updated, but I pushed the branch to get
build testing started.

> ---
> Changes in v7:
> - Bring the cover letter details to commit message as suggested by bjorn.
> - Add a comment in the driver to ensure pm_runtime_enable is called
>   before host bridge pm_runtime_enable().
> - Link to v6: https://lore.kernel.org/r/20241017-runtime_pm-v6-0-55eab5c2c940@quicinc.com
> Changes in v6:
> - include the patch by mayank which fixes runtime pm enable order for
>   pcie starfive driver.
> Changes in v5:
> - call pm_runtime_no_callbacks() as suggested by Rafael.
> - include the commit texts as suggested by Rafael.
> - Link to v4: https://lore.kernel.org/linux-pci/20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com/
> Changes in v4:
> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
> Changes in v3:
> - Moved the runtime API call's from the dwc driver to PCI framework
>   as it is applicable for all (suggested by mani)
> - Updated the commit message.
> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
> Changes in v2:
> - Updated commit message as suggested by mani.
> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> 
> ---
> Krishna chaitanya chundru (1):
>       PCI: Enable runtime pm of the host bridge
> 
> Mayank Rana (1):
>       PCI: starfive: Enable PCIe controller's runtime PM before probing host bridge
> 
>  drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
>  drivers/pci/probe.c                         | 11 +++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
> ---
> base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
> change-id: 20241016-runtime_pm-d3dbf41736b6
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

