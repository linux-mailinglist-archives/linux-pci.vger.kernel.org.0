Return-Path: <linux-pci+bounces-43627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E005CCDB29B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 03:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F3D3042FCC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686AD256C8D;
	Wed, 24 Dec 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pe3n+vxu"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50293244679;
	Wed, 24 Dec 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766542856; cv=none; b=GAnt8PPFNY5h0wg9DI3QhH3Wfk1fiPhm5u6RKVC0k680QhgBh+ozvobOxzS0LwsAUeuT+ylDXUv6riRzaNzxxT+g0HR2ddyjDHfZ9NxJqa3E3HWhoIdA/2lYKDSgZaamxVsZ+cMEIptybKvG7qMMtxThpwY295L8Kymu03I2rW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766542856; c=relaxed/simple;
	bh=9O9faazJu3EsJfOqlRbYed3HL2nlOiZpf1l1+gAtJu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeSKeWELz55ichF1AlEXzdQxUswRTlk1Mxly1g+l4NVbPA/AI5Hl7bfpRR00vIAzj9mvNRCKEqc8YQsHQ5KqlMvarBRnrHUV+Bz9+IkKMoSv25pZufGKKdZTll+3gwtPaP0NoJ4rUeY8ZdW2B9dm0sLgIQN7vkGnahSEeGAxohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pe3n+vxu; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766542843; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DsuUw8mDsVFd2QwMG/+NlitjPB43hNju25EUa8abfJ4=;
	b=Pe3n+vxuqY7Tlr5Qv7N9Q3wQiDOu1z43j7n7VMLRAniWPANf95GPtcbmmTBftbyhuiJuTzoMpcVuLJDjyNiLRQ8FTtsLdWtrzVFWBUZJB6OGhrwUblnNzUew0UyvR4JzJ61XUcp8rDIton3MjUjAND3iCHf96QRL37y8pAOiUUY=
Received: from 30.246.163.226(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WvZKr8p_1766542840 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 10:20:41 +0800
Message-ID: <eb991e64-21ec-4d26-b5cc-e2061163d0c4@linux.alibaba.com>
Date: Wed, 24 Dec 2025 10:20:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5 v8] ACPI: extlog: Trace CPER PCI Express Error Section
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Rafael J Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
References: <20251219124042.3759749-1-fabio.m.de.francesco@linux.intel.com>
 <20251219124042.3759749-3-fabio.m.de.francesco@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251219124042.3759749-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/25 8:39 PM, Fabio M. De Francesco wrote:
> I/O Machine Check Architecture events may signal failing PCIe components
> or links. The AER event contains details on what was happening on the wire
> when the error was signaled.
> 
> Trace the CPER PCIe Error section (UEFI v2.11, Appendix N.2.7) reported
> by the I/O MCA.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>   drivers/acpi/acpi_extlog.c | 34 ++++++++++++++++++++++++++++++++++
>   drivers/pci/pcie/aer.c     |  2 +-
>   2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 47d11cb5c9120..88a2237772c26 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -132,6 +132,36 @@ static int print_extlog_rcd(const char *pfx,
>   	return 1;
>   }
>   
> +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> +			      int severity)
> +{
> +#ifdef ACPI_APEI_PCIEAER
> +	struct aer_capability_regs *aer;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	unsigned int bus;
> +	int aer_severity;
> +	int domain;
> +
> +	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
> +		return;
> +
> +	aer_severity = cper_severity_to_aer(severity);
> +	aer = (struct aer_capability_regs *)pcie_err->aer_info;
> +	domain = pcie_err->device_id.segment;
> +	bus = pcie_err->device_id.bus;
> +	devfn = PCI_DEVFN(pcie_err->device_id.device,
> +			  pcie_err->device_id.function);
> +	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> +	if (!pdev)
> +		return;
> +
> +	pci_print_aer(pdev, aer_severity, aer);
> +	pci_dev_put(pdev);
> +#endif
> +}
> +
>   static int extlog_print(struct notifier_block *nb, unsigned long val,
>   			void *data)
>   {
> @@ -183,6 +213,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>   			if (gdata->error_data_length >= sizeof(*mem))
>   				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>   						       (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +			extlog_print_pcie(pcie_err, gdata->error_severity);

Hi, Fabio,

If PCIe errors are signaled by IOMCA, do we also need to queue a work to
recover the error like we do in ghes_handle_aer()?

Thanks.
Shuai

