Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B131D4847F0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 19:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiADSfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 13:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiADSfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 13:35:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2DC061761
        for <linux-pci@vger.kernel.org>; Tue,  4 Jan 2022 10:34:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so374562pjo.5
        for <linux-pci@vger.kernel.org>; Tue, 04 Jan 2022 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=1vPkhoAmu6xujyyZqkSCypZZt7iVMBrSLKU4icfyTzs=;
        b=A/7vdr76ac/YTFEfkt/cHqYz4RnTelQzDTWLl6Ot8GEN5MAvA3TOdQKHW5heTlwwij
         rZT874C1TGKb9c+El9ahvsB2/v7+wvT3Gi+8WFngbtCPtRvP5HBqyOVo23L6NVGS/l0q
         lp48INNY9jIJgNjC2RbGQDMQI0DAQ8JwoQsV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=1vPkhoAmu6xujyyZqkSCypZZt7iVMBrSLKU4icfyTzs=;
        b=NwwErwNGAAWB4fNDgU7/V1JkhuQbqbuRfxfo67NzmiNgWvjXcDpmR5eFs98V+FRIkp
         1ibiHgYLeGgtApCc7Lrxd+AxZ5GjS+rl9bjvbjGyscC/Kl2uovgNv2xxBLkU8/s01Jpr
         mjhIvJRii2kSq2Kpup1JJjwd0cBLzZjF6yoyjftCWVfTDpohrmBvOE1zd+X+wv/KYzEz
         de7ZEqu8msTQfFbgRwaPN3DzrdyZHvJeaKkaxyNCO0cTdTSTHf6wBJtmY3JSr1SHw29Y
         g/ZrjivwBRbXyeeKR2JUEgwus3iBx54BCU/gGID9AhFsOzFo7l32lGZuizbEiDQg7MRR
         KW6A==
X-Gm-Message-State: AOAM530TZh9doEH082iyMRAyxQUp+SbzQMACIkzyFvXcAZf3t+5wq2Sx
        jJSi5cBtYovf1PZy1as4BcFleg==
X-Google-Smtp-Source: ABdhPJwfanKPKjVi/4Eq4QtNwbpa7bU90y0Uc3G2cisLOEel4H1i+bNR1YWHNRYBD8G3oNLfII+keg==
X-Received: by 2002:a17:90b:4c48:: with SMTP id np8mr62085778pjb.51.1641321299317;
        Tue, 04 Jan 2022 10:34:59 -0800 (PST)
Received: from [10.136.8.222] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j4sm11274395pfa.149.2022.01.04.10.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:34:59 -0800 (PST)
Message-ID: <567c6e66-1baf-2942-87fc-17c5e0f4b0b9@broadcom.com>
Date:   Tue, 4 Jan 2022 10:34:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 12/23] PCI: iproc: Rename iproc_pcie_pltfm_ to
 iproc_pltfm_pcie_
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
 <20211223011054.1227810-13-helgaas@kernel.org>
From:   Ray Jui <ray.jui@broadcom.com>
In-Reply-To: <20211223011054.1227810-13-helgaas@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000007db8005d4c5e5f4"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000007db8005d4c5e5f4
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/2021 5:10 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename iproc_pcie_pltfm_* to iproc_pltfm_pcie_* for consistency with other
> drivers.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index b93e7bda101b..538115246c79 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -37,7 +37,7 @@ static const struct of_device_id iproc_pcie_of_match_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
>  
> -static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
> +static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct iproc_pcie *pcie;
> @@ -115,30 +115,30 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
> +static int iproc_pltfm_pcie_remove(struct platform_device *pdev)
>  {
>  	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
>  
>  	return iproc_pcie_remove(pcie);
>  }
>  
> -static void iproc_pcie_pltfm_shutdown(struct platform_device *pdev)
> +static void iproc_pltfm_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
>  
>  	iproc_pcie_shutdown(pcie);
>  }
>  
> -static struct platform_driver iproc_pcie_pltfm_driver = {
> +static struct platform_driver iproc_pltfm_pcie_driver = {
>  	.driver = {
>  		.name = "iproc-pcie",
>  		.of_match_table = of_match_ptr(iproc_pcie_of_match_table),
>  	},
> -	.probe = iproc_pcie_pltfm_probe,
> -	.remove = iproc_pcie_pltfm_remove,
> -	.shutdown = iproc_pcie_pltfm_shutdown,
> +	.probe = iproc_pltfm_pcie_probe,
> +	.remove = iproc_pltfm_pcie_remove,
> +	.shutdown = iproc_pltfm_pcie_shutdown,
>  };
> -module_platform_driver(iproc_pcie_pltfm_driver);
> +module_platform_driver(iproc_pltfm_pcie_driver);
>  
>  MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>  MODULE_DESCRIPTION("Broadcom iPROC PCIe platform driver");
> 

Acked-by: Ray Jui <ray.jui@broadcom.com>

--00000000000007db8005d4c5e5f4
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
gdQwLwYJKoZIhvcNAQkEMSIEIJRhmUaHY+2JMT5qIvcG3UkHZDCjQmDf2m3IFF3dinMoMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDEwNDE4MzQ1OVowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAdkebe6erwSxLSP6qg+JpvRhte6S5Ts8kRJW5b6kZbOkwKjCWSknUw3eWJtljFleYNeYRI
+el3kGROhq+hz9MAGkZ4d72k1RcNq21RFTs3iRAo1xct6pIRnMCsCTluc2n4m+CHDw59qrbLW+qF
8lRw30GKgNOr9N9xRp5jWDvUuTE/IJJkYXU0RRHf/uXnmERPHjo68bj9/WkOLEAtVauEPwZozBKf
emD6nHPCtwBHGnVp/tyrG2NuH2ysZrRm50Lb9nVzKWg4Bh34lOCa67HZY/AN3V0LQ7DH1WsK2OcW
7gFzBWr3Ny+XFcHEYxThP8BOZnAx/nyVYx7vn1Iztsyf
--00000000000007db8005d4c5e5f4--
