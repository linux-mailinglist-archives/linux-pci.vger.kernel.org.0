Return-Path: <linux-pci+bounces-32367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4084B08A8E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A33179472
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E713288537;
	Thu, 17 Jul 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMzAIZPT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E371F5413;
	Thu, 17 Jul 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748297; cv=none; b=LXNl7MHMyQ8H+8baUrhChSxWdcy2xHyWRKCR4/H3xDh+pRSP2Bop/R0Duy1DqZEPZblsuC23gFLt9zWpycphumKvuHJCNddr/Mrn+zWfXBQ90WfQHkxgYJx4DfWgBmKoDaaZ9UMG84UfF9nKaUSM+1W5usDDYFesc41QDr5ftPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748297; c=relaxed/simple;
	bh=GEF0Iea9tdt8h2xZCwTe5vufEO4aXfoWH9l3WAh+Oz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh6n5SK48nAZtD+DqPsui5gQqKr9ACsn0NxptoRyZYATyYlCz4Qi2bxzdleLZpRu3aA75dO4YlwiokdIw+cUgjstYeQYoWYatDRO091zPuAS1MJiCFN5otdDztPprfulJ30kk2j17K+1zRXe3zgA+JAqHeZj9FdQFGLp+Mbytj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMzAIZPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B58EC4CEE3;
	Thu, 17 Jul 2025 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752748295;
	bh=GEF0Iea9tdt8h2xZCwTe5vufEO4aXfoWH9l3WAh+Oz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMzAIZPTr+EmY4y6vQDBLndTvsjtdW2C/Q37l47c2JiNuLSMKT9BgZRlUw63VrlMc
	 o6KoeKskW/7c4OjpccPNJAK+abKpRVqfzcLSQrnpSuC0gu2HKt2y6abARAnv0/ESi6
	 e/3h3CYaFvb6yK7PXocCosZMbF0BZ+zRUVP+3BxoIB+a4/rNVqQWeX8ocYwS8Cid8b
	 qySdiZSO14+KSkjzDUnZx3d+Xo4AkNFu4O7bBMj8NmEzKmgfLTEpVzYcFw+7I5QH9o
	 Yy7d9U055qgdEqcwFMdnAeRh5UkwaILFQitu1p5ms2/lYH4Hl5qHnTW8NHji091BM9
	 Cg904INvymVcw==
Date: Thu, 17 Jul 2025 16:01:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jeff Johnson <jjohnson@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
	Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Message-ID: <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>

On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:

[...]

> > @@ -16,6 +16,8 @@
> >  #include "mhi.h"
> >  #include "debug.h"
> >  
> > +#include "../ath.h"
> > +
> >  #define ATH12K_PCI_BAR_NUM		0
> >  #define ATH12K_PCI_DMA_MASK		36
> >  
> > @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
> >  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
> >  
> >  	/* disable L0s and L1 */
> > -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > -				   PCI_EXP_LNKCTL_ASPMC);
> > +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
> 
> Not always, but sometimes seems the 'disable' does not work:
> 
> [  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
> [  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable
> 
> 
> >  
> >  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
> >  }
> > @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
> >  {
> >  	if (ab_pci->ab->hw_params->supports_aspm &&
> >  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> > -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > -						   PCI_EXP_LNKCTL_ASPMC,
> > -						   ab_pci->link_ctl &
> > -						   PCI_EXP_LNKCTL_ASPMC);
> > +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
> 
> always, the 'enable' is not working:
> 
> [  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
> [  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore
> 

Interesting! I applied your diff and I never see this issue so far (across 10+
reboots):

[    3.758239] ath12k_pci_power_up 1475: link_ctl 0x42
[    3.758315] ath12k_pci_power_up 1480: link_ctl 0x40
[    4.383900] ath12k_pci_start 1180: link_ctl 0x40
[    4.384026] ath12k_pci_start 1185: link_ctl 0x42

Are you sure that you applied all the 6 patches in the series and not just the
ath patches? Because, the first 3 PCI core patches are required to make the API
work as intended.

> 
> >  }
> >  
> >  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
> > 
> 
> In addition, frequently I can see below AER warnings:
> 
> [  280.383143] aer_ratelimit: 30 callbacks suppressed
> [  280.383151] pcieport 0000:00:1c.0: AER: Correctable error message received from
> 0000:00:1c.0
> [  280.383177] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Data Link
> Layer, (Transmitter ID)
> [  280.383184] pcieport 0000:00:1c.0:   device [8086:7ab8] error status/mask=00001000/00002000
> [  280.383193] pcieport 0000:00:1c.0:    [12] Timeout
> 

I don't see any AER errors either.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

