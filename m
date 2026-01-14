Return-Path: <linux-pci+bounces-44830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD95D20F02
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C30E3002D00
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3F2D0C9A;
	Wed, 14 Jan 2026 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wbn4G67Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6E3358B5;
	Wed, 14 Jan 2026 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417099; cv=none; b=Uz09YdE7rbgvvfcep7mLkkH8gjFxWaUZMZ1GhohYPNiieuWy6CwY9tpdIIr/ZapjqfFnbZGoebBSZd28I1/ybq3ep2aVcuaVW71lcuE//7L6ohlgZ80szTw9CkCijFNmqJfQW9fnHnScGLK0b20vNriNbI7CRl2rZwxhblrJwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417099; c=relaxed/simple;
	bh=mtq0di2LAofszrlMvr4JxgZBUNp2juD8JEQmttykNUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hstrF4UkEJeqhZRZFKrbKVINBrv2N6DxSITynUKNxu/LAJOq4VQnm0+fSGPv+E7k5g8UrCTVghK25nRGIF9+oWyZ+IymGQRkfNKaZVo2TIrvC2CJ6jrmOtJALe+gyGYPlohDYqsgSfvcW3JOHbn6jUzt7T4Pq09a5WWMpQlpuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wbn4G67Y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768417097; x=1799953097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mtq0di2LAofszrlMvr4JxgZBUNp2juD8JEQmttykNUg=;
  b=Wbn4G67Ybh8GGivN0Nyvh1YgGxHQqNA8vQm7Pae4LfSLKeevw7djgyX4
   Yud5WNk1p8cQ+TqJDqZmbgLKMjCp1ZB3XxgZENf+XKwxBXKloC4agUzDV
   /W8+/T4Z4dC/G6h2P0yQ3cwBfUMUM2IcVgsUUfbc+q0CtyCj9Ex7iM7mw
   QvPLO2Ym/CRozlJoCThi6wTEdFKz3PkHe2aYynu1AoYU4z97eK19+q1Bn
   evNfsdcZdSjfXz9sZA6/ArnJo7cm03TRKOPol8obZrboGuXa1L5RQRqY5
   m50jkhIMhAdoc1R2r/Yvn8/vOJyBQTktXT9gBLxT34/AOmdUG9lsOHvXr
   A==;
X-CSE-ConnectionGUID: Xa5dsZmmRCiYKU756rXywQ==
X-CSE-MsgGUID: MaKWfBP0RAig4bNFOKKf4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="81088228"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="81088228"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:58:16 -0800
X-CSE-ConnectionGUID: /CLtJLK3TqiWUfq2t7YamQ==
X-CSE-MsgGUID: 5y0q0mdJT+q22dJ+EdiFZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205020830"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:58:15 -0800
Message-ID: <9e0d3c5a-bc80-4d19-bf7b-fbf55d140b8c@linux.intel.com>
Date: Wed, 14 Jan 2026 10:58:15 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 27/34] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-28-terry.bowman@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260114182055.46029-28-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/14/2026 10:20 AM, Terry Bowman wrote:
> The CXL driver's error handling for uncorrectable errors (UCE) will be
> updated in the future. A required change is for the error handlers to
> to force a system panic when a UCE is detected.
> 
> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
> 
> Changes in v13 -> v14:
> - Add review-by for Dan
> - Update Title prefix (Bjorn)
> - Removed merge_result. Only logging error for device reporting the
>   error (Dan)
> 
> Changes in  v12->v13:
> - Add Dave Jiang's, Jonathan's, Ben's review-by
> - Typo fix (Ben)
> 
> Changes v11 -> v12:
> - Documentation requested (Lukas)
> ---
>  Documentation/PCI/pci-error-recovery.rst | 2 ++
>  include/linux/pci.h                      | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 43bc4e3665b4..82ee2c8c0450 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -102,6 +102,8 @@ Possible return values are::
>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>  	};

I think you also need to update the "Detailed Steps" section of this
document to include details on when these new values should be returned
and how they affect the recovery flow.

>  
>  A driver does not have to implement all of these callbacks; however,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f8e8b3df794d..ee05d5925b13 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -921,6 +921,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic. Is CXL specific */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


