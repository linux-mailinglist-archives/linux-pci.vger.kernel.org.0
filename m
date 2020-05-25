Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9761E1317
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEYQ6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEYQ6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 12:58:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA25C061A0E;
        Mon, 25 May 2020 09:58:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so9027003pfa.2;
        Mon, 25 May 2020 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aPMULKZDeq0BX+s9zNJj5lw/mRPJ8V62Bi00UZ2hLPQ=;
        b=JNQq63iU315TudbF0LDZbx0/ESdXGRQ+JL6Q8ov8UoVeiVwyyIzm0oBHPCwmXZzuvs
         xnf7opyTEzKm/Ipk769HDtPHEhmuPMBMiFybuXo2NewIjgQbZ2tUv2JRc43WWqYc3yZ9
         xJ3nkjKYoQFJgR7tVH4OJthhyecWG5WTE9Wkuf9TRujPbxby4YVsPnrYsnNVtlMyqeAM
         HEuiuXFX4Ezr6HR6tyzTDaNauY4TjnrvnoG/BEfOTgglxrJgVUDSP+Bc2+Xf9UcjgcAU
         vKZaPSahzBHFnvb/FO6EtDJHqAyKBvuTicmJl4bBYl1OxTuZtbXJVmPZNzBrLshZbfPN
         KopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aPMULKZDeq0BX+s9zNJj5lw/mRPJ8V62Bi00UZ2hLPQ=;
        b=Xvlc2EUH/caUJCsrjlKWXWNvCo5+z2u58lBfiIAXAQhmk8b67HBg2kUzxAVV/FpnFK
         9GKjmwaAa+bwXDFlzsZ8CDyQx3ydT/Yb2BOJEeAGcsR+AcwNV+8qB44kSVpUCZAT9yqE
         gSHW0Q6s4QndT7SCtfbKFMZpIZuQKjvJJrq5JeOGThkPN8OsvQ979mLqQTmYp9zi6lTK
         CCailk6ysoyTfZDAP9l0WvhbIKbzY4MFkIUS/eP9S1BY6pRSkOpRmNzyG1qCqEGz2dSW
         PI3+LkgntyYf47HZjK5YVD6ZOSUCZmS5tx+wfT4ditrBWgg8qcb8DJpVaEFxBwGD+n/l
         xlQg==
X-Gm-Message-State: AOAM5313AnsYyT5kQZ7cZWoEt7Sj7DY62n8hnW3F3teYsWQ6G5xNOp1K
        6kdVBkAVEKhXudWRSbiMyG3+9yUg
X-Google-Smtp-Source: ABdhPJyamdUHEpVQmhep6MniCPNxtcfAdKYfTqv1tOet1bkSJFZ/NVZIoCCC18ASwCtIF3W4ZjUrBg==
X-Received: by 2002:a63:5116:: with SMTP id f22mr16311686pgb.100.1590425915574;
        Mon, 25 May 2020 09:58:35 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e21sm11825840pga.71.2020.05.25.09.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 09:58:34 -0700 (PDT)
Subject: Re: [PATCH 07/15] PCI: brcmstb: Add control of rescal reset
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-8-james.quinlan@broadcom.com>
 <20200520072747.GB5213@pengutronix.de>
 <CA+-6iNxtW66QLrb5BaOOCPJwG-1fShdfZqiLSkKfi6Y669dn5w@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c76cc2e6-fcc5-5d42-5ff1-770a99cb9b13@gmail.com>
Date:   Mon, 25 May 2020 09:58:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CA+-6iNxtW66QLrb5BaOOCPJwG-1fShdfZqiLSkKfi6Y669dn5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/21/2020 2:48 PM, Jim Quinlan wrote:
> On Wed, May 20, 2020 at 3:27 AM Philipp Zabel <pza@pengutronix.de> wrote:
>>
>> Hi Jim,
>>
>> On Tue, May 19, 2020 at 04:34:05PM -0400, Jim Quinlan wrote:
>>> From: Jim Quinlan <jquinlan@broadcom.com>
>>>
>>> Some STB chips have a special purpose reset controller named
>>> RESCAL (reset calibration).  This commit adds the control
>>> of RESCAL as well as the ability to start and stop its
>>> operation for PCIe HW.
>>>
>>> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
>>> ---
>>>  drivers/pci/controller/pcie-brcmstb.c | 81 ++++++++++++++++++++++++++-
>>>  1 file changed, 80 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>> index 2c470104ba38..0787e8f6f7e5 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> [...]
>>> @@ -1100,6 +1164,21 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>               dev_err(&pdev->dev, "could not enable clock\n");
>>>               return ret;
>>>       }
>>> +     pcie->rescal = devm_reset_control_get_shared(&pdev->dev, "rescal");
>>> +     if (IS_ERR(pcie->rescal)) {
>>> +             if (PTR_ERR(pcie->rescal) == -EPROBE_DEFER)
>>> +                     return -EPROBE_DEFER;
>>> +             pcie->rescal = NULL;
>>
>> This is effectively an optional reset control, so it is better to use:
>> ↵
>>         pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev,
>>                                                               "rescal");↵
>>         if (IS_ERR(pcie->rescal))
>>                 return PTR_ERR(pcie->rescal);
>>
>>> +     } else {
>>> +             ret = reset_control_deassert(pcie->rescal);
>>> +             if (ret)
>>> +                     dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
>>> +     }
>>
>> reset_control_* can handle rstc == NULL parameters for optional reset
>> controls, so this can be done unconditionally:
>>
>>         ret = reset_control_deassert(pcie->rescal);↵
>>         if (ret)↵
>>                 dev_err(&pdev->dev, "failed to deassert 'rescal'\n");↵
>>
>> Is rescal handled by the reset-brcmstb-rescal driver? Since that only
>> implements the .reset op, I would expect reset_control_reset() here.
> Where exactly?  "reset.h" says that "Calling reset_control_rese()t is
> not allowed on a shared reset control." so I'm not sure why  you would
> want me to invoke it.

Yes this is handled by drivers/reset/reset-brcmstb-rescal.c which only
implements a .reset() callback, what would be the appropriate API usage
here given that this is a shared reset between AHCI and PCIe, should
drivers/reset/reset-brcmstb-rescal.c not implement a .reset() callback
and .assert() callback instead?

>> Otherwise this looks like it'd be missing a reset_control_assert in
>> remove.
> I can add this.
> Thanks,
> Jim
>>
>> regards
>> Philipp

-- 
Florian
