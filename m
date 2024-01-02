Return-Path: <linux-pci+bounces-1610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE68221EF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 20:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE8284185
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6615AE6;
	Tue,  2 Jan 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBlwKhCy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F016405;
	Tue,  2 Jan 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704223391; x=1735759391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pi4zx7xRM7AxSQNbCyQOKolzB32nwlVky/j9CjcIrT4=;
  b=PBlwKhCyg6lR07E0Xltt/78lZW0zYPGgjffeCfHSQXunxrDPbvgWSlA8
   yJWcYZTLOncEEl4bvpzhhN7SOS/FHDE812joDCcS1IkzKQY0iTkPpbGiT
   OaCrnK3nfrKtFvYtEFc9of0lx4G7c4e8P9YA0cmKRM4nNS+cEx9ht7DaP
   mtMtoRXvmDhw9VC7yF0m9u7ND7mcvsGT9whtHUSOfgC9oVmY0U1/DSbFx
   SuuY/WESlAfo9xrwbG8C2N+WQU2oTrNTKzAA8fwxgOtNNqnOhqa0Tl5sZ
   T9kHyNRS1tr0funlVtn7tbE1fqtwpkBz8HF9xJvqKTUBQbn87QmlZ1OL1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="428078531"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="428078531"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111132084"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="1111132084"
Received: from keithj1-mobl2.amr.corp.intel.com (HELO [10.209.44.31]) ([10.209.44.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:23:10 -0800
Message-ID: <cd9e4397-1110-40a5-891a-56e6288bbf91@linux.intel.com>
Date: Tue, 2 Jan 2024 11:23:11 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI/AER: Use 'Correctable' and 'Uncorrectable' spec
 terms for errors
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20231206224231.732765-1-helgaas@kernel.org>
 <20231206224231.732765-2-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231206224231.732765-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/6/2023 2:42 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PCIe spec classifies errors as either "Correctable" or "Uncorrectable".
> Previously we printed these as "Corrected" or "Uncorrected".  To avoid
> confusion, use the same terms as the spec.
> 
> One confusing situation is when one agent detects an error, but another
> agent is responsible for recovery, e.g., by re-attempting the operation.
> The first agent may log a "correctable" error but it has not yet been
> corrected.  The recovery agent must report an uncorrectable error if it is
> unable to recover.  If we print the first agent's error as "Corrected", it
> gives the false impression that it has already been resolved.
> 
> Sample message change:
> 
>   - pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
>   + pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/aer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 42a3bd35a3e1..20db80018b5d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -436,9 +436,9 @@ void pci_aer_exit(struct pci_dev *dev)
>   * AER error strings
>   */
>  static const char *aer_error_severity_string[] = {
> -	"Uncorrected (Non-Fatal)",
> -	"Uncorrected (Fatal)",
> -	"Corrected"
> +	"Uncorrectable (Non-Fatal)",
> +	"Uncorrectable (Fatal)",
> +	"Correctable"
>  };
>  
>  static const char *aer_error_layer[] = {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

