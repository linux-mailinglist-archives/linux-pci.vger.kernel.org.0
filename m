Return-Path: <linux-pci+bounces-11150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDB94551F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 02:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DF91F23265
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C9A2D;
	Fri,  2 Aug 2024 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMExmrcr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE6360;
	Fri,  2 Aug 2024 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557250; cv=none; b=jWxi5N1klc1x0XetwgtoHF9vru/q+pn3vNVogt0ROmP8L9WgRTfQ6bHvC5Im0guP/e/m9I8MZB3q4JKs+kaePDmXwA7eFw3/jUtBGpb48YwYWRksj5NGDhkVkIcPcK9+Qs2sm5tVTrJnyhes/kP3nRwZZGv7Fuo+NAAmbLjw3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557250; c=relaxed/simple;
	bh=480Hl3jwn1Ih92fLQP1Sp7/tFQ6zgQh8HN6mC/eWRTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pIMLXZ3PrR/MmzDlitTbjxU3sJbWg2xecEUxurNX143MxP/oZQaXlbyqTYT1SMlJJa7KvdyoMB0feLl8fYqK9aCyKsHjSo6penzpwuFyA1q2oRgVBA5Wk2pTj5FYH0dhpVsNuYprsY+KupyLwqFmNGYZLYHnNLjZJ35+Ut5TtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMExmrcr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722557249; x=1754093249;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=480Hl3jwn1Ih92fLQP1Sp7/tFQ6zgQh8HN6mC/eWRTc=;
  b=JMExmrcrsLSUowQLO5mn1rONxTXCdwLDUKhdvSZgcue0Li+XfWersp1R
   jcKfhOXvAQVZmJGvayZVDZ4Lpq4ey/7QJR75bPuJwlzCqMM+SSSYCQtnn
   W7ZmDNj9YYB1oOoF9+rH31rhcjLTkXWYxwsLas9zFenesOft6AC8b9iyQ
   ab74Vv0dh0HYO8/SxUonc21xyNG4a2q2q0TCvcSIqAUEmcHeqLMdcU2Zc
   HIzfdcibgYVuYM2Zx19UKcFLA1KzSlXAf2Fo3mVBYHRmq/cXbcfL9k7Tk
   nfwRFTo6B5ZExanLTA2FVWgeyqofVdWwnlzdcd967eYtZzsHlSdV0tQis
   g==;
X-CSE-ConnectionGUID: wqJKR5rMRs2nRXCOpkB25Q==
X-CSE-MsgGUID: PsU3CYCWQEK0puXbsV80jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20669305"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="20669305"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 17:07:28 -0700
X-CSE-ConnectionGUID: OovOfOATSByRd96rvGRPAQ==
X-CSE-MsgGUID: PVB3ueKpRjWU8FTDpSKk7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="55133000"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 17:07:27 -0700
Date: Thu, 1 Aug 2024 17:07:21 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>,
	D@bhelgaas.smtp.subspace.kernel.org,
	M@bhelgaas.smtp.subspace.kernel.org
Subject: Re: [PATCH 7/7] pci: controller: pcie-altera: Add support for
 Agilex
In-Reply-To: <20240731202338.GA78770@bhelgaas>
Message-ID: <09d513c-5cc-e110-333-891bf1163331@linux.intel.com>
References: <20240731202338.GA78770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 31 Jul 2024, Bjorn Helgaas wrote:

> In subject:
>
>  PCI: altera: Add Agilex support
>
> to match style of history.

I will change the subject to match the style of history.

>
>>  #define TLP_CFG_DW1(pcie, tag, be)	\
>> -	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
>> +	(((TLP_REQ_ID((pcie)->root_bus_nr,  RP_DEVFN)) << 16) | ((tag) << 8) | (be))
>
> Seems OK, but unrelated to adding Agilex support, so it should be a
> separate patch.

Yes, it is unrelated to Agilex and should be in a separate patch.

>
>> +#define AGLX_RP_CFG_ADDR(pcie, reg)	\
>> +	(((pcie)->hip_base) + (reg))
>
> Fits on one line.

One line would be better.

>
>> +#define AGLX_BDF_REG 0x00002004
>> +#define AGLX_ROOT_PORT_IRQ_STATUS 0x14c
>> +#define AGLX_ROOT_PORT_IRQ_ENABLE 0x150
>> +#define CFG_AER                   BIT(4)
>
> Indent values to match #defines above.
>
>>  static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
>>  				    int offset)
>>  {
>> -	if (pci_is_root_bus(bus) && (devfn == 0) &&
>> -	    (offset == PCI_BASE_ADDRESS_0))
>> +	if (pci_is_root_bus(bus) && devfn == 0 && offset == PCI_BASE_ADDRESS_0)
>>  		return true;
>
> OK, but again unrelated to Agilex.
>
>> @@ -373,7 +422,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
>>  	 * Monitor changes to PCI_PRIMARY_BUS register on root port
>>  	 * and update local copy of root bus number accordingly.
>>  	 */
>> -	if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
>> +	if (bus == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
>
> Ditto.
>
>> @@ -577,7 +731,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
>>  			dev_err(dev, "link retrain timeout\n");
>>  			break;
>>  		}
>> -		udelay(100);
>> +		usleep_range(50, 150);
>
> Where do these values come from?  Needs a comment, ideally with a spec
> citation.
>
> How do we know a 50us delay is enough when we previously waited at
> least 100us?

This is an unrelated change to Agilex and possibly wrong. I will remove 
both instances of the change from this patch.

>
>> @@ -590,7 +744,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
>>  			dev_err(dev, "link up timeout\n");
>>  			break;
>>  		}
>> -		udelay(100);
>> +		usleep_range(50, 150);
>
> Ditto.
>
>> +static void aglx_isr(struct irq_desc *desc)
>> +{
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct altera_pcie *pcie;
>> +	struct device *dev;
>> +	u32 status;
>> +	int ret;
>> +
>> +	chained_irq_enter(chip, desc);
>> +	pcie = irq_desc_get_handler_data(desc);
>> +	dev = &pcie->pdev->dev;
>>
>> +	status = readl(pcie->hip_base + pcie->pcie_data->port_conf_offset +
>> +		       pcie->pcie_data->port_irq_status_offset);
>> +	if (status & CFG_AER) {
>> +		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
>> +		if (ret)
>> +			dev_err_ratelimited(dev, "unexpected IRQ,\n");
>
> Was there supposed to be more data here, e.g., an IRQ %d or something?
> Or is it just a spurious "," at the end of the line?

It is a spurious "," that will be removed.

>
>>  	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
>> -					&intx_domain_ops, pcie);
>> +						 &intx_domain_ops, pcie);
>
> Cleanup that should be in a separate patch.  *This* patch should have
> the absolute minimum required to enable Agilex to make it easier to
> review/backport/revert/etc.

I will ensure this patch has the absolute minimum required to enable 
Agilex.

>
>> +static const struct altera_pcie_data altera_pcie_3_0_f_tile_data = {
>> +	.ops = &altera_pcie_ops_3_0,
>> +	.version = ALTERA_PCIE_V3,
>> +	.cap_offset = 0x70,
>
> It looks like this is where the PCIe Capability is?  There's no way to
> discover this offset, e.g., by following the capability list like
> pci_find_capability() does?

The cap_offset structure member is the offset in the "Hip" memory space 
where the PCIe Capability starts. The offset is explicitly stated in the 
relevent documentation for Statix10 and Agilex. One could follow the 
capability list, but adding a function like __pci_find_next_cap_ttl() 
seems like a bigger change than having the constants.

Thanks for the review,
Matthew

> Bjorn
>

