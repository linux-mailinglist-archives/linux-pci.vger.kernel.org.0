Return-Path: <linux-pci+bounces-6477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B403E8AA94A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 09:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A65F1F21DA9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED14779E;
	Fri, 19 Apr 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McI3rUdk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5846453;
	Fri, 19 Apr 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512178; cv=none; b=dvxgebFd49k81PR2b4bV2hbiIIx3oAwLHFFcyY4QXZehMq1MGfVK9w56FVFEf/x+2NAWqG9YM0Rrp1+7viY+UC04SDJ/hjL1T62nMcbVYH6R5VVeWFqjUwc1aq+fssls4Cs6OepLpBP0YKCVgb00y+7Ed5Rktah5sQfjAFJMHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512178; c=relaxed/simple;
	bh=Y+PE+i9/isbjj3qorbMc3Yvs+fiun2TXziDvq9ODPR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPkoR/dAp+qC5krpivR6I6WfNP1taiIkZMn8ooBnhD68DoRuwe1dLn63qRMx8D4Zq+6MFKUGZOyPT3VZa/ZJ2pIYuc49ZRNxk5cXK77cFaoDlhCWa4HvDGVzMdxuUdztECuknhIx8vsUSwoLDnKBhMoBQe9w00RMCorbmAzQuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McI3rUdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CB4C072AA;
	Fri, 19 Apr 2024 07:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713512178;
	bh=Y+PE+i9/isbjj3qorbMc3Yvs+fiun2TXziDvq9ODPR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McI3rUdkIx/edZ4XzqZpd27Tt3DhXs6611Kr3jwFQR7243R+DXbRyGO3nRIJFAchN
	 mmJM75XghUK4c/xWOW1q5Pk3QwwBSffBE2sD8nFNKeodws8h8H9oY330AWyD2amK3o
	 l//9i7FEKbxPGEyydZo+My12mkK/DM+PJ+2FVHY8mIlZyHAdcY12LchQ+xbzTXq4EH
	 y6mVNI+VxulkCAQYYgGUj9RC1faDKlMPEJznqgRCzePUxSiWvW8YBESZiQLw1VkGlA
	 GbX6OSoi/6Vh2ooA8Ud5iOicxC/ESQbXGoitsJQNqek4xGHVhwFowyup7fhH3v1pPG
	 EQmVl1NGIndvg==
Date: Fri, 19 Apr 2024 09:36:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add 16GT/s equalization and margining settings
Message-ID: <ZiIe6I06KH_0_JHQ@ryzen>
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419001013.28788-1-quic_schintav@quicinc.com>

On Thu, Apr 18, 2024 at 05:09:33PM -0700, Shashank Babu Chinta Venkata wrote:
> Add 16GT/s specific equalization and rx lane margining settings. These
> settings are inline with respective PHY settings for 16GT/s 
> operation. 
> 
> In addition, current QCOM EP and RC drivers do not share common
> codebase which would result in code duplication. Hence, adding
> common files for code reusability among RC and EP drivers.
> 
> v2 -> v3:
> - Replaced FIELD_GET/FIELD_PREP macros for bit operations.
> - Renamed cmn to common.
> - Avoided unnecessary argument validations.
> - Addressed review comments from Konrad and Mani.
> 
> v1 -> v2:
> - Capitilized commit message to be inline with history 
> - Dropped stubs from header file.
> - Moved Designware specific register offsets and masks to
>   pcie-designware.h header file.
> - Applied settings based on bus data rate rather than link generation.
> - Addressed review comments from Bjorn and Frank.
> 
> Shashank Babu Chinta Venkata (3):
>   PCI: qcom: Refactor common code
>   PCI: qcom: Add equalization settings for 16GT/s
>   PCI: qcom: Add rx margining settings for 16GT/s
> 
>  drivers/pci/controller/dwc/Kconfig            |   5 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  30 ++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 129 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  14 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  44 ++----
>  drivers/pci/controller/dwc/pcie-qcom.c        |  72 ++--------
>  7 files changed, 201 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h
> 
> -- 
> 2.43.2
> 

FWIW: I think the subject of the cover-letter should have been prefixed with:
"PCI: qcom: "


Kind regards,
Niklas

