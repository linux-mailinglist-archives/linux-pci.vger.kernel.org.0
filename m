Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785F4264E4A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIJTJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgIJTIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 15:08:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CFDC061573;
        Thu, 10 Sep 2020 12:08:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so5211330pfn.8;
        Thu, 10 Sep 2020 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dwnpM8JLZbBKIkQgOLZZmnOg2dEyjob2l7NHK0msXlE=;
        b=b4jMa7dn0K2TKjty1oEv4pSKKxhN/pZpU9t6puz8KR6lVKbaYXRGzjXA+RiPbWeVBP
         udH0RaAToStag+dEd7hCRA9oTka1aDGdXBR0BSY0A6Y0eFYcKr0zjU0mH+UdhEgXQagN
         bCO2hecd3FWV0oj1BILyVN0hjm4bkA4wbMFG6baAeXtDOETDKX24d+BrOKsqhFtIHovT
         QCvk4Nq17lU9V/BlGsGNBGoq4JI8fAp21ns0pq0N7DLfvsZmWiExvotFYYhEHNzUSi/O
         W43O42D82m8KZewecXfWBMd6xbUMl/1CqdAFfospOkue5EN28FXWZsVYiCtXReVjkslj
         UOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwnpM8JLZbBKIkQgOLZZmnOg2dEyjob2l7NHK0msXlE=;
        b=pVXfXEktrBqv3n+iFrYl7pD2RSh/K+2h2GmoASflImklZb2Etni+otAuzd5V27gv+6
         xCIoivPsmftfBDGQi9QB/P3ym9lg5tHh2Cl37k2SGeu70edCbTEkhINqEFz4LAFZ3Mjj
         rQdKgMRcvAojEceuf02XkLSDiNr6aiZt//stvKQFD6rHVFvyKRrnvFpC6JKLRUMS0ZTL
         BX9uYIPiy5EW4POPslwwG+nPYcXrOtDjEjUu64aQstBuDVFOx6mgXYtFtUqdJJLv5Gxn
         cc7xEYxaDlrLNC4YFmyLJsyBT1vOOPdjfG4Pu+Zjfdeofs8ExsOkR6QcQ7Jt/yHLuWnu
         KRDQ==
X-Gm-Message-State: AOAM533G9mO+xFUp16dFdELl8V7aXbjZ4d/0apykumcd3v9qV77sB372
        TCc0stVMLTsRuuZN6nXLMUnZv5k+oko=
X-Google-Smtp-Source: ABdhPJyukXJbwjvFKYrra3HXc9hr35P0awBCdafHP3LXlMZghA/JirNZoF+3l0EF+sjyWDBOggm7Qg==
X-Received: by 2002:a63:384b:: with SMTP id h11mr5820171pgn.113.1599764884416;
        Thu, 10 Sep 2020 12:08:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id n127sm6441841pfn.155.2020.09.10.12.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 12:08:03 -0700 (PDT)
Subject: Re: [PATCH v11 04/11] PCI: brcmstb: Add suspend and resume pm_ops
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Rob Herring <robh@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-5-james.quinlan@broadcom.com>
 <20200910155637.GA423872@bogus>
 <CA+-6iNy9g8fhJvd7SOKtc-SZcL8_gLLN1HEs-W8fe-=q6n430A@mail.gmail.com>
 <CAL_JsqJR4wALnsFKKPQ8h2y-o-933rzxHbV29zGXiptgYuuHTg@mail.gmail.com>
 <CA+-6iNwcLZcQcge2E6GUi71rveFaneeCBwxBTfn8MipwhaPvEQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3c6a0acc-8966-fd38-1613-8da7bece81c7@gmail.com>
Date:   Thu, 10 Sep 2020 12:07:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CA+-6iNwcLZcQcge2E6GUi71rveFaneeCBwxBTfn8MipwhaPvEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/10/2020 12:05 PM, Jim Quinlan wrote:
> On Thu, Sep 10, 2020 at 2:50 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Thu, Sep 10, 2020 at 10:42 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>>>
>>> On Thu, Sep 10, 2020 at 11:56 AM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Mon, Aug 24, 2020 at 03:30:17PM -0400, Jim Quinlan wrote:
>>>>> From: Jim Quinlan <jquinlan@broadcom.com>
>>>>>
>>>>> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
>>>>> and resume.  Now the PCIe driver may do so as well.
>>>>>
>>>>> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
>>>>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>> ---
>>>>>   drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
>>>>>   1 file changed, 47 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>>>> index c2b3d2946a36..3d588ab7a6dd 100644
>>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>>> @@ -978,6 +978,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>>>>>        brcm_pcie_bridge_sw_init_set(pcie, 1);
>>>>>   }
>>>>>
>>>>> +static int brcm_pcie_suspend(struct device *dev)
>>>>> +{
>>>>> +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
>>>>> +
>>>>> +     brcm_pcie_turn_off(pcie);
>>>>> +     clk_disable_unprepare(pcie->clk);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int brcm_pcie_resume(struct device *dev)
>>>>> +{
>>>>> +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
>>>>> +     void __iomem *base;
>>>>> +     u32 tmp;
>>>>> +     int ret;
>>>>> +
>>>>> +     base = pcie->base;
>>>>> +     clk_prepare_enable(pcie->clk);
>>>>> +
>>>>> +     /* Take bridge out of reset so we can access the SERDES reg */
>>>>> +     brcm_pcie_bridge_sw_init_set(pcie, 0);
>>>>> +
>>>>> +     /* SERDES_IDDQ = 0 */
>>>>> +     tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>>>>> +     u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>>>>> +     writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>>>>> +
>>>>> +     /* wait for serdes to be stable */
>>>>> +     udelay(100);
>>>>
>>>> Really needs to be a spinloop?
>>>>
>>>>> +
>>>>> +     ret = brcm_pcie_setup(pcie);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     if (pcie->msi)
>>>>> +             brcm_msi_set_regs(pcie->msi);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>>   static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>>>>>   {
>>>>>        brcm_msi_remove(pcie);
>>>>> @@ -1087,12 +1128,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>>>
>>>>>   MODULE_DEVICE_TABLE(of, brcm_pcie_match);
>>>>>
>>>>> +static const struct dev_pm_ops brcm_pcie_pm_ops = {
>>>>> +     .suspend_noirq = brcm_pcie_suspend,
>>>>> +     .resume_noirq = brcm_pcie_resume,
>>>>
>>>> Why do you need interrupts disabled? There's 39 cases of .suspend_noirq
>>>> and 1352 of .suspend in the tree.
>>>
>>> I will test switching this to  suspend_late/resume_early.
>>
>> Why not just the 'regular' flavor suspend/resume?
>>
>> Rob
> We must have our PCIe driver suspend last and resume first because our
> current driver turns off/on the power for the EPs.  Note that this
> code isn't in the driver as we are still figuring out a way to make it
> upstreamable.

The suspend/resume ordering should be guaranteed by the Linux device 
driver model though if not, this is a bug that ought to be fixed. The 
PCI bridge sits at the top of the pci_device list and all EPs should be 
child devices, so the suspend order should be from EPs down to the 
bridge, and the resume the converse.
-- 
Florian
