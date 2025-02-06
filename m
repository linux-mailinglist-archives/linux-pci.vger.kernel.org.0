Return-Path: <linux-pci+bounces-20840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F3A2B4F2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 23:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A9B167441
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 22:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04A1A9B3D;
	Thu,  6 Feb 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="R6Igtnxw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06E23C390;
	Thu,  6 Feb 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880395; cv=none; b=ftyzOBFPIBbEYUtAnR1MujlUYMGbf9zCTNmLBdfaSHImDZzAhubNFYUQ5yJ9ghXdl34l6Lex1azJgoE8j7/5E9H1/Zs6Q+NyZpt7IvDO/7oNfdXQ5TEOr5rHOZyH4pZjrZv0bxnN9FH/LfDtxBUEeTYas95VH2VsIioIVntaw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880395; c=relaxed/simple;
	bh=iplvGjxVtSNZieYITESjTh9ezPgWjVbjCyW+2fiP9dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4ucaT9tNSXf+NqfI1CQG8Lf7KP73lnL0VpQyUegigjE7olva18LC5ylFSuWIKRo1Qn2VrDaxevXOzczqw5ZepbHWeMQabLPHKrlRd9K+exvDAWiWyvp5BaBTCoFwDTjQC5xA7GncWOtZzAd8epE6DJ6sa3Suv6eAH/ce3QzCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=R6Igtnxw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738880391; x=1739485191; i=wahrenst@gmx.net;
	bh=dxtZrCctgBhiPn6B+3RMzEgrZOTooCI6T92FZv6MTPk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R6IgtnxwhC/48wpm38U/C1njOpeUq9DonRCJ50qndlZyB6SDDvTKwqxmnNUoPl0T
	 Cahkwq0zAmhBLnpt23ROyFo7mmyg6fu4dyzTQI4+eSixGgSi4AeRNpmDYRMyyayZj
	 mmoddlOhmEKwqt5WuaN5frPUPzNXuEYMaahU5DI6iug4pwugWtgNNcSlbuQSbUhSU
	 bPvPtYAfzNJToDiu3SRtW4U9jwBTFcJha4ZLQX51yJnE9ha+MWKS9oOjKxKh4Hgvt
	 ABvsJgexP2XiO+luOscnTl+kRrijcTG5957Y/bvtSNQlCpTA2ZlWF9zYHpZFcQ1pk
	 IC8SfJhTBloKDFR7qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1t8Cux0kmq-00kgXn; Thu, 06
 Feb 2025 23:19:51 +0100
