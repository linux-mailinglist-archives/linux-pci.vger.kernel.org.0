Return-Path: <linux-pci+bounces-21018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D30A2D640
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 14:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A459188CE87
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D435F1E04BB;
	Sat,  8 Feb 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="M7AwhCE3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B21D8A0D
	for <linux-pci@vger.kernel.org>; Sat,  8 Feb 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020938; cv=none; b=smmvKBLV0SF8Fd7fx4D3cF9i6fbGGAnMZ721ZUROZVZvmaVQRIzPlpOf8H+Bg+p7VsoyvyvgbYuz9ISWAmL/ef/cZchW1NpBf3uT/q0cziqMmA8FAC3EKRLFw3w0+h4WykgDscev+Xqp6KBIZtsQ0X+DCZE0JSYobSCmoq1XJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020938; c=relaxed/simple;
	bh=uOD95K3sscgsIYCQX6yo4FXvRz6B0gyyuMdCGjLmlW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyb2Je3WnEODsrTOyu5mpcMtnWicb2mG/vfZxXlapS/eIrj94nPk9cTXsrRrjJs8TQ8uo4JEPh+34WU8oMI8a3aOfDDqNqZ1Ev3fnUco7Suezgyi4yflYWcnc8JNDVjONwXczysFTHK6sY21haBVNoSwIyyzKTC4p9L9g4FnjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=M7AwhCE3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739020926; x=1739625726; i=wahrenst@gmx.net;
	bh=dWN/WMPQcbVfSDc9fPPJzIhIiZWYJckBwsKgU2OM4rk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M7AwhCE33XGfAydDLp1Ad+zVEOlBypotrSfXepweD9SGs5UxcKJHFDc4ZpURSHHr
	 lpPc2+sLr7HSHNUiOAMazmVXBJ4SlUR/Fy6fSMLe6UsQM2PFYTp8KJb3tH7CjYN74
	 EKXicmXsw+QKjKaV98bBzTy+KShedSSouAVgj3zVCJWxMksL+jY8reXUXf2eOUMbg
	 iU9P1xURrl1ge1lEUgSjEqkzw0u7hm2esblDU1+KdLzPuWNVRvRXQ/7Sbwl8e2/h0
	 eovFiTHmuPlaOwWNgPIhpK1FffDrUIiAet9lJQ7XV1BBa9t2pzCMzVbzdQKNN4EDP
	 SkkDfWe0RLAWuU6w+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1t5EE03hH7-00hAbQ; Sat, 08
 Feb 2025 14:22:06 +0100
