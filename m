Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA34404A1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ2VJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2VJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 17:09:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE7C061570;
        Fri, 29 Oct 2021 14:06:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k2-20020a17090ac50200b001a218b956aaso8179956pjt.2;
        Fri, 29 Oct 2021 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H4LjgedCQrSzDrKUcs+hHmsFFJ7P9Vd1VmkFO2vQoiU=;
        b=pg69LCnmdeQm5g1/gZYfnsWc9m0bQiWW+tI6D17boy8N0FPlQ5NsU/CdEI2Ty5oDNH
         ZblgvX4CAWjTKcZ2vaZqQHPCypNHHk+ztY9fvIjPWez/WcfAcqTS+HCVLcbhdZgLOAiv
         UZ+tInoe6y0HVzrLfMn39BXsEFwcsGUhUY5wxcb+U62Wu2g1SMg0K4bIEax0TrX495AG
         d+ML9vOPVw3WArZ1SG7HI7lSEqXipBjQIjsj/3UYOQjD4aS9620rvGwCzs9UFeJg/pF9
         JIxedfsthz1WEjIYH+NmgbkCrUSb53Ei22HahkAf2m8O2xaZgj1zwCjOusCbBu+3U71f
         uXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H4LjgedCQrSzDrKUcs+hHmsFFJ7P9Vd1VmkFO2vQoiU=;
        b=R1Zf9yEnNXjb8j4b0witYUOYjXOo8YlNseRgHVAg/cz/Pdstn7FU4avDDpOU2Ov1m1
         VxW/GIux4DNJrLUQBBq0jC8tN+hZW22JrNqcj7vVjV7BdIRGF0Ei/l23aJH45iFgjWWS
         hLBWg6bhYCsqmhW1wC35MTjAPyve+uSIJBmNEyssDtA0IRsGf8ar3oOCuUAt8GgPOEq2
         WPyYniTiVHS1BeMH1m7WD4pHoRmbCUUAU1qSeTTDro51ktUGxmfxX83sbkUXZQMOqpo6
         mvrUsnv/eWsGbuF7BbU3UHvPXhxfKoz3j901KX6lcQpHgFaYcrrkKz2MkjvvEb4mz6VR
         usXQ==
X-Gm-Message-State: AOAM532lsw4Ws7mqhnSj1F8tHGBnZKMow/HzBGsDzHInbOfge/V47TBQ
        x4yoP73H95I29dH9XycYuUvYI3094BA=
X-Google-Smtp-Source: ABdhPJybo1twgGsYP2HA2civOxjzbVo1O5huUSG6y20RhnbwJMKzxUUGW+E5big97stN2ZqDJhrMMA==
X-Received: by 2002:a17:90a:917:: with SMTP id n23mr15253801pjn.131.1635541593178;
        Fri, 29 Oct 2021 14:06:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f11sm8465753pfe.172.2021.10.29.14.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 14:06:32 -0700 (PDT)
Subject: Re: [PATCH v6 1/9] dt-bindings: PCI: correct brcmstb interrupts,
 interrupt-map.
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211029200319.23475-1-jim2101024@gmail.com>
 <20211029200319.23475-2-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cead3cd7-67c6-56da-860e-7b9a2415959e@gmail.com>
Date:   Fri, 29 Oct 2021 14:06:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029200319.23475-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/29/21 1:03 PM, Jim Quinlan wrote:
> The "pcie" and "msi" interrupts were given the same interrupt when they are
> actually different.  Interrupt-map only had the INTA entry; the INTB, INTC,
> and INTD entries are added.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I will submit a fix for arch/arm/boot/dts/bcm2711.dtsi shortly, since it
has the same issues as the example you are fixing, thanks!
-- 
Florian
