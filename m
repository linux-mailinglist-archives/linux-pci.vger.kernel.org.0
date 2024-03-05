Return-Path: <linux-pci+bounces-4535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35430872813
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 20:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCAD1F2615F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1498C59B7A;
	Tue,  5 Mar 2024 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNB+Nzg7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F20288DB;
	Tue,  5 Mar 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668645; cv=none; b=bHs7lLuMfXC2e+YHPI+4eTT0J+f3dM3INdAFsFPZNIyIGcDSp6rI9d37P4frv7fhTlXEmWfOaLJugJZb0vIdNrRrtVgKFlb+bBkh9Tzc+eOgoWUawadB/lR7bq5acSPcOmfXK/8P7SJ7puwjDk7AX1ZHbpC9pKW7qXCED6hN+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668645; c=relaxed/simple;
	bh=8wa+zOHBLIE4I/7MiJkFX8y53MtrP2Fi3EMm7bDPgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B3tofqHLvDuhOb7Y7ahuIHlt+9/n2PyPbHBCu9Ov9xXGzkvIhUbNoPJPZVKPVLj6fW/NW+Oinyrp6UrrN2Wnt/S3awLOg3uWP97g8vQ+y7OgSrTq5qd702O9bfWz+wjxGVN/8lE2eBsSDDanrsKpYPnsHe60SA3N328FUDWaLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNB+Nzg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201E3C433C7;
	Tue,  5 Mar 2024 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709668644;
	bh=8wa+zOHBLIE4I/7MiJkFX8y53MtrP2Fi3EMm7bDPgZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FNB+Nzg7zp4BpiiNkgGtrRzsDl5CMdXmLSaHJwv9DyGQAjTS6HE6S4hJr7E8ifXmc
	 haofwhZh4kY515Rqs3saXnWCYWquQzHK6ZRuzd39CPbrCiyQiWrIKvbXnwIRir2jna
	 +uw0yH1V3kN71EuioZ9/ZJ6hXDgbHZ0ij83FxMIZ9/iiPATH/YQ+3s8PTHXqAmOZ7S
	 Jz8Lzz17ZEKnZyQXbQMxoBhXGkgcHfGcmKaWpbBHZA5VNqiwbSD6Fkoy4S1LT6VLtz
	 ThflGRpXB8mtRZFjMKg2n7d+GMuLR9nkdYePB/hdgFHTEJ623Eegcad66WxDRehASc
	 /Gsx52YL9SOdQ==
Date: Tue, 5 Mar 2024 13:57:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v2] PCI: dwc: Enable runtime pm of the host bridge
Message-ID: <20240305195722.GA541937@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com>

On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
> The Controller driver is the parent device of the PCIe host bridge,
> PCI-PCI bridge and PCIe endpoint as shown below.

Nit: add blank line here.

> 	PCIe controller(Top level parent & parent of host bridge)
> 			|
> 			v
> 	PCIe Host bridge(Parent of PCI-PCI bridge)
> 			|
> 			v
> 	PCI-PCI bridge(Parent of endpoint driver)
> 			|
> 			v
> 		PCIe endpoint driver

Nit: use spaces instead of tabs to ensure this still looks good when
"git log" indents this.  In this case it doesn't seem to matter,

> Since runtime PM is disabled for host bridge, the state of the child
> devices under the host bridge is not taken into account by PM framework
> for the top level parent, PCIe controller. So PM framework, allows
> the controller driver to enter runtime PM irrespective of the state
> of the devices under the host bridge.

IIUC this says that we runtime suspend the controller even though
runtime PM is disabled for the host bridge?  I have a hard time
parsing this; can you cite a function that does this or some relevant
documentation about how this part of runtime PM works?

> And this causes the topology breakage and also possible PM issues.

Not sure what this refers to, since you didn't mention topology
breakage earlier.  And "possible PM" issues is too vague to be useful.

> So enable pm runtime for the host bridge, so that controller driver
> goes to suspend only when all child devices goes to runtime suspend.

s/pm runtime/runtime PM/ so all the references match (unless you mean
something different here) (also in subject line)

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in v2:
> - Updated commit message as suggested by mani.
> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d5fc31f8345f..57756a73df30 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> @@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pp->ops->post_init)
>  		pp->ops->post_init(pp);
>  
> +	pm_runtime_set_active(&bridge->dev);

There are currently no callers of pm_runtime_set_active() in
drivers/pci/controller/.  This adds it to dw_pcie_host_init(), but it
doesn't seem to be a DWC-specific issue, so I assume other drivers and
driver cores like cadence and mobiveil should have this, too?

> +	pm_runtime_enable(&bridge->dev);

There are several existing calls of pci_runtime_enable(), including
from several DWC drivers.  Are they now redundant?

In addition, [1] suggests that pm_runtime_enable() should be called
*after* pm_runtime_set_active(), but these existing calls
(dra7xx_pcie_probe(), ks_pcie_probe(), qcom_pcie_probe(),
rcar_gen4_pcie_prepare(), tegra_pcie_config_rp()) happen *before*
dw_pcie_host_init() calls pm_runtime_set_active().

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/power/runtime_pm.rst?id=v6.7#n582

>  	return 0;
>  
>  err_stop_link:
> 
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240219-runtime_pm_enable-bdc17914bd50
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

