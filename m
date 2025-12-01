Return-Path: <linux-pci+bounces-42374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB8C97E4D
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 15:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBF44342BB6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6EA302152;
	Mon,  1 Dec 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GTnVXb+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60040305043
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600383; cv=none; b=AfpSlpyvvso1PXHF0444qCHlwMon95QHN8PqRQivrUeUtmNT0G+mrT5Kv6Jq5MCMVq9IjV+Z1jYajD+Rl7XRc4YJvAQ5iIu1RiVDJeS56YtlQmcYPlYba3vcgM1XiOOX0WyoJsxjbNiMzs1JRAcfsqp+Uu82H5azUW7AfjRMKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600383; c=relaxed/simple;
	bh=flHWd3/EeIW/9h9K4Vl01KNGZtQyjGbiH0Uet1SsA2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+swDu5oHi385VeDchT6uhwT9+5dPNt4+fnM0AEZoYk5pn+lMUR/53+vvsEIZOcEg7QORw+oIQNPjbHh4RZ+ANtdCyiKWTBWW5gOn8E3A1Drr5Qe2IfF8zyBoXuNCyssdCe1CG1AvC7u3D5gmnx+uwOPtgKJy/mEqspUtsnozF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GTnVXb+8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764600371; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Sbzck6R+r9SorwfqADG9vFo7vpmiWZxrF60AtULoohA=;
	b=GTnVXb+8ERUIDMo0JwMVqpdMAqg5kX/Z/+ntz096MBe+53I0JCnViihU32xwWCDpGyfSXsVND5p0SiH4p1hsJcWmor3MH/Syj7s2cr3mCunrXowkVSGlFkEmMne6/OvS0J44TyAnw81l+qlOqhzomixps4DhxhLLscfokrL3e28=
Received: from 30.221.129.232(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WtsbPDo_1764600361 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 22:46:10 +0800
Message-ID: <238d7010-b54a-49cc-b5d0-e8422f59310f@linux.alibaba.com>
Date: Mon, 1 Dec 2025 22:46:00 +0800
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
 <969657a9-ea6b-44a8-a06c-c2af52212493@linux.alibaba.com>
 <aS2XeetaEW1RoWus@wunner.de>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <aS2XeetaEW1RoWus@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/12/1 21:26, Lukas Wunner 写道:
> On Mon, Dec 01, 2025 at 08:56:10PM +0800, guanghuifeng@linux.alibaba.com wrote:
>> 2025/12/1 18:03, Lukas Wunner :
>>> It seems highly unusual that the different functions of the same physical
>>> device require different delays until they're accessible.  I don't think
>>> we can accept such a sweeping change wholesale without more details,
>>> so please share what the topology looks like (lspci -tv), what devices are
>>> involved (lspci -vvv) and which device requires extra wait time for some
>>> of its functions.
> Could you please provide the details I asked for above?
>
> Thanks,
>
> Lukas

Thanks.

1. Currently, there are significant differences in reset recovery times 
among

    some PCIe multifunction devices, especially when the functions and 
complexities

    vary greatly, including some devices used for testing purposes.



2. Furthermore, similar implementations exist in various commercial devices

    (with vastly different functions), such as the multifunction devices

    (including VGA, audio functions, etc.) mentioned in the following link:

https://forums.developer.nvidia.com/t/nvidia-rtx-5090-not-detected-by-nvidia-smi-on-ubuntu-server-24-04/327409?page=2
[from the link]
lspci -nn | grep -i nvidia
c1:00.0 VGA compatible controller [0300]: NVIDIA Corporation GB202 
[GeForce RTX 5090] [10de:2b85] (rev a1)
c1:00.1 Audio device [0403]: NVIDIA Corporation Device [10de:22e8] (rev a1)

[from the link]



