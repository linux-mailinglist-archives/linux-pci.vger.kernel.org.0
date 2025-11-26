Return-Path: <linux-pci+bounces-42117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809CC8A0B3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A64E4516
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED711F8AC5;
	Wed, 26 Nov 2025 13:30:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73726FA5A;
	Wed, 26 Nov 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163842; cv=none; b=l/YiRaQX8TViqBWtB6pLHmuyUHJbdeL4Ig9CSmY2wAKlawzQH9xxtxlROdbDLL5J99OFHm1nK9tqvP6sbN8f7wYROlyzadLTjT/Ss5qSzgMRZ+HA2iDOyx2XpTjLBKTwBKRwjgei0SbLdC7N/QV7GkGTohjspq50qUFA373AMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163842; c=relaxed/simple;
	bh=ZQpIJE2nZ9XnRZw50HqycNgwEHjIpOyaSLSX5LUZ6zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYF2ya/yc65OJoPsfaCNWNOVVPFcm3AHqATxYDYl2Ow0jyNvukhhz22VUx259QazckAngjFGKT7grCOOYJdnaEIq1475lmpzx3PryqSRzNGUcxgFyXEmiFZ1B9vGvm2yEa+wb8+kl/ljE8bWsKHOw1oQ2yBRlzIcviDeIW4qOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1764163812t7f9a4d6f
X-QQ-Originating-IP: QzsTEkFPDfqXuxj5d2hYwNbuoMtvYYg2/9uIfCzBt8w=
Received: from [IPV6:240f:10b:7440:1:db14:8483 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 21:30:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12122122324758629906
Message-ID: <7667E818D7D31A4E+cf7c83d4-b99c-469d-8d46-588fc95b843f@radxa.com>
Date: Wed, 26 Nov 2025 22:30:06 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
 <aSRli_Mb6qoQ9TZO@ryzen>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <aSRli_Mb6qoQ9TZO@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OW5M9fEmm+WRcjjGVrJLlbSGeJFUAd6+g+CyvaeMc0k1fUtnTZGIWXb6
	h79VhwZapCbieaXd/LIl4u+B7Q9uB24bwV17598UCCkC2g656i8i6VHs5ve8a9+CYElkuQs
	ZK9/xx7kdfM0+260sMIP2BuChgbNBPg1T8H3UGZ03IXj5qgeXrCWkYAtFK+s7B5sFHYIzY7
	e+Ms3SRiPAPpJMPwW5wrKRnyu6aT/F8NQZGjYuaOEYLJ4OMWI2nZTrZws9UTC1eb9X6WCY1
	XEk8y2BEd69LajpL8vuIoA8NhjgGoJTJcokuz8E7hYE4IDXqgpHUyZ22r6NRmoO0/4uKzHd
	xUmdVYARAcjo2kz5yyt+TEdw0jZF/xzkAM9leykW+Rbw1Pmkr8i5EXRyYC4+q5hbRmGhfla
	rK39UeCLjKq9cqPFigAkdfCt0hwv2c2sPavRz7bv6t9f/vd4U1vaKB5h+PdYMAeyiH2nbST
	0ATurvokyTcdChJX7yy9M5FaabFEzyvmlo02cEkXhLVjHzF4HWATNbgRvaFiODjdoM3nnN7
	fySn/2UsmgtrCwQO9JQFIRhyfkxgftuKckZevxpnOXG2764br7mQMdBmcyr7xMB0VpelFvK
	LOeDwg5X5gQUdSLN/3AK2HpgO/S4S7AkXtXXW6S3xungAJjiL0WeS/07KZ9MIxKzBYycuuC
	9fkr1jdmH6dpUWo41v0FrAa2BZb2j4Z6Kx+6FR1f/wwESMVO3nxnpvRpo9m2bM+DQzWL2th
	tXKSwrE2+p72sBpMgNnNrsiCdv//gInCW+ya55CU3TeP2IxIgGrVH2mcIpc6GLxzwEZZXEs
	96cW+fAr+Z7jspUxjE607DeNKhiUoQQqZawMUzjJqIxF0kQxdFRJnRqKKIH1tK43R0UWG2x
	LTyi7MqbfbiBNsbs4aGYShASV/8WaQX3BgNtYBMKv0WwFFCKIxSjhJZwkDlb6sNMuwt0nZP
	LAkJgF0d8dTl2rC5RgZHcVp686/DRMiNjTcRyLT2iP4C8yZF8zCM6PB+KC5VlsrDyk6u/IL
	PsJ3ru4L9Dp5c801zJ5Nfy0VouMpg=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Niklas,

I apologize for the delayed response.

On 11/24/25 23:02, Niklas Cassel wrote:
> On Mon, Nov 24, 2025 at 06:07:44PM +0530, Manivannan Sadhasivam wrote:
>> While I suggested to revert the link up IRQ patch for rockchip earlier, I didn't
>> expect to drop the support for Qcom. The reason is, on Qcom SoCs, we have not
>> seen a case where people connect a random PCIe switch and saw failures. Most of
>> the Qcom usecases were around the M.2 and other proprietary connectors. There is
>> only one in-house PCIe switch that is being actively used in our products, but
>> so far, none of the bootloaders have turned them ON before kernel booting. So
>> kernel relies on the newly merged pwrctrl driver to do the job. Even though it
>> also suffers from the same resource allocation issue, this series won't help in
>> any way as pwrctrl core performs rescan after the switch power ON, and by that
>> time, it will be very late anyway.
>>
>> So I'm happy to take the rockhip patches from this series as they fix the real
>> issue that people have reported. But once the pwrctrl rework series gets merged,
>> and the rockchip drivers support them, we can bring back the reverted changes.
> 
> FUKAUMI Naoki, just to confirm:
> 
> Neither my suggested approach:
> https://lore.kernel.org/linux-pci/aRHdeVCY3rRmxe80@ryzen/
> 
> nor Shawn's suggested approach:
> https://lore.kernel.org/linux-pci/dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com/
> 
> worked for you?

Yes, I re-tested the two methods mentioned above, separately, on 
v6.18-rc7, but neither of them resolved the issue in my environment 
(ROCK 5C + ASM2806).

> If so, I don't see many alternative but for Mani to apply patch 1 and
> patch 2 from this series.

I believe applying patch 1 and patch 2 should be sufficient.

----

Incidentally, (probably) while applying patch 1 and patch 2, I have 
encountered the following issue several times:

[    1.709614] pcieport 0004:41:00.0: of_irq_parse_pci: failed with rc=134
[    1.710208] pcieport 0004:41:00.0: Unable to change power state from 
D3cold to D0, device inaccessible

I am still investigating this matter, and the conditions under which it 
occurs are currently unknown.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Kind regards,
> Niklas
> 


