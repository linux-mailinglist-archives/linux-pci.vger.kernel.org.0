Return-Path: <linux-pci+bounces-33999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D88B25732
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6022172661A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160326AEC;
	Wed, 13 Aug 2025 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBSSFvvO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF72EA16E
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126312; cv=none; b=s3VxeiejJ9Lylu8G5irQXeO6ui+X+0Yw0GFJt839TEKJBZ13LBt/cu6blOHW7rPkCJvteB5TL1htECtJemPEVd5CMyataN8cktfC/SzAy0vrWWPFtmEQFpuTcDgVCa58yLjQjYOp3YM9PHzXPJJMNnsSQoNpD9HBSWkhCVOAQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126312; c=relaxed/simple;
	bh=af2+KlDj0FItWaW81qBzp26/u+4WmaVEH6tIL/ZZkSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PC2zRo3zKt0/cspAk5o4B5dItGTZtCWYPolz2pfxx3yglwNLO2EDiOsHaoLb/lrCdS19BE3EU3ESU2MJ6a4u5hCYVNZdOpPeujPuvmDnOfsqc4Yp85zs2GolIqf1Jm+xIu3F0SCsB3hNnL6A7yv/gfGBe4GFcfzzkLGl8jdXE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBSSFvvO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755126311; x=1786662311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=af2+KlDj0FItWaW81qBzp26/u+4WmaVEH6tIL/ZZkSo=;
  b=XBSSFvvO8jOcyqMEFTxcoUhbG+VqfTwSBskF696al6JkxFs0ZMQnWEI4
   PDnHAj7EFqwyhtuYlOAzu2jx/KaIjjsxCJb4HK5WBaj7ZNdkw4hGOGpGD
   1NYdl0nJTbiP9j7tAEm1m+PamgCYKlCU/+r1DSC56RFcLyQiB/1FSnk7J
   RZSBBTSIKcvcdviG+H3fKtfnbGYByB8o6VRkuRhM+9aSaQp57RjcMV1OF
   wD9wtFUIMtYM1CwrwQ2Z9hPu61ggjHPL1xW64jig1seEB9F53ymmG9mXc
   QKxXiTDK/3pePAoA7PtTPo3RVI26GDfs8njn98wRlKKMGDYsnqCoWY+q9
   g==;
X-CSE-ConnectionGUID: lrpDj8DKT4mJvavo00BGbw==
X-CSE-MsgGUID: U/WThom3QPu+4/xRsSC8qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57515385"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57515385"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 16:05:07 -0700
X-CSE-ConnectionGUID: CTU1+4FHTLihCfthokJ0jg==
X-CSE-MsgGUID: LFytUysMRLCmbqBI/wZ6JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170736148"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 16:05:06 -0700
Received: from [10.124.222.231] (unknown [10.124.222.231])
	by linux.intel.com (Postfix) with ESMTP id B97FC20B5720;
	Wed, 13 Aug 2025 16:05:05 -0700 (PDT)
Message-ID: <fa9f42ab-bced-4c7f-9977-c0b611e92e2e@linux.intel.com>
Date: Wed, 13 Aug 2025 16:05:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] PCI/ERR: Notify drivers on failure to recover
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 "Sean C. Dardis" <sean.c.dardis@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
References: <cover.1755008151.git.lukas@wunner.de>
 <ec212d4d4f5c65d29349df33acdc9768ff8279d1.1755008151.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ec212d4d4f5c65d29349df33acdc9768ff8279d1.1755008151.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/12/25 10:11 PM, Lukas Wunner wrote:
> According to Documentation/PCI/pci-error-recovery.rst, the following shall
> occur on failure to recover from a PCIe Uncorrectable Error:
>
>    STEP 6: Permanent Failure
>    -------------------------
>    A "permanent failure" has occurred, and the platform cannot recover
>    the device.  The platform will call error_detected() with a
>    pci_channel_state_t value of pci_channel_io_perm_failure.
>
>    The device driver should, at this point, assume the worst. It should
>    cancel all pending I/O, refuse all new I/O, returning -EIO to
>    higher layers. The device driver should then clean up all of its
>    memory and remove itself from kernel operations, much as it would
>    during system shutdown.
>
> Sathya notes that AER does not call error_detected() on failure and thus
> deviates from the document (as well as EEH, for which the document was
> originally added).
>
> Most drivers do nothing on permanent failure, but the SCSI drivers and a
> number of Ethernet drivers do take advantage of the notification to flush
> queues and give up resources.
>
> Amend AER to notify such drivers and align with the documentation and EEH.
>
> Link: https://lore.kernel.org/r/f496fc0f-64d7-46a4-8562-dba74e31a956@linux.intel.com/
> Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/err.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 21d554359fb1..930bb60fb761 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -110,7 +110,19 @@ static int report_normal_detected(struct pci_dev *dev, void *data)
>   
>   static int report_perm_failure_detected(struct pci_dev *dev, void *data)
>   {
> +	struct pci_driver *pdrv;
> +	const struct pci_error_handlers *err_handler;
> +
> +	device_lock(&dev->dev);
> +	pdrv = dev->driver;
> +	if (!pdrv || !pdrv->err_handler || !pdrv->err_handler->error_detected)
> +		goto out;
> +
> +	err_handler = pdrv->err_handler;
> +	err_handler->error_detected(dev, pci_channel_io_perm_failure);
> +out:
>   	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> +	device_unlock(&dev->dev);
>   	return 0;
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


