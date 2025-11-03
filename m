Return-Path: <linux-pci+bounces-40104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980EC2BD2D
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6186E3BD2C0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3B30F929;
	Mon,  3 Nov 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StuMPw7i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486F306B2C;
	Mon,  3 Nov 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173831; cv=none; b=bzu8/ZJ9tBXomOvfIinLy0xTQ4refdoBIoFYrq4ByegkjSS+XbtfwxRoJ4G2/YYj9YsBBhCnP6USxoq9tFeV+ZGPqIoL20NqzqvjVa8CEhjtif5nsYOrttRyTGJRAfTapUNVUlDuulTfLTYU+LFyhjSkoDl60vVL4Mbh+au3nLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173831; c=relaxed/simple;
	bh=DK6Qoga15L0ESP5ijps+jZiHacx74F2Rwieqr8w+dz0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=An4h3C9PVqyrsTpH7mFVvBLgDvoMj6T6fuXYx8+oD7ZJKbWP3aCp+T6EccSowZvKSp5hJYlq9SQNhAmCChXaM+tRaHHgAcqfsA6c9i3ND15oDbItK35PXFxemGoLIwXO6uMVMqM3Pynsh+ZiFoQSJdGBy4M8Y3v85oL5DV6RVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StuMPw7i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762173830; x=1793709830;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DK6Qoga15L0ESP5ijps+jZiHacx74F2Rwieqr8w+dz0=;
  b=StuMPw7iQ0hm5lINnUFGG4eeFCdrvxjMOBJRSgmis0LlWiz5Vj+Xe6V3
   uXsP7c3EiWOgwaWJovsrhvNRCP8aUqkBD5QDqERILXe4xt+u8fbz+gJcb
   CF8OvBkWhlL2jVFsWoDgPYtyCaLCgTwtHNc/5nRJnxPiHmnZKVBZ/gK4Z
   tr84akZhTNry8tqbmj9hm9RQ1wTxZbRigO7nhjuN/XqiWkceoyI+KnlhF
   QB8YjYw2a3wGDHc/2h+UORJ44IlAQlSWoem0cMOt2O8X38+H8JFDqRjsl
   ewM80Kr7kebybZF8UgVVavReEPuOAAFur/FyjyZcUMQ/LlHPMd0/Gs0O2
   g==;
X-CSE-ConnectionGUID: fT49145ISQ2ULduLMx/JtQ==
X-CSE-MsgGUID: NTdsjY88RTeMV4HVhDEr/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="68107620"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="68107620"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 04:43:47 -0800
X-CSE-ConnectionGUID: +l7yY1SEQq6rNoC6pxFeog==
X-CSE-MsgGUID: WKYQr0/WQjKHpXoqY4WgNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186539036"
Received: from krybak-mobl1.ger.corp.intel.com (HELO [10.245.246.110]) ([10.245.246.110])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 04:43:44 -0800
Message-ID: <9e34fe42-a031-4ab6-b986-c09a36040b66@linux.intel.com>
Date: Mon, 3 Nov 2025 14:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] PCI: Add Intel Nova Lake S audio Device ID
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.dev, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kw@linux.com
References: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
 <20251002084252.7305-2-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20251002084252.7305-2-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krysztof, Bjorn,

On 02/10/2025 11:42, Peter Ujfalusi wrote:
> Add Nova Lake S (NVL-S) audio Device ID

Can you check this patch so Takashi-san can pick the series up?

Thank you,
Péter

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..a9a089566b7c 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3075,6 +3075,7 @@
>  #define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
>  #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
>  #define PCI_DEVICE_ID_INTEL_HDA_FCL	0x67a8
> +#define PCI_DEVICE_ID_INTEL_HDA_NVL_S	0x6e50
>  #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
>  #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
>  #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020



