Return-Path: <linux-pci+bounces-4371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A286EFE4
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD8E284732
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42E6125B2;
	Sat,  2 Mar 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ta9ctijo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A118B661
	for <linux-pci@vger.kernel.org>; Sat,  2 Mar 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709372752; cv=none; b=Pn/PRbknhVGH36Wt1crmybL+9v0YgZRQMjkykZM1mc12y8lMIl7n6nAdVJCxyEfM2rfzbFi6lo0kfjFyug8PKOoK/V6RYm6CoB4hoXGLLPhajqNcGPRHPY1pQQOVRk3Uaiin02gvMJZ4Ov/lSs3Yb+9fBEj9038li/9UbDO1p/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709372752; c=relaxed/simple;
	bh=jlSEwxjnbBmPD2uPin4R7CHQCbkpchaamNZ1uWo55qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvsAcrIz7dSvFq5fqGac19oHTyDTv5bQ8u4ucxAbI4C/A1yhFw0Ze6sj1qS51XjIzZvpUOUsoyMNdBKXMBSyPpTZKOivWw5MCPRNyLKaJnQuFkrF9jxKZrevV3PezMaJFxk5uzH59obHkCyAqQQeAAjjSwjRvQ1WCSInh9ydQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ta9ctijo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1709372721; x=1709977521; i=wahrenst@gmx.net;
	bh=jlSEwxjnbBmPD2uPin4R7CHQCbkpchaamNZ1uWo55qM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ta9ctijoNGkXvRC7t5W1pIccIlnq6MOgisUBWopyVeuP9+Jb1oGepzmDF1glVkFt
	 JirmzcKXktt3ZHAIjdozEYBXf12gppxJKXfhfcJHOvmkNONv/+HKa1DOUT75fICTQ
	 kyTtk8cwQ5vNmLyNdglohXlBxBzBdpIkR+RwWKVZQ9ge4Llr7I9KF+jPxHKe/WYYk
	 zqHNvwYRvxgqNIa4OOlGOZkEEbLWqpyaoHVJiBuCnnBqksxyxLVTfsmTzEbN1TtrK
	 u/o8ZJioKmwbgw7d6Xp8drTkdq2qqee91h1oVRUNIWvksIrRbPZxepGxDoY4Lkww5
	 STf+Brb9JWCIwE2uUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1r4V8F3QpH-00pfV4; Sat, 02
 Mar 2024 10:45:20 +0100
Message-ID: <0553c39b-4f64-4761-9e56-a991333f7fb3@gmx.net>
Date: Sat, 2 Mar 2024 10:45:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: fix broken brcm_pcie_mdio_write() polling
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Cyril Brulebois <kibi@debian.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jonathan Bell <jonathan@raspberrypi.com>
References: <20240217133722.14391-1-wahrenst@gmx.net>
 <ba9fa05c-0a3d-4d68-bdb1-d9e6e2c59c78@broadcom.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ba9fa05c-0a3d-4d68-bdb1-d9e6e2c59c78@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6cfeNmMt0s2qU3FciHnuJtjFll/SA4fSLQ3/SWxPoIwL8/AE1jw
 QDMbAnauLUYT/r3PVZPx9VtYnPNDzzsFdpxAwAkJil4DbM9AZSgzazOw6S2MoTqITBKnEgd
 MzgGqicl8V3rQxPz/cYccuOyBwJ+drcqJErE0JkWPb+EDlMef8bsdyG+hwGYvR7s+8w5WUe
 94QzOItM58uDo73fusNBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z5WawOtq8wI=;1Zlll7xou/fxm0abmDPbUD0FTMT
 nbUJR7LIXA0Or2VjsdLW6Zp+fT5IWUZP0tJs86DVf6De7JMgpiFVI9BGaWtj0JR8KKYnPq5Tk
 +HoOwdx+mmU4VfPnx9NmxL2syNLVx8X/E5qE01DpshrAKHGzZCujfF3M6AH2PuMuU1s82RKGY
 ZplEOr31L39pgsae6v5HlmmLWgahktDqwA9qruNEkf+P4L57+rv2eE9x1VW3Ti5w0ffQwFjc+
 fb4FYTXeQXdARKjutvYkbytEHw2ASu8DmEffeHujK9DEap0sFzNpRradLkvWyAVybiInoYHXl
 Y2vYloP9edR7HqR1fznyr3M1mh2a1/kyF7nA07naV9PQToroqxcuJh5PUqMs9B6VWSFwl1c0p
 3PA9NqF9qYB89bybLIJXQht6m4dDxt0TwoJyh/l7OVvI3VNEbk8GMI2sgNxR/yCbwV3w4eVmv
 zpdHy2OgXNC/NTqP1U4kG09eDYp6eBIe83p+HtH3jS7wL3U+BgchHsu3YtMykpRKh9L/z+Eb1
 /GiDqYkNKuDIzFYX5vAn0XlcYPBcvLh+KW1JHp9RZELF9WxnUfHNyG0IeCt8kJsaoTNQGeTg+
 ZWZs43FjBfBfE4h7vmPG/dYhu5XUaxyidjL17Fnh1nUzmIHIAhcfD2+IMwVm0fNZ/Zi7DQQ/p
 Sk5yRRnep9MxHecCrE0Ou90ldWkuMX7r3AXGAdX3226cB92oXeaw+i9DzhJu5czl/H3iG1Oib
 01LnNK2iuBr4XwZeY1g81bWsFeGVwfGPWH1aQdIwzgpCjvTJt+i9NHh2B3QaMYuw8gLBkje6g
 i9ev6GaQiL3eeMQCpYOojcEKBUBHRv6kbwXbKgK1Bdzjo=

Hi,

Am 17.02.24 um 18:27 schrieb Florian Fainelli:
>
>
> On 2/17/2024 5:37 AM, Stefan Wahren wrote:
>> From: Jonathan Bell <jonathan@raspberrypi.com>
>>
>> MDIO_WR_DONE() tests bit 31, which is always 0 (=3D=3Ddone) as
>> readw_poll_timeout_atomic does a 16-bit read. Replace with the readl
>> variant.
>>
>> Fixes: ca5dcc76314d ("PCI: brcmstb: Replace status loops with
>> read_poll_timeout_atomic()")
>> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>
> Excellent catch! Not sure what the real world impact was.
>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
is there anything what prevents this patch from being applied?

