Return-Path: <linux-pci+bounces-38753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2076ABF1753
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF07B4F5210
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE4E2F83DF;
	Mon, 20 Oct 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P6BX9Pcj"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501619992C;
	Mon, 20 Oct 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965798; cv=none; b=nWjF1XrhlKyGUkqEupqvM5HGROqjBg01pH7fnA8y5WWyrtdKWS4kgWgufbtrFjAN8E4rO69A8/QnVC9rV+D1pkOU/OMX1zcT7+eW5Mp9e/lpTfXVqZR+D94ldMBS09HUOFobGd+wtQQJH4PKLFy9U2UpnnkPhkysr9DXEpPHHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965798; c=relaxed/simple;
	bh=5MJxyHQi0JAnt3hnhp6JjvFyKPWOiQz2LJxf6siCF/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjyvfI10YuFoN5oxVnDIltWG1VK/KgAf1drjaxFoo1V3Y+M288keYzRAxE5/WoEF6Cp/D4nDeMgBVznU2Hig99qmH/UF7fqp27HKUiFCk2uURP7wIXZKtgQsMmEMLtX/Z/1O7zqLaNMCAHjqItX8mN9kvAEPJechUyCKkUPUr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P6BX9Pcj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760965787; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A/YVSIfENMg7a+CnApsjKhHaaNSfgBvr9Vz+qTSmgCU=;
	b=P6BX9Pcj1Y8Biyjhg/KHDuYm3uPOylZVVJTCgBT4U24088+cDNhATEgGcwktQzvJOJ3f/OHnC8J/RCSNPaaEVJFCGneGRJKwpQXaSk+Qf8nba0otDP6qWLyq/WIbszo65Xt/J8DepdzZCK2YJt7ouEZiAoAtfwQHlI1dUaVCJ2k=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqcnHlY_1760965785 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 21:09:46 +0800
Message-ID: <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
Date: Mon, 20 Oct 2025 21:09:41 +0800
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPYMO2Eu5UyeEvNu@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/20 18:17, Lukas Wunner 写道:
> On Wed, Oct 15, 2025 at 10:41:58AM +0800, Shuai Xue wrote:
>> Replace the manual checks for native AER control with the
>> pcie_aer_is_native() helper, which provides a more robust way
>> to determine if we have native control of AER.

Hi, Lukas,

Thank you for your question.

> 
> Why is it more robust?

IMHO, the pcie_aer_is_native() helper is more robust because it includes
additional safety checks that the manual approach lacks:

int pcie_aer_is_native(struct pci_dev *dev)
{
	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);

	if (!dev->aer_cap)
		return 0;

	return pcie_ports_native || host->native_aer;
}
EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");

Specifically, it performs a sanity check for dev->aer_cap before
evaluating native AER control.

And I think this is more maintainable than manual checks scattered
throughout the code, as the helper encapsulates the exact conditions
required to determine native AER control.

> 
> Thanks,
> 
> Lukas

Thanks.

Shuai

