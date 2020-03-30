Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9521981D4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgC3REn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 13:04:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33359 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgC3REn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 13:04:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id z14so80042wmf.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2020 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqStv1Lo1qg4gRg7lDrcQqRCTc9QZc+NG4mrfiQbFjE=;
        b=Uh4bVVfaNPgqBDf14A/tNlnFlIMgcAjfpCWcb+Uzrx//iiYZNWzYxkVZtoxnnBGNE7
         JUng1z3YWhf3Ee4gCS+2rK3YV4eaABGB5nQVH/R8tVtdVZInAAMkT1GD+hjo00JOuZqN
         FvOAi1z1lfK4wW+rdBnYnyco/ZYm94ggobg0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqStv1Lo1qg4gRg7lDrcQqRCTc9QZc+NG4mrfiQbFjE=;
        b=kST9aFlBFbkzWjL5eFQNYIhLY2DkWznymGA0RRyUCzWkJfAw1ns49WA2fW6vYcNsS4
         m8FZOMEX8QZa4jQwYv4ieS6ZR1PenIvGr4AWVGQjg7Vkyi+2qEy+gw0eOO9368PwL1Xj
         AgfxjMh5+JuF322TrP290gA2vGhLcfcuJi2bJVSeyLWlRc10XUBp/hKePD8PEhJY6YFE
         FjpQoQB245oc3d8vvF/BSwrgck2aHDnuwRroNcMkE9ipBwwRf1taEAps9LM0NiBo70Wy
         dQeQNJtt91qsztFGmf9dmB2udyE1xjMcoKLqdaS5L6lxr89h6Vs4zZOex4GuV2e3JTx0
         PT9g==
X-Gm-Message-State: ANhLgQ0D5VDgQFY/w9QC7ho+Veea1Nh8UG/Tmk1B65Qtx4h7YP8xeWEW
        h/DOLRFagzrp+y49ys/KQ/EteQ==
X-Google-Smtp-Source: ADFU+vvo+5kRarlX8ncgn7tFCSQDq8v2Ad0Bb+4DKkjHRYgiSGCpdbHJ7aZZkfTIo2aaSImThdshhg==
X-Received: by 2002:a05:600c:2202:: with SMTP id z2mr263068wml.64.1585587881418;
        Mon, 30 Mar 2020 10:04:41 -0700 (PDT)
Received: from [10.230.26.36] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id t126sm192175wmb.27.2020.03.30.10.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 10:04:40 -0700 (PDT)
Subject: Re: [PATCH 1/3] PCI: iproc: fix out of bound array access
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
References: <20200326204807.GA87784@google.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <0fec2db0-fb56-615d-eed4-d702d1bc37fb@broadcom.com>
Date:   Mon, 30 Mar 2020 10:04:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326204807.GA87784@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/26/2020 1:48 PM, Bjorn Helgaas wrote:
> On Thu, Mar 26, 2020 at 01:27:36PM -0700, Ray Jui wrote:
>> On 3/26/2020 12:48 PM, Bjorn Helgaas wrote:
>>> ...
>>> It's outside the scope of this patch, but I'm not really a fan of the
>>> pcie->reg_offsets[] scheme this driver uses to deal with these
>>> differences.  There usually seems to be *something* that keeps the
>>> driver from referencing registers that don't exist, but it doesn't
>>> seem like the mechanism is very consistent or robust:
>>>
>>>   - IPROC_PCIE_LINK_STATUS is implemented by PAXB but not PAXC.
>>>     iproc_pcie_check_link() avoids using it if "ep_is_internal", which
>>>     is set for PAXC and PAXC_V2.  Not an obvious connection.
>>>
>>>   - IPROC_PCIE_CLK_CTRL is implemented for PAXB and PAXC_V1, but not
>>>     PAXC_V2.  iproc_pcie_perst_ctrl() avoids using it ep_is_internal",
>>>     so it *doesn't* use it for PAXC_V1, which does implement it.
>>>     Maybe a bug, maybe intentional; I can't tell.
>>>
>>>   - IPROC_PCIE_INTX_EN is only implemented by PAXB (not PAXC), but
>>>     AFAICT, we always call iproc_pcie_enable() and rely on
>>>     iproc_pcie_write_reg() silently drop the write to it on PAXC.
>>>
>>>   - IPROC_PCIE_OARR0 is implemented by PAXB and PAXB_V2 and used by
>>>     iproc_pcie_map_ranges(), which is called if "need_ob_cfg", which
>>>     is set if there's a "brcm,pcie-ob" DT property.  No clear
>>>     connection to PAXB.
>>>
>>> I think it would be more readable if we used a single variant
>>> identifier consistently, e.g., the "pcie->type" already used in
>>> iproc_pcie_msi_steer(), or maybe a set of variant-specific function
>>> pointers as pcie-qcom.c does.
>>
>> It is not possible to use a single variant identifier consistently,
>> i.e., 'pcie->type'. Many of these features are controller revision
>> specific, and certain revisions of the controllers may all have a
>> certain feature, while other revisions of the controllers do not. In
>> addition, there are overlap in features across different controllers.
>>
>> IMO, it makes sense to have feature specific flags or booleans, and have
>> those features enabled or disabled based on 'pcie->type', which is what
>> the current driver does, but like you pointed out, what the driver
>> failed is to do this consistently.
> 
> There are several drivers that have the same problem of dealing with
> different revisions of hardware.  It would be nice to do it in a
> consistent style, whatever that is.
> 

Sure, agree with you that it should be handled in a consistent way
within this driver, and the current driver is not handling this
consistently.

>> The IPROC_PCIE_INTX_EN example you pointed out is a good example. I
>> agree with you that we shouldn't rely on iproc_pcie_write_reg to
>> silently drop the operation for PAXC. We should add code to make it
>> explictly obvious that legacy interrupt is not supported in all PAXC
>> controllers.
>>
>> pcie->pcie->reg_offsets[] scheme was not intended to be used to silently
>> drop register access that are activated based on features. It's a
>> mistake that should be fixed if some code in the driver is done that
>> way, as you pointed out.
> 
> That's actually why I dug into this a bit -- the
> iproc_pcie_reg_is_invalid() case is really a design-time error, so it
> seemed like there should be a WARN() there instead of silently
> returning 0 or ignoring a write.
> 

I think 'iproc_pcie_reg_is_invalid' is a fall back protection. We should
aim to prevent this from happening in the first place using whatever
means we determined appropriate, and do that consistently. In addition,
I also agree with you that there should be a WARN instead of silently
returning zero (for reads) and dropping the writes.

We'll be looking into improving this as you suggested when we have a
chance. In the mean time, I think both of us agree this is out of the
scope of the issue that this patch is trying to fix, which is actually a
pretty critical issue that can cause potential corruption of memory and
the fix should be picked up ASAP (and for older LTS kernels too).

Thanks,

Ray

> Bjorn
> 
