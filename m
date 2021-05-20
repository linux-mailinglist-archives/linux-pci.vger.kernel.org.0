Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1238B4F9
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhETRM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhETRM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 13:12:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D105C061574
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 10:11:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so4246289plf.7
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=kF5W8oW2fiC3hY9wsQvFozPUEdntCjvbS7jvugmld0s=;
        b=JZKSIumgG4Y/7qbI6aS19Fg5HV7BLAGeGf8AmLvpSh4939FchvtvG6I/Ps9+RDd9sW
         FVTmK+gv5EEAEgNMFfndVVJJ8nUmHciQA+UvQiegzMNc5ItBD4QowXNYtnChHjzbzXWk
         FCE1vU48B8weiJ9XXvQBgaTKfEULRwfAN98DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=kF5W8oW2fiC3hY9wsQvFozPUEdntCjvbS7jvugmld0s=;
        b=NabLLrTzjp0nR4pqnB1kRIqnF9l2qrwCu5OPKY9bx2oZZurZtRd9Hl/NsqYyD3jKqh
         7pvdydxJm4moVwijYPiDCI6S9G1t6lB9G7sZMt/fT8qTGlFej1Kag3D+7BrbknhzP5yP
         EequHs9hQIPrhF5oxEzyb/7+KwUjQIfkr8Qw+IobwJPv4ik3dlVFcCxxu1qpsE5wyAdF
         XImP2i8QIK0LhLy0ZX/G0AT28xjZnhGS49ud8WLTyQ09yMG14v2OdBQmqiA3e6Q12DKx
         v5u6JwwdjZGvU9WLQc1O4BSM9+wAbUmMZS52WXHuuglIr2rBYdEkmsD00Pc9fW//mlcE
         C/Lw==
X-Gm-Message-State: AOAM532c73mU49sj23OKkPsgTsEv0FSKOtR1ASG98cnSxBI11Ti/uxzh
        l3Sk8K8rOVWgIXGEvQhiBc883g==
X-Google-Smtp-Source: ABdhPJz5650wyDBbAMutdwpi9diwVW2zvt7BB2MaEuC6+O8iCoCJz/vS9IVfK2Umpg8VG3y/AvHP6A==
X-Received: by 2002:a17:90a:4a89:: with SMTP id f9mr6329433pjh.50.1621530695111;
        Thu, 20 May 2021 10:11:35 -0700 (PDT)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id j21sm7175600pjl.27.2021.05.20.10.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 10:11:34 -0700 (PDT)
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20210520120055.jl7vkqanv7wzeipq@pali>
 <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali>
 <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com>
Date:   Thu, 20 May 2021 10:11:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001da88a05c2c60980"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000001da88a05c2c60980
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 5/20/2021 7:22 AM, Sandor Bodo-Merle wrote:
> On Thu, May 20, 2021 at 4:05 PM Pali Rohár <pali@kernel.org> wrote:
>>
>> Hello!
>>
>> On Thursday 20 May 2021 15:47:46 Sandor Bodo-Merle wrote:
>>> Hi Pali,
>>>
>>> thanks for catching this - i dig up the followup fixup commit we have
>>> for the iproc multi MSI (it was sent to Broadcom - but unfortunately
>>> we missed upstreaming it).
>>>
>>> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
>>> failed to reserve the proper number of bits from the inner domain.
>>> We need to allocate the proper amount of bits otherwise the domains for
>>> multiple PCIe endpoints may overlap and freeing one of them will result
>>> in freeing unrelated MSI vectors.
>>>
>>> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
>>> ---
>>>  drivers/pci/host/pcie-iproc-msi.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-iproc-msi.c
>>> index 708fdb1065f8..a00492dccb74 100644
>>> --- drivers/pci/host/pcie-iproc-msi.c
>>> +++ drivers/pci/host/pcie-iproc-msi.c
>>> @@ -260,11 +260,11 @@ static int iproc_msi_irq_domain_alloc(struct
>>> irq_domain *domain,
>>>
>>>         mutex_lock(&msi->bitmap_lock);
>>>
>>> -       /* Allocate 'nr_cpus' number of MSI vectors each time */
>>> +       /* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI
>>> vectors each time */
>>>         hwirq = bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vecs, 0,
>>> -                                          msi->nr_cpus, 0);
>>> +                                          msi->nr_cpus * nr_irqs, 0);
>>
>> I'm not sure if this construction is correct. Multi-MSI interrupts needs
>> to be aligned to number of requested interrupts. So if wifi driver asks
>> for 32 Multi-MSI interrupts then first allocated interrupt number must
>> be dividable by 32.
>>
> 
> Ahh - i guess you are right. In our internal engineering we always
> request 32 vectors.
> IIRC the multiply by "nr_irqs" was added for iqr affinity to work correctly.
> 

May I ask which platforms are you guys running this driver on? Cygnus or
Northstar? Not that it matters, but just out of curiosity.

Let me start by explaining how MSI support works in this driver, or more
precisely, for all platforms that support this iProc based event queue
MSI scheme:

In iProc PCIe core, each MSI group is serviced by a GIC interrupt
(hwirq) and a dedicated event queue (event queue is paired up with
hwirq).  Each MSI group can support up to 64 MSI vectors. Note 64 is the
depth of the event queue.

The number of MSI groups varies between different iProc SoCs. The total
number of CPU cores also varies. To support MSI IRQ affinity, we
distribute GIC interrupts across all available CPUs.  MSI vector is
moved from one GIC interrupt to another to steer to the target CPU.

