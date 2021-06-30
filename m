Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9953B8A55
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 00:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhF3WMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 18:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232513AbhF3WMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 18:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625091002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ReCbrtMP/cxLMRe/lZJL4GXF42nMx1vpMXEPSI0hvQ=;
        b=KAkRhiD8lqEvL133a/SsRTuJ3V3X6QTJbHgZDmSbP5Fo4A9hp4Rg8tb+AximmvOuFzsUrH
        XVggwiAQVukZO+7MhQJ/1ceKftRhCprdXfPu1UecDbuC8RWTrt7HPooQ6XTcK5F5rjmohq
        haIbDGgRzphVCvhpPbVn3gi026jO7JE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-rCztVIqCPHyV8HPh9BPeLQ-1; Wed, 30 Jun 2021 18:10:01 -0400
X-MC-Unique: rCztVIqCPHyV8HPh9BPeLQ-1
Received: by mail-wm1-f72.google.com with SMTP id t82-20020a1cc3550000b02901ee1ed24f94so3541390wmf.9
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 15:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ReCbrtMP/cxLMRe/lZJL4GXF42nMx1vpMXEPSI0hvQ=;
        b=Z5yb+mlkolkOk98dzKhF1zugLk5Ip8YHzx2Qa397uDlVSUutRaz7sJndR1/7a9PA3l
         8r9xFj0M6tFgiwjpLyJS8QZ+Ul18X0D6xCRG2CdOJ+AaHi0+ybF2e5n6q9gU2NLXmgJf
         F9dq0Sz5xa6QqQ09EJdaGZLmQwpL5ekdGoBdZF+0Q/r9G1brJde6dKz21Q+6kSX3KRiP
         +F/FF7mu3L2kki2svDdy1meYWDyuMf8Kgap4ROEZR0J4r7ElM5adjXpOqBFvJOeON7qm
         pmxCUqj6jk1n1nr0Qht/Ppj279+OmSgdsm87GPqFyCqHt6m8MI3lGf4U2A/0LPOPkkB3
         Rw8Q==
X-Gm-Message-State: AOAM532sAmNU+dx9g2HdrTqIDsHvUz92b65Cga8fd+7r44ctRyDgMuxj
        tnueWDD/Y0uxhcqp/0Zmtk3EddUe3RBw51dVifVHmdxLcv43DyjuGzzmGrfYbacco0Slrkbe3BA
        pZO2WwkK2l65Ee7FuVyM9
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr16882648wmg.117.1625091000111;
        Wed, 30 Jun 2021 15:10:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlU5TtFXVLyohpWwUCLVR70qKXp8D+c6+g8CDe44j7e9CNHSYRynn3Hnx7Cwjxfz20NWN+Rw==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr16882631wmg.117.1625090999901;
        Wed, 30 Jun 2021 15:09:59 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d17sm9611715wro.93.2021.06.30.15.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 15:09:59 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210630203030.GA4178852@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <51276875-658e-e6fe-5433-b5d795b253ff@redhat.com>
Date:   Thu, 1 Jul 2021 00:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630203030.GA4178852@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/30/21 10:30 PM, Bjorn Helgaas wrote:
> On Wed, Jun 30, 2021 at 09:59:58PM +0200, Javier Martinez Canillas wrote:

[snip]

>>
>> But maybe you can also add a paragraph that mentions the CONFIG_DEBUG_SHIRQ
>> option and shared interrupts? That way, other driver authors could know that
>> by enabling this an underlying problem might be exposed for them to fix.
> 
> Good idea, thanks!  I added this; is it something like what you had in
> mind?
> 

Thanks a lot for doing this rewording. I just have a small nit for the text.

>     Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ handler when it
>     is being unregistered.  An error during the probe path might cause this
>     unregistration and IRQ handler execution before the device or data
>     structure init has finished.
> 

The IRQ handler is not called when unregistered, but it is called when another
handler for the shared IRQ is unregistered. In this particular driver, both a
"pcie-sys" and "pcie-client" handlers are registered, then an error leads to
"pcie-sys" being unregistered and the handler for "pcie-client" being called.

So maybe the following instead?

    Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ handlers when a
    handler for the shared IRQ is unregistered. An error during the probe path
    might cause this unregistration and handler execution before the device or
    data structure init has finished.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

