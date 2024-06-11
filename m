Return-Path: <linux-pci+bounces-8617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682F904754
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B511F234E1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25270155732;
	Tue, 11 Jun 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA2Cs6I1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3787D3FA;
	Tue, 11 Jun 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146591; cv=none; b=mubPdkyNYjN/OhuXWoetP6FENoqR/2R3BRSY/q+mg6RZkCeyzWPjsMdSK+AoevgDAOktHgSLOA/GnZ0A41yNyCUouswFXXhQx1P5MeV5pJSAo+J5TrslA1QSYUwaZ6tH7wZbHFpvIE6iNMxsnlpGMWwQ6s0e/Rv4UDGnzqJQx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146591; c=relaxed/simple;
	bh=qnNWTWk0UrgyhvUjk0j87kljyjnbkKARlOWolh0T5tw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m6rZM+itVvoYSFXR2HBXLTgWKY+Ua+t1a/TzFBJNlrLLCY+EMAIQEji0sosPF52hWrsHm3NCMdGd/EuT5AsTjFurtSB5QmXOrrpZelF+AiV5LmDzUuRs6DeJm/0IIcbmH5EsFDqmPXctxWSYeUoMh5EpsfZSUxmwH/tjTRpnbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA2Cs6I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36142C2BD10;
	Tue, 11 Jun 2024 22:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718146590;
	bh=qnNWTWk0UrgyhvUjk0j87kljyjnbkKARlOWolh0T5tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BA2Cs6I1BYbjUh7E1G9n4X7oIKQ+SDHio2B3ehBM9+FfN7UHRGYljUoeXk41tmjBk
	 ker4TmT/a0IKRWDRVXOeVZYzqwh7Ka/WsKnyALVe4mTtvhMF2FdPI8j7ZrBsR1M3LO
	 Nx+NkX7AcMkh7smKLa6WylB9wPJg059VPN84hJmPVZRHjxubr6oMsd6Rp4xPSruIDM
	 MGAJdOSGevzLQR/qcHvMxEjoSlTbS9pFhBP6hjAgFnuXPw2WZtX7d3MWBySJG3l08c
	 MOWQrcBACAq9HTplPxxxswYW+awMscqOryBFh0i2sGUoSLae74mqPiFXFJt2OnypTU
	 edN/9Z3wjCixA==
Date: Tue, 11 Jun 2024 17:56:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 14/17] PCI/pwrctl: create platform devices for child
 OF nodes of the port node
Message-ID: <20240611225628.GA1005877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-14-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In preparation for introducing PCI device power control - a set of
> library functions that will allow powering-up of PCI devices before
> they're detected on the PCI bus - we need to populate the devices
> defined on the device-tree.
> 
> We are reusing the platform bus as it provides us with all the
> infrastructure we need to match the pwrctl drivers against the
> compatibles from OF nodes.
> 
> These platform devices will be probed by the driver core and bound to
> the PCI pwrctl drivers we'll introduce later.
> 
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With s/create/Create/ in subject,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/bus.c    | 9 +++++++++
>  drivers/pci/remove.c | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 826b5016a101..3e3517567721 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>  
> @@ -354,6 +355,14 @@ void pci_bus_add_device(struct pci_dev *dev)
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
>  
>  	pci_dev_assign_added(dev, true);
> +
> +	if (pci_is_bridge(dev)) {
> +		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
> +					      &dev->dev);
> +		if (retval)
> +			pci_err(dev, "failed to populate child OF nodes (%d)\n",
> +				retval);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>  
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..910387e5bdbf 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
>  #include <linux/module.h>
> +#include <linux/of_platform.h>
>  #include "pci.h"
>  
>  static void pci_free_resources(struct pci_dev *dev)
> @@ -18,7 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
>  	pci_pme_active(dev, false);
>  
>  	if (pci_dev_is_added(dev)) {
> -
> +		of_platform_depopulate(&dev->dev);
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> 
> -- 
> 2.43.0
> 