Assuming:
The number of MSI groups (the number of total hwirq for this PCIe
controller) is M
The number of CPU cores is N
M is always a multiple of N (we ensured that in the setup function)

Therefore:
Total number of raw MSI vectors = M * 64
Total number of supported MSI vectors = (M * 64) / N

I guess I'm not too clear on what you mean by "multi-MSI interrupts
needs to be aligned to number of requested interrupts.". Would you be
able to plug this into the above explanation so we can have a more clear
understanding of what you mean here?

In general, I don't see much issue of allocating 'msi->nr_cpus *
nr_irqs' here as long as we can still meet the affinity distribution
requirement as mentioned above.

Example in the dw PCIe driver does the following for reserving in the
bitmap:

bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
order_base_2(nr_irqs));

>>>         if (hwirq < msi->nr_msi_vecs) {
>>> -               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
>>> +               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
>>
>> And another issue is that only power of 2 interrupts for Multi-MSI can
>> be allocated. Otherwise one number may be allocated to more devices.
>>
>> But I'm not sure how number of CPUs affects it as other PCIe controller
>> drivers do not use number of CPUs.

As I explained above, we definitely need to take nr_cpus into account,
since we cannot move around the physical interrupt between CPUs.
Instead, we dedicate each physical interrupt to the CPU and service the
MSI across different event queues accordingly when user change irq affinity.

>>
>> Other drivers are using bitmap_find_free_region() function with
>> order_base_2(nr_irqs) as argument.
>>

Yes we should do that too.

>> I hope that somebody else more skilled with MSI interrupts look at these
>> constructions if are correct or needs more rework.
>>
> 
> I see the point - i'll ask also in our engineering department ...
> 
>>>         } else {
>>>                 mutex_unlock(&msi->bitmap_lock);
>>>                 return -ENOSPC;
>>> @@ -292,7 +292,7 @@ static void iproc_msi_irq_domain_free(struct
>>> irq_domain *domain,
>>>         mutex_lock(&msi->bitmap_lock);
>>>
>>>         hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq);
>>> -       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
>>> +       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
>>>
>>>         mutex_unlock(&msi->bitmap_lock);
>>>
>>>
>>> On Thu, May 20, 2021 at 2:04 PM Pali Rohár <pali@kernel.org> wrote:
>>>>
>>>> Hello!
>>>>
>>>> I think there is a bug in pcie-iproc-msi.c driver. It declares
>>>> Multi MSI support via MSI_FLAG_MULTI_PCI_MSI flag, see:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-iproc-msi.c?h=v5.12#n174
>>>>
>>>> but its iproc_msi_irq_domain_alloc() function completely ignores nr_irqs
>>>> argument when allocating interrupt numbers from bitmap, see:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-iproc-msi.c?h=v5.12#n246
>>>>
>>>> I think this this is incorrect as alloc callback should allocate nr_irqs
>>>> multi interrupts as caller requested. All other drivers with Multi MSI
>>>> support are doing it.
>>>>
>>>> Could you look at it?

--0000000000001da88a05c2c60980
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Pi3DQoJNNR5cV1dw3cNMKQyHRziEjFTVmILshClu9AljdXzCUoHXDUbge8TIJ/fK36qTGCYWwA01
rTB3drVX3FZq/Uqo0JnVcyP1dtYVzQIDAQABo4IB1TCCAdEwDgYDVR0PAQH/BAQDAgWgMIGjBggr
BgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9j
YWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8v
b2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBE
MEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20v
cmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2Jh
bHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAfBgNVHREEGDAWgRRyYXku
anVpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU5E1VdIocTRYIpXh6e6OnGvwfrEgwDQYJKoZIhvcNAQEL
BQADggEBADcZteuA4mZVmXNzp/tJky+9TS87L/xAogg4z+0bFDomA2JdNGKjraV7jE3LKHUyCQzU
Bvp8xXjxCndLBgltr+2Fn/Dna/f29iAs4mPBxgPKhqnqpQuTo2DLID2LWU1SLI9ewIlROY57UCvO
B6ni+9NcOot0MbKF2A1TnzJjWyd127CVyU5vL3un1/tbtmjiT4Ku8ZDoBEViuuWyhdB6TTEQiwDo
2NxZdezRkkkq+RoNek6gmtl8IKmXsmr1dKIsRBtLQ0xu+kdX+zYJbAQymI1mkq8qCmFAe5aJkrNM
NbsYBZGZlcox4dHWayCpn4sK+41xyJsmGrygY3zghqBuHPUxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxnTAexrtwIst251kUwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIDaoOnubei2NA8GRI82RfnFg/GnyvxXYXO/S21w5O1iHMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDUyMDE3MTEzNVowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBo3aTGb5RjLs6l5Mozs3RqwtUnDRDkYvXT48nWG6L/ZFKbHHMwlnRmBS9bDg/XSyXpURMX
qauZi46t/M6zZpuz3ZU/08jP10ih/ecDsgAlHU/LPHqxLqHZkrMt+G0/23rLwDOYRpXCoUIs6ezx
TDA9yNp+NSNDFEuZhcveZN+QVFbn13Pg2mXePHnL7B5DQQD4RkqtWXgFIGGlEOVr7P3gU4HrLXTk
DJIDV+2VqE9vg8wEAEepw+apTuuiDCCepB1WtwQuIuM0QimDhZ5wPtfNCeRWHV8iv/UJyhidZ16F
OfwLBuaUMmpBv4f/2KuDlEtBgJaFyFneW9P0yqhvJSDy
--0000000000001da88a05c2c60980--
