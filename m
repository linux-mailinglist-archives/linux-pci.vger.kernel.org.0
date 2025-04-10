Return-Path: <linux-pci+bounces-25616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA5A83E02
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C206F9E08D4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808232144B4;
	Thu, 10 Apr 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DxzR6flk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32114.qiye.163.com (mail-m32114.qiye.163.com [220.197.32.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AC20F069
	for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275789; cv=none; b=dOvZhosgc9o1nH2tTuthbk2tpcqw4x7SY4KPAHsWReSwbV5TMIoLTYhqfBqfngo6AFsUi00PniEC2t9/3PPw+EkKK8LTXtH4JjGWzFk+ZIAbtDvAVtjbcL94LFp0nc1zsdD1MPLnXKBXvfptf9aVnI0YS92uvuICyMDiSNIDU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275789; c=relaxed/simple;
	bh=OotE7cHBSFlzurwTI18wNFBuZPftr/UlkB6mzjMB4ko=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cH231Kkq5kxDz8eCSViY+cMYva2ox+xU+PkUQRg8a5hW3XFhyXKdZ2nozks1OlXqfKoJHeKHRwxXj8ynH6COQ35Uspi7WSAxrQPA+lBsH0XpqJ9acmgwnfayx2KEgT0lhc+5jR5KpM6JnSePJEkxvI9KYu3uUjWZbZiGhrtT2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DxzR6flk; arc=none smtp.client-ip=220.197.32.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1160c0ad2;
	Thu, 10 Apr 2025 16:57:46 +0800 (GMT+08:00)
Message-ID: <11fa4ae4-2765-8d10-176f-602bf9d81d4b@rock-chips.com>
Date: Thu, 10 Apr 2025 16:57:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enable L0S capability
To: Niklas Cassel <cassel@kernel.org>
References: <1744248981-43371-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_eEw-l6SG-lF_7R@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <Z_eEw-l6SG-lF_7R@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgfQlYfTksdHU8fSBgZTR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961eeb67ce09cckunm1160c0ad2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6Kxw5DTJJQzARMSEMSxoj
	HA4KFAJVSlVKTE9PSUxOT01MSUpIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhCSEo3Bg++
DKIM-Signature:a=rsa-sha256;
	b=DxzR6flkJJfZ2y5DXmXLBgdMMmPnAx1sGQbgFWd/hnsibiQy78TS4qTBKtzd/LG4GVmoZ2+YdcsgQ+IhivI7Ww+hQ0WK8IzA2to4eLsuWXLnFtR12FQNGhZBrxAvpshxBpEp2f78mWwhMfVdrdSvNjKalINLA82M+Arr7sltrKU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KGUyqCpZlkneH9bPtD1oxyi9RUc2m083c5vFMnUGzPs=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/10 星期四 16:43, Niklas Cassel 写道:
> Hello Shawn,
> 
> On Thu, Apr 10, 2025 at 09:36:21AM +0800, Shawn Lin wrote:
>> L0S capability isn't enabled on all SoCs by default, so enabling it
>> in order to make ASPM L0S work on Rockchip platforms. We have been
>> testing it for quite a long time and the default FTS number provided
>> by DWC core is broken since it fits only for DWC PHY IP but not for
>> other types of PHY IP from other vendors.
> 
> If we take the rk3588 SoC for example,
> some PCIe controllers use PHY:
> drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> some PCIe controllers use PHY:
> drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> 
> This second PHY is obviously a Synopsys PHY.
> 
> So, I think the commit message is a bit confusing/misleading,
> since IMO the second PHY driver is for a DWC PHY IP.
> 
> Is this N_FTS value correct for both of these PHYs?

yes, the vaule is PHY depends, but we don't know which PHY is
used currently. So the safest one is 255 which is the max defined
in spec, seems work fine for both under massive test.

> 
> 
> Having this code in ->start_link() looks incorrect.
> 
> rockchip_pcie_configure_rc(), calls dw_pcie_host_init().
> 
> dw_pcie_host_init() first calls dw_pcie_setup_rc(), which calls dw_pcie_setup().
> dw_pcie_setup() will write pci->n_fts[0] / pci->n_fts[1].
> 
> dw_pcie_host_init() then calls dw_pcie_start_link()
> (which calls ->start_link()).
> 
> So, setting pci->n_fts[0] / pci->n_fts[1] in ->start_link() is thus too late.
> 

Oops, I did move n_fts a bit afterward after testing, in order to look
more reasonable until we enable L0S capability. Let me see how to fix
it.

Thannks for the review.

> 
> Kind regards,
> Niklas
> 
> 
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 21dc99c..56acfea 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -185,6 +185,20 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>>   static int rockchip_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +	u32 cap, lnkcap;
>> +
>> +	/* Enable L0S capability for all SoCs */
>> +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +	if (cap) {
>> +		/* Default fts number(210) is broken, override it */
>> +		pci->n_fts[0] = 255; /* Gen1 */
>> +		pci->n_fts[1] = 255; /* Gen2+ */
>> +		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
>> +		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
>> +		dw_pcie_dbi_ro_wr_en(pci);
>> +		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
>> +		dw_pcie_dbi_ro_wr_dis(pci);
>> +	}
>>   
>>   	/* Reset device */
>>   	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>> -- 
>> 2.7.4
>>
> 

