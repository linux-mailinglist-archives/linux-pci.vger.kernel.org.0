Return-Path: <linux-pci+bounces-27641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63615AB57AE
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9017A657
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB01B4132;
	Tue, 13 May 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M4t9yiWS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B11AD3E0;
	Tue, 13 May 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148068; cv=none; b=Ki1+u1vxnw7waEyl1Yu2r1eqmQYpX1OMBeZGP27eaI4fGY29pFZ9sSDgdLXyr0Veywk52K49ub3mX02nKK8aWR3ao+5IiiXAnikJuRnjcX4+0DUca/zYsf2+IgalO2TPIHVyE40LLLwIGWcW666Ckqa1SfFG91XBWqMTxcY3S3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148068; c=relaxed/simple;
	bh=+ZMC4xvjWCXIHQQmuBli+mqd8+6t/RUnKW6CLhSK6vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXAFbIwOMLTPnDmK4vuSww6zGhXOvaj3hOG4p2G+GmogbY92u9Q5V4Qbd2Yn2P9xMhJaaRNHRLpdqJ+tOkIu6Aye6h/kcabX9yK9koJzBSjEOuE6EDW+1z9hbEZgs8YGRoWSOsHfN+7jGyBEoKqkS8MCEW+3HUfoc4S/bmgUOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M4t9yiWS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=nXQDzb+tFFVU+4SLdENHkW/1SY6XdLMilSABvcCoeBU=;
	b=M4t9yiWS6jQq9lz15VN6CVAutd+twdoSe9/gfmvn4tn9O3peNgeaTMQ/EcejzC
	KEFcIIZ6IYe7GW1kjoyKFkMSD8kwDZqSOPo4tO5tOF4QO+EsyfmPBlZD8DhhkCr9
	/4j2/u98y0120iF+3FSwZbK/zCM1HUC867PBfoJZz+UA8=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXt+XpXCNoldCmBA--.8342S2;
	Tue, 13 May 2025 22:53:30 +0800 (CST)
Message-ID: <ade4c14a-ff20-4001-8eda-75fef15df62c@163.com>
Date: Tue, 13 May 2025 22:53:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] PCI: Configure root port MPS during host probing
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
 pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-2-18255117159@163.com> <aCL9CStLrGEY2MEH@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aCL9CStLrGEY2MEH@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXt+XpXCNoldCmBA--.8342S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1rtrW7uFW3uw4rAFWkZwb_yoW8ur1Dpa
	y8Xw4vyFZ7WryfG3WDAa109rWjqas5CF43JrZ8JryqqFn8C3WqqrWYka1Fqas7Grnayw1j
	vw1jqry8uws0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpKZXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhxMo2gjWD+jDQAAsL



On 2025/5/13 16:04, Niklas Cassel wrote:
> On Sat, May 10, 2025 at 11:56:06PM +0800, Hans Zhang wrote:
>> Current PCIe initialization logic may leave root ports operating with
>> non-optimal Maximum Payload Size (MPS) settings. While downstream device
>> configuration is handled during bus enumeration, root port MPS values
>> inherited from firmware or hardware defaults might not utilize the full
>> capabilities supported by the controller hardware. This can result is
>> uboptimal data transfer efficiency across the PCIe hierarchy.
>>
>> During host controller probing phase, when PCIe bus tuning is enabled,
>> the implementation now configures root port MPS settings to their
>> hardware-supported maximum values. By iterating through bridge devices
>> under the root bus and identifying PCIe root ports, each port's MPS is
>> set to 128 << pcie_mpss to match the device's maximum supported payload
>> size. The Max Read Request Size (MRRS) is subsequently adjusted through
>> existing companion logic to maintain compatibility with PCIe
>> specifications.
>>
>> Explicit initialization at host probing stage ensures consistent PCIe
>> topology configuration before downstream devices perform their own MPS
>> negotiations. This proactive approach addresses platform-specific
>> requirements where controller drivers depend on properly initialized
>> root port settings, while maintaining backward compatibility through
>> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
>> utilized without altering existing device negotiation behaviors.
>>
>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
> 
> Looks good to me, but since this I'm the one who suggested this specific
> implementation, it would be good if someone else could review it as well.
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Dear Niklas,

Thank you very much for your review and suggestions. Let's wait for 
others' opinions.

Best regards,
Hans


