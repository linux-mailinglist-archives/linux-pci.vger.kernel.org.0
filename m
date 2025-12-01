Return-Path: <linux-pci+bounces-42348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEDC95EA0
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 07:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE7D634359D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0D280309;
	Mon,  1 Dec 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="vG/7rzgp"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E434286D7B
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764571720; cv=none; b=njlusWv75JVXu860HDhdwKhS+UriO3hcukYAYcxH/+rzzd1zntOdkjPxaqfBlIHjrZwy08az3it6JfR/3JLQhESjbVL2whISAjU7jHj7hKJ+7LtuBZF34V1Qnh8w1EwW+GS+T2nxD1xBhJL4cXasx8N7SxUlrRsaa3Qzmh0k1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764571720; c=relaxed/simple;
	bh=1NRo23qvFcKwP4ZEynQppXAUxeIqmqyc5XRObziJiXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVAu6tUyM06DypyghyNjXNAjjFMvA4bOOCtkAzd2zMlxSybipNeZMunE1sP/YWWz4Wztjvq6A4sSxK/Pv7xCLmZGmt577RKUijzO2WRDXdOXwuNNobghTkMoCeR4ExmDrIs795sYPkuIH/TdAi2an/2CfU1xFPQea2WM67PcTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=vG/7rzgp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <9a9280e7-d29a-475a-83fa-671acfab9d92@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1764571705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CvsvPDo++88EIfQk1NEfDubJ5f3pS7dCz2G/tHuOlo=;
	b=vG/7rzgp++1UVzDvFlSiXFXxbhK45/p4F7ZFE/ppCGsEQ+Esxt2HtVMYpHX5qOGSKQjqcz
	lND3oOWBCZmrGS1zopweXxuye9ek6jNx/AW3yyjPyvxZe5NrFLk6RifnwwlkpAlYbPuAL5
	Wiaf0ZsqgdXpAtoxwJmqLlDeV1QdKiFrGbFjrUBLNwhQHFhyICuY2M4/yrI3WQ9pBSFgeD
	jwOsWZZetVnlujuUmqn9QoIUpfnH8tqIUvCse4AVed+VqOjP7jdd7EwwIwhzyx69E2JTfp
	+0ORuqxTbNkLtnagpAP3Vzd0RB/pjgt7YIFk0Jy4lKKF5kJ8YdbziH1+8yZKSw==
Date: Mon, 1 Dec 2025 03:48:13 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,
 Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>,
 Jeffrey Lien <Jeff.Lien@sandisk.com>, Avinash M N <Avinash.M.N@sandisk.com>
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
 <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/25/25 2:21 AM, Manivannan Sadhasivam wrote:
> [..]
> There are a couple of points that made me convince myself:
>
> * Other X1E laptops are working fine with ASPM L1.
> * This laptop has WCN785x WiFi/BT combo card connected to the other controller
> instance and L1 is working fine for it.
> * There is no known issue with ASPM L1 in X1E chipsets.
>
> Because of these, I was so certain that the NVMe is the fault here.

There is *a* known issue with ASPM L1 on X1E, reported by maaaany users 
on #aarch64-laptops, that we discussed in another thread..

But it is a full system freeze, **not** a correctable AER message, and 
it definitely happens with a bunch of various SSDs on various laptops. I 
personally have had it happen both with the SN740 and an SK Hynix drive, 
on a Latitude 7455. It's an SSD-only issue (disabling ASPM just for the 
drive, but keeping it on for the WiFi, was enough to get to month-long 
uptime) but not specific to any SSD model.

One bit of news I have about it is that I recently started using EL2 
(slbounce), and I did see something that looked like that hang.. but 
unlike in EL1, right before the reboot the panic LED did start blinking. 
So if that was indeed from the same issue, I should now be able to catch 
it into pstore (if pstore works.. trying blk with sdhc instead of efi 
now 0.o) Maybe QHEE was eating the fault and itself crashing, since it 
"owns" the PCIe IOMMU when it's running.. (???)

~val


