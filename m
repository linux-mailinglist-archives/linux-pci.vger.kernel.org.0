Return-Path: <linux-pci+bounces-39079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BADBFF4EE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C55023446D7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 06:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A6D27E;
	Thu, 23 Oct 2025 06:12:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC927AC4D;
	Thu, 23 Oct 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199977; cv=none; b=R3+T8q0IeU5Nr9JgiDIHyqhZlBvAPR2ehdPGWMteYBHFuC1RYWvCbDRVNPYUt+YK4Sa2UBzspLizFxrY3PsBF1869W7ln+esGV51yVGNFFrQRPp3PS0v6mC6D1FjV3po/3zH6UOfuxPU/Ob1CjEz2a5RRU0ju50LqfkAR9QcT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199977; c=relaxed/simple;
	bh=GvqU9uGGx+KJM1yhuHMieGDlGEi9DwW5CHDBghxQKy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3aqVvicK0tZcOJEY53QRUZuaNhYLKjAla9xzatC327FWO7xNZCNnSoQBvHE9AYclH7VoL1PuBGjyrvAHhg3S2rFECqS/nOi5kxdVbFbKCYwqriWps3kr4lPP1XSyVw20fV8+l8glwikGtXOV8+UWnhF0DGQcIoSOzEaZEmODno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1761199936tb3585278
