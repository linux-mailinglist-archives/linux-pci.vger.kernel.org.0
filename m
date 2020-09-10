Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2359A264DE9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIJSz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 14:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIJSyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 14:54:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39748C061573;
        Thu, 10 Sep 2020 11:54:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so465246pjb.5;
        Thu, 10 Sep 2020 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Xa8adrS68p10V9uAlCA1zNdv/U/GcBjRclFrOXiS48=;
        b=gyUqp0qm8ln6pVCngaN7s20aFFvyFckMVpNQYk128QI9pagHu2mKSdbTs2JYRvLeTK
         QZcDep/Q1nfAj+q4hDlRXJi6rPbvXBDSBsJmKscnozvrOE4ZXFin9qMBfsNR/Kd5uRWQ
         AJU7KZXE3Qk2dx3F5SvDaOIsRk33Msb1vjmUs76kSEwzhV1MVUhBShgA48EsUp6R4UZM
         iheF35RSl5eFN2WlsfiPmK5FP4jfrO5Juu+2kLVkqxd/kC3Ks5us3yM2XfsONuWghrjU
         s6D23HcupvG31AT9riVU0ZCWFpOMbzasmrRbM020VO4nHlycpm3HPj5odRw83zXlr/nx
         SMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Xa8adrS68p10V9uAlCA1zNdv/U/GcBjRclFrOXiS48=;
        b=cEcs7EZ7h9H3qTLAyrkudkdLquqaygZOZ5NMc80TZIc9eiu5VfqhJwVQTHkqkRi+NO
         6E0zGoBJAHBWuAKE+M57XtV5Wk6WdjL4+XAxsw/EiCugjZdtxAsPRUaZ7j26eN1BklsS
         QpArm8xfWLFHo44D1mt/LP/hrUbL8MoG4N/+MmShieGLxlhK1jwLreBtYPCko4sHVZCQ
         1UOzVR44TwvJUALmfRBUeFh8tLvgiVzux663kjGgB338wXxR0HD9+JvH7lhhXenrNymI
         ulMphmgO/aF61idz44MOfXT3J5UIyxbYjvMXb9/RjyUGyq/UIaxFKm1jPLT33SpMOKd5
         AKyA==
X-Gm-Message-State: AOAM5337CsCqtKfE517wMSvwffMSv/hSgi49QZ1AbMyTm3WalAALrT52
        hqZzYR6SSZTp6FsVSqi9o4yx2/v6TOs=
X-Google-Smtp-Source: ABdhPJyQypWjMN7zIVrB/qW+UZo9cXIHTKKUrEfZmWYJCb4LBOJuMS5AQaKJfMkXxnrwyDS3ChDf7g==
X-Received: by 2002:a17:90a:13c7:: with SMTP id s7mr1309300pjf.124.1599764052289;
        Thu, 10 Sep 2020 11:54:12 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v205sm6620706pfc.110.2020.09.10.11.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:54:11 -0700 (PDT)
Subject: Re: [PATCH v11 04/11] PCI: brcmstb: Add suspend and resume pm_ops
To:     Rob Herring <robh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <027ee22c-0981-f49f-52be-0c8aa3a3699b@gmail.com>
Date:   Thu, 10 Sep 2020 11:54:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJR4wALnsFKKPQ8h2y-o-933rzxHbV29zGXiptgYuuHTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/10/2020 11:50 AM, Rob Herring wrote:
> On Thu, Sep 10, 2020 at 10:42 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>>
>> On Thu, Sep 10, 2020 at 11:56 AM Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Mon, Aug 24, 2020 at 03:30:17PM -0400, Jim Quinlan wrote:
>>>> From: Jim Quinlan <jquinlan@broadcom.com>
>>>>
>>>> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
>>>> and resume.  Now the PCIe driver may do so as well.
>>>>
>>>> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
>>>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>>   drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
>>>>   1 file changed, 47 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>>> index c2b3d2946a36..3d588ab7a6dd 100644
>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>> @@ -978,6 +978,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>>>>        brcm_pcie_bridge_sw_init_set(pcie, 1);
>>>>   }
>>>>
>>>> +static int brcm_pcie_suspend(struct device *dev)
>>>> +{
>>>> +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
>>>> +
>>>> +     brcm_pcie_turn_off(pcie);
>>>> +     clk_disable_unprepare(pcie->clk);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int brcm_pcie_resume(struct device *dev)
>>>> +{
>>>> +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
>>>> +     void __iomem *base;
>>>> +     u32 tmp;
>>>> +     int ret;
>>>> +
>>>> +     base = pcie->base;
>>>> +     clk_prepare_enable(pcie->clk);
>>>> +
>>>> +     /* Take bridge out of reset so we can access the SERDES reg */
>>>> +     brcm_pcie_bridge_sw_init_set(pcie, 0);
>>>> +
>>>> +     /* SERDES_IDDQ = 0 */
>>>> +     tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>>>> +     u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>>>> +     writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>>>> +
>>>> +     /* wait for serdes to be stable */
>>>> +     udelay(100);
>>>
>>> Really needs to be a spinloop?
>>>
>>>> +
>>>> +     ret = brcm_pcie_setup(pcie);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     if (pcie->msi)
>>>> +             brcm_msi_set_regs(pcie->msi);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>>   static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>>>>   {
>>>>        brcm_msi_remove(pcie);
>>>> @@ -1087,12 +1128,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>>
>>>>   MODULE_DEVICE_TABLE(of, brcm_pcie_match);
>>>>
>>>> +static const struct dev_pm_ops brcm_pcie_pm_ops = {
>>>> +     .suspend_noirq = brcm_pcie_suspend,
>>>> +     .resume_noirq = brcm_pcie_resume,
>>>
>>> Why do you need interrupts disabled? There's 39 cases of .suspend_noirq
>>> and 1352 of .suspend in the tree.
>>
>> I will test switching this to  suspend_late/resume_early.
> 
> Why not just the 'regular' flavor suspend/resume?

We must have inherited this from when the driver was not a 
platform_device back in our 3.14 downstream kernel and we used 
syscore_ops to do the system suspend/resume.

Later on, we sort of mechanically made those _noirq() to preserve the 
semantics of syscore_ops, but in hindsight it should not be necessary, 
the regular suspsend/resume should work and the device driver model 
ordering between parent/child should take care of the bridge being 
suspended last within the PCI bus type that is.
-- 
Florian
