Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423973FBA28
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhH3Q2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbhH3Q2d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 12:28:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B76C0617A8;
        Mon, 30 Aug 2021 09:27:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c17so13998694pgc.0;
        Mon, 30 Aug 2021 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SpvJ4CLAzhva5F4XtB4tBqXKDI4X4EVKC4ISV0mt3TQ=;
        b=o0YL3iEkw8q0MowNpeR/VimKmsU6TWbEzdwc6ToupWCLOaed6sYGM2aqsjrPtkChUG
         iOL/XLD3JLQ3h1vgASVVACHjUAah8iPuiLr9354s/X3eVypT7R/Z9hInjmbjRnDsIehW
         +vfX5rWml/b3MZ27c7uIIBOx5TArWWd0kNidfd8psSI3nyc15X8JH6gMJDoUJbg7g+l0
         /3mKK17tk7ZE7Jwvn04xT/+/CDwJNrvb5apN4XnVklDp0cMkpNajAdq3VMj4b1oheGzL
         pgEuAuvewxkFPBYojdHGRemAGSGcN5dyAfPjYpzw95nhwXNmFkfWdxtgL882ucvvgcbL
         68SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SpvJ4CLAzhva5F4XtB4tBqXKDI4X4EVKC4ISV0mt3TQ=;
        b=fK2v84a5jwhXdHvx1ZrCX+wz1sPekYvLcHf/jcaaXO0oK/k+D7JT4EEkaSOI4ie+sN
         LyofHV7FpHTrHK/kymvjX72X4I6C6JHX8tv9FSroaY6GPd5T/43mNwv2EfyCoLlFO9SU
         FT461+491xutBx5fM7xPgFTr76vkagvvv9efZR4MkWkxyd/8Wgz9QdV3QlB7AtmDxf5c
         gmB75y8zhu5pIbS3OhNytyPzNkEqr6rUTRRKQ3BQpRWj9Q68AKkCSM13yTR1VtxmeC2B
         0kff4TFnvsZIKkbDWfmEVz5Vx2sWITY1piN6TMj6+/2OZaghwBm24X23hLPM3jDtPP/q
         9joA==
X-Gm-Message-State: AOAM532kK9UlyE/2W1N50SizQHyWoHwqHp+OHJrHCbVJhVCgDePaDGB1
        /RaMlkFa1lCPOdsLbq94AyW7aiUswt0=
X-Google-Smtp-Source: ABdhPJygMorFNusfQeS9xBheuAyjc2V0N2/yjue/iuDSrnu2bwejacaGM7WVS7ULTcntBHH47ZTLiA==
X-Received: by 2002:a63:7405:: with SMTP id p5mr22388217pgc.426.1630340859387;
        Mon, 30 Aug 2021 09:27:39 -0700 (PDT)
Received: from [192.168.1.121] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with UTF8SMTPSA id h5sm14234261pfv.131.2021.08.30.09.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:27:38 -0700 (PDT)
Message-ID: <f6860e38-c6fa-292d-f1a1-22b3e4b48f32@gmail.com>
Date:   Mon, 30 Aug 2021 09:27:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
Content-Language: en-US
To:     Jeremy Linton <jeremy.linton@arm.com>,
        nicolas saenz julienne <nsaenz@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210826071557.29239-1-jeremy.linton@arm.com>
 <20210826071557.29239-3-jeremy.linton@arm.com>
 <44ad79081412af289c68e74cdecb6a2baa2e873c.camel@kernel.org>
 <5c39cf29-a08f-48d1-b873-ce0fda763d66@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <5c39cf29-a08f-48d1-b873-ce0fda763d66@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/30/2021 9:23 AM, Jeremy Linton wrote:
> Hi,
> 
> On 8/30/21 3:36 AM, nicolas saenz julienne wrote:
>> Hi Jeremy,
>> sorry for the late reply, I've been on vacation.
>>
>> On Thu, 2021-08-26 at 02:15 -0500, Jeremy Linton wrote:
>>
>> [...]
>>
>>> +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus,
>>> +                    unsigned int devfn, int where)
>>> +{
>>> +    struct pci_config_window *cfg = bus->sysdata;
>>> +    void __iomem *base = cfg->win;
>>> +    int idx;
>>> +    u32 up;
>>> +
>>> +    /* Accesses to the RC go right to the RC registers if slot==0 */
>>> +    if (pci_is_root_bus(bus))
>>> +        return PCI_SLOT(devfn) ? NULL : base + where;
>>> +
>>> +    /*
>>> +     * Assure the link is up before sending requests downstream. 
>>> This is done
>>> +     * to avoid sending transactions to EPs that don't exist. Link flap
>>> +     * conditions/etc make this race more probable. The resulting 
>>> unrecoverable
>>> +     * SERRORs will result in the machine crashing.
>>> +     */
>>> +    up = readl(base + PCIE_MISC_PCIE_STATUS);
>>> +    if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
>>> +        return NULL;
>>> +
>>> +    if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
>>> +        return NULL;
>>
>> Couldn't this be integrated in the original brcm_pcie_map_conf()? IIUC 
>> there is
>> nothing ACPI specific about it. It'd also make for less code duplication.
> 
> That is where I started with this, but it wasn't the linkup check/etc 
> which caused me to hoist it but the fact that if ACPI quirks are enabled 
> they end up statically built into the kernel. While if this host bridge 
> is enabled, it can end up being a module, and the resulting mess I 
> created trying to satisfy the CONFIG variations. I'm not much of a fan 
> of copy/paste programming, but that IMHO ended up being the cleanest here.
> 

Agreed, the open coding that is being done is reasonable IHMO, although 
we may have to update the link up code in both pcie-brcmstb.c and this 
file in the future if offsets/bits do change, nothing impossible though.
-- 
Florian
