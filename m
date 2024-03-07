Return-Path: <linux-pci+bounces-4612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB3B875680
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1101C21498
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 18:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7812E1FA;
	Thu,  7 Mar 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="M978ppBy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBB135A55
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837980; cv=none; b=CjJD01MMYD9fTAmLpmFEodlnezAGqaqKhfOjQpydKQ9tI3V3pf1eoyCiwHP2jctCPglL8are7mXkEkM0GhyhrSSvvfPzRO/ataBYR3aXlOLTCe2Shth/vI6B4pqjo5x9d1Jr72z9BgGaokXoe/OyYP6eF8et8/B5lc3Pm9Yde4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837980; c=relaxed/simple;
	bh=OAqbfAOI9WagWLZLs3Us0eeJhbxoEn2TOe3To4x0/B0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gs1/T9YswOG5Aju6/0AYrOlrJ+D9JIAmvF6VVbIUXp05aZ16C7VzFg5GI/+5PpQYlsTdLSpQkSH7HQPFqNpjEHu8cCOSBDyXkgyewRX4D3Ed2RuCmOpnQKeu4UoMjKPrHHOt/3YFzYaiARH0RZNiiayDEblvWTCGB1ImHEjj+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=M978ppBy; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1709837960; x=1710442760; i=wahrenst@gmx.net;
	bh=OAqbfAOI9WagWLZLs3Us0eeJhbxoEn2TOe3To4x0/B0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=M978ppBygDoVTgsW6gTyD6hN/WzCXVKNN4Fbp/0kChiwo2crZWIc7u1eCLJMVV1h
	 MgqqpijOCRukTavJ31XWVctJQ30AyS0e0naLO0hwEtp5HnNV53bue0aNmAkRDX2TF
	 hItUL9qh5/FbLE0zbhEM0frSEXD3jjsmOvTh3CS8wToxlJE7kRrEIAT/3uDO1g4RC
	 QvGPUWeStc71yLxn3fWmSsiRv7cmmpeVpexGTpvS53WIz83RrnzZkde1fauYnSgqq
	 eS+0yDnsSHQzENwso3U6+WX8Js81fDLy2qtReJLQIgzfrfxDz+t+Wf2856A30GsO8
	 RI1SfRU1BdB3+Q18cQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1rFWe43qFH-00TXts; Thu, 07
 Mar 2024 19:59:20 +0100
Message-ID: <e9991fc7-4626-4797-9694-12d45ef1c2b3@gmx.net>
Date: Thu, 7 Mar 2024 19:59:18 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: fix broken brcm_pcie_mdio_write() polling
From: Stefan Wahren <wahrenst@gmx.net>
To: Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Cyril Brulebois <kibi@debian.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jonathan Bell <jonathan@raspberrypi.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20240217133722.14391-1-wahrenst@gmx.net>
 <ba9fa05c-0a3d-4d68-bdb1-d9e6e2c59c78@broadcom.com>
 <0553c39b-4f64-4761-9e56-a991333f7fb3@gmx.net>
Content-Language: en-US
In-Reply-To: <0553c39b-4f64-4761-9e56-a991333f7fb3@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RN3R/bgqZCI1yt7nxmq+Dp7HxBPoMiED3XPpMiFdM4qmvYq9WOd
 gmMpe3gmJdpS/irYN7aQlLxW3H9as4n7+gb5ZJ2LdkFzlpTn+VIDTizlLInIpX2TAdsdMAZ
 ZqjPAvXxkN7cMXKZjR/+XX26nBShvSPUTKcCc6p8giwfWhtjTJeecQ+ZwJDBN1BpJqNJhN9
 iXH2f2c14fwQgfA7PZRzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nG3L5XlVJm4=;Yxl5wndSecnrBQyBD+2/AzrQ+jI
 4LMmuW0jlDL9wQu3TGos61xTTyM/wAlvMh793fw1Pza7zoPvOtLIuWClSqGxYtwF1M97gGQzf
 wKcMGN9pwPEMW4Ip5z0X15zQ6k0qFkmKbejyA+CwdUE9rZF2hRJZRIf8s1i3iHzrCCZA9E2WA
 fXhGyBX0SLxIKXYSf5FWQhoSI/TElyLu75OhcyeseO/zkCWXUWjkZpOJs4jy0A6vsO/sK8dUQ
 D2vpdTBKx8BQNM1oiVkokJid4gCB/7KSqwpKM63W4CFHxFleqp0RfHDFCKJIVa2FGt696XOvk
 kfydgnI+DT3mOCL/C00RrLaNNynefUrkTFoeDnj3RjNYHeH3ORYwKPny+ZGeGsvnFz3L6TNYQ
 WCpeMaTR0rJS9AShC6OHf6lLKv0hX8Ay2ictcdHaXAHd9u2RfUb6bckglhM9UDS5vz4v5xZa+
 9v6Y+3zYxtJHHiKWA/Qc2OmoJAdOA2SrKYvHCu+BrWl9nzvwnsGq0fLixl2WyArF+XFbHAjVZ
 epRcetXk4nKb8Y3h+sAi3Rgk+m01RttMPWT3PPxXFkyPg62NRpCdjYOVgjTN9htqS0SdO8vpa
 8LPTNwnlqEyN9Yo8FCliAg6Myx5xVE/kIxLuWN0ckhdGEhU2UNKBhmP9y9hEApEOJWkO0D+K3
 fFXwONRMZEu16aD9yE6x6xusZz+fbCnDHGuRZK2VoEXzBC6PoDSunek5jX/RyUwIeSyUAflpY
 bNaF3ku969IxQFsP212H+CiNJVJvxuZsnuhivYFJRodrln7jlnXuvLD36KIDXar88Oy61sI/T
 b4Mv8S4Fo3wTeKlgqZiZP2/YHk2hwAwNaCKEqtM8qQcn4=

Am 02.03.24 um 10:45 schrieb Stefan Wahren:
> Hi,
>
> Am 17.02.24 um 18:27 schrieb Florian Fainelli:
>>
>>
>> On 2/17/2024 5:37 AM, Stefan Wahren wrote:
>>> From: Jonathan Bell <jonathan@raspberrypi.com>
>>>
>>> MDIO_WR_DONE() tests bit 31, which is always 0 (==done) as
>>> readw_poll_timeout_atomic does a 16-bit read. Replace with the readl
>>> variant.
>>>
>>> Fixes: ca5dcc76314d ("PCI: brcmstb: Replace status loops with
>>> read_poll_timeout_atomic()")
>>> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>
>> Excellent catch! Not sure what the real world impact was.
>>
>> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> is there anything what prevents this patch from being applied?
ping