Message-ID: <67b38b32-ce4e-4d8d-a55f-d56d5389b488@gmx.net>
Date: Thu, 6 Feb 2025 23:19:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] PCI: brcmstb: Cast an int variable to an
 irq_hw_number_t
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250205191213.29202-1-james.quinlan@broadcom.com>
 <20250205191213.29202-7-james.quinlan@broadcom.com>
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
In-Reply-To: <20250205191213.29202-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sTGnfuSTXZK7MNvCp5CKmJzOpF5On8p7IkfI//o0gj6Vs+nZ3zo
 HIgCyeUZCL+1EetfpRQ79B69GgcxGbIHPTicg/Pn0Sqj62W/9RMLRBH1Z8K1h9eOfay9Iyp
 aDTp97Q+1glUN5bYInLOb2GTCwl1TFa8G3Rfy/3stJszHIeb8xR/iTj3MqC7hrzP9Yl2Ek6
 3sGEeafqsDL0/i+myDJdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7t9Vbysqt/o=;fZrYQ9MrCW2wQMR1vnqMNUEr3j7
 YNy0Sy0mrI8o56qCWcPXMbwFeKvZSYDLQIc0Ijjhgm03dUSzahEEI5f5HJDL+lLnbJH2mHfsu
 /3aSr79J7grLGa3G2M+UjL2cM2GJi3NHbLIlCl8WD/mHq46Imv2v59bRf+pYfKGvX/ZuvOiYU
 DnpmpV7kbDT6/fhZ8JXVgC1OTplZDPTbyAMxG3hN+A+5NKx0WKjbPoSA0sK0STWM7FQQcD8ax
 GSUE32/VvkPo4Q5TL+5IAfE4GpCO6q0qCl9b5MTtUrN1Gi54ZVrqd8bpNnHPJmaqCXeVnyou3
 8OOgngG3NtWM7mIq6HwTu6tlL675ZJZkBpb0N9ysRQoxScqa82aWYgW1uGHP7iw1tr9OTlklW
 Af8JdgneDmNsftOWp0XDewJbxL6k+YIcrIcueNzIBB6Lp2+RcsbIG1RLEJOyJSlFxLwb32uJn
 0jlg22vKVVvftzg9MnniqUVC1PFueFP15WpJbZXZ1oibjbxXxofS9B0qc76OazPveloHMcz1v
 juErKA0P7mjiZHs2rOfXF/63Y7/UgHN4EPeK7Lf/SLhBLd9CAp5zsjtLjg2WUspzU8Wmhq8FQ
 4xQlK9pPBjF4OzQzeP9S/8Wm8rSKdFT21BIOD9PDdCz/Lu2JH9/ZSkTFXVQIKlRmwZH6RWf9D
 hWGqFCSyi9R+GLlpH0VeiIQgX7RFbxBZ/4H+9a2HJb7Z4uwDZlIx2vcNXknXiUfi3vwd7iOCa
 9Ux2ZzhNHYrfR8sd0Pfaac1Z4QnVrPn96ootZ6uCoEW2a+qLIlKjnXSdr6CKE9T89NCw/ltJM
 f1SP3PvPyUDOqQfA37h77OS5cbURdmHKlf7V6qHI6EQXXwRVdJx8MlbA35ZKxlGTie5BcMb+7
 ljtTmjbMjfWPnr5kvGf1WC5Vm36wRbcapLgR7Zw78ZJuleZJFcwSn3Youn/pZfxIhZEu1rTBr
 kdFZeHuBxobBDCLVX+YDNhdybXvWsMolE1kiGuaQyahnNZZlUiZr+K936rLe0Fe9aQ7YU7nsw
 zcXgl7CIMy9JFlLP8vt/htmDplcHa3T4otinI33g+OhHD9WGAvgofic0ppXuZnfloA/3FXtCL
 vbFuMGcs6t56hhNbXeQO3WKBMo6vQUYLK8YwvIlAJe+JBlEJNdpVoLvQfOjRqy5PwnlPqGHNh
 QAYf3sOGhrKgEKmbE2Fm8SJOfRWOnHe00WNkYmWfQBgW+6L4hOfLRusGvrSAjrWmvxdwC8ij4
 /Z6fcj7NHesEs7wTPqxsNSd+KnzBLsicXb3JgMzhq0jcMlko52WGkRAA7du/tljgWcHV17A4N
 MWYZ+vZaPs2nqjGy5EUqS9QM/7cDA7pRhMQcL5mZw2wj4v2SW67P8nn6IDVHzxR70H9v7YjtB
 /IPW04WzyIOb1frR17z8o28MBkjrXl84b3NqhSOcFy8bChaAduQTKy+Wtf

Hi Jim,

Am 05.02.25 um 20:12 schrieb Jim Quinlan:
> Just make it clear to the reader that there is a conversion happening,
> in this case from an int type to an irq_hw_number_t, an unsigned long in=
t.
I'm not a fan of this generic subject. A possible suggestion might be:

PCI: brcmstb: Clarify conversion by irq_domain_set_info

Regards
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/control=
ler/pcie-brcmstb.c
> index da7b10036948..1e24e7fc895c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -560,7 +560,7 @@ static int brcm_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq,
>   		return hwirq;
>
>   	for (i =3D 0; i < nr_irqs; i++)
> -		irq_domain_set_info(domain, virq + i, hwirq + i,
> +		irq_domain_set_info(domain, virq + i, (irq_hw_number_t)hwirq + i,
>   				    &brcm_msi_bottom_irq_chip, domain->host_data,
>   				    handle_edge_irq, NULL, NULL);
>   	return 0;


