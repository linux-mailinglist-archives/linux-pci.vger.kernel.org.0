Return-Path: <linux-pci+bounces-28274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32870AC109E
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E634E7D22
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36930299953;
	Thu, 22 May 2025 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pKWzNnO5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4829CE6;
	Thu, 22 May 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929745; cv=none; b=nVJ5TZRpmbE4UwZNYQ+psnVo+foDC6HJTT6tW/frtcxEd+lGgCl2WGpZXo7Th3RqMtBv7h6y08KjtaMZL2ZGEEQIgyOIJgbW56TrcwnAELzxTh0dZNLdwX4Ort7j61hc6cogm4BPYbZb00Bd4GYhwIcIDRKmP2pCrEOn8YTIrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929745; c=relaxed/simple;
	bh=K8qyu4zwXLqUbPIjChC8Rq9ekYH/PJ1pa+QpwOv/Jrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRFZypcpckEZjd2/gpidG5mZCqofsFDFOV6x7kJ51+UK9EpSbsiLpSu0IK+vmDKon3cMV3zMSIPkJrDllwr8xHWXZyMhIJs5DWLa4rK3U/Ti0MuFHpdR+N0/Cssyqjs/E6satMlg7ev+NCC+v80f1eygrvb7hOYl4tOsX0DCptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pKWzNnO5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=0AZGXn3LCPEY9S15QKsQn0Bu/8rEFUNP3khAtgVDGKw=;
	b=pKWzNnO5XPi/51xWxZGHLUBE5xUg3sch9xkRX49/M8KWSiSNF7lEAQuo3FmU/7
	KRQYqXuz8ctRU1QXqUkb5NS9EW5XpDU0Y6mPMZGN9p+b2MkA5X0XqD0Wm6tLHGFX
	ZITh/p3TlrYa7CIp2Da/UllR4Zi0q0kDKR5pe/6/tIuGo=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXeqFZSi9ol5cRDQ--.46492S2;
	Fri, 23 May 2025 00:01:30 +0800 (CST)
Message-ID: <403949d7-7c36-4b9a-a079-60a5aa985dd1@163.com>
Date: Fri, 23 May 2025 00:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pci: implement "pci=aer_panic"
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, tglx@linutronix.de, kw@linux.com,
 mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20250516165518.125495-1-18255117159@163.com>
 <e2iu7w3sn7m4zwo6ork2mbfjcfixo5jn5ydshkefezsgtquvh6@kjdvxgiapbjj>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <e2iu7w3sn7m4zwo6ork2mbfjcfixo5jn5ydshkefezsgtquvh6@kjdvxgiapbjj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXeqFZSi9ol5cRDQ--.46492S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW5KF1rKr4kKr43KFW7Jwb_yoW8XrWkpF
	45tayDKF4DAFyfAFs2g3y0v3yjq3s5Jws8Jrn8Wr1ftr4agF17G34a9FWY9FW7Kr1I9w4S
	vFW0q398tFn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBMKZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwRVo2gvRGCRpgAAs9



On 2025/5/22 19:47, Manivannan Sadhasivam wrote:
> On Sat, May 17, 2025 at 12:55:14AM +0800, Hans Zhang wrote:
>> The following series introduces a new kernel command-line option aer_panic
>> to enhance error handling for PCIe Advanced Error Reporting (AER) in
>> mission-critical environments. This feature ensures deterministic recover
>> from fatal PCIe errors by triggering a controlled kernel panic when device
>> recovery fails, avoiding indefinite system hangs.
>>
>> Problem Statement
>> In systems where unresolved PCIe errors (e.g., bus hangs) occur,
>> traditional error recovery mechanisms may leave the system unresponsive
>> indefinitely. This is unacceptable for high-availability environment
>> requiring prompt recovery via reboot.
>>
>> Solution
>> The aer_panic option forces a kernel panic on unrecoverable AER errors.
>> This bypasses prolonged recovery attempts and ensures immediate reboot.
>>
> 
> You should not panic the kernel when a PCI error occurs (even if it is a fatal
> one). You should instead try to reset the root complex. For that you need this
> series that got merged recently:
> https://lore.kernel.org/all/20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org
> 
> PS: You need to populate the slot_reset callback in your controller driver to
> reset the controller in the event of a fatal AER error or link down.

Dear Mani,

Thank you for your reply. I will take a look at the submission record 
you provided.

Best regards,
Hans


