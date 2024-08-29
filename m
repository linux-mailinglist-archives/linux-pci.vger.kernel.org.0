Return-Path: <linux-pci+bounces-12414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCD963F44
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 10:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA9D286D5B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF118D63C;
	Thu, 29 Aug 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ewCNwA1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAD18CBF4;
	Thu, 29 Aug 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921739; cv=none; b=V/x4Icm3auGmD8LsxQIvmfXi6q3Xd/7794GbWLkWPMpvQGwZd1WqIcO+DhbFp1b0i5T7o47VzxUGTgrpgeiPZfdHFOoDoQNbmqFRxFFKpBNZ3b9c6RuBiPr4new7PmjdVE5M/YcuNjrhYuTvzztDNaMeQr/DV7QBGM/8ChLfFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921739; c=relaxed/simple;
	bh=irF/Exbh8tNHJyA0mbYDXwJY+Vdp/Xe4uxYhxNaFg+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur9vnrOiUbRdeZiHnThtW4gnywGoZpQoDrX/WJZ3h7fs1xb7IpZLlCRKiZUWzwyCle8FKnr46KtonMn4tTXbcoroeLHKLWTf5q+T+w+doRJNhTVgk+65vbcM0nWc4Bhkxckb5uP3sVM9I736WaUA0KqQ+wynTTugA/SzaS8WvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ewCNwA1v; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724921724;
	bh=9f8xxWjXOiiRlGB1TNKCMEUgG8ygajsw78osxDrP6mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ewCNwA1v0P6AUtz7JJ2x90ZkLRpIpohUy/hc5Boh0sLyqEJGR9D41dFsSVOJZh2wl
	 Zb0Q+0XwmPLGKl4H54/nJ0i2tHHkvX+XBQ8JueykrYp7RWiCKInrpo531KW0fLwtqY
	 nXmxqbgYVL9rk7tbZdtuHVLL3XE3FIsG1qAEL7aY=
X-QQ-mid: bizesmtpsz15t1724921721tj1qhz
X-QQ-Originating-IP: MFmiqbLlMzHklrZhjHSs0ONeA9dWI0dP6A0aey/qloU=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Aug 2024 16:55:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3019131951402270349
Message-ID: <A2BAFE2C814CDA13+6d47d76e-f0be-4380-bc98-9bd303ac52d6@uniontech.com>
Date: Thu, 29 Aug 2024 16:55:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, bhelgaas@google.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 guanwentao@uniontech.com, zhanjun@uniontech.com,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Wang Zhimin <wangzhimin1179@phytium.com.cn>,
 Chen Zhenhua <chenzhenhua@phytium.com.cn>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
References: <59E000092FD56E43+20240829073005.304698-1-wangyuli@uniontech.com>
 <2024082944-say-caution-befe@gregkh>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <2024082944-say-caution-befe@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/8/29 16:46, Greg KH wrote:
> Please read the top of this file, there's no need to add this id to this
> file as you are only using it in one .c file.

Thanks for review.

More files using PCI_VENDOR_ID_PHYTIUM will appear,though maybe not in 
the USB subsystem.

These patches are on their way and I won't keep you waiting too long.

However,if I temporarily delete this line and use a raw hexadecimal 
value in xhci-pci.c,I'll need to modify xhci-pci.c again soon.

If you think it is more reasonable and acceptable,I'll send a patch-v2 
immediately to avoid breaking the rules for pci_ids.

>
> thanks,
>
> greg k-h
>
Thanks,
-- 
WangYuli


