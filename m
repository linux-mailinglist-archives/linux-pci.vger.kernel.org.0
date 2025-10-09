Return-Path: <linux-pci+bounces-37761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEBBC97D3
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 16:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E634D19D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801012EA48E;
	Thu,  9 Oct 2025 14:24:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982482EA482;
	Thu,  9 Oct 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019865; cv=none; b=ciMRZGYvI6nI6sziffK8aVxYNvKF44zts5BjCIIDuz6Ilqvff0bBQ/7PeUnIZuIvwz3T/XRHTuW32Pmbn4QQor6IgJdtFMVdo2t/Qs3qVvqCV6kL0ztnkTN8chE4pQ3/zmTwpB4VnEPEOCSKfZ054m2C/2jjnDbv1PKIeQtIPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019865; c=relaxed/simple;
	bh=wzThbFBUUideRSzeEE49g3wu4P5JNp2dfbBPjavJKbc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KajZd6CGfS6iJoVfpGCM9TLcwvDkb4T3vwPlDd1+ltQtc02BE9Jcpnmzf0nmW5fVutzIvaig8BZRKIg9MFS5Up1PWGnvNJXQyZuU05ADOwtyrO4TS6ugZhOr8I8xdPG/Dt8dpo9YPPPROy33YNFFhCpAnBX/kKAFmOfXdfry3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjBtv67VHz6L55G;
	Thu,  9 Oct 2025 22:23:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EC5A14025A;
	Thu,  9 Oct 2025 22:24:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 15:24:17 +0100
Date: Thu, 9 Oct 2025 15:24:15 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Evangelos Petrongonas <epetron@amazon.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, Chris Li
	<chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>, "Pratyush Yadav"
	<pratyush@kernel.org>, Stanislav Spassov <stanspas@amazon.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [RFC PATCH 04/13] pci: pcsc: infer PCIe extended capabilities
Message-ID: <20251009152415.00000b07@huawei.com>
In-Reply-To: <026b1d3e3fcb2a554511de3f23d6a7640b5377b6.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<026b1d3e3fcb2a554511de3f23d6a7640b5377b6.1759312886.git.epetron@amazon.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 3 Oct 2025 09:00:40 +0000
Evangelos Petrongonas <epetron@amazon.de> wrote:

> Extend PCSC to support cacheability inference for PCIe extended
> capabilities located in the 4KB extended configuration space.
> 
> Similar to the capabilities, PCIe extended capabilities require
> traversal of the capability list to determine cacheability. The
> implementation identifies cacheable registers for capabilities used
> by the generic PCIe driver:
> 
> - Advanced Error Reporting (AER)
> - Access Control Services (ACS)
> - Alternative Routing-ID (ARI)
> - SR-IOV
> - Address Translation Services (ATS)
> - Page Request Interface (PRI)
> - Process Address Space ID (PASID)
> - Downstream Port Containment (DPC)
> - Precision Time Measurement (PTM)
> 
> The extended capability header (4 bytes) is always cached to enable
> efficient capability list traversal.
> 
> All the extended capabilities apart from the DPC are static. Regarding
> DPC, the DPC capabilities is read and based on its value the
> cacheability of RP* registers is inferred.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
A few comments below.

> ---
>  drivers/pci/pcsc.c | 203 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
> 
> diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
> index 29945eac4190..343f8b03831a 100644
> --- a/drivers/pci/pcsc.c
> +++ b/drivers/pci/pcsc.c

> +static void infer_extended_capabilities_pointers(struct pci_dev *dev)
> +{
> +	int pos = 0x100;
> +	u32 header;
> +	int cap_ver, cap_id;
> +	int i;
> +
	if (!IS_ENABLED(CONFIG_PCIE_PCSC))
		return;

is probably enough to allow the compiler to get rid of everything without
the ifdef magic.

> +	while (pos) {
> +		if (pos > 0xFFC || pos < 0x100)
> +			break;
> +
> +		pos &= ~0x3;
> +
> +		if (pcsc_hw_config_read(dev->bus, dev->devfn, pos, 4,
> +					&header) != PCIBIOS_SUCCESSFUL)
> +			break;
> +
> +		if (!header)
> +			break;
> +
> +		bitmap_set(dev->pcsc->cachable_bitmask, pos, 4);
> +		for (i = 0; i < 4; i++)
> +			pcsc_update_byte(dev, pos + i,
> +					 (header >> (i * 8)) & 0xFF);
> +
> +		cap_id = PCI_EXT_CAP_ID(header);
> +		cap_ver = PCI_EXT_CAP_VER(header);
> +
> +		pci_dbg(dev,
> +			"Extended capability ID %#x (ver %d) found at %#x, next cap at %#x\n",
> +			cap_id, cap_ver, pos, PCI_EXT_CAP_NEXT(header));
> +
> +		/* Check if this is a supported extended capability and infer cacheability */
> +		for (i = 0; i < ARRAY_SIZE(PCSCS_SUPPORTED_EXT_CAPABILITIES);
> +		     i++) {
> +			if (cap_id == PCSCS_SUPPORTED_EXT_CAPABILITIES[i]) {
> +				infer_extended_capability_cacheability(dev, pos,
> +								       cap_id);
> +				break;
> +			}
> +		}
> +
> +		pos = PCI_EXT_CAP_NEXT(header);
> +	}
> +}
> +#endif
> +
>  static void infer_cacheability(struct pci_dev *dev)
>  {
>  	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
> @@ -432,6 +631,10 @@ static void infer_cacheability(struct pci_dev *dev)
>  		}
>  
>  		infer_capabilities_pointers(dev);
> +#ifdef CONFIG_PCIE_PCSC
> +		if (pci_is_pcie(dev))
> +			infer_extended_capabilities_pointers(dev);
> +#endif
>  	}
>  }
>  


