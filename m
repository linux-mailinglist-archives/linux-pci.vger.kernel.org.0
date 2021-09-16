Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710940D2CF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 07:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhIPFOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 01:14:52 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60040
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234246AbhIPFOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 01:14:51 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 59F273F077
        for <linux-pci@vger.kernel.org>; Thu, 16 Sep 2021 05:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631769210;
        bh=hSiD7I+b6Yuq8W+sJ8bufKGiKQgP8tTvc9YDJ5YkefU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ns7vLkOwDC4CWhDdYloFYk55l8ZGf3Ha/rGHPNmPBm+GzO3eczEVzsSSKj5GaMZpn
         0I9vURCGKB5oqNVCTJuuVJzAywFKY6asrGcYWp/Xhl+X2oHTDkQO+IRuyYn1zz5mKQ
         9YSTy/mEfVcAYnGP80uxUrBsgQ0i0i3PSe0XQeO8trA4ONcyQyzqfnEulCQeTIT0fC
         Gk0nR2g9Jswfwk1FF34EFwBAjbjhK1j5+p56CsbcetFbmje9U1ezuaEbNU+10I2Hlp
         6xSIbgDJhHwROwPIHT7Fi2F4X1mNB7fkT7nPUoq+ExWAbRNBRAGjIph67Rnzj33sNQ
         LjZplmLgjaBhQ==
Received: by mail-pl1-f197.google.com with SMTP id e2-20020a17090301c200b0013b8b16c22cso2467169plh.5
        for <linux-pci@vger.kernel.org>; Wed, 15 Sep 2021 22:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSiD7I+b6Yuq8W+sJ8bufKGiKQgP8tTvc9YDJ5YkefU=;
        b=Ia1q01OFmBvzA1Js5B5BEcJTljs9NU6vRtBdJCM81xZTbJ+IWaCj82b0Cd/BDOhltQ
         qHQdkA83KL50d0vZu7DrclS3QXIeCB1DE7FZ0e8Ke6TATtX/xU/5cR42K8t+v4mCHZtk
         YGmT97cxEEDAna4pXGXDAugdfYaLm77jl4oecQpMWVVGD1k87xoRMar62Os2hsLzKcrB
         pb8u3iTRkMKiu2Hn5N0XHLGk1JK1+5qBH/stGyQjR5at/USDdW+Y8Cs+FekyOONgaV4l
         H1Fhv8neUUQ1yCg48UrGX6S3mG7VtmdOJBdHkF7St8zRvURgWN9nnRckJ+cpwI8VkFD2
         FonQ==
X-Gm-Message-State: AOAM531evo4dlSIEqS81S1QzAcnOvrPU0OrIob08Vh6xaNxU02Qz+PVY
        UCTeajHMSb/1ecy4hwZC6yDnQ9KgvSdIpszOamcXv1YHQrrrF2ffpAkdLkYsPB1fvNUlJRcy0/G
        QvmwTZ8dOVdAbaPDlkKsQlFD3KLwMtmUHbHQ5HQ==
X-Received: by 2002:a17:903:1208:b0:13a:8c8:8a33 with SMTP id l8-20020a170903120800b0013a08c88a33mr2955893plh.89.1631769208656;
        Wed, 15 Sep 2021 22:13:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL+9MLr7N9W7Q9KOrVaSyEil3UeLX/dMrujMKOIQ5bZoFKNvaH6rKNCaPbQBEkbICsbNCmXQ==
X-Received: by 2002:a17:903:1208:b0:13a:8c8:8a33 with SMTP id l8-20020a170903120800b0013a08c88a33mr2955869plh.89.1631769208277;
        Wed, 15 Sep 2021 22:13:28 -0700 (PDT)
Received: from [192.168.1.107] (125-237-197-94-fibre.sparkbb.co.nz. [125.237.197.94])
        by smtp.gmail.com with ESMTPSA id z9sm1443369pfn.22.2021.09.15.22.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 22:13:27 -0700 (PDT)
