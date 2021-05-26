Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465D8391E34
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhEZRga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEZRga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 13:36:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99554C061574
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 10:34:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so3986313pjr.0
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=ANKK6/Ab08N6jh/IOr98DH4/SaKPVmGU0kTBJVnKP/c=;
        b=JF3rYV21FKGAfzUzUC2+fmEJePe/sUFoIx1bapEZ0EPQe6elyVoDpmp8GPGpMEgkJR
         LJN5ylKNXCIIhv64TcC7H0qisfYhc1P4J6JNpgMaLFlOTHMa3Q7zV19tuVQ6djv1L+Jk
         rwjvDHO1L1tKM//5nMR/VN03KM4j2CAoNozks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=ANKK6/Ab08N6jh/IOr98DH4/SaKPVmGU0kTBJVnKP/c=;
        b=EYEQmsitjKHVy8ClLkKKW/0/LNQcasT1hobem7sGr8LVHRBJXqUKdPm3QhJtGWbJgZ
         r4CbKs6aiesh/Re3RcLcYeX4n7BUYkNQiwsue/l2E1CMwhGoLcQxxbSkxgsCvUD5Xn5+
         J5zECnZwOoMtg1w+XsAKu/vjeKsyKc7qwvKQjYwiTnymcXPDLnXuj0dZUVF2rmFP1Fg1
         D8hd4BWX8jTOR1pF4nUc4nK1M9t2J2r/3f2pVqvyGjHFoxhiILGJPGoDs8Fr8ieCh7O0
         LrWHMropMTGq/imjteRb8UjsH2sHFGaHioRMXUgmAGvVREBYBNUodVQdU5aVtC5k2xEO
         3/ig==
X-Gm-Message-State: AOAM533d48zQMlArRt4hyvJqQvhXygcaWUbGSaFF3gQFwjyO8nl7oCVl
        Dgl6ddFZLTTvhZOAm02ZrWpjBQ==
X-Google-Smtp-Source: ABdhPJw3GuGK4vqtOwnr+7O6QegSREF4Y4oxQ7b61yqd/IGkvoGg8G7TZ3WK2yNUnyhLs71dZs68Ow==
X-Received: by 2002:a17:902:bb91:b029:fd:6105:c8e6 with SMTP id m17-20020a170902bb91b02900fd6105c8e6mr4385439pls.0.1622050497775;
        Wed, 26 May 2021 10:34:57 -0700 (PDT)
Received: from [10.136.8.240] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c11sm14595682pjr.32.2021.05.26.10.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 10:34:57 -0700 (PDT)
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sandor Bodo-Merle <sbodomerle@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20210520120055.jl7vkqanv7wzeipq@pali>
 <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali>
 <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com>
 <87pmxgwh7o.wl-maz@kernel.org>
 <13a7e409-646d-40a7-17a0-4e4be011efb2@broadcom.com>
 <874keqvsf2.wl-maz@kernel.org>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <964cc65e-5c44-8d29-9c08-013a64a5c6fd@broadcom.com>
