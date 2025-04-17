Return-Path: <linux-pci+bounces-26082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A31EAA918E4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 12:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471A419E2FB2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6222A7FE;
	Thu, 17 Apr 2025 10:13:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13971D63D6;
	Thu, 17 Apr 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884803; cv=none; b=IhF0w8dGToMUpwYFc/2gb69zPdLi7Sh2SXZPIJdlZ17qoyzkA4bj7FXbqvDKfuYWIeC/1sr5Dq1H/bGNc0yKeF9aVjd/4weV71bs4OWBwAWyjRoubsvDpgdZrezfD21LVLOfxjM4kP/eaPn0D8ERdRRbyCqpfPSIqSV9rxLwNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884803; c=relaxed/simple;
	bh=/i89Akd76Mhyz5w3Hye3H1Pj5d4OFWyxCf/sdlT3SQc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onrlgo1kG7teguSzRBr7cRgBWsGOwsmwFJjo2MlJOPcggAlhyFNKmhcU9LN+QPClqIxhWXoCZykR2iLrqAVtUBEjLKxcantownsPEls5gRzrDCHTMK7Rsz3NLn5ufBoFG1zZAt9UeHIKQEKBfmWELfGYYprz084cVy9D35Utcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZdYWp4Wvwz6K9Kg;
	Thu, 17 Apr 2025 18:08:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C46B14050C;
	Thu, 17 Apr 2025 18:13:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 12:13:10 +0200
Date: Thu, 17 Apr 2025 11:13:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 16/16] CXL/PCI: Disable CXL protocol errors during
 CXL Port cleanup
Message-ID: <20250417111309.00000672@huawei.com>
In-Reply-To: <97a53556-4e01-40ed-80da-0369f401ceda@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-17-terry.bowman@amd.com>
	<20250404180427.00007602@huawei.com>
	<97a53556-4e01-40ed-80da-0369f401ceda@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

Hi Terry,

> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index d3068f5cc767..d1ef0c676ff8 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -977,6 +977,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
> >>  
> >> +/**
> >> + * pci_aer_mask_internal_errors - mask internal errors
> >> + * @dev: pointer to the pcie_dev data structure
> >> + *
> >> + * Masks internal errors in the Uncorrectable and Correctable Error
> >> + * Mask registers.
> >> + *
> >> + * Note: AER must be enabled and supported by the device which must be
> >> + * checked in advance, e.g. with pcie_aer_is_native().
> >> + */
> >> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
> >> +{
> >> +	int aer = dev->aer_cap;
> >> +	u32 mask;
> >> +
> >> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> >> +	mask |= PCI_ERR_UNC_INTN;
> >> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> >> +  
> > It does an extra clear we don't need, but....
> > 	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
> > 				       0, PCI_ERR_UNC_INTN);
> >
> > 	is at very least shorter than the above 3 lines.  
> Doing so will overwrite the existing mask. CXL normally only uses AER UIE/CIE but if the device
> happens to lose alternate training and no longer identifies as a CXL device than this mask
> value would be critical for reporting PCI AER errors and would need UCE/CE enabled (other
> than UIE/CIE).
I'm not seeing that.  Implementation of pci_clear_and_set_config_dword() is:
void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
				    u32 clear, u32 set)
{
	u32 val;

	pci_read_config_dword(dev, pos, &val);
	val &= ~clear;
	val |= set;
	pci_write_config_dword(dev, pos, val);
}

With clear parameter as zero it will do the same the open coded
version you have above as the ~clear will be all 1s and hence
&= ~clear has no affect.

Arguably we could add pci_clear_config_dword() and pci_set_config_dword()
that both take one fewer parameter but I guess that is not worth
the bother.

Jonathan




