Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3356273493
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 23:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIUVDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 17:03:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgIUVDh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 17:03:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kKSyE-0002gj-CM; Mon, 21 Sep 2020 21:03:34 +0000
Subject: Re: [PATCH][next] PCI: brcmstb: fix a missing if statement on a
 return error check
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20200921144017.334602-1-colin.king@canonical.com>
 <c9d7435b-42a1-2e40-7d40-62d227523f79@gmail.com>
 <CA+-6iNyg16dEfnJZpSppRHO6Z6fsWyQdjyzoVsBRW4W1x_4Yeg@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <2702aa0d-7f60-05c1-7b9b-cfe313024886@canonical.com>
Date:   Mon, 21 Sep 2020 22:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CA+-6iNyg16dEfnJZpSppRHO6Z6fsWyQdjyzoVsBRW4W1x_4Yeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/09/2020 21:53, Jim Quinlan wrote:
> Hello,
> I am fine with Colin's suggested change or Florians as well:
> 
>          ret = brcm_phy_start(pcie);
> +        if (ret) {
> +                clk_disable_unprepare(pcie->clk);
>                  return ret;
> +        }
> 
> Currently, our STB upstream suspend/resume is not functional yet and
> this is how this omission slipped by testing.
> 
> Thanks,
> Jim Quinlan
> Broadcom STB
> 
> On Mon, Sep 21, 2020 at 3:43 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 9/21/20 7:40 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The error return ret is not being check with an if statement and
>>> currently the code always returns leaving the following code as
>>> dead code. Fix this by adding in the missing if statement.
>>>
>>> Addresses-Coverity: ("Structurally dead code")
>>> Fixes: ad3d29c77e1e ("PCI: brcmstb: Add control of rescal reset")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/pci/controller/pcie-brcmstb.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>> index 7a3ff4632e7c..cb0c11b7308e 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>> @@ -1154,6 +1154,7 @@ static int brcm_pcie_resume(struct device *dev)
>>>       clk_prepare_enable(pcie->clk);
>>>
>>>       ret = brcm_phy_start(pcie);
>>> +     if (ret)
>>>               return ret;
>>
>> Maybe this should also disable the clock if we failed to start the PHY
>> somehow.
> 
> Hi Florian,
> 
> I'm fine with Colin's change as
> 

I'll send a V2 in a short while
> 
>>
>> --
>> Florian

