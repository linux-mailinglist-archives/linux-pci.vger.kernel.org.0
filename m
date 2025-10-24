Return-Path: <linux-pci+bounces-39242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CFCC04681
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 07:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC403AFA31
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 05:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B1224891;
	Fri, 24 Oct 2025 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EGuaOB0i"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF12144C9;
	Fri, 24 Oct 2025 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284265; cv=none; b=byORtMD/aecMTCgt35dmbFiz1QzzZ95W3/5Bl7G8YYXbXQQgb2f+irIxl1YOnSWlrrpvgP0AlbvrAJoOS5W+49+iC9ESWqIJ3GK3JdTfDL1zm8p+xO6uYeInJj9wOy2CI2I8Z3pqIS2MY4zKYopvo4FXPb0LCTGFIhCHEXKlC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284265; c=relaxed/simple;
	bh=89Xh5dqUkfTeBBpojD+0rLJhmiP52jECIfc1pDkyhYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSfOnS2pp+8fhfDzHd5OXfaVpOWdAEK2dT0GuiSYma5fbaBnk9vDv+2YW/QyCPZyNFBbEZ7p0yj46NvKkM5WFQLbP40rMBumm/VPyAeoXN87Yget4LxOwQ+qLjRhMl1V2zsbLaBTZUHCYfva0hgm9zFTgIiEsejGOlg/fDs9jIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EGuaOB0i; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761284259; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Sp+hJRz+WWV/IDIJ1UXPhHVGxPXYYI9AFpPwtJzLdQA=;
	b=EGuaOB0iw2NTv8IOZ6vVxkCUSU438+blxF98ILkNaM+WvP8K2Xp+eht/2YmbWONbiisKAbIeNqi93AEGSC+3wxYEio1JhgdjbshWBnU0maKsbgUpL86RkwU3g3jpPKJb6NSKK+37l7iBz/sbBlY4n5ZnpTU3y/Gc9PIW6H3G9Gc=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wqt6g34_1761284257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 13:37:38 +0800
Message-ID: <2cc91a94-a444-4d15-b714-fe8502da1586@linux.alibaba.com>
Date: Fri, 24 Oct 2025 13:37:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
 <aPZAAPEGBNk_ec36@wunner.de>
 <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>
 <aPoDbKebJD30NjKG@wunner.de>
 <1eaf1f94-e26b-4313-b6b7-51ad966fe28e@linux.alibaba.com>
 <aPrvEZ3X4_tiD2Fh@wunner.de>
 <91cf33b4-7f67-4f3a-b095-e8f04d8c18e9@linux.alibaba.com>
 <aPr6dBDUUohRUzYg@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPr6dBDUUohRUzYg@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/24 12:03, Lukas Wunner 写道:
> On Fri, Oct 24, 2025 at 11:38:10AM +0800, Shuai Xue wrote:
>> The remaining question is whether it would make more sense to rename
>> pcie_clear_device_status() to pci_clear_device_error_status() and refine
>> its behavior by adding a mask specifically for bits 0 to 3. Here's an
>> example of the proposed change:
> 
> I don't see much value in renaming the function.
> 
> However clearing only bits 0-3 makes sense.  PCIe r5.0 defined bit 6
> as Emergency Power Reduction Detected with type RW1C in 2019.  The
> last time we touched pcie_clear_device_status() was in 2018 with
> ec752f5d54d7 and we've been clearing all bits since forever,
> not foreseeing that new ones with type RW1C might be added later.

Thank you for the detailed explanation and pointing out the history
behind bit 6 and the evolution since PCIe r5.0.

> 
> I suggest defining a new macro in include/uapi/linux/pci_regs.h
> instead of using 0xf, say PCI_EXP_DEVSTA_ERR.  Then you don't
> need the code comment because the code is self-explanatory.
> 

I’ll prepare a patch to implement this fix and submit it shortly.
Thanks again for the guidance!

Thanks.
Shuai





