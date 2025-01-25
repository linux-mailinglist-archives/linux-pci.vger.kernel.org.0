Return-Path: <linux-pci+bounces-20358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD2A1C449
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD003A7880
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12622098;
	Sat, 25 Jan 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsOUjW+S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815C1372;
	Sat, 25 Jan 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737821800; cv=none; b=aBr0VYn8NDKH9buO7Di3nX7u6dKepEvt2+uyPDbNakvYPdeou++5yH6lFCD1ZTScdYY1y5YGs2UQ+Sj+LNnlS/eRzm7O58Rk98rBo5WO1PMuMhss+xpLiEY2x2WkNlLnG6EgC7pa/T/jEHcop5xj3nuQlLq69fhJobzL1lRL+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737821800; c=relaxed/simple;
	bh=yWJEn8zBPCM+vhRHeZAqLPayrGku3Jj0hMOlqCwBIaI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jrXyp87IrtTrz346vrnCSTNPSsInDWqUIWE7stMPe+Y3qVUQfAK3joMpTYW6BoSicDVhs+WzrJo9ZulyaNbKYtbMXN5Ai07V6zPeiKWXV1VDKUtxN/EHi6IpJZosyxu1SCUtfb/TRuyU5FHmJLSCh2/F5r0WeNAK+7UtZHG/OkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsOUjW+S; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737821799; x=1769357799;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yWJEn8zBPCM+vhRHeZAqLPayrGku3Jj0hMOlqCwBIaI=;
  b=IsOUjW+SH7jWHIPCGKPmeJyaCqupnREAnmM/MB1wC52Q3qdzRiKC7JvL
   v7OrfP3wsVbcGwov30QVWRUKgkw0FRRY8Af+clOHRwk0ac/XxElXFq+BM
   5a8tXnZaHGXU2ZwepjkhwSsGxoyRJEh7HYqEKjdTbuZag/k8s623qAppD
   MUbdBOARftmvMGxcbCSKBT7oPWFNx9MDjULoReLh1srYihKpNtWS5zawo
   QGGOYt9hCPY4klvbtb7dHvudVCjO2CXhq+4WEicLc3gjiDm4Kh73KHBq5
   vLUDRb1mwvQy3wbTgcbZiFu3lRTQQTOjNdjNJ3LulJWoZ6pbKFFTXOil2
   Q==;
X-CSE-ConnectionGUID: 2yetf9cmQhOzea3+jcNVVg==
X-CSE-MsgGUID: jRfwRC8eQv29jWnQsbgPBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="38507305"
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="38507305"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 08:16:38 -0800
X-CSE-ConnectionGUID: S7gogHSVQVKTN9VtzmLy6w==
X-CSE-MsgGUID: mV6XjxVbSbOvGEvgMQpeDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="107837842"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 08:16:37 -0800
Date: Sat, 25 Jan 2025 08:16:37 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, matthew.gerlach@altera.com, 
    peter.colberg@altera.com, 
    "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>, D@web.codeaurora.org, 
    M@web.codeaurora.org
Subject: Re: [PATCH v4 5/5] PCI: altera: Add Agilex support
In-Reply-To: <f2c9061a-6a9c-4cd1-8a3f-a286a2eb30a8@linux.intel.com>
Message-ID: <e3e95c4b-9b71-c2f5-4c83-2e4048627d89@linux.intel.com>
References: <20250123181932.935870-1-matthew.gerlach@linux.intel.com> <20250123181932.935870-6-matthew.gerlach@linux.intel.com> <f2c9061a-6a9c-4cd1-8a3f-a286a2eb30a8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1565007811-1737821797=:3336834"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1565007811-1737821797=:3336834
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 24 Jan 2025, Ilpo Järvinen wrote:

> On Thu, 23 Jan 2025, Matthew Gerlach wrote:
>
>> From: "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
>>
>> Add PCIe root port controller support for the Agilex family of chips.
>> The Agilex PCIe IP has three variants that are mostly sw compatible,
>> except for a couple register offsets. The P-Tile variant supports
>> Gen3/Gen4 1x16. The F-Tile variant supports Gen3/Gen4 4x4, 4x8, and 4x16.
>> The R-Tile variant improves on the F-Tile variant by adding Gen5 support.
>>
>> To simplify the implementation of pci_ops read/write functions,
>> ep_{read/write}_cfg() callbacks were added to struct altera_pci_ops
>> to easily distinguish between hardware variants.
>>
>> Signed-off-by: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>


