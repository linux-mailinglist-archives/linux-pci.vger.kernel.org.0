Return-Path: <linux-pci+bounces-38483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40132BE92E8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819956E1ABC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC73396F2;
	Fri, 17 Oct 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Svnw1jhg"
X-Original-To: linux-pci@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82633971C
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711072; cv=none; b=Z3Uy2bfmipkT5sN41mmsazFxLQDD6+tkEPdAf8VTDgtBDk4NUj/MB7e2TF34zZ/u9yh4/tmWyxevfOV9fm+4to07IVfyNxklY+/lGrNF3zCQ7VXbsVoGIkzFYixfsFS7idCFFhyG36YqnSaoLfAF/9SCLZpyU3k6HOR6qsj6Ge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711072; c=relaxed/simple;
	bh=706xBnB4fYLv2jjlmSiFVHGjWvbAX3OJViQ92vBMWWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsRNq9Cl80sGzd4u1kKkVOUZrE3dX5nFWGyrfKx8/JhpNbBMsaYLJogEdte3YzkfX3GcpAZMRAu6tOAK+6kzkGakl15E0XDbgpFDRGveGk3Ancfaw396v850L7TVymFm25lq/Nztt1NBaf/Ep0uVF1F4BsGSk6csWwYaVeL/2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Svnw1jhg; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 9k3wv6tjVeNqi9lNXv0vw7; Fri, 17 Oct 2025 14:24:24 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 9lNUv2Pb4HyqZ9lNUvyIew; Fri, 17 Oct 2025 14:24:20 +0000
X-Authority-Analysis: v=2.4 cv=G4EcE8k5 c=1 sm=1 tr=0 ts=68f25197
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=3N43v1ldxO06oT20SBYA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Whjp/o8gAymLru/lmY44LsapSkUqY4dx4+MOKj6v9O4=; b=Svnw1jhgLJAK9WG4DToR+cIyEA
	7HkdsRua88axA2oaNpeNKx9BEaY+qoekWcfNr8xNnGtRijTGlpgNQCQlL9EyMVm8la2IRME9BEtNe
	vBQiyv4A9c4D36aLWtKkutdkzzWWHnMd9oJ+gSi8R7JaqaSHAvZ87Uzpi1vfSfnSVB8/puikTvUO1
	u2/M1LxXRVXGMFbgGOo4CieNfPRE5rX+J3r2YW0EpR4PtS/xGJinYiV224n9iXN6nSPAGR22AXbnZ
	AsQdgVhlDWw/gn1CS53IKkmshlIxL5JT27EDrQJnWbkSVynuSw7PMPSxKNTUP8EJFOgkt4w87245o
	l0g5OTXg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:52300 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v9lNU-00000002ibW-0AQJ;
	Fri, 17 Oct 2025 08:24:20 -0600
Message-ID: <ce932cec-e9e2-4322-a68c-cef5c01b3b16@w6rz.net>
Date: Fri, 17 Oct 2025 07:24:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>
 <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1v9lNU-00000002ibW-0AQJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:52300
X-Source-Auth: re@w6rz.net
X-Email-Count: 15
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFVC4WlkvoZrV8IUYRTT0Y2KMiOTYNALD5OdZX78/w1VDV3j+O1BSfa16qcCNMAMlmVPVm5ivr5B/8eJ9JAxOT+UVR9hqmyeV5vz8zXQVwO5ehBRWyjj
 j3OB5BrtsNxDTaOwsgz2QjQVlDo7hSjw3usK5N1N0pKaoAavT3gUoE/C/eTA5w+/IvoLRsjcGQ/kRwhIzOmJIlWpqMjYdGEyv1Y=

On 10/17/25 04:40, Krishna Chaitanya Chundru wrote:
> When the vendor configuration space is 256MB aligned, the DesignWare
> PCIe host driver enables ECAM access and sets the DBI base to the start
> of the config space. This causes vendor drivers to incorrectly program
> iATU regions, as they rely on the DBI address for internal accesses.
>
> To fix this, avoid overwriting the DBI base when ECAM is enabled.
> Instead, introduce a custom ECAM PCI ops implementation that accesses
> the DBI region directly for bus 0 and uses ECAM for other buses.
>
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 28 +++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -23,6 +23,7 @@
>   #include "pcie-designware.h"
>   
>   static struct pci_ops dw_pcie_ops;
> +static struct pci_ops dw_pcie_ecam_ops;
>   static struct pci_ops dw_child_pcie_ops;
>   
>   #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
> @@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *re
>   	if (IS_ERR(pp->cfg))
>   		return PTR_ERR(pp->cfg);
>   
> -	pci->dbi_base = pp->cfg->win;
> -	pci->dbi_phys_addr = res->start;
> -
>   	return 0;
>   }
>   
> @@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>   		if (ret)
>   			return ret;
>   
> -		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +		pp->bridge->ops = &dw_pcie_ecam_ops;
>   		pp->bridge->sysdata = pp->cfg;
>   		pp->cfg->priv = pp;
>   	} else {
> @@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>   
> +static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct dw_pcie_rp *pp = cfg->priv;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	unsigned int busn = bus->number;
> +
> +	if (busn > 0)
> +		return pci_ecam_map_bus(bus, devfn, where);
> +
> +	if (PCI_SLOT(devfn) > 0)
> +		return NULL;
> +
> +	return pci->dbi_base + where;
> +}
> +
>   static struct pci_ops dw_pcie_ops = {
>   	.map_bus = dw_pcie_own_conf_map_bus,
>   	.read = pci_generic_config_read,
>   	.write = pci_generic_config_write,
>   };
>   
> +static struct pci_ops dw_pcie_ecam_ops = {
> +	.map_bus = dw_pcie_ecam_conf_map_bus,
> +	.read = pci_generic_config_read,
> +	.write = pci_generic_config_write,
> +};
> +
>   static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>
Works good on the SiFive FU740 controller.

Tested-by: Ron Economos <re@w6rz.net>


