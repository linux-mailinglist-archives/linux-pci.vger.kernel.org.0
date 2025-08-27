Return-Path: <linux-pci+bounces-34941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4238B38A8F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 21:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83691364AA4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824F2E7BDA;
	Wed, 27 Aug 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdO7UUwv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289C2D24B2
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324646; cv=none; b=gN5inD37b85c2Pqjd2LlPJI2ELuPPsZ8NOgTfv4gKVRo7qMF46c2QwAkb9CjLK80Da7NLZBiUw19B/P5xGfwM0iYZXs2PIoadcr/l7SE3sc4y8Q1f97bKNHVbgegdu17RCJyE79pIxgS810BualPNjiMdLrccpy5KPLDqVz7GMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324646; c=relaxed/simple;
	bh=dN/0LGTTO2mIMuv5CAHk8QNgW0R0zS/JdxacWvuYn5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qf0u3CS/186oAmHiElLPVjG6k1wFS4WfMyxy15VWYO2QRF3n/lAeO7aSFINzIgUTFJgBto1SCIYyCQsFI8/Ro7lzkiLOKVaDtJyW9srh5kTwzmmMaCTc9Iq35V2cwS/5ZcBI82IEFs8PSd99u2149Nd0wAWM7CUtx+jDdGx3dfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdO7UUwv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756324645; x=1787860645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dN/0LGTTO2mIMuv5CAHk8QNgW0R0zS/JdxacWvuYn5s=;
  b=WdO7UUwvKx2qwdbTR5HL22oPjBJM7836MoghbV+DXwSmERznqQMpXyVP
   UdD6225m3WnodA4m3ot1wxWXN6/ICbRQUF8VGh8zWxh2bX4n0eY2FCQO2
   lKw6ufcfSR8un/ad7zrdzeIr2enDFDbphMUSm0yzOMy7CFW9GtVKXbO+9
   I5imXNo5iY7AQtQcbaqpxIdiL5Ik/juX+hdgNGvjyEZgOMR5Tn9xTHB5i
   ZRv9Eb+XKRI1A9MhQy/sB9s3Sfp+bcEvAtYCYVdoGIp0B5aHuIH+YDryz
   6PRcblsZ34Xo988Ef3LQy1Xk90sYo1fzH5StMAl/3U48/SGkf3pFTthF9
   Q==;
X-CSE-ConnectionGUID: 1Zdhjlm9Sh6rJLlzYopScA==
X-CSE-MsgGUID: RJyRlp7zQRi+fgdjKz8v0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62229476"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62229476"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 12:57:24 -0700
X-CSE-ConnectionGUID: s2dnWLKURQGgaASzRZRyYQ==
X-CSE-MsgGUID: MvZNH5TnRHeDmqnNozbKUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="200820932"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 12:57:23 -0700
Received: from [10.124.223.227] (unknown [10.124.223.227])
	by linux.intel.com (Postfix) with ESMTP id 8CC2820B571C;
	Wed, 27 Aug 2025 12:57:22 -0700 (PDT)
Message-ID: <64a661bd-cb64-4850-90d8-f34de9457173@linux.intel.com>
Date: Wed, 27 Aug 2025 12:56:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Support errors introduced by PCIe r6.0
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
References: <21f1875b18d4078c99353378f37dcd6b994f6d4e.1756301211.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <21f1875b18d4078c99353378f37dcd6b994f6d4e.1756301211.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/25 6:41 AM, Lukas Wunner wrote:
> PCIe r6.0 defined five additional errors in the Uncorrectable Error
> Status, Mask and Severity Registers (PCIe r7.0 sec 7.8.4.2ff).

is 2ff a typo ?

>
> lspci has been supporting them since commit 144b0911cc0b ("ls-ecaps:
> extend decode support for more fields for AER CE and UE status"):
>
> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/commit/?id=144b0911cc0b
>
> Amend the AER driver to recognize them as well, instead of logging them as
> "Unknown Error Bit".
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Last amendment of aer_uncorrectable_error_string[] was in 2019 for an
> error introduced in PCIe r3.1, see commit 6458b438ebc1 ("PCI/AER: Add
> PoisonTLPBlocked to Uncorrectable error counters").
>
>   drivers/pci/pcie/aer.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c19..15ed541 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -43,7 +43,7 @@
>   #define AER_ERROR_SOURCES_MAX		128
>   
>   #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
> -#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
> +#define AER_MAX_TYPEOF_UNCOR_ERRS	32	/* as per PCI_ERR_UNCOR_STATUS*/
>   
>   struct aer_err_source {
>   	u32 status;			/* PCI_ERR_ROOT_STATUS */
> @@ -525,11 +525,11 @@ void pci_aer_exit(struct pci_dev *dev)
>   	"AtomicOpBlocked",		/* Bit Position 24	*/
>   	"TLPBlockedErr",		/* Bit Position 25	*/
>   	"PoisonTLPBlocked",		/* Bit Position 26	*/
> -	NULL,				/* Bit Position 27	*/
> -	NULL,				/* Bit Position 28	*/
> -	NULL,				/* Bit Position 29	*/
> -	NULL,				/* Bit Position 30	*/
> -	NULL,				/* Bit Position 31	*/
> +	"DMWrReqBlocked",		/* Bit Position 27	*/
> +	"IDECheck",			/* Bit Position 28	*/
> +	"MisIDETLP",			/* Bit Position 29	*/
> +	"PCRC_CHECK",			/* Bit Position 30	*/
> +	"TLPXlatBlocked",		/* Bit Position 31	*/
>   };
>   
>   static const char *aer_agent_string[] = {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


