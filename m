Return-Path: <linux-pci+bounces-19003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0629FBCDB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616167A0437
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABFC1B6CE6;
	Tue, 24 Dec 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TyyqscQf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999A1B4F02;
	Tue, 24 Dec 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735038238; cv=none; b=D4D4QOPlc/HpfqrYEyCCsH5v2MT7/nfNHnM1g6vzeFW/SHA0YuYVd24IoD6XrNSch6bQRVYXgstD9GQtMfirtiUMAMiGHX4zl7zfqThWHwDvNPbvkQDE9UlEDWSRFMmMlvTwfGUpk6p0912X56Ge9AMTB06AIC8EhrcSsgWwuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735038238; c=relaxed/simple;
	bh=kZLRVdkG9OuO9YtFLZStPYa62dfyTiHvT71cFlx/gxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aorVL4hW82n2dZkAO6N7TxLAxP+s53fUUVoryQuiwpEzf79LY8NVf1S185Im1nqMfATYHyIQQv5hUgmwOkhk3S9WqnKGi1Y6E3RMCAZ+08YrSS4reCMhB8hlFzctcRqeCTR8zFuB3W0fUPx3eyy/SaO9uEG7HPKOE87LCQ6q5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TyyqscQf; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735038227; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mvF+dV1vOqypF3DXfAFYUzb9UKgwVp9yfkPjXxoAPvw=;
	b=TyyqscQfIjhjbMQOXbPa1Y9/Rm5YihwWeKWqN9GhoeQUDOlsG+b02eS9UDlh501so//ppkPatERzocqvIQV0phCVDimGh68orSRweaNy73i1hNzJFemREh38+cLV+vR12nLmUs5j+HH4WvALw9b4v4QEAmKtPpCXLvcSZ+RwJIs=
Received: from 30.246.161.240(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WMBoiH8_1735038225 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Dec 2024 19:03:46 +0800
Message-ID: <07a8c3b9-c14d-4754-900c-e08ea1051393@linux.alibaba.com>
Date: Tue, 24 Dec 2024 19:03:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/12 21:54, Shuai Xue 写道:
> changes since v1:
> - rewrite commit log per Bjorn
> - refactor aer_get_device_error_info to reduce duplication per Keith
> - fix to avoid reporting fatal errors twice for root and downstream ports per Keith
> 
> The AER driver has historically avoided reading the configuration space of an
> endpoint or RCiEP that reported a fatal error, considering the link to that
> device unreliable. Consequently, when a fatal error occurs, the AER and DPC
> drivers do not report specific error types, resulting in logs like:
> 
>    pcieport 0000:30:03.0: EDR: EDR event received
>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>    nvme nvme0: frozen state error detected, reset controller
>    nvme 0000:34:00.0: ready 0ms after DPC
>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
> 
> AER status registers are sticky and Write-1-to-clear. If the link recovered
> after hot reset, we can still safely access AER status of the error device.
> In such case, report fatal errors which helps to figure out the error root
> case.
> 
> - Patch 1/2 identifies the error device by SOURCE ID register
> - Patch 2/3 reports the AER status if link recoverd.
> 
> After this patch set, the logs like:
> 
>    pcieport 0000:30:03.0: EDR: EDR event received
>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>    nvme nvme0: frozen state error detected, reset controller
>    pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>    nvme 0000:34:00.0: ready 0ms after DPC
>    nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>    nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>    nvme 0000:34:00.0:    [ 4] DLP                    (First)
>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
> 
> Shuai Xue (2):
>    PCI/DPC: Run recovery on device that detected the error
>    PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
> 
>   drivers/pci/pci.h      |  5 +++--
>   drivers/pci/pcie/aer.c | 11 +++++++----
>   drivers/pci/pcie/dpc.c | 32 +++++++++++++++++++++++++-------
>   drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
>   drivers/pci/pcie/err.c |  9 +++++++++
>   5 files changed, 62 insertions(+), 30 deletions(-)
> 

Hi, all,

Gentle ping.

Best Regards,
Shuai

