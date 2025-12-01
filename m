Return-Path: <linux-pci+bounces-42364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036ECC97747
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 14:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DD83A0FD3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017382F5A28;
	Mon,  1 Dec 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JFD1/qPQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31B30DEC8
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593779; cv=none; b=KqQOR3yW4t5BlYAViup/+/ti0YIF4ucG5rdSmX/QCQeUZLcAEylIm/z50/3nlHT4R/Sed3wh3GBiM2l6cn7op32m+MG4b9hnQsh2NJjECHUJOutqSr2tDIAT5xiwWx5Mzlmj9aN7psdB+ubb8JJZ7jCDDj17ryPZRDxqXA+3TRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593779; c=relaxed/simple;
	bh=GAP2xMHkHqaBfkFB94IisYBWx2GIIvZhS7tNMKXpImg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3V8dN5U8vtsQbaXnA5vGICMrIxL5pBzeSJgpgDlprDVJ1A21VOn5e0mcydd1JZq6RwMLfWvd5yoEu1+jAERmotxZ+71SHQ4skiokTdk+SvXtsUbNopJLHCecUTY7x8YFzUR/a4GPHeRgBZdMeez2hvOcx6IXSNAxa/aMKFjCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JFD1/qPQ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764593772; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tNfFxOjWQl6zEhCNLR1qyJDyReiS0qRLG188Vv0o2Xw=;
	b=JFD1/qPQg81ctKr2lTXVN0WOSw42C10AkTkfzVO56NddbyxpfkWApKJ+1Y18inKYuEUiAc+GIFA68iyCpHYJO8FXbCi4E3xkIJtXH5BTsfMLNC1GQGelFYV05ZApP9GtdsuavLinWl/bCRsUHSBn7WNeiBGKSzSrkyYW7IifH6g=
Received: from 30.221.129.232(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WtrTiYr_1764593771 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 20:56:12 +0800
Message-ID: <969657a9-ea6b-44a8-a06c-c2af52212493@linux.alibaba.com>
Date: Mon, 1 Dec 2025 20:56:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci
 <linux-pci@vger.kernel.org>, kanie <kanie@linux.alibaba.com>,
 alikernel-developer <alikernel-developer@linux.alibaba.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>
 <20251124235858.GA2726643@bhelgaas>
 <a4a2a5ee-1f4e-4560-b8cf-c9c10ae475dd.guanghuifeng@linux.alibaba.com>
 <aS1oArFHeo9FAuv-@wunner.de>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <aS1oArFHeo9FAuv-@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/12/1 18:03, Lukas Wunner 写道:
> On Tue, Nov 25, 2025 at 02:20:10PM +0800, guanghui.fgh wrote:
>> After __pci_reset_slot/__pci_reset_bus calls
>> pci_bridge_wait_for_secondary_bus, the device will be restored via
>> pci_dev_restore. However, when a multifunction PCIe device is connected,
>> executing pci_bridge_wait_for_secondary_bus only guarantees the restoration
>> of a random device. For other devices that are still restoring, executing
>> pci_dev_restore cannot restore the device state normally, resulting in
>> errors or even device offline.
> PCIe is point-to-point, i.e. at the two ends of a link there's only a
> single physical device.  So if there are multiple pci_dev's on a bus,
> they're additional functions or VFs of the same physical device.
>
> The expectation is that if the first device on the bus is accessible,
> all other functions of the same physical device are accessible as well.
> That's why we only wait for the first device to become accessible.
>
> It seems highly unusual that the different functions of the same physical
> device require different delays until they're accessible.  I don't think
> we can accept such a sweeping change wholesale without more details,
> so please share what the topology looks like (lspci -tv), what devices are
> involved (lspci -vvv) and which device requires extra wait time for some
> of its functions.
>
> Thanks,
>
> Lukas

1. For PCIe end-to-end/point-to-point connections, PCIe multifunctions 
do indeed share the same PCIe links/lanes.
2. However, the functions within a PCIe multifunction device have 
different functionalities and complexities.

    During the hot reset process, each function requires a different 
recovery time. Therefore, after confirming

    that the PCIe links are functioning correctly, it is necessary to 
further check to ensure that each function has completed its recovery.


