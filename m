Return-Path: <linux-pci+bounces-39540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D3C153C0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD28234E06C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332123EAA0;
	Tue, 28 Oct 2025 14:48:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25F23AB88;
	Tue, 28 Oct 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662905; cv=none; b=Gq7zUdqg8oXohVlPWpgdY0eKrCOjkIMAVEQfu6LgKvbKdueeWh2Vh4e1MyJYKTlKgCqhJgz6XiQ+JMN7eJS9rOi7BkxD1976JdX5nHDFvhFC6N344RjRH1jgZHF94GlWX3+v3F5VxUK96hz76IqNnXbiLQDI9+cqcqKJ83PL6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662905; c=relaxed/simple;
	bh=u5tgenMRvxilh77m58rybstaqB+YjCZ+fqhpsL+7yLw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mq9gL0wZWsTB9kTKImcCnK73lnSJTd6ZCZCt9Ausw1czj50z0Ydeqod8MY4okFcuielxAYdVJEUOUKKsyXb84XOQzR/33YLljUQYNKimBQJdPDe/77almzqnyIhhoBjqpEvihSaXSk7JOxfJ87S7OoZEcUzthknCtf1RSs+8uX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwtSH23J8z6M4hV;
	Tue, 28 Oct 2025 22:44:31 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9749D1400D3;
	Tue, 28 Oct 2025 22:48:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 14:48:18 +0000
Date: Tue, 28 Oct 2025 14:48:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Sunil V L <sunilvl@ventanamicro.com>, Xiaofei Tan <tanxiaofei@huawei.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Huacai Chen
	<chenhuacai@kernel.org>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, Arnd Bergmann <arnd@arndb.de>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Guo
 Weikang" <guoweikang.kernel@gmail.com>, Xin Li <xin@zytor.com>, Will Deacon
	<will@kernel.org>, Huang Yiwei <quic_hyiwei@quicinc.com>, Gavin Shan
	<gshan@redhat.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6n?=
 =?ISO-8859-1?Q?ig?= <u.kleine-koenig@baylibre.com>, Li Ming
	<ming.li@zohomail.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Karolina Stolarek
	<karolina.stolarek@oracle.com>, Jon Pan-Doh <pandoh@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Shiju Jose <shiju.jose@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/6 v6] ACPI: extlog: Trace CPER PCI Express Error
 Section
Message-ID: <20251028144816.000018a3@huawei.com>
In-Reply-To: <20251023122612.1326748-3-fabio.m.de.francesco@linux.intel.com>
References: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
	<20251023122612.1326748-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 14:25:37 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> I/O Machine Check Architecture events may signal failing PCIe components
> or links. The AER event contains details on what was happening on the wire
> when the error was signaled.
> 
> Trace the CPER PCIe Error section (UEFI v2.10, Appendix N.2.7) reported
> by the I/O MCA.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Hi Fabio,

Was taking a fresh look at this as a precursor to looking at later
patches in series and spotted something that I'm doubtful about.

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 47d11cb5c912..cefe8d2d8aff 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -132,6 +132,34 @@ static int print_extlog_rcd(const char *pfx,
>  	return 1;
>  }
>  
> +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> +			      int severity)
> +{
> +	struct aer_capability_regs *aer;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	unsigned int bus;
> +	int aer_severity;
> +	int domain;
> +
> +	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID ||
> +	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))

Looking again, I'm not sure this is as intended.  Is the aim to
allow for either one of these two?  Or check that that are both present? 
That is should it be !(A && B) rather than !(A || B)?


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
> +}


