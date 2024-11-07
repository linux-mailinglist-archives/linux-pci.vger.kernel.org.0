Return-Path: <linux-pci+bounces-16229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75069C0409
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 12:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CB8B20F28
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DDE2022E2;
	Thu,  7 Nov 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/2ZLnBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8972022C8
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979035; cv=none; b=eUfBniReA/j20JDIeP3g9klElHOBAP4IJj2eSO7yKJncayv7b5lA604e1xyWMWaxtx6mZh/tYK0Q+Zv122ACuMqxpmsjiydsM+L6VNueqJL9q8QrVfSIEwsTxHDCDrASSGlihtzc/LpodrblAvDP+OWxcLgNvUzwHioFMv3Ojyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979035; c=relaxed/simple;
	bh=bnUvjVdiSft7WVIMlOpLml9wAklJpPbdK06oUWbZ4qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL8Jtu1JfaqfvhIYO0PRQOk/zZrz0kVfbpcTG9c5jDAwlk2+Yo5lYfBOyMCRfgnEc0WBvxKFUOo/knTuFgrMkt/nJp92etBqOIsSI3v79JoVKb3ZWWXUeM5KlB/WHgFgawDCegn1G5F93BrAqbxuMiFWp10EtN+rj0ZhxJkzxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/2ZLnBI; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b35f536e-1eb0-4b7b-85f4-df94d76927d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730979027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6cUyGgnQgri70MMdhq/M7qPzahwKEUdSTflvW+Wn4g=;
	b=M/2ZLnBIDrhL+/lhucMT8nzJZrssCQ/ZV1MxyZzlfLqdUXGb0zz42XgAG5WSle2VHkKygy
	0+tk9AhPIb1M5jERCxv3kUr7cWCNWvXWtLuYtlT9XaUzIv1nZHUC0dNWJZCIQbL0Jm7KuE
	jcFqLgc6TsH1OiD+zYNKfe2yFfaBf/E=
Date: Thu, 7 Nov 2024 11:30:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
To: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <helgaas@kernel.org>,
 Sanman Pradhan <sanman.p211993@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
 jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20241106122251.GC5006@unreal> <20241106171257.GA1529850@bhelgaas>
 <76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
 <20241106160958.6d287fd8@kernel.org> <20241107082327.GI5006@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241107082327.GI5006@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/11/2024 08:23, Leon Romanovsky wrote:
> On Wed, Nov 06, 2024 at 04:09:58PM -0800, Jakub Kicinski wrote:
>> On Wed, 6 Nov 2024 18:36:16 +0100 Andrew Lunn wrote:
>>>> How would this be done in the PCI core?  As far as I can tell, all
>>>> these registers are device-specific and live in some device BAR.
>>>
>>> Is this a licences PCIe core?
>>>
>>> Could the same statistics appear in other devices which licence the
>>> same core? Maybe this needs pulling out into a helper?
>>
>> The core is licensed but I believe the _USER in the defines names means
>> the stats sit in the integration logic not the licensed IP. I could be
>> wrong.
>>
>>> If this is true, other uses of this core might not be networking
>>> hardware, so ethtool -S would not be the best interfaces. Then they
>>> should appear in debugfs?
>>
>> I tried to push back on adding PCIe config to network tooling,
>> and nobody listened. Look at all the PCI stuff in devlink params.
>> Some vendors dump PCIe signal integrity into ethtool -S
> 
> Can you please give an example? I grepped various keywords and didn't
> find anything suspicious.

Hmm...

[root@host ~]# ethtool -i eth0 | grep driver
driver: mlx5_core
[root@host ~]# ethtool -S eth0 | grep pci
      rx_pci_signal_integrity: 1
      tx_pci_signal_integrity: 1471
      outbound_pci_stalled_rd: 0
      outbound_pci_stalled_wr: 0
      outbound_pci_stalled_rd_events: 0
      outbound_pci_stalled_wr_events: 0

Isn't it a PCIe statistics?



