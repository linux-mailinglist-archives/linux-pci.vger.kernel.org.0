Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3A264DA3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgIJSrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 14:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgIJSrG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 14:47:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43675C061573;
        Thu, 10 Sep 2020 11:47:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u13so4746643pgh.1;
        Thu, 10 Sep 2020 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=424l1MWPbS/ON1GRg0DetsLYxUXYchwHArTK6auJOEk=;
        b=YIgCxUrQkyCOpWEZvBl36B/2BtAyPgmv8YOBishJRRckJddXUNWTdKa2SjJroCGC6c
         mb7iklS28ksdFo8mjJiaxOQIw9wJb1Bnm3swGVBtDZOYa3P9CxsWOpPuHqXkSt5nDDYT
         k4SNl9vZFwyBdSTC/XUUxuIHsIAjms8SmJA1mnfgTCpsk2vykBWFd//Zwtu1xYG0t+4D
         tDas9zB0Jq9DUvUgxYc2e56WMnZMyUU4yf+zshuTMw8+T7zjYDkubH4+9hy2Tdnr0Dyp
         Izjd/kB8FL5Tp8Vn7VUbwn7cBNuVMIspKxplnnmE/1gxLY6wAFcs7q3ObibCdMuPMK3J
         ZNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=424l1MWPbS/ON1GRg0DetsLYxUXYchwHArTK6auJOEk=;
        b=YEi17Fl7IrLYwPMZth+wc7ESRCPzJElPEy75d/FNKI7CL4ySYg0Uy33c+SkcGS81kg
         bOSAKSaMaCB6rMd61iQMT1CZ4i0nMInA/mM6E0iNGyGtLB+JP1YhXUc9+wnrLieuw09p
         mUtg5aLid4TgUoe+BDhkqqaGU223PX3NftKeoCl5NwlQTChl3ZI2YfSwI06XykGuO/cA
         y22x1ihz6lRb5X0TgkQGkrw4lJt3SyNr+A17vsIAyuDLdyRJ8rC2K70xRbLgKc2wdD2S
         kzU9KPFJtgn3imqWlLTjgBqGGxR+XQey4ADyRgCpmgQfXJ/LKZY1HmVuJYr1k+6Tl/MD
         nksQ==
X-Gm-Message-State: AOAM531jGUL7QKy1JKNzsql/BLYWtOSKEjOzTeyvYkxuRtvmwjPN5k/F
        NBr9LqiLvGwv3KNaEvKAsv5l9DHLXf8=
X-Google-Smtp-Source: ABdhPJwmxeE6OZg5TekYzKbCaPzO9u6oZpsgdf2gwxq5xNrvkL1KFBdPRlzijgJTftcw/V/JHfwphw==
X-Received: by 2002:a62:1a95:0:b029:13c:1611:6539 with SMTP id a143-20020a621a950000b029013c16116539mr6480616pfa.11.1599763625562;
        Thu, 10 Sep 2020 11:47:05 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x4sm6610411pfm.86.2020.09.10.11.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:47:05 -0700 (PDT)
To:     Rob Herring <robh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-5-james.quinlan@broadcom.com>
 <20200910155637.GA423872@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v11 04/11] PCI: brcmstb: Add suspend and resume pm_ops
Message-ID: <4ae713d2-14d3-8ef8-e589-fdc55f5b1731@gmail.com>
Date:   Thu, 10 Sep 2020 11:47:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200910155637.GA423872@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/10/2020 8:56 AM, Rob Herring wrote:
> On Mon, Aug 24, 2020 at 03:30:17PM -0400, Jim Quinlan wrote:
>> From: Jim Quinlan <jquinlan@broadcom.com>
>>
>> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
>> and resume.  Now the PCIe driver may do so as well.
>>
>> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>> index c2b3d2946a36..3d588ab7a6dd 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -978,6 +978,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>>   	brcm_pcie_bridge_sw_init_set(pcie, 1);
>>   }
>>   
>> +static int brcm_pcie_suspend(struct device *dev)
>> +{
>> +	struct brcm_pcie *pcie = dev_get_drvdata(dev);
>> +
>> +	brcm_pcie_turn_off(pcie);
>> +	clk_disable_unprepare(pcie->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int brcm_pcie_resume(struct device *dev)
>> +{
>> +	struct brcm_pcie *pcie = dev_get_drvdata(dev);
>> +	void __iomem *base;
>> +	u32 tmp;
>> +	int ret;
>> +
>> +	base = pcie->base;
>> +	clk_prepare_enable(pcie->clk);
>> +
>> +	/* Take bridge out of reset so we can access the SERDES reg */
>> +	brcm_pcie_bridge_sw_init_set(pcie, 0);
>> +
>> +	/* SERDES_IDDQ = 0 */
>> +	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>> +	u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>> +	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>> +
>> +	/* wait for serdes to be stable */
>> +	udelay(100);
> 
> Really needs to be a spinloop?
> 
>> +
>> +	ret = brcm_pcie_setup(pcie);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (pcie->msi)
>> +		brcm_msi_set_regs(pcie->msi);
>> +
>> +	return 0;
>> +}
>> +
>>   static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>>   {
>>   	brcm_msi_remove(pcie);
>> @@ -1087,12 +1128,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>   
>>   MODULE_DEVICE_TABLE(of, brcm_pcie_match);
>>   
>> +static const struct dev_pm_ops brcm_pcie_pm_ops = {
>> +	.suspend_noirq = brcm_pcie_suspend,
>> +	.resume_noirq = brcm_pcie_resume,
> 
> Why do you need interrupts disabled? There's 39 cases of .suspend_noirq
> and 1352 of .suspend in the tree.
> 
> Is doing a clk unprepare even safe in .suspend_noirq? IIRC,
> prepare/unprepare can sleep.

Yes, it is safe, provided that your clock provider (clk-scmi.c in our 
case) supports it, too. In our case the underlying mailbox driver has 
its interrupts flagged with IRQF_NOSUSPEND such that they can still be 
processed at _noirq time.

I think the rationale was to ensure that this would be done much later 
after other subsystem have been made quiescent, but given the Linux 
device driver model, the PCI bridge should be suspended after all 
pci_device child device, so it should be safe not to use _noirq.
-- 
Florian
