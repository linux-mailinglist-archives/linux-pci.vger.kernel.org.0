Return-Path: <linux-pci+bounces-18136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D219ECDBE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0962843C4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32623368E;
	Wed, 11 Dec 2024 13:55:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA490381AA
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925333; cv=none; b=GVbKZ8gNgIxAKgQTyi89An515g3nFBEYFky3LmzmN9K+rJM/psb/cfq9aJpT7l630IrMD99p5QVVopzoSDBOpRz1n8OletRxp5bqBYhkIVkB5BgPknjsTzW96hH/TpLV7MmIvpDTpPGp8UnnDjlz2XKoFnMrxoFkuOyuFrx/0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925333; c=relaxed/simple;
	bh=XXGOt+wUuN34kty62vBmiJ+sscDkVdQ/z6Qhs740dZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ex/f9+NXB9Vaj+MN/SrhzUcI0MwpvTzOK8ewUXGhFXANuZyyTzrfXQURDfxSVR57xW7qOXHfmbM90QhogdvgtANoGLG4s2AxD+mHZglQdHhmj/RKQf6GG/WJW/bn5+k3XomnPdjCL23rwGQ3xJw7dqwXw3qHa0pPqDUjalWHKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 215BC1063;
	Wed, 11 Dec 2024 05:55:58 -0800 (PST)
Received: from [10.57.70.84] (unknown [10.57.70.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FA113F720;
	Wed, 11 Dec 2024 05:55:28 -0800 (PST)
Message-ID: <6a506ccb-bb8f-425b-9b93-771a45d2b8f2@arm.com>
Date: Wed, 11 Dec 2024 13:55:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] configfs-tsm: Namespace TSM report symbols
Content-Language: en-GB
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Yilun Xu <yilun.xu@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Alexey Kardashevskiy <aik@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Sami Mujawar <sami.mujawar@arm.com>, Steven Price <steven.price@arm.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343740180.1074769.15809313632664416174.stgit@dwillia2-xfh.jf.intel.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <173343740180.1074769.15809313632664416174.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 22:23, Dan Williams wrote:
> In preparation for new + common TSM (TEE Security Manager)
> infrastructure, namespace the TSM report symbols in tsm.h with an
> _REPORT suffix to differentiate them from other incoming tsm work.
> 
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

> ---
>   Documentation/ABI/testing/configfs-tsm-report   |    0
>   MAINTAINERS                                     |    2 +
>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |    8 +++---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


