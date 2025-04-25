Return-Path: <linux-pci+bounces-26740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB0A9C55A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98DA16CCCD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E023AE84;
	Fri, 25 Apr 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X5PsQabr"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4718D;
	Fri, 25 Apr 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576875; cv=none; b=UE0s/l9wK94Z7FjKY6l1gwz83jMhvA7s0Mn7Ug8NdNGbZkk1aZmqS72KuZ4CkK5yWGPdgNM8fiJbHu1c7tC30j2K/3Xm6feny+pfATtpVI82uMb7WwR5WynutW9kseKbfl799CQBrUKXqJVcu7AxQKcxrvAlycr1l+wlHguCtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576875; c=relaxed/simple;
	bh=E0x8N3AZ4TFX3tbBzDUe98mYE9dOVHmKa0S5IerdplU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUS3g/fq5mRwnEcdMBLkwf5Hatyox9FWBKwDKtwZud/QgC+0GVYLeRKJEO9AF0DEMDp+DsU+wlUsLMTwEM0CxEbJgdstYrpoQafd6UWrjSBcLPz6IbpL6/BKsL9NsgunDEDSUNG4c9MkYDuwuBglMpXsqxs68otw1CAbYUL2Cvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X5PsQabr; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=zG66mfWXbPjwAhDXIOR7A3831eYYgiM5AtcB2S18NL4=;
	b=X5PsQabrR9K6jEK20m5Eq2MEBQh2A09QM7jIB2UrPHQt0hNJboxBD2siXKisad
	1paXffNBE7hxQ+f8HzCeu9z8lHGHyut6+CtFCe/FOO0gCvcrs27FH7TQU67pm2Mk
	78D9AMShMMXJO++3C+VZRrCWdrbh4XpmD9TXmYvFl9DZg=
Received: from [192.168.142.52] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAH4ilJYwto+c_QBg--.57013S2;
	Fri, 25 Apr 2025 18:26:18 +0800 (CST)
Message-ID: <7c7d5e12-7378-473e-941a-33c1b03cc8c9@163.com>
Date: Fri, 25 Apr 2025 18:26:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, thomas.petazzoni@bootlin.com,
 manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com, pali@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com> <aAthR8ZXSqfe6fzV@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAthR8ZXSqfe6fzV@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgAH4ilJYwto+c_QBg--.57013S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xw1Dtry8AFWxKr18AFyxZrb_yoW8Jr1Upa
	ySvrySya18tr4F9anrA3W8CryrWas7Kr90qr98Gr1xJ3Z0vF13JFya9F10q34UJryYq3W0
	yF4Yv347C3Z0kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UM89_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOho6o2gLYUIC+QACsA



On 2025/4/25 18:17, Niklas Cassel wrote:
> On Fri, Apr 25, 2025 at 05:57:08PM +0800, Hans Zhang wrote:
>> With the PCI core now centrally configuring root port MPS to
>> hardware-supported maximums (via 128 << pcie_mpss) during host probing,
>> platform-specific MPS adjustments are redundant. This patch removes the
>> custom the configuration of the max payload logic to align with the
>> standardized initialization flow.
>>
>> By eliminating redundant code, this change prevents conflicts with global
>> PCIe hierarchy tuning policies and reduces maintenance overhead. The Meson
>> driver now fully relies on the core PCI framework for MPS configuration,
>> ensuring consistency across the PCIe topology while preserving
>> hardware-specific MRRS handling.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>>   drivers/pci/controller/pci-aardvark.c  |  2 --
> 
> Since you are touching two drivers (and the changes are not exactly identical),
> I suggest that you do one patch per driver.

Dear Niklas,

Thank you very much for your reply. In the next version, I will split 
two patches.

Best regards,
Hans




