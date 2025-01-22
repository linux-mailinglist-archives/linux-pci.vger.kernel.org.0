Return-Path: <linux-pci+bounces-20235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C487FA1902F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 11:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A888163FC5
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848E2116EC;
	Wed, 22 Jan 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R0hhQB0x"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71A136A;
	Wed, 22 Jan 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543561; cv=none; b=CXvmz0zE6qDAJZZ4+CdV52vVx7uj46tbnk6mLz0cu0Qj0oEx7Ynt9NnrFNxMZ+ntIfQZCqPsukxcxrOsl8S6tdmhiy2lD/pyBjMTgDP7mYjsXmqXS4aBQSFRaqDvQMOLfGmfqzEMwPgDwKdHdEJeD6ZDrEgRCUWle0cETxRgSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543561; c=relaxed/simple;
	bh=wSC/ZATZYnTq0hx1jV74YnHd06lM46mDgIrka2H8e0g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=prAJIxwAAPR8LYVuD6ArC2//d/7fZkWCLwuAcKp5lsDBAs99Jg5o2owMLFt6TX96Pt2VYWnPz3SMDj1nYlWAEcLCLRRbSk/7c6cv4T/iWmGJOsoRB92tCHVFCHyRpQVhJZ+9Fq78KtoARBpsff8l0jyTsldf+j8yY3uMhiSv+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R0hhQB0x; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737543546; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=3cS1NupOfPb8WLvVbyrxEZgH8DoM9HSXnNPe+WOzLRg=;
	b=R0hhQB0xI2Ej9tBbj2nNTHfBk+01Kr+YrT2+d9dd/3df86l0aytjy6zBJAMhxCkdtUc+So9SuLrNR45PwujCB4+nuIEu+vMzvZ2y/bW5Jc9I6yPFAGFtmc8NrwC/ywM895eFsuGZnOlu+xe77axZB5Rxo8YN3OGZf3i1UV0izSM=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WO8Ek8._1737543545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 18:59:06 +0800
Message-ID: <01ac07c9-0cd6-4b63-a244-8a6dfa853ebc@linux.alibaba.com>
Date: Wed, 22 Jan 2025 18:59:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <07a8c3b9-c14d-4754-900c-e08ea1051393@linux.alibaba.com>
In-Reply-To: <07a8c3b9-c14d-4754-900c-e08ea1051393@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, all,

Gentle ping.
  
Best Regards,
Shuai

在 2024/12/24 19:03, Shuai Xue 写道:
> 
> 
> 在 2024/11/12 21:54, Shuai Xue 写道:
>> changes since v1:
>> - rewrite commit log per Bjorn
>> - refactor aer_get_device_error_info to reduce duplication per Keith
>> - fix to avoid reporting fatal errors twice for root and downstream ports per Keith
>>
>> The AER driver has historically avoided reading the configuration space of an
>> endpoint or RCiEP that reported a fatal error, considering the link to that
>> device unreliable. Consequently, when a fatal error occurs, the AER and DPC
>> drivers do not report specific error types, resulting in logs like:
>>
>>    pcieport 0000:30:03.0: EDR: EDR event received
>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>    nvme nvme0: frozen state error detected, reset controller
>>    nvme 0000:34:00.0: ready 0ms after DPC
>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>
>> AER status registers are sticky and Write-1-to-clear. If the link recovered
>> after hot reset, we can still safely access AER status of the error device.
>> In such case, report fatal errors which helps to figure out the error root
>> case.
>>
>> - Patch 1/2 identifies the error device by SOURCE ID register
>> - Patch 2/3 reports the AER status if link recoverd.
>>
>> After this patch set, the logs like:
>>
>>    pcieport 0000:30:03.0: EDR: EDR event received
>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>    nvme nvme0: frozen state error detected, reset controller
>>    pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>>    nvme 0000:34:00.0: ready 0ms after DPC
>>    nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>>    nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>>    nvme 0000:34:00.0:    [ 4] DLP                    (First)
>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>
>> Shuai Xue (2):
>>    PCI/DPC: Run recovery on device that detected the error
>>    PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
>>
>>   drivers/pci/pci.h      |  5 +++--
>>   drivers/pci/pcie/aer.c | 11 +++++++----
>>   drivers/pci/pcie/dpc.c | 32 +++++++++++++++++++++++++-------
>>   drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
>>   drivers/pci/pcie/err.c |  9 +++++++++
>>   5 files changed, 62 insertions(+), 30 deletions(-)
>>
> 
> Hi, all,
> 
> Gentle ping.
> 
> Best Regards,
> Shuai


