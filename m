Return-Path: <linux-pci+bounces-31700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECDAAFD500
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AC94202A7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13CC21A426;
	Tue,  8 Jul 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opKIuaAO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D62E54D6;
	Tue,  8 Jul 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994938; cv=none; b=AFr2XJ0jzD034LLJmukfF7wVnyjC7Kz4gn8vDDG7EB3jvNuihaBYpu1LdBo/ByVO5FP+QJ+YbYo6Yk19yviqp8a2yjpji7A8ffXDrlvJrgKHBpeuab1rm69En5AZt/XLRY5oE6KfIcvcpx2aRvJC6zTXoi0WNPMUkeVZ6q5+SkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994938; c=relaxed/simple;
	bh=G4hnyLkgMkEeeDP4WcFeZOCQ5C1IlFKdxpJ/+mu5LgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNs5Dh8MLn/SU7d9knpuO4xWQglmLlJcdryjpfaQ8NDYebWaTAXuLH8TMSu5fGzv1JrgYKGXt2s1rm2QtOOmgSmGe1x7eBpVBLpcvC0w+b4/1ZZXdIXhhkuliVrJMXOBDJqIgrRMexA6rwg82CHOfwqHIO3VctrMZ85588Rnups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opKIuaAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1992BC4CEED;
	Tue,  8 Jul 2025 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994938;
	bh=G4hnyLkgMkEeeDP4WcFeZOCQ5C1IlFKdxpJ/+mu5LgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opKIuaAO3BlnWsujF70bvZupBRhBGMdopxt6dvx4EIpWv7+JtK1FiOG9bC2ms/5Dl
	 UtIFxU6eIZzcBfCQzHG9wCpg2RD1/ncADtxx5593QMZ7KWs0ZQ2zuCOC10BiG9e3dl
	 4fIlE40BK7oDwyZTsFR+1fGDdBNxxBUz3J4njjPFEgsT5EKZlGCZQykEGXQqIM3pfd
	 rkoV+6TKYCXt7epwhNGfWO1vmQxkX8kKF7vU0cojOXBVLCL8A4hV+eRACYuwCRPhVR
	 ZexmNG3rUFetp196JBhzhjo5Lazi87u5HkzaW0+v/1gCZ1UcYnpLh3OvkDB74i11nZ
	 RR2kyMm0/AK0A==
Date: Tue, 8 Jul 2025 22:45:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <qo6mb3qlt3xpuvhepwcv6be4wd53neee2t6buzk4tdiy22xsub@vu7lykp3rnu2>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:27PM GMT, Krishna Chaitanya Chundru wrote:
> ASPM states are not being enabled back with pci_enable_link_state() when
> they are disabled by pci_disable_link_state(). This is because of the
> aspm_disable flag is not getting cleared in pci_enable_link_state(), this
> flag is being properly cleared when ASPM is controlled by sysfs.
> 

A comment in pcie_config_aspm_link() says:

 /* Enable only the states that were not explicitly disabled */

But the function is called from both aspm_attr_store_common() and
__pci_enable_link_state(). So I don't know if this is behavior is intentional
or wrong. 

> Clear the aspm_disable flag with the requested ASPM states requested by
> pci_enable_link_state().
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Fixes tag?

- Mani

> ---
>  drivers/pci/pcie/aspm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	link->aspm_default = pci_calc_aspm_enable_mask(state);
> +	link->aspm_disable &= ~state;
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

