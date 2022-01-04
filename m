Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD404847EE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiADSes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 13:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiADSer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 13:34:47 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411BC061784
        for <linux-pci@vger.kernel.org>; Tue,  4 Jan 2022 10:34:47 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 8so32958291pfo.4
        for <linux-pci@vger.kernel.org>; Tue, 04 Jan 2022 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=GzEVmErBJKRI0yBChgZfu8dZqEDJdECzAPzSwAyx5Dc=;
        b=Vwpu5UCyxnDdX5/p7kjwjsRJTGa2X2cEuIFxj3B0XFnmuDdra6pDA5uMUX4Q983CQN
         GPecLFNeJQ718nOWTu7vSj+0ZjJRXBBnC1rUrf8B2kz/tWIHIC28aX/0ON6I81CKbE7j
         wZshSH994LpYxcT1Has5aPkvLg4j/dlKCsuMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=GzEVmErBJKRI0yBChgZfu8dZqEDJdECzAPzSwAyx5Dc=;
        b=o0AWGyAlBZKqZ6mith92Q6J2sOx50a8T0BFLOloA6Tz60RheLfUlojMd1W7KgklixP
         T6GA5vQ0xKeP3NienLMlWbyBXscBfMJDQItb7QCuNb49oCBKFLMxvhDJGQD0cEJ4nIsR
         ZVXDwmkR5+McWYzLjIe+RcYdKqlW4xW7qyEupQ3bjWzRjN03o8h8KURJYF6gAeiN8FFI
         jyeRtSp8g7u2ryYwlMnOTxbzEkIrwgKKKzc5qqSYsw9Fp41N4/LrOle9+Opbj7FLAdvy
         UqmSPeN9AbYRcn3DMB18Nk4SM67cNpyV7/hu4lHkejIcEog0YpiYaXNRLTIuazDXE/eV
         p9pQ==
X-Gm-Message-State: AOAM530cQjNeE8VEjQiMoBLh3dpaMspIM+H/JSFlFA1NXP4ntFFJNHkb
        TI4UciaBaLC0ZkVMWxamR5H02g==
X-Google-Smtp-Source: ABdhPJz4uLAkhfLyR6EYx6OhDFJcpP0WSq2qKGbxiQzIg90flakGxqxoI+j4LAOlcfqeekTtmmcpYg==
X-Received: by 2002:a62:75c6:0:b0:4bb:6e45:89c1 with SMTP id q189-20020a6275c6000000b004bb6e4589c1mr51991843pfc.6.1641321286735;
        Tue, 04 Jan 2022 10:34:46 -0800 (PST)
Received: from [10.136.8.222] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h10sm18442923pgi.56.2022.01.04.10.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:34:45 -0800 (PST)
Message-ID: <c8c8942a-3247-4ac8-8878-9a5406480316@broadcom.com>
Date:   Tue, 4 Jan 2022 10:34:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 11/23] PCI: iproc: Rename iproc_pcie_bcma_ to
 iproc_bcma_pcie_
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <20211223011054.1227810-1-helgaas@kernel.org>
 <20211223011054.1227810-12-helgaas@kernel.org>
From:   Ray Jui <ray.jui@broadcom.com>
In-Reply-To: <20211223011054.1227810-12-helgaas@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000047902305d4c5e4a3"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000047902305d4c5e4a3
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/2021 5:10 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename iproc_pcie_bcma_* to iproc_bcma_pcie_* for consistency with other
> drivers.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/pci/controller/pcie-iproc-bcma.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
> index f918c713afb0..54b6e6d5bc64 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
> @@ -23,7 +23,7 @@ static void bcma_pcie2_fixup_class(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8011, bcma_pcie2_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);
>  
> -static int iproc_pcie_bcma_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +static int iproc_bcma_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	struct iproc_pcie *pcie = dev->sysdata;
>  	struct bcma_device *bdev = container_of(pcie->dev, struct bcma_device, dev);
> @@ -31,7 +31,7 @@ static int iproc_pcie_bcma_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return bcma_core_irq(bdev, 5);
>  }
>  
> -static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
> +static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
>  {
>  	struct device *dev = &bdev->dev;
>  	struct iproc_pcie *pcie;
> @@ -64,33 +64,33 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>  	if (ret)
>  		return ret;
>  
> -	pcie->map_irq = iproc_pcie_bcma_map_irq;
> +	pcie->map_irq = iproc_bcma_pcie_map_irq;
>  
>  	bcma_set_drvdata(bdev, pcie);
>  
>  	return iproc_pcie_setup(pcie, &bridge->windows);
>  }
>  
> -static void iproc_pcie_bcma_remove(struct bcma_device *bdev)
> +static void iproc_bcma_pcie_remove(struct bcma_device *bdev)
>  {
>  	struct iproc_pcie *pcie = bcma_get_drvdata(bdev);
>  
>  	iproc_pcie_remove(pcie);
>  }
>  
> -static const struct bcma_device_id iproc_pcie_bcma_table[] = {
> +static const struct bcma_device_id iproc_bcma_pcie_table[] = {
>  	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_NS_PCIEG2, BCMA_ANY_REV, BCMA_ANY_CLASS),
>  	{},
>  };
> -MODULE_DEVICE_TABLE(bcma, iproc_pcie_bcma_table);
> +MODULE_DEVICE_TABLE(bcma, iproc_bcma_pcie_table);
>  
> -static struct bcma_driver iproc_pcie_bcma_driver = {
> +static struct bcma_driver iproc_bcma_pcie_driver = {
>  	.name		= KBUILD_MODNAME,
> -	.id_table	= iproc_pcie_bcma_table,
> -	.probe		= iproc_pcie_bcma_probe,
> -	.remove		= iproc_pcie_bcma_remove,
> +	.id_table	= iproc_bcma_pcie_table,
> +	.probe		= iproc_bcma_pcie_probe,
> +	.remove		= iproc_bcma_pcie_remove,
>  };
> -module_bcma_driver(iproc_pcie_bcma_driver);
> +module_bcma_driver(iproc_bcma_pcie_driver);
>  
>  MODULE_AUTHOR("Hauke Mehrtens");
>  MODULE_DESCRIPTION("Broadcom iProc PCIe BCMA driver");
> 

Acked-by: Ray Jui <ray.jui@broadcom.com>

--00000000000047902305d4c5e4a3
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
gdQwLwYJKoZIhvcNAQkEMSIEIGSFPRXbJr5a3o7/4TKevaTeaWlXSB9fw9q6x/+r/dLBMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDEwNDE4MzQ0N1owaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAxat8Z2BKU37XpuvmL/9WtRznwIFZszkdCJ9fu8vtlLM7HLHvkTZTEZCTT5Ivkc+irkCGq
ImnM1QiBSLanbTk7WqmZWFsBuicaik9ROSZxlMKpIiMBeUKUDOwUGtr8CPNQ2zTh8eHTdE5H8xnS
0sjI3mhvgEzULaoXxWyFY4DRxeSm1NuIbS4qFJ6+BTZczfm7Jz9hIkFYHZMMGuvkMmm0bX0HZmIg
Um7BIktmgkZhKSMSpTOXD/uJF+9GIbaGT8FkcYauRTn64GRwydRA8FugsVSvNwyCMzAqtR3VAC4M
UbCvEWiHazvNc7gg89t8fYlfL2bFmhkrHq/PlkRczoJq
--00000000000047902305d4c5e4a3--
