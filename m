Return-Path: <linux-pci+bounces-38849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA84BF4978
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 06:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD8EE4E1254
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B423E320;
	Tue, 21 Oct 2025 04:27:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB523BD01;
	Tue, 21 Oct 2025 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761020835; cv=none; b=QygL1kAHNbbJcyreYZshHqsB7SJtfAzJpj4t9TZIwVjcPoeRjXZ6lR/jOk+/iC85CzRjVpFTNjuX5YRE7R1TBYWNgvC9Y7X2gMjjqtKXfPrSr2MZ9NT8pBHkPts+hV59HBc5qoY3lg1kReyPSG7JCo1G3D2tOCcLSafBfF0KO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761020835; c=relaxed/simple;
	bh=K6zXAQZdpNuumB1G+bS9Vwoj3dBgntKcmMtAG1phyOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZonnAHFXB32iwKe40wr1uoVIhkzTNV/1S2SHN15qiUolB3lqdXlt8PYSilSrhhm4K/Tti+MIn1OMo41SP1g8Ptb2xFnsGdUAPZ/2WmL8XvKbkAYiFTHACThoI8MNIoA82qmhZ93jWkcj1SEQBgWhl6mQkGoMBzCODmLcatwhicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1761020794t6063e055
X-QQ-Originating-IP: vMCkboM9fsdjPAzo91wrsqh4saIlE7UDpjoWy4czKSc=
Received: from [IPV6:240f:10b:7440:1:21fe:b84: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 12:26:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1327726975815582351
Message-ID: <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
Date: Tue, 21 Oct 2025 13:26:26 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M+0YV038q5N1qZdC/xUgQ5d/cL55WGNcfOwvaKGBN9Ao5ICtHpEt/jLB
	5os0RbZm2ZxSIgP1xC5ZjbGpAVcj91dOm08OQBd+Ovp2J4jR+Q5ybjgxZOB2z6+AaFJrYGO
	OtChVv/ZHk1CkJnHZqXO3R/bLQqmNUEj1vmVzIHduQXiItoKJGlXAF5gOdJltcG0An5RIn0
	EPhR5W2x0BZ9dn4tCa1Sj7FnYtJ9T25KcT2N8NrjX/VytL81V2fPXI4G3xTSdDXZUZ83DUa
	w2TCwc3lmhxdWNLz1BjlV8mPvujBc2OEQ3HJK2t9PebsDC2aLWfhd4rgpX2J5l+TVfIE5vE
	80DThFzNi36Oac+/dk71MT/NGKUvNplZoLjHC4JejrA92OrwIslA3AAi9KPLHev6r8+Bf9+
	UOtwboMG9wfJoK9yWzr7Y7oNmFT2UdNbC/p9f/F7IH2MaJirPX+IVdC+0MetH7yux/f4sUp
	9dkQBgAqBcI6+Ry+jJmqUyg8XUt1IS1YgvFk6SP/bre77WcN0swnBtLeO9RXH6Bffkn+tgT
	xWmMBEoO7EcaL5yHnNCUi533PJLmhMO2mZunEPazN0eBrcwz0uVrcGxcoMspy2Yxz7w71i3
	4H0Ic1zHh57df5UzKJuTw8+N+QveO5+FdlER6KMGQsdsXltjoKkUF8anr5k+P55OgLAIKQ6
	h0Gv2uDmnlvkEskMeNXj8acWxIjy8y6q8x+R5W4B6bMZMWzcQNkB0FpcMzzC77PAlKYdOWq
	xD/Cp6Ivh1zdacbTIin8wPChY/RrlRxaFQ4k36uagVX91Wy3kWt3TcoprJ/60TxagVV9XQF
	Ia6+5QW8BYH/cmPFLc78EbFrIHv0Bf4zvr+f4KmKOKeNXRjg6g7i74E89RK2rHqzbNhuSvf
	00XAwMYqX5QMcf6NCEp9o3TlMUr5AbVKIt6Ik5tPtYshoUsXZVP/resSdxprS+6yF1eC26t
	vCEdJeoHvIzllCIw6oDDfW437lgkL1YXS2+kWimxsUk7PhgJd5Jn7wxZUEBg7Wb8Luq+CR1
	bL86+ucYpE4saY/08c
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3

Hi Niklas, Bjorn,

I noticed an issue on the Rockchip RK3588S SoC using the ASMedia ASM2806 
PCIe bridge where devices behind the bridge fail to probe since v6.14.
Specifically, this started happening after commit 
647d69605c70368d54fc012fce8a43e8e5955b04.
dmesg logs from before and after this commit are available at:
  https://gist.github.com/RadxaNaoki/fca2bfca2ee80fefee7b00c7967d2e3d

I have confirmed that reverting the following commits fixes the issue:
  commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we 
can detect Link Up")
  commit 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on 
dll_link_up IRQ")

On v6.18-rc2, the cold boot behavior has changed somewhat, and I have 
observed the following three behaviors so far:

- Probe succeeds
- Probe fails
- Kernel oops

There seems to be no pattern to these three behaviors. During a warm 
boot, a successful probe does not seem to occur.

If commit ec9fd499b9c6 is reverted on v6.18-rc2, I have observed the 
following two behaviors so far:

- Probe succeeds
- Kernel oops

"Probe fails" has not been observed so far.

The dmesg for the kernel oops is available at:
  https://gist.github.com/RadxaNaoki/4b2dcd5e41b09004eda2fdeb80ae5e15

Can you please help me with this issue?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 1/13/25 19:59, Niklas Cassel wrote:
> The Root Complex specific device tree binding for pcie-dw-rockchip has the
> 'sys' interrupt marked as required.
> 
> The driver requests the 'sys' IRQ unconditionally, and errors out if not
> provided.
> 
> Thus, we can unconditionally set use_linkup_irq before calling
> dw_pcie_host_init().
> 
> This will skip the wait for link up (since the bus will be enumerated once
> the link up IRQ is triggered), which reduces the bootup time.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> 
> ---
> base-commit: 2adda4102931b152f35d054055497631ed97fe73
> change-id: 20250113-rockchip-no-wait-403ffbc42313
> 
> Best regards,
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1170e1107508bd793b610949b0afe98516c177a4..62034affb95fbb965aad3cebc613a83e31c90aee 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -435,6 +435,7 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
>   
>   	pp = &rockchip->pci.pp;
>   	pp->ops = &rockchip_pcie_host_ops;
> +	pp->use_linkup_irq = true;
>   
>   	return dw_pcie_host_init(pp);
>   }


