Return-Path: <linux-pci+bounces-22833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1DA4DC49
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 12:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49847A745C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110111F03C0;
	Tue,  4 Mar 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kOwWUsyx"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760F01F76C0;
	Tue,  4 Mar 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087187; cv=none; b=rFkac+KjIA24Mj3bMxcz6nmiMeM8eeRX4ODFtgRd3kbQzZyKximc/mppSpdwMmH+zzDLRggTcDAYnvSkoyHrMFWjzPa+tieFcDaVj/Av6sqQoAh9l03kdJQ179mCRgFW+toySI5xwcaDKAcLOZ11onUoq2FnuHnwP8eFigges+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087187; c=relaxed/simple;
	bh=C7Iv/jeyWjTA3dGBlMW6Um/8mVYZwN5zn6x3p4sIXYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRrLgA0kHvRl3VupLu166I4iSkYEx3SksH1r2SN/Z9zbI45JLFdyezm5eS9u2eGmSE2ckEhLEx0GYJ96UVFLO5iPMQKUYlg3a/fzSxYyWblT+t0Arn5LbGaGWaNBDc5PQZx1Y+LHqnr1w9+eMEAYtau/9+ae+4HBWkgzXQQUI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kOwWUsyx; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=sBluh1p4+KUU8wEwPmT8gKFeC51HPBnTxIKdh6B6pBo=;
	b=kOwWUsyx8lZ0CC6cHHZhv/nDCAbn4ymzM1CrJC50sg1asPEptMkYCizZUrg6tZ
	MJw9dOkudXmoQT1/cIvZMYPpi3OHfuIb9zNWFZvH8X4TiIj4B+rCXmq/VSzPqSwr
	/W5b81k192s50x7wmfM0Q4pu7XuhA2ddbhSjcVZo9qq40=
Received: from [192.168.97.52] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHH+Gp4cZn6a7xBg--.59104S2;
	Tue, 04 Mar 2025 19:19:08 +0800 (CST)
Message-ID: <f51a60de-65f9-459e-9c1f-dd4f10ed65c6@163.com>
Date: Tue, 4 Mar 2025 19:19:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx
 without data payload
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250214165724.184599-1-18255117159@163.com>
 <20250303190602.GB1466882@rocinante> <20250304110134.GA4101682@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250304110134.GA4101682@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHH+Gp4cZn6a7xBg--.59104S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4xZr18KrW7WryrKFWUCFg_yoWkKwb_ur
	4kXFykAFs0gFna9F4rGF43AFyDuw1vyrWaga48trn8JayaqrWUJasxAr1rA3yrGw4Syr17
	uF93u3s8G3W3AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjD73PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwoGo2fG27rb-gAAsF



On 2025/3/4 19:01, Krzysztof Wilczyński wrote:
> On 25-03-04 04:06:02, Krzysztof Wilczyński wrote:
>> Hello,
>>
>>> Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
>>> 9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
>>> axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
>>> set, MSG without data.
>>
>> Would it be possible to get the full name of the reference manual mentioned
>> about?  I want to properly reference the full name, version, revision, etc.,
>> like we do for other documentation of this type where possible.
> 
> Hans, I came up with the following, have a look at:
> 
>    https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/cadence&id=09f4343a59cc2678a3a5b731d16e55c697246a40
> 
> Let me know if this is OK with you.  Thank you.
> 
> 	Krzysztof

It's OK with me.

Can you add an email address of our company as Signed-off-by? Because it 
involves Cadence documentation.

My company email: Hans Zhang <hans.zhang@cixtech.com>

Like this:
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Best regards
Hans


