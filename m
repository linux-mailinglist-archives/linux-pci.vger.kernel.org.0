Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5770139BD96
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFDQug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 12:50:36 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:40873 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDQug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 12:50:36 -0400
Received: by mail-pj1-f52.google.com with SMTP id jz2-20020a17090b14c2b0290162cf0b5a35so7734214pjb.5
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=8Z/ddpllN+BthqcRI1/6lAChpNxjK3J08p/2Z7tzhPE=;
        b=Z0bSkm+3JAtIpQOUuoHfCLMRtZZ8gTn2BvYQBI+Rn+GnAvIHStc8C8DCKEhYmcIEBE
         0QlADX2Q/4LY/QNHjWg2Z7cB2A3rSdsaB4mc93sgoCdPT4SM1M/jwoUDPW4vWbs3lxb0
         bxzT5b8Afy73ef/bYnkzSfYJSNcXhLttVLmoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=8Z/ddpllN+BthqcRI1/6lAChpNxjK3J08p/2Z7tzhPE=;
        b=klpCS90BhRytRRFR9rtaIUMRmon2xR01RpTaU21I08ArpWzsIskhaFQriDJ9O54LJ9
         zz/SgMwuFK2wleDNi52ca9OT6ODfIad03Xdpo7ceNZEEni8r0+GcViKfbv231i7i6unE
         3FlTGtFhRLHPnAtCIugUhVQEOX8fUcH0rDsn4YzkFkfboQ1aEzFG/xPfGDaFhf29FUKz
         pBNbnmCbHW8JGtt2ZV7bteEjJ2vcEdG78ad5mn6G+dN+UFT2rN0depJeqE0mDg3NJ5JY
         QdFkP3gRXaOTawyU3YCsFMF7q3uyqOXG2dmUA8c3FO55eP0h1iLNL3rJeighXV0tabyv
         Qv+Q==
X-Gm-Message-State: AOAM530bCJks/FG2ZCEUhKeWzEQTyWyD9GoIEWdpcC9CTSCuQFKw9w4P
        Znc8wE8zxpbNiEPptX4Asc6ne5YcT/YCZGow
X-Google-Smtp-Source: ABdhPJxnNfxmdO2VmsSw2UyF/1JLoB63JDxRl4eZKkQY8lPHFTob7NfyHrBR9GqLXwSlJ9udREa2rQ==
X-Received: by 2002:a17:90a:fd86:: with SMTP id cx6mr3543384pjb.148.1622825269747;
        Fri, 04 Jun 2021 09:47:49 -0700 (PDT)
Received: from [10.136.8.240] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 6sm2186483pfw.56.2021.06.04.09.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:47:48 -0700 (PDT)
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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
 <CABLWAfSAq50_WvFrqF0+wjqYx3btBrU1kgms3i9dy8GBm4FcdA@mail.gmail.com>
 <87bl8o1x8c.wl-maz@kernel.org>
 <92a918e6-37cc-8892-a665-4121b3200f00@broadcom.com>
 <CABLWAfS+yGHRc5Qo9FeSK-1JA_Xm8H6pY5wzEcHkyk491kAvvQ@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <4185e424-0ee2-03fb-9dc2-62c16b32a6f0@broadcom.com>
Date:   Fri, 4 Jun 2021 09:47:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABLWAfS+yGHRc5Qo9FeSK-1JA_Xm8H6pY5wzEcHkyk491kAvvQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c6146905c3f3739e"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000c6146905c3f3739e
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 6/4/2021 2:17 AM, Sandor Bodo-Merle wrote:
> Would something like this work on top of the previous patch - or it
> needs more checks,
> like the "nr_irqs" iniproc_msi_irq_domain_alloc() ?
> 
> diff --git drivers/pci/controller/pcie-iproc-msi.c
> drivers/pci/controller/pcie-iproc-msi.c
> index eede4e8f3f75..49e9d1a761ff 100644
> --- drivers/pci/controller/pcie-iproc-msi.c
> +++ drivers/pci/controller/pcie-iproc-msi.c
> @@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
> 
>  static struct msi_domain_info iproc_msi_domain_info = {
>         .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -               MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> +              MSI_FLAG_PCI_MSIX,
>         .chip = &iproc_msi_irq_chip,
>  };
> 
> @@ -539,6 +539,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct
> device_node *node)
>         mutex_init(&msi->bitmap_lock);
>         msi->nr_cpus = num_possible_cpus();
> 
> +       if (msi->nr_cpus == 1)
> +               iproc_msi_domain_info.flags |=  MSI_FLAG_MULTI_PCI_MSI;
> +

That looks right to me. Please also add comments to explain we cannot
support multi-msi and msi affinity at the same time.

Thanks.

>         msi->nr_irqs = of_irq_count(node);
>         if (!msi->nr_irqs) {
>                 dev_err(pcie->dev, "found no MSI GIC interrupt\n");
> 


--000000000000c6146905c3f3739e
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
gdQwLwYJKoZIhvcNAQkEMSIEICp/MfSYOsBdBupi8D4bI0mHQtm4DQnvelPmwfRr4gcJMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDYwNDE2NDc1MFowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCSHQfMRk5QU2DCexPeCAYA82N0wHWY1z8klg1gEKnW7qcMRclE8mGaE4d3CYu+vvhLXxSC
LWTWe47wmaHJbKnI9EPqyh5d38BFD0sRKWW5Up7oXV+24ow4nXzAClywm7V6A4jRns4TfNS/igcU
2tvUo/1j0ZGUXEVAWmxynpNa8WdvxuL6k7l3qDFNtAmDE43bBKgKcvcrw6VxUkDc2uQtVFJlR7Av
0weiwBkbx3fxsgJmtEijd+tZveBvUwNUFNMY0he2xihsxnvKx32um0ebWgjCDr0pUyOBVDf5cA1k
MIkbnpdPCLhTSH2/1k8Rjzz3Jf+hUCAtnkwM7pegICoE
--000000000000c6146905c3f3739e--