X-QQ-Originating-IP: SKDmvKPX8O6anW4D6mauzpeuJa6t2OsditiZvwm93CA=
Received: from [IPV6:240f:10b:7440:1:e4c5:315f ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 14:12:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3584863861311309371
Message-ID: <4B275FBD7B747BE6+a3e5b367-9710-4b67-9d66-3ea34fc30866@radxa.com>
Date: Thu, 23 Oct 2025 15:12:11 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20251020221217.1164153-1-helgaas@kernel.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20251020221217.1164153-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N3gATt1+RV61wWrmTsis+KI3BuzDlPCoZbfQnE2543/08BoenZcpNGXS
	IAB6Oe1BddqoAcfNvMWjllDWK9O6n0BavNzB3cGKh9bKxCfKY84dyu8+UnIvnl6gabzZSZ9
	030czqHPzo/wG1AyS7oEoLM9fFOQ5XElHLiSY9NGyQHXh6Uxgtt2JZQ2v50qWhvaoH+CwVv
	Xcio8X6JggPKKX/P/Nd8qn7RSxD1p5jGO1bwb42iBJXmhzt6dbBJJoCs2KZww/pXXvTl7UK
	DMrBLiFie+/GhoEwbJCJ+DTGkqx1AhKeGvelRuULYg/WP00i2HKJlIFFcsX+MVuMb0kiunI
	OfpkBVwaJFbknO756nBqzmZ1H39vxj0wovsXE7T/KO6B0PGSOhuXv87HsrPDXEamJTjuXge
	014yUd9iYnSnv5pOerQwIJYowY18pixZMIYD3wMCwRcdsWggJBUOjZrU/wMJaEbNuTuY9rk
	9nJXxIW7Unf7ZVrh6BVb2FgBlXcWvnk46L+UVO7y3zsWCjkfa2tvYIzUFNKApyJIixleOA8
	gVk9PI+mdu6Vo9GOUb66SKWM2I9pgFfBGOyuqeLtvDEYlUzk6FTUxOQab8pa+ymDOKpaTjj
	grg7rC4A8+8LIf03h+6C+Zonk1W4ss1BurBaL+esGFtEsqP1WTm9AGmHXHKR7sshWNaL6aa
	nCk9ejxbIYtIxmpOZJDAYEPkSCI3WzT38tK3ugC5m1zcou06c8GalZ7E0VTqOZOYqAOExyG
	daUB8nyNFcFj6YCXJpmoCzO0gCzPWvsgnMQGWOEZMjkH1BfELA678jUS367hFCHPLYTxV//
	naYcIsDceeyP/MxcWgHj6OUlWnsBbbmeMfF7l/CGsTseYZfYceCCNbOCIIveIff2TnjmC3r
	MHtz1XtTlaLAB4YvGYhWkAFha9VCBz/8hxJj1wiH7pR42FkdkA/srNouE0RHce3hOk8ew6V
	SMXSoj5hXBOBqEmwLWgDqJuapVYe6X+Pqm8E2/Fa66gpJU0zCJ5IYDlsdOBmynxrhlNQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi Bjorn,

On 10/21/25 07:12, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> platforms") enabled Clock Power Management and L1 Substates, but that
> caused regressions because these features depend on CLKREQ#, and not all
> devices and form factors support it.
> 
> Enable only ASPM L0s and L1, and only when both ends of the link advertise
> support for them.
> 
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> Link: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/

I've confirmed that this patch resolves the PCIe (M.2) Wi-Fi freezes or 
probe failures, as well as the NVMe SSD I/O errors occurring since 
v6.18-rc1.

Specifically, I verified this with the following configuration:

  ROCK 5A & M.2 RTL8852BE
  ROCK 5B & M.2 MT7921E, NVMe SSD
  ROCK 5T & on-board AX210, NVMe SSD x2
  ROCK 5 ITX+ & M.2 MT7922E, NVMe SSD x2

Therefore,

  Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
> 
> Mani, not sure what you think we should do here.  Here's a stab at it as a
> strawman and in case anybody can test it.
> 
> Not sure about the message log message.  Maybe OK for testing, but might be
> overly verbose ultimately.
> 
> ---
>   drivers/pci/pcie/aspm.c | 34 +++++++++-------------------------
>   1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7cc8281e7011..dbc74cc85bcb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -243,8 +243,7 @@ struct pcie_link_state {
>   	/* Clock PM state */
>   	u32 clkpm_capable:1;		/* Clock PM capable? */
>   	u32 clkpm_enabled:1;		/* Current Clock PM state */
> -	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
> -					   override */
> +	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>   	u32 clkpm_disable:1;		/* Clock PM disabled */
>   };
>   
> @@ -376,18 +375,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>   	pcie_set_clkpm_nocheck(link, enable);
>   }
>   
> -static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
> -						   int enabled)
> -{
> -	struct pci_dev *pdev = link->downstream;
> -
> -	/* For devicetree platforms, enable ClockPM by default */
> -	if (of_have_populated_dt() && !enabled) {
> -		link->clkpm_default = 1;
> -		pci_info(pdev, "ASPM: DT platform, enabling ClockPM\n");
> -	}
> -}
> -
>   static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>   {
>   	int capable = 1, enabled = 1;
> @@ -410,7 +397,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>   	}
>   	link->clkpm_enabled = enabled;
>   	link->clkpm_default = enabled;
> -	pcie_clkpm_override_default_link_state(link, enabled);
>   	link->clkpm_capable = capable;
>   	link->clkpm_disable = blacklist ? 1 : 0;
>   }
> @@ -811,19 +797,17 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>   	struct pci_dev *pdev = link->downstream;
>   	u32 override;
>   
> -	/* For devicetree platforms, enable all ASPM states by default */
> +	/* For devicetree platforms, enable L0s and L1 by default */
>   	if (of_have_populated_dt()) {
> -		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> +		if (link->aspm_support & PCIE_LINK_STATE_L0S)
> +			link->aspm_default |= PCIE_LINK_STATE_L0S;
> +		if (link->aspm_support & PCIE_LINK_STATE_L1)
> +			link->aspm_default |= PCIE_LINK_STATE_L1;
>   		override = link->aspm_default & ~link->aspm_enabled;
>   		if (override)
> -			pci_info(pdev, "ASPM: DT platform, enabling%s%s%s%s%s%s%s\n",
> -				 FLAG(override, L0S_UP, " L0s-up"),
> -				 FLAG(override, L0S_DW, " L0s-dw"),
> -				 FLAG(override, L1, " L1"),
> -				 FLAG(override, L1_1, " ASPM-L1.1"),
> -				 FLAG(override, L1_2, " ASPM-L1.2"),
> -				 FLAG(override, L1_1_PCIPM, " PCI-PM-L1.1"),
> -				 FLAG(override, L1_2_PCIPM, " PCI-PM-L1.2"));
> +			pci_info(pdev, "ASPM: DT platform, enabling%s%s\n",
> +				 FLAG(override, L0S, " L0s"),
> +				 FLAG(override, L1, " L1"));
>   	}
>   }
>   



