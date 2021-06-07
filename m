Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DBB39E44E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGQsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 12:48:42 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:40490 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGQsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 12:48:41 -0400
Received: by mail-pg1-f182.google.com with SMTP id j12so14248682pgh.7
        for <linux-pci@vger.kernel.org>; Mon, 07 Jun 2021 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=CRdtLkea/MT9XS0CUDAF+Q6nH/g1tmPXsXHY97pKA1U=;
        b=HgWCABa+8cC10ypYdM5TJnbVH8WCdZfmyo67T9CDdgcWgWnfBOxJ4TB/jz4ydNuZld
         bPEHTecV6udgVwoyd5lyj56GT9PIzCBMbWwfpQQF4grC8Ru4BHxFELbp7MwCxXVxHwUT
         3QBBzLJBGNB0cteSX0zeB2Nch6XektTOyF1Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=CRdtLkea/MT9XS0CUDAF+Q6nH/g1tmPXsXHY97pKA1U=;
        b=Z5HqY5/oQq8HImxk0wUWENWP1htn1FfDviVMYk1hwODMkZhsonLjFtUM8lTl2fSuR5
         tbvLF2DYgmkH7XL4tDMxfDi7yhVwfAxP6ybqJHTNx3JzOVuRSNEuv3oRdcl7mSbJZl3K
         fOP8zE9JIbQW4qw7q2VlzTE1y+8VZ7+9+HAdEFS6TKyHjeWWpOhLO/rrVHd3UIinV2u4
         y6sQZHKM7k5/K8xSy/U7m+gMpp+VtDRQJf8nxKio30v/g2r0rtJoO1dc7Kk9m4nPyl17
         GpZX2B7jSViu2IJRQyf/aGtpRdS7kweC1MHcT4lcj7nojzJ5aYN38FDBzFHIcistfZl4
         droQ==
X-Gm-Message-State: AOAM5323k5GbgxK7FOqDmtCOpEEjKKb60NiAqknUBU8S5CrBGAqbbY4g
        2D5hsbgNaNzA0r6sgb5s5cmDQ319U4A/CJ+P
X-Google-Smtp-Source: ABdhPJz/4IY+XutdSDHwO3UNDNLu/Z0XQy1/Y8T393+ZXPfENURUDTqVZesIn+POUmSrn81ZonvA5Q==
X-Received: by 2002:aa7:96fc:0:b029:2e9:e827:928f with SMTP id i28-20020aa796fc0000b02902e9e827928fmr17798383pfq.49.1623084349857;
        Mon, 07 Jun 2021 09:45:49 -0700 (PDT)
Received: from [192.168.1.240] (d64-180-180-231.bchsia.telus.net. [64.180.180.231])
        by smtp.gmail.com with ESMTPSA id z17sm8587106pfq.218.2021.06.07.09.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 09:45:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCI: iproc: fix the base vector number allocation for
 multi-MSI
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20210606123044.31250-1-sbodomerle@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <89d35f7f-48b2-e117-d7b3-b1ccdec30b4e@broadcom.com>
Date:   Mon, 7 Jun 2021 09:45:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606123044.31250-1-sbodomerle@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000025f53305c42fc60f"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000025f53305c42fc60f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 6/6/2021 5:30 AM, Sandor Bodo-Merle wrote:
> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> introduced multi-MSI support with a broken allocation mechanism (it failed
> to reserve the proper number of bits from the inner domain).  Natural
> alignment of the base vector number was also not guaranteed.
> 
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> Reported-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index eede4e8f3f75..557d93dcb3bc 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -252,18 +252,18 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
>  
>  	mutex_lock(&msi->bitmap_lock);
>  
> -	/* Allocate 'nr_cpus' number of MSI vectors each time */
> -	hwirq = bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vecs, 0,
> -					   msi->nr_cpus, 0);
> -	if (hwirq < msi->nr_msi_vecs) {
> -		bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
> -	} else {
> -		mutex_unlock(&msi->bitmap_lock);
> -		return -ENOSPC;
> -	}
> +	/*
> +	 * Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI vectors
> +	 * each time
> +	 */
> +	hwirq = bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
> +					order_base_2(msi->nr_cpus * nr_irqs));
>  
>  	mutex_unlock(&msi->bitmap_lock);
>  
> +	if (hwirq < 0)
> +		return -ENOSPC;
> +
>  	for (i = 0; i < nr_irqs; i++) {
>  		irq_domain_set_info(domain, virq + i, hwirq + i,
>  				    &iproc_msi_bottom_irq_chip,
> @@ -284,7 +284,8 @@ static void iproc_msi_irq_domain_free(struct irq_domain *domain,
>  	mutex_lock(&msi->bitmap_lock);
>  
>  	hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq);
> -	bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> +	bitmap_release_region(msi->bitmap, hwirq,
> +			      order_base_2(msi->nr_cpus * nr_irqs));
>  
>  	mutex_unlock(&msi->bitmap_lock);
>  
> 

Looks good to me too. Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>

--00000000000025f53305c42fc60f
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
gdQwLwYJKoZIhvcNAQkEMSIEICkvHIP2RiOTPdfkG6Rn+qwRm0fTFEmvOOieybGqPx+qMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDYwNzE2NDU1MFowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAnHiHYr1kqC6Ynuy8D6JCkJihLP//f84o4MWvlY9SXuyf3HfaqnyzqIURs37xPPAClKsON
y2c00ItBrDkC9aQcm5n8yfA2nOR5VF3GFSCc4Ht4sKGNNgKvAYYxEx/VcOHep6Sh0SG4vIfJgseC
rzXgbeWiGhy/CHMLVCQAo2LuzZw+CIqPT0NjS3IgXdHAzfDC3pz7h2nlCRMjYvlfURphB7uxBVfM
woLtV4qXEHDg8Mya0FXqN9abPMOfmfCmZs4CCBZA49XSl8rGG4hhlAA2p/AUXNq/BS19GzC6x/Zo
wtjPihe05DodSvqvp6JYuhkFXM4994aJ+lf3/px5dowr
--00000000000025f53305c42fc60f--
