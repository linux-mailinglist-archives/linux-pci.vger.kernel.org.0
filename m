Return-Path: <linux-pci+bounces-34012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A9B2587D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A3D5A61FD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 00:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461B4086A;
	Thu, 14 Aug 2025 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfrfAHCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670D1CFBA;
	Thu, 14 Aug 2025 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132028; cv=none; b=W6bkMtY6pzR0URPxBj2Wpa8PKISTffWLseMhAGQgH0o0U4kL8NegBDXZgImdF78d2dOKrVz+tl1yHkPCJDLEVIIkA7pnb1l4hD3f0NJSKdDPmS8Eaq9c80ULSLXYMWo6Eet6Qk2b5Ps2pbZ5FBs4jOK6qaEgvxZpdwExsx8q7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132028; c=relaxed/simple;
	bh=TN6yIRy/n3GAXu3+Cz6SHsLoEcKFJfcymnW3CHC41C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSjQvQCA8T827mMVXHAxfS9w2Pio/rosbeQAJ0GyeQ2flouhrRksI3tm8rVNNF+4PEXPgvHMxZAkfZRomT62uwyRqNB316MYRVui0y1cZvciSr3scZk3ymmAWRjWvC0RjNqCWagayFCNnm0DyBq5pI/mlrOZzNdfaiL4cNaDClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfrfAHCs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755132026; x=1786668026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TN6yIRy/n3GAXu3+Cz6SHsLoEcKFJfcymnW3CHC41C4=;
  b=FfrfAHCsmTz1bXgAU6DRqc2T2Rbq7h4HlQKFl1gJAfIPZNKjYwlEew9y
   2AjWGWSzn0S4EEkdPn+Qbv5tAvm6F4SuZ1qvtJBo7LFuhZwQWp4QIzklY
   0DZ6n97T1SJviVZTNxp2ihhmBjETNUo0Zr79wBa7XZ90TeJiyc4sVuYrl
   trnBTAs8hq4TrnimdzMxPxtnEPwVEkzynZSene0SeavaqpxU89FrQplMg
   S4HR76hCyF/1Uxn1Uh42i2mXzKDu8dMhY15qKTt6RO8nNADj5T/a5wie5
   WU1gmLWbAOBHUT5+KQz4qQqMVwZ/I72nmQqHKu/lIvBXZ1ovu6LbZLYtn
   g==;
X-CSE-ConnectionGUID: ARk6lH2QTW+e7DCLS4fZjA==
X-CSE-MsgGUID: Ww4LaJb9Sy2cjXqBTbYhjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68521636"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68521636"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 17:40:25 -0700
X-CSE-ConnectionGUID: 3UkUsY5oR+mykk3Pf1Th3Q==
X-CSE-MsgGUID: ba5Gof1LSTa66Z6VAA22jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="203795622"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 17:40:25 -0700
Received: from [10.124.222.231] (unknown [10.124.222.231])
	by linux.intel.com (Postfix) with ESMTP id 82EC720B571C;
	Wed, 13 Aug 2025 17:40:23 -0700 (PDT)
Message-ID: <59308229-24ed-4b8a-b398-cc47c61dfc47@linux.intel.com>
Date: Wed, 13 Aug 2025 17:40:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] PCI/ERR: Remove remnants of .link_reset() callback
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 "Sean C. Dardis" <sean.c.dardis@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Edward Cree <ecree.xilinx@gmail.com>, linux-net-drivers@amd.com,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <cover.1755008151.git.lukas@wunner.de>
 <1d72a891a7f57115e78a73046e776f7e0c8cd68f.1755008151.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1d72a891a7f57115e78a73046e776f7e0c8cd68f.1755008151.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/12/25 10:11 PM, Lukas Wunner wrote:
> Back in 2017, commit 2fd260f03b6a ("PCI/AER: Remove unused .link_reset()
> callback") removed .link_reset() from struct pci_error_handlers, but left
> a few code comments behind which still mention it.  Remove them.
>
> The code comments in the SolarFlare Ethernet drivers point out that no
> .mmio_enabled() callback is needed because the driver's .error_detected()
> callback always returns PCI_ERS_RESULT_NEED_RESET, which causes
> pcie_do_recovery() to skip .mmio_enabled().  That's not quite correct
> because efx_io_error_detected() does return PCI_ERS_RESULT_RECOVERED under
> certain conditions and then .mmio_enabled() would indeed be called if it
> were implemented.  Remove this misleading portion of the code comment as
> well.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/net/ethernet/sfc/efx_common.c       | 3 ---
>   drivers/net/ethernet/sfc/falcon/efx.c       | 3 ---
>   drivers/net/ethernet/sfc/siena/efx_common.c | 3 ---
>   drivers/scsi/lpfc/lpfc_init.c               | 2 +-
>   4 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
> index 5a14d94163b1..e8fdbb62d872 100644
> --- a/drivers/net/ethernet/sfc/efx_common.c
> +++ b/drivers/net/ethernet/sfc/efx_common.c
> @@ -1258,9 +1258,6 @@ static void efx_io_resume(struct pci_dev *pdev)
>   
>   /* For simplicity and reliability, we always require a slot reset and try to
>    * reset the hardware when a pci error affecting the device is detected.
> - * We leave both the link_reset and mmio_enabled callback unimplemented:
> - * with our request for slot reset the mmio_enabled callback will never be
> - * called, and the link_reset callback is not used by AER or EEH mechanisms.
>    */
>   const struct pci_error_handlers efx_err_handlers = {
>   	.error_detected = efx_io_error_detected,
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
> index b07f7e4e2877..0c784656fde9 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.c
> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
> @@ -3128,9 +3128,6 @@ static void ef4_io_resume(struct pci_dev *pdev)
>   
>   /* For simplicity and reliability, we always require a slot reset and try to
>    * reset the hardware when a pci error affecting the device is detected.
> - * We leave both the link_reset and mmio_enabled callback unimplemented:
> - * with our request for slot reset the mmio_enabled callback will never be
> - * called, and the link_reset callback is not used by AER or EEH mechanisms.
>    */
>   static const struct pci_error_handlers ef4_err_handlers = {
>   	.error_detected = ef4_io_error_detected,
> diff --git a/drivers/net/ethernet/sfc/siena/efx_common.c b/drivers/net/ethernet/sfc/siena/efx_common.c
> index a0966f879664..35036cc902fe 100644
> --- a/drivers/net/ethernet/sfc/siena/efx_common.c
> +++ b/drivers/net/ethernet/sfc/siena/efx_common.c
> @@ -1285,9 +1285,6 @@ static void efx_io_resume(struct pci_dev *pdev)
>   
>   /* For simplicity and reliability, we always require a slot reset and try to
>    * reset the hardware when a pci error affecting the device is detected.
> - * We leave both the link_reset and mmio_enabled callback unimplemented:
> - * with our request for slot reset the mmio_enabled callback will never be
> - * called, and the link_reset callback is not used by AER or EEH mechanisms.
>    */
>   const struct pci_error_handlers efx_siena_err_handlers = {
>   	.error_detected = efx_io_error_detected,
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 4081d2a358ee..cf08bb5b37c3 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -14377,7 +14377,7 @@ lpfc_sli_prep_dev_for_perm_failure(struct lpfc_hba *phba)
>    * as desired.
>    *
>    * Return codes
> - * 	PCI_ERS_RESULT_CAN_RECOVER - can be recovered with reset_link
> + *	PCI_ERS_RESULT_CAN_RECOVER - can be recovered without reset
>    * 	PCI_ERS_RESULT_NEED_RESET - need to reset before recovery
>    * 	PCI_ERS_RESULT_DISCONNECT - device could not be recovered
>    **/

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