Date:   Wed, 26 May 2021 10:34:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <874keqvsf2.wl-maz@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c3ca0205c33f0f03"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000c3ca0205c33f0f03
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 5/26/2021 12:57 AM, Marc Zyngier wrote:
> On Tue, 25 May 2021 18:27:54 +0100,
> Ray Jui <ray.jui@broadcom.com> wrote:
>>
>> On 5/24/2021 3:37 AM, Marc Zyngier wrote:
>>> On Thu, 20 May 2021 18:11:32 +0100,
>>> Ray Jui <ray.jui@broadcom.com> wrote:
>>>>
>>>> On 5/20/2021 7:22 AM, Sandor Bodo-Merle wrote:
> 
> [...]
> 
>>>> I guess I'm not too clear on what you mean by "multi-MSI interrupts
>>>> needs to be aligned to number of requested interrupts.". Would you be
>>>> able to plug this into the above explanation so we can have a more clear
>>>> understanding of what you mean here?
>>>
>>> That's a generic PCI requirement: if you are providing a Multi-MSI
>>> configuration, the base vector number has to be size-aligned
>>> (2-aligned for 2 MSIs, 4 aligned for 4, up to 32), and the end-point
>>> supplies up to 5 bits that are orr-ed into the base vector number,
>>> with a *single* doorbell address. You effectively provide a single MSI
>>> number and a single address, and the device knows how to drive 2^n MSIs.
>>>
>>> This is different from MSI-X, which defines multiple individual
>>> vectors, each with their own doorbell address.
>>>
>>> The main problem you have here (other than the broken allocation
>>> mechanism) is that moving an interrupt from one core to another
>>> implies moving the doorbell address to that of another MSI
>>> group. This isn't possible for Multi-MSI, as all the MSIs must have
>>> the same doorbell address. As far as I can see, there is no way to
>>> support Multi-MSI together with affinity change on this HW, and you
>>> should stop advertising support for this feature.
>>>
>>
>> I was not aware of the fact that multi-MSI needs to use the same
>> doorbell address (aka MSI posted write address?). Thank you for helping
>> to point it out. In this case, yes, like you said, we cannot possibly
>> support both multi-MSI and affinity at the same time, since supporting
>> affinity requires us to move from one to another event queue (and irq)
>> that will have different doorbell address.
>>
>> Do you think it makes sense to do the following by only advertising
>> multi-MSI capability in the single CPU core case (detected runtime via
>> 'num_possible_cpus')? This will at least allow multi-MSI to work in
>> platforms with single CPU core that Sandor and Pali use?
> 
> I don't think this makes much sense. Single-CPU machines are an oddity
> these days, and I'd rather you simplify this (already pretty
> complicated) driver.
> 

Here's the thing. All Broadcom ARMv8 based SoCs have migrated to use
either gicv2m or gicv3-its for MSI/MSIX support. The platforms that
still use iProc event queue based MSI are only legacy ARMv7 based
platforms. Out of them:

NSP - dual core
Cygnus - single core
HR2 - single core

So based on this, it seems to me that it still makes sense to allow
multi-msi to be supported on single core platforms, and Sandor's company
seems to need such support in their particular use case. Sandor, can you
confirm?

>>> There is also a more general problem here, which is the atomicity of
>>> the update on affinity change. If you are moving an interrupt from one
>>> CPU to the other, it seems you change both the vector number and the
>>> target address. If that is the case, this isn't atomic, and you may
>>> end-up with the device generating a message based on a half-applied
>>> update.
>>
>> Are you referring to the callback in 'irq_set_addinity" and
>> 'irq_compose_msi_msg'? In such case, can you help to recommend a
>> solution for it (or there's no solution based on such architecture)? It
>> does not appear such atomy can be enforced from the irq framework level.
> 
> irq_compose_msi_msg() is only one part of the problem. The core of the
> issue is that the programming of the end-point is not atomic (you need
> to update a 32bit payload *and* a 64bit address).
> 
> A solution to workaround it would be to rework the way you allocate
> the vectors, making them constant across all CPUs so that only the
> address changes when changing the affinity.
> 

Thanks. This makes sense. And it looks like this can be addressed
separately from the above issue. I'll have to allocate time to work on
this. In addition, I'd also need someone else with the NSP dual-core
platform to test it for me since we don't have these legacy platforms in
our office anymore.

> Thanks,
> 
> 	M.
> 

--000000000000c3ca0205c33f0f03
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
gdQwLwYJKoZIhvcNAQkEMSIEIJUdOnCM6gaQGyITwHO6TyJLOmeUqTK5lQBTiKEm/IOTMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDUyNjE3MzQ1OFowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQB90Zgy3a1l2QrSYgTt/u/4RAY9C1NBh4cJLIOaoKE++Tw+jjpIVOy1DUFxN5suDGrFvZED
GivuPXdbK+KYNS7ZZmTQ52hRrz+mxWv6UcX0p2x4pQjycZlMWLDrpbNlLDrECiB8fQMv4RI+xqim
Bqj85ERmLzHNvulZG/7jh/sCarOT3ACXJ5RdwJ129PkbEb0lDpFzzPhT0I/Uxwl6JDMBpGepoucc
9lw34j0XaK8XtArEM+4gWzUK6fsr5Km/zXla4hhhDL7vno5JxBi+2jameW1lROsJjVaKyIE/gpXX
GULsW11E1RNah0QL2LcDJQ534sJyTNqiRy77byP0Q1X8
--000000000000c3ca0205c33f0f03--
