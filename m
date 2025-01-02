Return-Path: <linux-pci+bounces-19172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4BA9FFC0B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A858A1882C7E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7C481CD;
	Thu,  2 Jan 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKguF/bd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B21EB44;
	Thu,  2 Jan 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836149; cv=none; b=AnsTF5QOwOs3cdD/V02Df3VgNkAlyy/88FuFLKO8fKEPNPDmbeeJmNIYJs4CPGsrJVsA2CFTIjxeYYKi9yTf8Fm1tf0G8ExLeGcPtIlRDmEBS941UOm4jf7YG4Y1pHdIur9in4Sr48oTBAhMLsnqNs5cY9w4Jt+2bPMJ7rtptNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836149; c=relaxed/simple;
	bh=tZuVzd99ApeDUiVzw3KuaRFyYnW0IaFKchnEVYIP3F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPq7b1x7nuLy3mG8Yf4HrwRrJp/KzDt/tidtBR4jQPgSYR5rBS46N4BQ5thMEPzkxKPuAeVqrCZmK6cNQZBRVwwBt+ib4oT1twg43Uh8qTOJaZbo8bwzH39FSCPM0C1AyQz3KdpvI9OrFw1VhS1fg39wEfljjfvjjwjIULYJd1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKguF/bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE5C4CED0;
	Thu,  2 Jan 2025 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735836149;
	bh=tZuVzd99ApeDUiVzw3KuaRFyYnW0IaFKchnEVYIP3F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKguF/bdVe/nYsa5OBSSdjQU+0IB0oiClOLxaKJk3C/QCjdxyQ8iD0MJrfbc/JRKX
	 +nmLJFamWcySsUJZnJfilv/ppewKO0ERHvkFz4Qp5Lp4UsXZMPVtQQhQZthPCCJHpy
	 Ix54ywD08xG5zdbYN0KfQzhbqxX0cKviCGXNG57DeCHip2+41JF2e1ZcmgGxw12onj
	 9muhc3eHf8QLKrI+BZj9pGP+3MT0FZYSQNZlz8FYD6pNo3Yc+VwGl/EstAh8I+rxJb
	 vkJ2MWGlKwmYQGMWeCQbXEwicIbmRX3yglpwE53wZhnEPkgg9Mqta8T1HSlqPPaFZD
	 uuQOsPUwD1xHQ==
Date: Thu, 2 Jan 2025 17:42:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	andersson@kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v5 0/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Message-ID: <Z3bB79Wu2U6-65Z4@ryzen>
References: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>

On Sat, Nov 23, 2024 at 12:39:58AM +0530, Krishna chaitanya chundru wrote:
> If the vendor drivers can detect the Link up event using mechanisms
> such as Link up IRQ, then waiting for Link up during probe is not
> needed. if the drivers can be notified when the link comes up,
> vendor driver can enumerate downstream devices instead of waiting
> here, which optimizes the boot time.
> 
> So skip waiting for link to be up if the driver supports 'use_linkup_irq'.
> 
> Currently, only Qcom RC driver supports the 'use_linkup_irq' as it can
> detect the Link Up event using its own 'global IRQ' interrupt. So set
> 'use_linkup_irq' flag for QCOM drivers.
> 
> And as part of the PCIe link up event, the ICC and OPP values are updated.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in v5:
> - update the commit text as suggested by (mani).
> Changes in v4:
> - change the linkup_irq name to use_linkup_irq a suggested by (bjorn
>   andresson)
> - update commit text as suggested by bjorn andresson.
> - Link to v3: https://lore.kernel.org/r/linux-arm-msm/20241101-remove_wait-v3-0-7accf27f7202@quicinc.com/T/
> Changes in v3:
> - seperate dwc changes and qcom changes as suggested (mani)
> - update commit & comments as suggested (mani & bjorn)
> - Link to v2: https://lore.kernel.org/linux-pci/20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com/T/
> Changes in v2:
> - Updated the bypass_link_up_wait name to linkup_irq  & added comment as
>   suggested (mani).
> - seperated the icc and opp update patch (mani).
> - Link to v1: https://lore.kernel.org/r/20240917-remove_wait-v1-1-456d2551bc50@quicinc.com
> 
> ---
> Krishna chaitanya chundru (3):
>       PCI: dwc: Skip waiting for link up if vendor drivers can detect Link up event
>       PCI: qcom: Set use_linkup_irq if global IRQ handler is present
>       PCI: qcom: Update ICC and OPP values during link up event
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c            |  7 ++++++-
>  3 files changed, 15 insertions(+), 3 deletions(-)
> ---
> base-commit: cfba9f07a1d6aeca38f47f1f472cfb0ba133d341
> change-id: 20241122-remove_wait2-d581b40380ea
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

For the series:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

