Return-Path: <linux-pci+bounces-38792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B912BF2FA7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 20:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68294E3475
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2529BD90;
	Mon, 20 Oct 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpEQulUQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF731DE4E0;
	Mon, 20 Oct 2025 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985793; cv=none; b=VWTYTXoXY/AxegHUbBlWGL1UqE3p7YjdMn4Jhcvu6DuAfa6I75Uce4HkAO6W41j48/Z7/Hm7xQhH5G1FgpLJqKmYikcaDTYgPfKkksIz4PieKVuZoyx2Phmh+xK1D52IzykBJE7fO10EwnqRFFoJRMnyACeHfyhZfJP+3zwerBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985793; c=relaxed/simple;
	bh=8rrgzNNkAXQJ2s3G7iaOcQ9ClFqvPz61hpFmah8TFKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khofE1IR1Z/kJX4/8PlPn1wb+7sjqdJV0o7OxIdjgAZqQQgHEYeuQTZOlZDzVO3JsLU6kfvcRDdxtp9SpTQDQR2OXPIfN3+kJGTZWh/FA8I249KnA/8eZusequc0ITJ4+HHAsBhqOaJN2O+KOcjUmRJ4iYR+lYEPIAjuT0Ln0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpEQulUQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760985792; x=1792521792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8rrgzNNkAXQJ2s3G7iaOcQ9ClFqvPz61hpFmah8TFKQ=;
  b=mpEQulUQRhvbdf/MQIYAW8ltlm8nY9JWBPv6ow2hkDwUril0HkKdcQB9
   gzoe2NLWfl3peGAY5wNurdUfrM29r9SvfvYYvDmToEcfRhgQFWYlKF4Uo
   +QgqL4mSS4uUhbx7do3F4u+DEcGd3VJ9bywE+nQNg3RbOh4qDbwMCP48d
   +kn9PkkkKRa715gcjr3f5PWRsmR/WLT7IL7jkXjUEJXipV52xD2mJrCv2
   crehLUI/iWuLPcu+TN2u0A6fxF6Zy4QibvqXjEda2mXbH5E2tgdBiU/+Q
   /znANL8RU/yIaoUQJDbboA434tN+ir4wiMH7FpHd6Q9hP8dpfcEQRlo1w
   A==;
X-CSE-ConnectionGUID: 7nYquKorQUOjwBqj0xKJ5g==
X-CSE-MsgGUID: yGbHhnyvRYWmNAnpDeNj9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73778069"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="73778069"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:43:11 -0700
X-CSE-ConnectionGUID: 62lNo2+SRdyU50TAsi/wNg==
X-CSE-MsgGUID: 38MMGEGuRXuYXjQADXH3Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="187416438"
Received: from skuppusw-desk2.jf.intel.com (HELO [10.165.154.101]) ([10.165.154.101])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:43:12 -0700
Message-ID: <a92c343a-919d-4940-b142-4919d90eb9f3@linux.intel.com>
Date: Mon, 20 Oct 2025 11:43:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com, lukas@wunner.de
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20251015024159.56414-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/14/25 19:41, Shuai Xue wrote:
> Replace the manual checks for native AER control with the
> pcie_aer_is_native() helper, which provides a more robust way
> to determine if we have native control of AER.
>
> No functional changes intended.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/err.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 4e65eac809d1..097990094b71 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -214,7 +214,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	int type = pci_pcie_type(dev);
>   	struct pci_dev *bridge;
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>   	struct aer_err_info info;
>   
>   	/*
> @@ -289,7 +288,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	 * it is responsible for clearing this status.  In that case, the
>   	 * signaling device may not even be visible to the OS.
>   	 */
> -	if (host->native_aer || pcie_ports_native) {
> +	if (pcie_aer_is_native(dev)) {
>   		pcie_clear_device_status(dev);
>   		pci_aer_clear_nonfatal_status(dev);
>   	}

