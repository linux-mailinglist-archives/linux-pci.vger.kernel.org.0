Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02A3FCF3E
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 23:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhHaVko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 17:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhHaVko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 17:40:44 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A6FC061575
        for <linux-pci@vger.kernel.org>; Tue, 31 Aug 2021 14:39:48 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so929034otg.11
        for <linux-pci@vger.kernel.org>; Tue, 31 Aug 2021 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qITbWcdLaPPuGsGpQjvViElfyoyBFKA9+UX/LVO02uI=;
        b=Z6z5dMItJjfvCvti67bLsguZIW958ttIwxuK0IcwSzWK1Ds7gbL9aiDwfqZ/v5nGU6
         v9bS4fNeIFq7jgVgh5u3jqEJhHDoli5WLLSszQ7UQsdViNhMkjMGMlMyvDomzpBtod1N
         ajyEp24SJ67x3p85Ii/yB5ORA4PDCXbv4N0HnmNk8bfjiAGp21Xx/3AGj/5qTKIiclLw
         z9Bx761HBvP8aps0NXPVJj5T8B18yq9lz0FH62m8XfxAd8C6r1b5he40Ru6OLezwf8BY
         oc/dO5Xulw2MZlT3rgDjmcIwaTnYVzXFVk26tQjysUKnlJ1AuphAXe2xzbv/uePYCAxi
         82Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qITbWcdLaPPuGsGpQjvViElfyoyBFKA9+UX/LVO02uI=;
        b=jqoqNcn368zofQPuP1islmCIO77jI6jCsZy4Ilqf1yEqBgZsA7tbZwIob64EQz/47I
         jGHqirn++OM/8Djx9WJDrU0P9dkGBWci0SwsczYrKroCaAOVwIllQIdTXtzsF5RU98Gr
         b3eeLDqKyfc6pKGEfG4Ufcml7ijfA0M58QPBDT2DOwsL0jkQtO6PQcT9XSpWV1mOuDWm
         ngZNrKOzBDsK3XFWQWtcpF4APc9j1r/ZPUpamM5MelRG1IR1ECJ09chu1b6HdDEt8TUA
         VdXFqnS+Yv8oeONEP5/PkXLQx2D6jbCOPhI01Y5/w5HDzgAH5d8qBjFvjOcFXZXSWXmG
         t7MA==
X-Gm-Message-State: AOAM531cG8BvQs1sSd7aKZoQ0AbLCO6IxIhaE9aTZq4qwmbe8W73Hznq
        Pj7EBzkrIL2ei/i81hjMv0/mZhg/NyE=
X-Google-Smtp-Source: ABdhPJyDxVXpvndU/yv8UhaLp/KIY2h9vXppF8clORXbAEkyruSAI7euaTXexnKs+Y4dxzvZIRjnoQ==
X-Received: by 2002:a9d:6c04:: with SMTP id f4mr26053978otq.185.1630445987163;
        Tue, 31 Aug 2021 14:39:47 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:79bb:47a:661c:1aa1? (2603-8081-2802-9dfb-79bb-047a-661c-1aa1.res6.spectrum.com. [2603:8081:2802:9dfb:79bb:47a:661c:1aa1])
        by smtp.gmail.com with ESMTPSA id j8sm1610250ooc.21.2021.08.31.14.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 14:39:46 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczy??ski <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20210831192041.GA124936@bjorn-Precision-5520>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <9e31bae7-d7c7-d40a-9782-c59dcaf83798@gmail.com>
Date:   Tue, 31 Aug 2021 16:39:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210831192041.GA124936@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/31/2021 2:20 PM, Bjorn Helgaas wrote:
> On Wed, May 26, 2021 at 08:12:04PM -0500, stuart hayes wrote:
>> ...
>> I made the patch because it was causing the config space for a downstream
>> port to not get restored when a DPC event occurred, and all the NVMe drives
>> under it disappeared.  I found that myself, though--I'm not aware of anyone
>> else reporting the issue.
> 
> This niggles at me.  IIUC the problem you're reporting is that portdrv
> didn't claim a port because portdrv incorrectly assumed the port
> supported bandwidth notification interrupts.  That's all fine, and I
> think this is a good fix.
> 
> But why should it matter whether portdrv claims the port?  What if
> CONFIG_PCIEPORTBUS isn't even enabled?  I guess CONFIG_PCIE_DPC
> wouldn't be enabled then either.
> 
> In your situation, you have CONFIG_PCIEPORTBUS=y and (I assume)
> CONFIG_PCIE_DPC=y.  I guess you must have two levels of downstream
> ports, e.g.,
> 
>    Root Port -> Switch Upstream Port -> Switch Downstream Port -> NVMe
> 
> and portdrv claimed the Root Port and you enabled DPC there, but it
> didn't claim the Switch Downstream Port?
> 

That's correct.  On the system I was using, there was another layer of 
upstream/downstream ports, but I don't think that matters... I had:

Root Port -> Switch Upstream Port (portdrv claimed) -> Switch Downstream 
Port (portdrv did NOT claim) -> Switch Upstream Port (portdrv claimed) 
-> Switch Downstream Port (portdrv claimed) -> NVMe

> The failure to restore config space because portdrv didn't claim the
> port seems wrong to me.
> 

When a DCP event is triggered on the root port, the downstream devices 
get reset, and portdrv is what restores the switch downstream port's 
config space (in pcie_portdrv_slot_reset).

So if portdrv doesn't claim the downstream port, the config space 
doesn't get restored at all, so it won't forward anything to subordinate 
buses, and everything below the port disappears once the DPC event happens.

I'm not really sure how else it would recover from a DPC event, I guess.

> Bjorn
> 
