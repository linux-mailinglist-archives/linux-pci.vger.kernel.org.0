Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A387C39E478
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhFGQuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGQuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 12:50:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472DDC061766
        for <linux-pci@vger.kernel.org>; Mon,  7 Jun 2021 09:48:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i34so7840469pgl.9
        for <linux-pci@vger.kernel.org>; Mon, 07 Jun 2021 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=G9dJ+IlO+LEAaNeAbGXY3yXgyascYmPVMAQohwo67zk=;
        b=TFJOA7xcFOvcGT65ZqRHcqWQteAGPoUZSnN9CHAH0vbgHg34tcessqv/L+6k9Ikcei
         pwYo9itsAkXNOq4O1p6d8uPsif82BdHxCwAzF7Fv2WGccozgMqKiReTW5+YoDRGRV6VR
         wbfObYkkrE1xAnAFmSo1AvK7Nl9MkfcTtl3hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=G9dJ+IlO+LEAaNeAbGXY3yXgyascYmPVMAQohwo67zk=;
        b=cFOFn5QozK+Ma8Dt1L8EcoWzuEMI3JPz0cXWSxPpVOQacnCmcb53Lvr47fLTNcRZIM
         sSMH0BbBh50/cjCXC6AQSkAGIbWHr2z6RasEikfGs3/c7hD8O35gCoRDGMvU8ZFnM7/V
         j+LNZRNGWDK7x5fxRWbNnvIDR5aRmi90IcoQ3lZ4rUUEcZrbX+f91Gq2xwabsl8GguO3
         jT5z1d6gqDnw1uhrY5NNFIjkSYHjy/YWonsnuAoTbWZ7LDgg9P8m1n1ajusiKl1j1IV3
         BeyWe4iNQe7LhiecQpVK4xaJ6ixZm8jIMmtIa/hWnswBsK/B1slggpc7dPZHuAdDq2GM
         0ecw==
X-Gm-Message-State: AOAM533lSTBT9E6IjdwXiJsV+UH8GfLy9MXBUdSpOA+hUrI5uMjqEwYC
        f+b7uk29Z4MB6J43+uEg0UHaF5Ow2UXBlMLs
X-Google-Smtp-Source: ABdhPJxfekAY8IPM5STPcDAWnk8aPO4voMZVkbsbh0gmnruyESjseirrf3AhGk89zXuKyYr+qUefMg==
X-Received: by 2002:a63:2bd0:: with SMTP id r199mr18651015pgr.395.1623084501675;
        Mon, 07 Jun 2021 09:48:21 -0700 (PDT)
Received: from [192.168.1.240] (d64-180-180-231.bchsia.telus.net. [64.180.180.231])
        by smtp.gmail.com with ESMTPSA id l3sm9378758pgb.77.2021.06.07.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 09:48:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] PCI: iproc: Support multi-MSI only on uniprocessor
 kernel
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
References: <20210606123044.31250-1-sbodomerle@gmail.com>
 <20210606123044.31250-2-sbodomerle@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <927a977c-5bd5-3df1-c990-d817b0759654@broadcom.com>
Date:   Mon, 7 Jun 2021 09:48:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606123044.31250-2-sbodomerle@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000030bfbf05c42fcff1"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000030bfbf05c42fcff1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 6/6/2021 5:30 AM, Sandor Bodo-Merle wrote:
> The interrupt affinity scheme used by this driver is incompatible with
> multi-MSI as it implies moving the doorbell address to that of another MSI
> group.  This isn't possible for multi-MSI, as all the MSIs must have the
> same doorbell address. As such it is restricted to systems with a single
> CPU.
> 
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> Reported-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 557d93dcb3bc..81b4effeb130 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
>  
>  static struct msi_domain_info iproc_msi_domain_info = {
>  	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> +		MSI_FLAG_PCI_MSIX,
>  	.chip = &iproc_msi_irq_chip,
>  };
>  
> @@ -250,6 +250,9 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
>  	struct iproc_msi *msi = domain->host_data;
>  	int hwirq, i;
>  
> +	if (msi->nr_cpus > 1 && nr_irqs > 1)
> +		return -EINVAL;
> +

This should never happen since the framework would have guarded against
this. But I guess it does not hurt to have the check here.

>  	mutex_lock(&msi->bitmap_lock);
>  
>  	/*
> @@ -540,6 +543,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
>  	mutex_init(&msi->bitmap_lock);
>  	msi->nr_cpus = num_possible_cpus();
>  
> +	if (msi->nr_cpus == 1)
> +		iproc_msi_domain_info.flags |=  MSI_FLAG_MULTI_PCI_MSI;
> +
>  	msi->nr_irqs = of_irq_count(node);
>  	if (!msi->nr_irqs) {
>  		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
> 

Looks fine to me. Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>

--00000000000030bfbf05c42fcff1
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
gdQwLwYJKoZIhvcNAQkEMSIEIEz7i0ScHzgdHOtieT3on91RBeb6hdhZcjLOdItvLAL0MBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDYwNzE2NDgyMlowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBreRKk4+hRrDj5ds0fmvgWCSHPbPviDTTyi6kWVUh8T8NOKPxVpiT4evRwqHI2ewxYpqJv
lEG38Ys7h8jZVCc3hp6G3lIF1oFSdnI+y0go5S+nZcQ75Yk8yF8MBNIR2VyEaRNe+GI8/NauCR6G
y05Tk++eYvggg8ktoxYGXdgkNrr9nDUhZvTZVRJNDtJfDcpnKfYl8PVd8oDbZhzDep+MilU/oyqK
G5icia97koxcWwb5Gennmu0yUKliRV3uOgBAL4AmjVOIFydSB03PUhwqi5dRzXGjCHnyUOfUW7JO
rReAH4pbIFuRL9OlWACZjZqKY4qs+rZ9GQM2IVqyw75T
--00000000000030bfbf05c42fcff1--
