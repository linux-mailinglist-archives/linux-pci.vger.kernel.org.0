Return-Path: <linux-pci+bounces-1836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1188278C6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 20:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF371C22801
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166D5380B;
	Mon,  8 Jan 2024 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcmeuHhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0A54F9D
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704743639; x=1736279639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8RY9qaoIHX1YOOflwiUpM+04gh8w5gdHNPRq3bh5myI=;
  b=XcmeuHhJpKgNVLxg6blNzm/82fi3ER1kpnq3L42QEMwABwWpCZDxDzCe
   e1ihrKWN8tKL0dglPFksOzQ3p0ObYppGaKFZBWZij9U/0G68Oq+QkDQJi
   mvp5TDJPeErx/ZujtbiZGAqcxba5c5s4jVdtT4LwGO5R1DBeSAOavCyqE
   AZjXvzoXSZfkZTrrWDjo0sBs7rJFuHgpb/QGG4Jfx7pOlGVwHepLeA9Ye
   4DKf7Fze0Aq1IRfLGBV9cpHqcNsXVqoQfWtEdNSqc2NdD6dLa0Wj3+q6y
   c31B063FXyAgTAXZ8RIbr6lrghY8tjeBIYhE6wxZ389TXRq/xHog74NsM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4749082"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="4749082"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 11:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1028497513"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="1028497513"
Received: from nsingiri-mobl2.amr.corp.intel.com (HELO [10.212.166.188]) ([10.212.166.188])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 11:53:57 -0800
Message-ID: <aac66e30-4b3f-4b08-83bd-d50472007212@linux.intel.com>
Date: Mon, 8 Jan 2024 11:53:53 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Content-Language: en-US
To: Matthew W Carlis <mattc@purestorage.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, kbusch@kernel.org,
 linux-pci@vger.kernel.org, lukas@wunner.de, mika.westerberg@linux.intel.com
References: <ed47c116-78eb-40d7-a5e7-0c23e1e6712f@linux.intel.com>
 <20240108194642.30460-1-mattc@purestorage.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240108194642.30460-1-mattc@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/8/2024 11:46 AM, Matthew W Carlis wrote:
> Hello again, sorry for the delayed response.. I have been on PTO. The above patch
> doesn't fix the problem in our systems as host->native_dpc is not set due to
> not using or having support for Error Disconnect Recovery (EDR). I wonder if

The only condition we check before requesting DPC control is whether OS
supports both EDR and DPC. As long as you have enabled related configs
(IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR)), this will be true.
Enabling these configs does not mean you are using it. Any reason why you don't
enable it in your case?

> host->native_dpc is a misleading name a way... Misleading in the sense that
> setting host->native_aer implies firmware intends the OS to control AER, whereas
> host->native_dpc being set appears to have an additional requirement on the
> use/support of EDR in addition to DPC. When I was working on the patch as
> submitted I had been thinking about all of these fields & my thinking was
> as follows.. The kernel requires host->native_aer in order to control AER, but
> it could control DPC whether host->native_dpc is set or unset. Therefore, if
> the kernel will control AER it should also control DPC on any capable devices.
> Of course there is also the requirement of having built with CONFIG_PCIE_AER
> & CONFIG_PCIE_DPC. Please advise if my understanding of all this is incorrect..
> 
> Thanks,
> -Matt
> 
> I included an update to the patch submitted in chain which should remove the
> build error that occured when CONFIG_PCIE_AER was not set. Including it
> in case my understanding of EDR/DPC/etc is correct.
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..2fc006f12988 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -257,12 +257,18 @@ static int get_port_device_capability(struct pci_dev *dev)
>         }
> 
>         /*
> +        * _OSC AER Control is required by the OS & requires OS to control AER,
> +        * but _OSC DPC Control isn't required by the OS to control DPC; however
> +        * it does require the OS to control DPC. _OSC DPC Control also requres
> +        * _OSC EDR Control (Error Disconnect Recovery) (PCI Firmware - DPC ECN rev3.2)
> +        * PCI_Express_Base 6.1, 6.2.11 Determination of DPC Control recommends
> +        * platform fw or OS always link control of DPC to AER.
> +        *
>          * With dpc-native, allow Linux to use DPC even if it doesn't have
>          * permission to use AER.
>          */
>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -           pci_aer_available() &&
> -           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +           pci_aer_available() && (pcie_ports_dpc_native || host->native_aer))
>                 services |= PCIE_PORT_SERVICE_DPC;
> 
>         if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

