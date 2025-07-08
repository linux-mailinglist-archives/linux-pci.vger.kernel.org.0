Return-Path: <linux-pci+bounces-31690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E4AAFCEBA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56DA188FE2D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88C52E0402;
	Tue,  8 Jul 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgbu+3uI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54992E041F;
	Tue,  8 Jul 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987645; cv=none; b=StyxZmEkmG7iNwGbwOw8GLdlAlJg04iM0uWlZ7cmn7037p0gx+OxqNIyXPbwRSM8nOlSScb1dmxzuZh2/lJrVt4apES+abxdMvQ1VoED2jVaddDWD7SU3xUnWDtCwsKWpUpXTM3//KFX+GjfLH0uTk2LxFO8aX+lGad2bO0Z5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987645; c=relaxed/simple;
	bh=HLwJX5QT3UNWX3z8LqzLY6nx+EIVfmL3uCZ2H723Z0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7oTKvACXW7iDlm9LmuCDL1I0fH3gf9iNGMcWathBmSNr6mx/DqRtnKGTcjyQyyDdjoy27MwRa149IyO9NuURX8Qxe0X7DoxFElZREMaELJ6yVscia7pL14m8wIGKPSOJU0nyOr9YbqlkDV8OjlhIjmNVKIECxjieyXeE2nZXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgbu+3uI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A0FC4CEED;
	Tue,  8 Jul 2025 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751987645;
	bh=HLwJX5QT3UNWX3z8LqzLY6nx+EIVfmL3uCZ2H723Z0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgbu+3uICnilzU7yt4gSm3YEVbHVhirbcQsISXRWu4gqnqi9Wa2emvrvgygt1EpFE
	 32I7u1RHIwC29A5oaKIMevVrhZ20ST2jMpVPoTGIwYotmQiPzNAIH5JdYxd5SkKYcO
	 PXE+xIggAcD1T/W7iXoXXkmiXuwar32bLf4jdlPoMxeIIYOqiAi6l0xxD4s0513u9N
	 j9yh75kAPe/6fqdPoY/4UUx9KCuaApckykXEIYugO5TnYZap60X2XZJy3weg2y3K5K
	 4WZWHlNYn0sob0oiI+smCF9Y2kLPR+E/YXFe+Cg6YhsuhgzxiGZUtScKeI9djQpCyL
	 GRlSdW5d7vgwQ==
Date: Tue, 8 Jul 2025 20:43:52 +0530
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
Subject: Re: [PATCH v4 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
Message-ID: <g4aynbh4kve3kdbnxhwgogxdvylynpdfu47lq3m3ngj6abuk7b@ross7a2ilqtz>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-1-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-mhi_bw_up-v4-1-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:22PM GMT, Krishna Chaitanya Chundru wrote:
> If the link is not up till the pwrctl drivers enable power to endpoints
> then cur_bus_speed will not be updated with correct speed.
> 
> As part of rescan, pci_pwrctrl_notify() will be called when new devices
> are added and as part of it update the link bus speed.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..4c1d3832c43503a7e434a3fe5e0bf15a148434dc 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -10,16 +10,21 @@
>  #include <linux/pci-pwrctrl.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include "../pci.h"
>  
>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>  			      void *data)
>  {
>  	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
>  	struct device *dev = data;
> +	struct pci_bus *bus = to_pci_dev(dev)->bus;
>  
>  	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
>  		return NOTIFY_DONE;
>  
> +	if (bus->self)
> +		pcie_update_link_speed(bus);

I'm wondering why this should be in pwrctrl driver and not in pci_device_add()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