Subject: Re: [PROBLEM] Frequently get "irq 31: nobody cared" when passing
 through 2x GPUs that share same pci switch via vfio
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, nathan.langford@xcelesunifiedtechnologies.com
References: <d4084296-9d36-64ec-8a79-77d82ac6d31c@canonical.com>
 <20210914104301.48270518.alex.williamson@redhat.com>
 <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
 <20210915103235.097202d2.alex.williamson@redhat.com>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Message-ID: <4d9d0366-1769-691f-fcb0-3b14d468e36e@canonical.com>
Date:   Thu, 16 Sep 2021 17:13:21 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915103235.097202d2.alex.williamson@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/09/21 4:32 am, Alex Williamson wrote:
> On Wed, 15 Sep 2021 16:44:38 +1200
> Matthew Ruffell <matthew.ruffell@canonical.com> wrote:
>> On 15/09/21 4:43 am, Alex Williamson wrote:
>>>
>>> FWIW, I have access to a system with an NVIDIA K1 and M60, both use
>>> this same switch on-card and I've not experienced any issues assigning
>>> all the GPUs to a single VM.  Topo:
>>>
>>>  +-[0000:40]-+-02.0-[42-47]----00.0-[43-47]--+-08.0-[44]----00.0
>>>  |                                           +-09.0-[45]----00.0
>>>  |                                           +-10.0-[46]----00.0
>>>  |                                           \-11.0-[47]----00.0
>>>  \-[0000:00]-+-03.0-[04-07]----00.0-[05-07]--+-08.0-[06]----00.0
>>>                                              \-10.0-[07]----00.0
> 
> 
> I've actually found that the above configuration, assigning all 6 GPUs
> to a VM reproduces this pretty readily by simply rebooting the VM.  In
> my case, I don't have the panic-on-warn/oops that must be set on your
> kernel, so the result is far more benign, the IRQ gets masked until
> it's re-registered.
> 
> The fact that my upstream ports are using MSI seems irrelevant.

Hi Alex,



It is good news that you can reproduce an interrupt storm locally. Did a single

reboot trigger the storm, or did you have to loop the VM a few times?



On our system, if we don't have panic-on-warn/oops set, the system will

eventually grind to a halt and lock up, so we try to reset earlier on the first

oops, but we still get stuck in the crashkernel copying the IR tables from dmar.

> 
> Adding debugging to the vfio-pci interrupt handler, it's correctly
> deferring the interrupt as the GPU device is not identifying itself as
> the source of the interrupt via the status register.  In fact, setting
> the disable INTx bit in the GPU command register while the interrupt
> storm occurs does not stop the interrupts.
> 

Interesting. So the source of the interrupts could be from the PEX switch

itself?



We did a run with DisIntx+ set on the PEX switches, but it didn't make any

difference. Serial log showing DisIntx+ and full dmesg below:



https://paste.ubuntu.com/p/n3XshCxPT8/

> The interrupt storm does seem to be related to the bus resets, but I
> can't figure out yet how multiple devices per switch factors into the
> issue.  Serializing all bus resets via a mutex doesn't seem to change
> the behavior.

Very interesting indeed.

> I'm still investigating, but if anyone knows how to get access to the
> Broadcom datasheet or errata for this switch, please let me know.

I have tried reaching out to Broadcom asking for the datasheet and errata, but

I am unsure if they will get back to me.



They list the errata as publicly available on their website, in the 

Documentation > errata tab.

https://www.broadcom.com/products/pcie-switches-bridges/pcie-switches/pex8749#documentation



The file "PEX 8749/48/47/33/32/25/24/23/17/16/13/12 Errata" seems to be missing

though.

https://docs.broadcom.com/docs/PEX8749-48-47-33-32-25-24-23-17-16-13-12%20Errata-and-Cautions



An Intel document talks about the errata for the PEX 8749:

https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/rn/rn-ias-n3000-n.pdf

It links to the following URL, also missing.

https://docs.broadcom.com/docs/pub-005018



I did however find an older errata document at:



PEX 87xx Errata Version 1.14, September 25, 2015

https://docs.broadcom.com/doc/pub-005017



I will keep trying, and I will let you know if we manage to come across any

documents.



Thank you for your efforts.

Matthew

> Thanks,
> Alex
> 
