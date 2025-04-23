Return-Path: <linux-pci+bounces-26553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A0A9927E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DB14A0D53
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C128936D;
	Wed, 23 Apr 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cp0hA+Ip"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754F28BAA9;
	Wed, 23 Apr 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421881; cv=none; b=Qoc0UROV8jt7VWzdun7WZMfDpP+zi5msVMB2/1C7Pf6/dna4h2vE+qU+dw+Td5RJYL6IZUaJqxww9LDMDtBcyjKZ/fC6aYNQxRER/QGGJfzLLRSgrHxWVPKLnzYFWQE3gmNQ+gVqbZlzrAaWEMOqhzUS4X70Ol0pwZGmuBVtFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421881; c=relaxed/simple;
	bh=nMhCwAOTSMRyVPdhT0XUroexVj2lZ57XR6Ezp9vic6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtWxzADva783RYCqN0pglLXrFYmrhJC+PxPyh7qqk7WNcMqW9TH6L8AgHPKViE6cZoLp7cb8+aXjQjnaEvqi40J6wt2XISDnQYnvvwMl5VgkJGXMPZo/GDe/fRSJf35K4mTAqMPLNyZ3JGXZKbFrC+z224jRZfizY83WFGW/LKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cp0hA+Ip; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=fLf6c6c5ft8eN46VJWzZEfTcLHZ/iFnsmavl08qDxwU=;
	b=Cp0hA+IpCX8WlV1svNV2MyHKPXjl4LoFaXE7Xrw/Badl8BO+C+hHZwx+ElOkcQ
	eqscdFuprmIXObh56TRVMM7UNOB9XYAOuXyt5vptI36gOtPLW2cXYqMpWSy29JsW
	I9URNWxVX2J5ZPX6Bj4iY0vFHAtrO5y0QAwoayJE6hVwI=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnfGf9BQloLLNpCA--.43427S2;
	Wed, 23 Apr 2025 23:23:42 +0800 (CST)
Message-ID: <9212f2ee-9562-4409-a378-20e41fe30325@163.com>
Date: Wed, 23 Apr 2025 23:23:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: dw-rockchip: Reorganize register and bitfield
 definitions
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250423105415.305556-1-18255117159@163.com>
 <20250423105415.305556-3-18255117159@163.com> <aAjufPQnBsR6ysAH@ryzen>
 <352e40a0-65e2-499f-a7dd-904a4a7b19da@163.com> <aAkDRIqIOjLo7haw@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAkDRIqIOjLo7haw@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnfGf9BQloLLNpCA--.43427S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4ktF47Gw18Cr4UtrWUJwb_yoW3trgEqr
	4UArsxCryqgF9xWa93Jr1jyFsIk3ykuw45urykXr4Iyw1agrs5Kr429rZ3JFy8Ja13GFs2
	kw15Aa1ruryS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjqjg3UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw44o2gJAM5KAgABso



On 2025/4/23 23:12, Niklas Cassel wrote:
> On Wed, Apr 23, 2025 at 10:14:57PM +0800, Hans Zhang wrote:
>>> I can see why you renamed PCIE_CLIENT_GENERAL_CONTROL to PCIE_CLIENT_GENERAL_CON
>>> (to match PCIE_CLIENT_MSG_GEN_CON).
>>>
>>> But now we have PCIE_CLIENT_MSG_GEN_CON / PCIE_CLIENT_GENERAL_CON and
>>> PCIE_CLIENT_HOT_RESET_CTRL.
>>>
>>> _CTRL seems like a more common shortening. How about renaming all three to
>>> end with _CTRL ?
>>
>> I saw that TRM is named like this.
>>
>> PCIE_CLIENT_GENERAL_CON / PCIE_CLIENT_MSG_GEN_CON /
>> PCIE_CLIENT_HOT_RESET_CTRL
>>
>> Shall we take TRM as the standard or your suggestion?
> 
> Aha, so the inconsistency is in the TRM... hahaha :)
> 
> Probably best to keep it identical to the TRM.
> 

Hi Niklas,

Thank you very much for your reply. Okay.

Best regards,
Hans


