Return-Path: <linux-pci+bounces-22725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB61A4B5F2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 03:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D641B16527C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2EA73451;
	Mon,  3 Mar 2025 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nhPlIaTN"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670A11CA9;
	Mon,  3 Mar 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967435; cv=none; b=IoJctNJPktW5Kvb1H1+mIGDPIfaX5yopVHOfv7QRgXMtMYytYxFZnYYeN85+2NTcZVgLnlT1bL5ktGIw4WAicNUHyIPKGIRbBSILVyVHo7INOU9EmrNs1/Y3Q2AnvAXd0rVmJySuAe3+USgbfOnuvGfUhgp4PIi779GeLJQcdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967435; c=relaxed/simple;
	bh=SEl1Hhf8NGcojuiMYmabQEzaNG0PSXe4Q1cOqkei6w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0bGOsMWRrjkdJOMnh0UpioslXNMe54jAskyOj0kwHtADD/BcYwcmYPBHWtcud1JTCrdPXNZg5m9181/CfKuVHhEQU3I4w1C/zexVT+liJHgedsuf5h6pDWHPC+sjDqOKJv015DKks5HmDlB13JUodrvRrquHDLNydi5MpVXRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nhPlIaTN; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740967423; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ovJU3Q9h8hU/G3fkOoZ1jgiNl8W2k7s8Lwa5u8Ka3Hk=;
	b=nhPlIaTNEI+rXbuTfVUF4mR3ko8wjzygstZJ6gFuYi68VLE0t8TmMQxJux7BHfMSlKWfQQ//jJYPcYhH2AH6nxk2jyQQ5iIojPCUZb2qs0E7z3ZuFhw80amd8koiSwDbK/S4fa1S+PfNhsb7K+SSUP4BAlvhvdC9viwGi7eyGy4=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQWfcKP_1740967421 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 10:03:42 +0800
Message-ID: <8c7b0cbf-fc93-4d97-b388-bfd0f13e404b@linux.alibaba.com>
Date: Mon, 3 Mar 2025 10:03:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com
References: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/17 10:42, Shuai Xue 写道:
> changes since v3:
> - squash patch 1 and 2 into one patch per Sathyanarayanan
> - add comments note for dpc_process_error per Sathyanarayanan
> - pick up Reviewed-by tag from Sathyanarayanan
> 
> changes since v2:
> - moving the "err_port" rename to a separate patch per Sathyanarayanan
> - rewrite comments of dpc_process_error per Sathyanarayanan
> - remove NULL initialization for err_dev per Sathyanarayanan
> 
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
>     pcieport 0000:30:03.0: EDR: EDR event received
>     pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>     pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>     pcieport 0000:30:03.0: AER: broadcast error_detected message
>     nvme nvme0: frozen state error detected, reset controller
>     nvme 0000:34:00.0: ready 0ms after DPC
>     pcieport 0000:30:03.0: AER: broadcast slot_reset message
> 
> AER status registers are sticky and Write-1-to-clear. If the link recovered
> after hot reset, we can still safely access AER status of the error device.
> In such case, report fatal errors which helps to figure out the error root
> case.
> 
> After this patch set, the logs like:
> 
>     pcieport 0000:30:03.0: EDR: EDR event received
>     pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>     pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>     pcieport 0000:30:03.0: AER: broadcast error_detected message
>     nvme nvme0: frozen state error detected, reset controller
>     pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>     nvme 0000:34:00.0: ready 0ms after DPC
>     nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>     nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>     nvme 0000:34:00.0:    [ 4] DLP                    (First)
>     pcieport 0000:30:03.0: AER: broadcast slot_reset message
> 
> Shuai Xue (3):
>    PCI/DPC: Clarify naming for error port in DPC Handling
>    PCI/DPC: Run recovery on device that detected the error
>    PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
> 
>   drivers/pci/pci.h      |  5 +++--
>   drivers/pci/pcie/aer.c | 11 +++++++----
>   drivers/pci/pcie/dpc.c | 34 +++++++++++++++++++++++++++-------
>   drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
>   drivers/pci/pcie/err.c |  9 +++++++++
>   5 files changed, 64 insertions(+), 30 deletions(-)
> 


Hi, All,

Gentle ping.

Thanks.
Shuai

