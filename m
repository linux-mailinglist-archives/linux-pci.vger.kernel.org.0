Return-Path: <linux-pci+bounces-25711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36017A86AA4
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 05:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF957A25B3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 03:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB613A244;
	Sat, 12 Apr 2025 03:53:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EA15CD78;
	Sat, 12 Apr 2025 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744429982; cv=none; b=a8AlXMQKYFFtRAiBIfkgun/pr0SZGCqHOj+45mHRMa4yBgHmFB6pMpFiTG58mBA+1IQFIIe0O6ej64/9A/QH1ajh/YiqjtXua0SsyS69rekrwIx/01fgTLH2PcwOLjx8aojoAmktrnFYr9WvoDv2eMHj8tHlWZcIQ30j1LQIvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744429982; c=relaxed/simple;
	bh=r4/JMs6C2Dvw1bW8VHdZlPi+YkDCZTs1eOaXxjGw/oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2vDr3xPSBuO2kFHgZWy06EAOlxUngqcQJxQRfPw4T0x/ZxNW9yzPC55MtAr5U4VOZqEg8Y+jR/R+PgTP2FrS5lpY5uyb9QVso899Latx9/CG4hDLOYjQv2qaiDVvxLkxV/7nBoufzu5tYPWb/C+f2Gu+SQVGlPLBIzADZaSDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 35C8D2C4C0D2;
	Sat, 12 Apr 2025 05:52:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 031171E092; Sat, 12 Apr 2025 05:52:56 +0200 (CEST)
Date: Sat, 12 Apr 2025 05:52:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 7/9] PCI: PCI: Add pcie_link_is_active() to determine
 if the PCIe link is active
Message-ID: <Z_njmA49Gda-m0aH@wunner.de>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com>

On Sat, Apr 12, 2025 at 07:19:56AM +0530, Krishna Chaitanya Chundru wrote:
> Introduce a common API to check if the PCIe link is active, replacing
> duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

One heads-up and one nit:

> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>  	 * Synthesize it to ensure that it is acted on.
>  	 */
>  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> -	if (!pciehp_check_link_active(ctrl))
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>  		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>  	up_read(&ctrl->reset_lock);
>  }

Heads-up:  There's a trivial merge conflict here with what's queued on
pci.git/hotplug.  No need for you to respin because I expect this will be
merged through a different topic branch anyway, but Bjorn and the other
maintainers will see the merge conflict when generating the next branch.


> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
>  			    pci_select_bars(pdev, IORESOURCE_MEM));
>  }
>  
> +bool pcie_link_is_active(struct pci_dev *dev);
>  #else /* CONFIG_PCI is not enabled */
>  
>  static inline void pci_set_flags(int flags) { }
> @@ -2093,6 +2094,9 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	return -ENOSPC;
>  }
> +
> +static inline bool pcie_link_is_active(struct pci_dev *dev)
> +{ return false; }
>  #endif /* CONFIG_PCI */

Nit:  Seems like this would still fit within 80 chars:

static inline bool pcie_link_is_active(struct pci_dev *dev) { return false; }

That said, all existing callers of this function as well as the new one
introduced by this series are only compiled in the CONFIG_PCI=y case,
so I'm not sure the inline stub is necessary at all?

Thanks,

Lukas

