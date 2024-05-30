Return-Path: <linux-pci+bounces-8079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129598D4E05
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1323281FFC
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08817625C;
	Thu, 30 May 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieQgh+8J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A116EC1E;
	Thu, 30 May 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079584; cv=none; b=Ze2afb8/b0QhwU8kLRfrRSh4EeFxK03G1BC2wLw7phGCWMsQFL4u5X702Fgt6G6SKRbLnHHEeBuy+3EabhHtPFRCltsPpYQKx75xgV7llVXqjRNgvQwcvRVjWTjd5gSvFQIJsdhklRZ6WYEwkgI38H1p3iLZYC3BzOahIVqXamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079584; c=relaxed/simple;
	bh=FgNZ6UjOzMWytcVycdPrNhtaXn45l9qWzklpNQ44q/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjtl3G8F65D+IAF96jpJFiQ8VW+lrHARAK6+o3m9xBx+IksS1Z8+Fp8vkigdS6aMVPVSlp3tpbSrlhHIF9WCWZURbE3kt8n05h3UoBicWrndf83iAdr9qboGgpaM11RPswaeKCruCHVwX1ntsYoSlCuNdo7CQHkfjcjS7HDOqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieQgh+8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E047C2BBFC;
	Thu, 30 May 2024 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079584;
	bh=FgNZ6UjOzMWytcVycdPrNhtaXn45l9qWzklpNQ44q/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieQgh+8J1zMd+M7lZKkSMAAW+nBzU7iyminVY9mOzC4OvUHf76yVw0iUFzkm7v6Cz
	 H9OtSrjVMLk8g4rAZAqChoL4sADAT2SLccwSJwgZure+lRUweRMgkccCh6v6JiKPif
	 2SzjvDkobOkdS2uQf1dpAyNAf0hlQyYbpcfg/KpXu4Ah5a4up2e0n3W97oBbklQwrb
	 pVTBRLlgyHeh3B20/aJu+0wjKFMm1PT3HZFgmneyGZBvNvaWycAQjZItGv8rx2QEnz
	 sN1fr7Rm4cmUus6x1WYwpoULzIOeES1gLQYNwCaGtIP+fLIVDJiM009oWCV5UsFznr
	 DxiyTi/Ls9Eig==
Date: Thu, 30 May 2024 20:02:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	manivannan.sadhasivam@linaro.org, andersson@kernel.org,
	agross@kernel.org, konrad.dybcio@linaro.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] pci: qcom: Add 16GT/s equalization and margining
 settings
Message-ID: <20240530143254.GE2770@thinkpad>
References: <20240501163610.8900-1-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501163610.8900-1-quic_schintav@quicinc.com>

On Wed, May 01, 2024 at 09:35:31AM -0700, Shashank Babu Chinta Venkata wrote:
> Add 16GT/s specific equalization and rx lane margining settings. These
> settings are inline with respective PHY settings for 16GT/s 
> operation. 
> 
> In addition, current QCOM EP and RC drivers do not share common
> codebase which would result in code duplication. Hence, adding
> common files for code reusability among RC and EP drivers.
> 

For the next revision, please rebase on top of [1].

- Mani

[1] https://lore.kernel.org/linux-pci/20240518-opp_support-v13-2-78c73edf50de@quicinc.com/

> v3 -> v4:
> - Addressed review comments from Mani and Konrad.
> - Preceded subject line with pci: qcom: tags
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
>   PCI: qcom: Add equalization settings for 16 GT/s
>   PCI: qcom: Add RX margining settings for 16 GT/s
> 
>  drivers/pci/controller/dwc/Kconfig            |   5 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  30 ++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 144 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  14 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  44 ++----
>  drivers/pci/controller/dwc/pcie-qcom.c        |  74 ++-------
>  7 files changed, 218 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h
> 
> -- 
> 2.43.2
> 

-- 
மணிவண்ணன் சதாசிவம்

