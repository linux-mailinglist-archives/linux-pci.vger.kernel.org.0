Return-Path: <linux-pci+bounces-32148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B1B05899
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 13:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562674A78DA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDD2D63FF;
	Tue, 15 Jul 2025 11:19:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B926E6F1;
	Tue, 15 Jul 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578375; cv=none; b=D1U5vmT1eHaKXJOERAEXUg2lm5xqLnblcfsD1jiiA9nm4BrujorZuDy1EheaEOZ0mz3bunLj82d1GnU6oPXHsTahKXUVb4gxaiPHWoHySr9o45jD6+eFNE+YGCIHw1EEXnIC6JD1f2rToW+uniTmi1lMI7HlNbAPgxOlmEkP3/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578375; c=relaxed/simple;
	bh=1fgdaPHSb+dz9sXfWTIUSKP3VavySoHBRLHJ7K9NoOs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukFfBdZrNu2OKrpV89AlcLMeRH86gRkTEdMs1ik/BrletGpy+Yer4ZqpbdFG1T1vGUaRwSAp1vXpHr6rgF1A0EWH7sqP8hl1Ldo83D6/Sw7NkojQnfCg2xyNkEi+8NinHFyxV8OZfQBXAsol4XTS8mNeD6k3PzgPFPnWuhfrWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhGrn0WBWz6M4PN;
	Tue, 15 Jul 2025 19:18:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CD9B2140275;
	Tue, 15 Jul 2025 19:19:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 13:19:30 +0200
Date: Tue, 15 Jul 2025 12:19:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matthew Wood <thepacketgeek@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH pci-next v1 0/1] PCI/sysfs: Expose PCIe device serial
 number
Message-ID: <20250715121929.00007ef2@huawei.com>
In-Reply-To: <20250713011714.384621-1-thepacketgeek@gmail.com>
References: <20250713011714.384621-1-thepacketgeek@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 12 Jul 2025 18:17:12 -0700
Matthew Wood <thepacketgeek@gmail.com> wrote:

> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same 2-byte dashed formatting as lspci serial number capability
> output:
> 
>     more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f.0/0000:cc:00.0/device_serial_number
>     00-80-ee-00-00-00-41-80
> 

What is the use case for this? I can think of some possibilities but good to
see why you care here.


> Accompanying lspci output:
> 
>     sudo lspci -vvv -s cc:00.0
>         cc:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe Switch management endpoint (rev b0)
>             Subsystem: Broadcom / LSI Device 0144
>             ...
>             Capabilities: [100 v1] Device Serial Number 00-80-ee-00-00-00-41-80
>             ...
> 
> If a device doesn't support the serial number capability, userspace will receive
> an empty read:

Better if possible to not expose the sysfs attribute if no such capability.
We already have pcie_dev_attrs_are_visible() so easy to extend that.


> 
>     more /sys/devices/pci0000:00/0000:00:07.1/device_serial_number
>     echo $?
>     0
> 
> 
> Matthew Wood (1):
>   PCI/sysfs: Expose PCIe device serial number
> 
>  drivers/pci/pci-sysfs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 