Message-ID: <32e74c11-d6cb-4c42-b9e0-a52bab608c16@gmx.net>
Date: Sat, 8 Feb 2025 14:22:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Adjust message if L23 cannot be entered
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Jonathan Bell <jonathan@raspberrypi.com>
References: <20250201121420.32316-1-wahrenst@gmx.net>
 <20250208102748.2aytlzgzbvm6u4vi@thinkpad>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250208102748.2aytlzgzbvm6u4vi@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Th+KIiOCiIiw1MY1//6zdwJu9I+IeP3cHWtK/iTHEMJah+6DHB1
 yAQhJRdfN2IAUvWdKHrRsTI+B+YkyoJ/IOt3M7EHSnqE++BpHuqk6/U19rmdqVw3y25V1iK
 fq3I4OOKvMhp3JmTLFpI/5kcGx4ON6OxxAqDPOIjzyKqV83PJO+dWUPcRYMeG2Wd7KAHc9m
 XpGvncZ01v1JFwWtl+huw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UYMJ1v9vVw0=;m+GDyp6P17KHI1DxBeCSYS9Vmwr
 PrbMWxRloDnN/1xnz3dv+hf1W9vsKIp4iPF1rsMMUqVYpiYkrqJKNkaWAAkessjZTSCGt4e9+
 OUnm3fC7B3CXa+eU3RCreFAGJtNMLMKbc+y1d7x0jNYx1l9YZS8W2mjJkwdzFEERX7KOOE5eL
 RbEuWMsYYUrav/uNT72oYca61gUCRcV9+ZGrXRnwr7wZwLTTh/7SIPdX1yqomlGKyfaPD2MJg
 HuSCWmUVAcCmnxwvrO0IR/kZDyHvIHVG1vsJfQXJX890SAgDWsgnwCf8590rq+ql5hH6f10SH
 CCe8UIgE1+gmT2IOGDLaq32YA4jBGmdIIYma9aBOgo9N3jP93epSaTaycH4xcMMoOXKzlz9yh
 j/skxwLN1GrB5xMKtB2EjrSmazm+w2eS1s31d9xyV63pCbHG6Uxc1ZhEiCj5K+a/9nQETFHTQ
 7fHYFOEePSLJsCDs/n6jV2rGewYnbGYtOkTGSEfdd4O1pNah38/1FISGAYbx1R+gSk8Mwu5q+
 eQeCOqf54v8iPbHlC4Z21UtfD57xi+y6CRiP/jLD30cFBK14nazPEOyHe4Kz35/SUnjRPfIrA
 fCZkn+nKiCsLuXPqDrRjuPP3R5065xn53BvBqD2+Qpv0iYT0LVVanRUGshHr61+TFYWWAcSxq
 jx3vLSsW0tmFzg6k6O4MLxzVpfeTS4vojl9AmQ4WEaqKdvu6tcLcHGK3i5ZTpbzbsSFu1xGej
 xwj8z1BmbSUBHZ0VgQQSluWQgSoX7sJrgnIACJKfGsC4rtWNy2fZWppc9usv6lnwWUvcvxc/q
 V3kr8DfeOGtV8Kf4cP+8iw6/ijstn9og5GYrY0wAL/u7yKOhelCopxxFkdNgux1QksY5TIZyC
 yCSYuUfyudA9/p+HQHNX7/SC1YbWUMluK2oFomxYdv4tvkqc8AkEyQ8BM1pnh0Y2G22XY93KK
 FKiqxARwEC4GlbJa8b84RUvrruAAIh4ksiKYEo04yUUsqS3B4gaUDB1nVVgvwesozVpkv8v/W
 n8hiWakXgSP76LOEcPQjNQzkDMGabiMocfO/czhU7JK8YlS/sATxs2iFqF0J+DftDGzRAKyUY
 +7oG2t5WLMRIkSpfMwXvz+rUpTmvVujMX+e84HCXI1X4nllbEQsDIgwOYacSOCa5XUVLgq/7q
 sBvcPh/H2KylZ5cFqCsRPoz/kek8hdF04uAV3GlrJpPgaxkJRTOJ5qnLy8l3RVc2iC3vS0Fqr
 +3U1EZcp3xLhV8mNIzm4QSMFJ2M3z8QtRg6vxCdYUKz+09Px/y1ub6W75w6AVzOFWmvOQRFte
 Q8MX5abcLrr4bB55NASBxHz6sHCGcKczu+UiFmNUcAlz4s0X4cJtXK4xtmXcjAYtgY9c6EYoY
 qw5/rGFruFz5d/XcsB9bdux7/X6v8OTUvVN7bUx7ckQeO1eOY4NdSuD4Fv

Hi Mani,

Am 08.02.25 um 11:27 schrieb Manivannan Sadhasivam:
> On Sat, Feb 01, 2025 at 01:14:20PM +0100, Stefan Wahren wrote:
>> The entering of L23 lower-power state is optional, because the
>> connected endpoint might doesn't support it. So pcie-brcmstb shouldn't
>> print an error if it fails.
>>
> Which part of the PCIe spec states that the L23 Ready state is optional?
tbh i don't have access to the PCIe spec, so my statement based on this
comment [1].

Thanks

[1] -
https://lore.kernel.org/all/CADQZjwcjLMTLZB1tzp+PYKK9rm=3DKe7a-KoGKMKb9zoW=
odcRK-A@mail.gmail.com/
>
> - Mani
>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/pci/controller/pcie-brcmstb.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
>> index e733a27dc8df..9e7c5349c6c2 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -1399,7 +1399,10 @@ static void brcm_pcie_remove_bus(struct pci_bus =
*bus)
>>   	pcie->sr =3D NULL;
>>   }
>>
>> -/* L23 is a low-power PCIe link state */
>> +/*
>> + * Try to enter L23 ( low-power PCIe link state )
>> + * This might fail if connected endpoint doesn't support it.
>> + */
>>   static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
>>   {
>>   	void __iomem *base =3D pcie->base;
>> @@ -1422,7 +1425,7 @@ static void brcm_pcie_enter_l23(struct brcm_pcie =
*pcie)
>>   	}
>>
>>   	if (!l23)
>> -		dev_err(pcie->dev, "failed to enter low-power link state\n");
>> +		dev_dbg(pcie->dev, "Unable to enter low-power link state\n");
>>   }
>>
>>   static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
>> --
>> 2.34.1
>>
>>


