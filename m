Return-Path: <linux-pci+bounces-42835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B3CAFBF6
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 12:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDD7A300BDB6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C742D9488;
	Tue,  9 Dec 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdMSlwUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83576228CB8;
	Tue,  9 Dec 2025 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279249; cv=none; b=T5ratHXPo2yd9R7jy+xwAaT+V5i4xzYweLDi4S+W//2NmEBGU6/4kgwIaft9A87OYbhmTNMQXltnM6kc9Myr0wCKW01BVRKwwdzAZ6AQ/cf1EAwb6L0AEmtL9KuheLjWpEtPi429Sz6iA3WiqJFfFhzLxlFp+sCI8F7aJeXbSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279249; c=relaxed/simple;
	bh=WeXfTlIRSxfY9oonRiLO3CPIXZl6lMFAIZhsuzla1GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixtIwy2sd7iJDrUcpgLyKNRfXNQCvaw12jik3qNmDWQkH+ZQlE7rgJySO4SPlUGO/OrUHxMJFeHtWvflMTtPBm2vaufq2VsvLcg2M6BFlcrQ2ZniaiPQYKU2kz5GPf584ZhqTfFXdcrM1cS8USniNiu0DGpEcmAKulPfAcSs9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdMSlwUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8762BC4CEF5;
	Tue,  9 Dec 2025 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765279247;
	bh=WeXfTlIRSxfY9oonRiLO3CPIXZl6lMFAIZhsuzla1GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdMSlwUMCIu8TogXM9+XgYvDMokICEZp2BMtU8Adi/jdaJ6yYFCnT5zw7QWM2+KsY
	 T1HYONeYS4qUq+TM4mpu3jTLniRoNPg9+2s4xJgokxraxOnP/zpCdlHTi7QFg9kcYj
	 zSWF5gRk9gmWRWbOFPIOJcI4wQewRoTRq15AigArc8wnjHJISyYKCcH2lRy5SoYc5Y
	 2A5PeArP6IOgk78KGpdVZjztqM1YlPRU4faWF7wclU/k4nnppju9MDqLQJl3KAckeG
	 QmX+PnAkhh20oPJZOZVA2enZeUuuMYi2XFWqSdBZQoMStwvBRcwPwjUdMf8MRtR8Ut
	 eFcZtKLS+ct4A==
Date: Tue, 9 Dec 2025 20:20:39 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <4d3asssmv5xkttasl2xl2f6q3l5ki4jxmsrbyy6hvrd7djgsnj@y7drlazpwzi3>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
 <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>
 <20251202191533.GI812105@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251202191533.GI812105@ziepe.ca>

On Tue, Dec 02, 2025 at 03:15:33PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 02, 2025 at 07:52:50PM +0530, Manivannan Sadhasivam wrote:
> > @@ -544,6 +544,7 @@ struct pci_dev {
> >  #endif
> >  	u16		acs_cap;	/* ACS Capability offset */
> >  	u16		acs_capabilities; /* ACS Capabilities */
> > +	u16		acs_broken_cap; /* Broken ACS Capabilities */
> 
> Why do we need this? Have the quirk function accep tthe
> acs_capabilities from the register and return the value to program
> into struct pci_dev ?
> 

We dont have any quirk levels between pci_acs_init() and pci_acs_enable() that
will allow us to modify pci_dev::acs_capabilities in the quirk function. Hence,
I came up with one more member to pass the broken caps.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