[snip]

>> +}
>> +
>> +static inline void cra_writeb(struct altera_pcie *pcie, const u32 value,
>> +			      const u32 reg)
>> +{
>> +	writeb_relaxed(value, pcie->cra_base + reg);
>> +}
>> +
>> +static inline u32 cra_readb(struct altera_pcie *pcie, const u32 reg)
>> +{
>> +	return readb_relaxed(pcie->cra_base + reg);
>> +}
>> +
>>  static bool altera_pcie_link_up(struct altera_pcie *pcie)
>>  {
>>  	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
>> @@ -145,6 +185,15 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
>>  	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
>>  }
>>
>> +static bool aglx_altera_pcie_link_up(struct altera_pcie *pcie)
>> +{
>> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie,
>> +				   pcie->pcie_data->cap_offset +
>> +				   PCI_EXP_LNKSTA);
>> +
>> +	return !!(readw_relaxed(addr) & PCI_EXP_LNKSTA_DLLLA);
>
> This returns bool so double negations are not necessary.

I will remove unecessary !!

>
>> +}
>> +
>>  /*
>>   * Altera PCIe port uses BAR0 of RC's configuration space as the translation
>>   * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
>> @@ -425,6 +474,103 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
>>  	return PCIBIOS_SUCCESSFUL;
>>  }
>>
>> +static int aglx_rp_read_cfg(struct altera_pcie *pcie, int where,
>> +			    int size, u32 *value)
>> +{
>> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
>> +
>> +	switch (size) {
>> +	case 1:
>> +		*value = readb_relaxed(addr);
>> +		break;
>> +	case 2:
>> +		*value = readw_relaxed(addr);
>> +		break;
>> +	default:
>> +		*value = readl_relaxed(addr);
>> +		break;
>> +	}
>> +
>> +	/* interrupt pin not programmed in hardware, set to INTA */
>> +	if (where == PCI_INTERRUPT_PIN && size == 1 && !(*value))
>> +		*value = 0x01;
>> +	else if (where == PCI_INTERRUPT_LINE && !(*value & 0xff00))
>> +		*value |= 0x0100;
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static int aglx_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
>> +			     int where, int size, u32 value)
>> +{
>> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
>> +
>> +	switch (size) {
>> +	case 1:
>> +		writeb_relaxed(value, addr);
>> +		break;
>> +	case 2:
>> +		writew_relaxed(value, addr);
>> +		break;
>> +	default:
>> +		writel_relaxed(value, addr);
>> +		break;
>> +	}
>> +
>> +	/*
>> +	 * Monitor changes to PCI_PRIMARY_BUS register on root port
>> +	 * and update local copy of root bus number accordingly.
>> +	 */
>> +	if (busno == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
>> +		pcie->root_bus_nr = value & 0xff;
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static int aglx_ep_write_cfg(struct altera_pcie *pcie, u8 busno,
>> +			     unsigned int devfn, int where, int size, u32 value)
>> +{
>> +	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
>> +	if (busno > AGLX_RP_SECONDARY(pcie))
>> +		where |= BIT(12); /* type 1 */
>
> Add a define to replace the comment?

I will create a suitably name macro; so that a comment won't be necessary.

>
>> +
>> +	switch (size) {
>> +	case 1:
>> +		cra_writeb(pcie, value, where);
>> +		break;
>> +	case 2:
>> +		cra_writew(pcie, value, where);
>> +		break;
>> +	default:
>> +		cra_writel(pcie, value, where);
>> +			break;
>> +	}
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static int aglx_ep_read_cfg(struct altera_pcie *pcie, u8 busno,
>> +			    unsigned int devfn, int where, int size, u32 *value)
>> +{
>> +	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
>> +	if (busno > AGLX_RP_SECONDARY(pcie))
>> +		where |= BIT(12); /* type 1 */
>
> Same here?

Yes, use a better macro here too.

>
> -- 
> i.

Thanks for the review,
Matthew Gerlach

>
>
--8323329-1565007811-1737821797=:3336834--

