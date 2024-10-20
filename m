Return-Path: <linux-pci+bounces-14923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75799A5311
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18771C20C88
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748C2B9B4;
	Sun, 20 Oct 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jo2crYfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mr85p00im-ztdg06011801.me.com (mr85p00im-ztdg06011801.me.com [17.58.23.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552628684
	for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729412294; cv=none; b=UCovN3MslwuT9TshOuLhoNiblL9NdjCZlSOf3jG5EwA0q69jxPECIlNMeL7+3z+DemFszwZEc/DqVm5nECI7hQ5BX7EQ1j0czuHUIGADCd8JURSdP1ut0lAkdUasGdDtlCulE3tg0JtlMnrgGOyHLAbKXVXWN15AUjwtOQujcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729412294; c=relaxed/simple;
	bh=4rRN2upErJXwVYOa3zXJGtjNIRKub+rjNK9urqCnwp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8v01oCAEZ9FxUBZDOkAG/K8ZamsuCIxo0TpmfyChi3SajmoB/CF5hB/fP8ujR5HoaJJiHG3gdQEppfhVwguA+y2PpJxVVSr+UA5TAF/oOZV0E7Ervwy9rkumDo3E8maraXWqqBJ6vowR9cUtYsqoUNPF6GWGONjnvcWll6gpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jo2crYfQ; arc=none smtp.client-ip=17.58.23.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729412292;
	bh=+UZzz+z7p55a5+mo6TK6JWnhlOW39+wGGfYZPaGJKtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=jo2crYfQmO8Gv4wwWh41gOlsWA5WRua3SyRkVzwCl9CHc41gRxVeoXCAUKr4xLXMp
	 VSWgVsmXvAfAZDXbWaMXKu9GNy6QDSIM+DyoRwPaZOFhRKGxIG54rfMmdgec2yGWlR
	 44WLL6D+j7r548/avuiEpX1yZSN5XIWsAe7FuX18jUHLN5ZbFEc3kMY6B/iAklUUX3
	 OT++rFGJwxAR96T3RliTcxgfTiBadAXXlATuxaPLYRDvh7bKy4DQF1ESQVYD3gsitN
	 dtxkkdPztAgqkaRaDK+mK3bPfXui3gsZt6eDYdb+gj6b9JuvIA85Hbc4sG5EG2PGup
	 6aiekBiHLHDCw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id 0679AAC56DC;
	Sun, 20 Oct 2024 08:18:08 +0000 (UTC)
Message-ID: <e165fb81-8d96-49dc-9bfd-85ae79ef4f64@icloud.com>
Date: Sun, 20 Oct 2024 16:18:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] phy: core: Add missing of_node_put() in
 of_phy_provider_lookup()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
 <20241020-phy_core_fix-v1-5-078062f7da71@quicinc.com>
 <5e828a43-9365-4ac5-b411-0be7188ab8f2@wanadoo.fr>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <5e828a43-9365-4ac5-b411-0be7188ab8f2@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6BrM4yrglDgG8u6czpMYQdRccmjjapAH
X-Proofpoint-GUID: 6BrM4yrglDgG8u6czpMYQdRccmjjapAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_05,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410200052

On 2024/10/20 15:23, Christophe JAILLET wrote:
> Le 20/10/2024 à 07:27, Zijun Hu a écrit :
>> From: Zijun Hu <quic_zijuhu@quicinc.com>

[snip]

>> ---
>>   drivers/phy/phy-core.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index 967878b78797..24bd619a33dd 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -143,10 +143,11 @@ static struct phy_provider
>> *of_phy_provider_lookup(struct device_node *node)
>>       list_for_each_entry(phy_provider, &phy_provider_list, list) {
>>           if (phy_provider->dev->of_node == node)
>>               return phy_provider;
>> -
>>           for_each_child_of_node(phy_provider->children, child)
>> -            if (child == node)
>> +            if (child == node) {
>> +                of_node_put(child);
>>                   return phy_provider;
>> +            }
> 
> Hi,
> 
> Maybe for_each_child_of_node_scoped() to slightly simplify things at the
> same time?
> 

thank you for code review.

it does not use _scoped() since for_each_child_of_node() usage here is
very simple and only has one early exit, _scoped() normally is for
complex case.

i maybe use _scoped() in next revision if one more reviewer also prefers
it.

thank you.

>>       }
>>         return ERR_PTR(-EPROBE_DEFER);
>>
> 


