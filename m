Return-Path: <linux-pci+bounces-31173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66694AEF9AE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06CD3A596E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CA274667;
	Tue,  1 Jul 2025 13:05:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15518223707;
	Tue,  1 Jul 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375110; cv=none; b=gVcY94qGK3ypOMhna2TkOaYuRLNo9cds1GCoGSPpjSgJSpDbP/9g0198qEwXpVBHgQnNDFpJwDOOnWX8DL6UbAP3Z0QC2ngIhJIXGNCGPT1651nRGqQb6GNFg0uda+c6K8SfrkqfD7jNJaiHqoZ5OGf0Iea8QmXrx8zgtXI+qAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375110; c=relaxed/simple;
	bh=hKeiZFqaAZmfcsCW85Fv7xa/9DAFVCrUvTyCASY0EEU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faAv2nR1V6ktetq1kuKHbzojyZ9yZJyHtWjKN9votSdvoEcguehS5uU00RqUqya7Pm24jKkARSryvsNBvAhBzDJWhVl5QTVid0D0btffczBCrL1C9iYrzB6cJwb/nPx6q6CuDD+tMCeZ7yH0TCHSZ4XRkVup9fznggvRnJEzif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWjt25brXz6L5Y7;
	Tue,  1 Jul 2025 21:04:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EEF31402F8;
	Tue,  1 Jul 2025 21:05:05 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 15:05:04 +0200
Date: Tue, 1 Jul 2025 14:05:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 3/3 v4] ACPI: extlog: Trace CPER CXL Protocol Error
 Section
Message-ID: <20250701140503.00006a48@huawei.com>
In-Reply-To: <20250623145453.1046660-4-fabio.m.de.francesco@linux.intel.com>
References: <20250623145453.1046660-1-fabio.m.de.francesco@linux.intel.com>
	<20250623145453.1046660-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 16:54:20 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> When Firmware First is enabled, BIOS handles errors first and then it makes
> them available to the kernel via the Common Platform Error Record (CPER)
> sections (UEFI 2.10 Appendix N). Linux parses the CPER sections via one of
> two similar paths, either ELOG or GHES. The errors managed by ELOG are
> signaled to the BIOS by the I/O Machine Check Architecture (I/O MCA).
> 
> Currently, ELOG and GHES show some inconsistencies in how they report to
> userspace via trace events.
> 
> Therefore, make the two mentioned paths act similarly by tracing the CPER
> CXL Protocol Error Section (UEFI v2.10, Appendix N.2.13).
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 62 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/ras.c     |  6 ++++
>  include/cxl/event.h        |  2 ++
>  3 files changed, 70 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index cefe8d2d8affc..9a37b08aacfea 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -12,6 +12,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/edac.h>
>  #include <linux/ras.h>
> +#include <cxl/event.h>
>  #include <acpi/ghes.h>
>  #include <asm/cpu.h>
>  #include <asm/mce.h>
> @@ -160,6 +161,60 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  	pci_dev_put(pdev);
>  }
>  
> +static void
> +extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				int severity)
> +{
> +	struct cxl_cper_prot_err_work_data wd;
> +	u8 *dvsec_start, *cap_start;


A bunch of this is identical to cxl_cper_post_prot_err()
Can we factor that stuff out for common use?

> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> +		pr_warn_ratelimited("CXL CPER invalid agent type\n");
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_warn_ratelimited("CXL CPER invalid protocol error log\n");
> +		return;
> +	}
> +
> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
> +		pr_warn_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> +				    prot_err->err_len);
> +		return;
> +	}
> +
> +	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
> +	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
> +	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> +		pr_warn_ratelimited(FW_WARN
> +				    "CXL CPER no device serial number\n");

Whilst some of this check isn't present in cxl_cper_post_prot_err(), it should
be harmless.

> +
> +	switch (prot_err->agent_type) {
> +	case RCD:
> +	case DEVICE:
> +	case LD:
> +	case FMLD:
> +	case RP:
> +	case DSP:
> +	case USP:
> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> +
> +		dvsec_start = (u8 *)(prot_err + 1);
> +		cap_start = dvsec_start + prot_err->dvsec_len;
> +
> +		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
> +		wd.severity = cper_severity_to_aer(severity);
> +		break;
> +	default:
> +		pr_err_ratelimited("CXL CPER reserved agent type: %d\n",
> +				   prot_err->agent_type);
> +		return;
> +	}
> +
> +	cxl_cper_ras_handle_prot_err(&wd);
> +}

