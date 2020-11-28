Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8162C705C
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgK1Rzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 12:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbgK1FBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Nov 2020 00:01:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F1C0613D2
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2020 21:01:43 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e23so970815pgk.12
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2020 21:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=CHVkKVR/AjLINerb5NXuJpv5TBkK6zlrr0ZOsAbUzQY=;
        b=eoLxG843gNib7MIuaVWwxhibqBhAh9FqkgYmGuV4Js02pNSALFHdFoj1zGcta8GzzO
         Nn03YTpWtRN7FtoMt4VLEBwIOdoI1mp099l2LVoKNxkmaf0/xNcE8nfqhnr0W1slvwJC
         u3CdzxPQXjtvlir+YhMGixayxMJH/l6WqPrxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=CHVkKVR/AjLINerb5NXuJpv5TBkK6zlrr0ZOsAbUzQY=;
        b=TMZOGJa6rzrXDlhON0pA2yFXr7ZFqtBheud7dkxQbhC5lz5/h4UsCOMiROB8KXyEvG
         eceVfoj+Lbvq5t2XIUkBXjf8qFhwmPjrut+5abwlPBjC0vF19GHpX84m8vq6XxKrPuRl
         4MmzD9G/C8aL9hQp++BaeOEBZfN/O7M8TWC3hpVpecEDrYHv7cwjqSPSs5kJXFAPpbf4
         MDurXvbNmZehVYodytW8oXe2vTaeCYpxl0+Ih4mptk09S9n87zFVNCLZUT3jLQqTaoty
         0PNZpanvy883i45LQpgmyG/J+yxjnlqjwkfNOHJbWD8jUj1QyW0OFuHooEd8w5f57Ra5
         Bahg==
X-Gm-Message-State: AOAM53351AOZxMXuDW5TFFzSMRm4o3iaaGcjiVOhIZU7D24fAGODUT9e
        8UebloodiIJtFC+ZO4JKXPB1eQ==
X-Google-Smtp-Source: ABdhPJwxxSw61kvjwIBCaqqiA2dRcIzC99ZzKRTHUsqAwoZHjtxelE6UJNxGwJx+HLZXyH7iSqcxRQ==
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr13989159pjb.164.1606539702833;
        Fri, 27 Nov 2020 21:01:42 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b83sm3115354pfb.220.2020.11.27.21.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 21:01:42 -0800 (PST)
Subject: Re: [PATCH 2/2] PCI: brcmstb: support BCM4908 with external PERST#
 signal controller
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201126135939.21982-1-zajec5@gmail.com>
 <20201126135939.21982-3-zajec5@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <1e18fd61-594f-499f-d7a0-1de54b9f9a45@broadcom.com>
Date:   Fri, 27 Nov 2020 21:01:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126135939.21982-3-zajec5@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000567b2b05b523ac4b"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000567b2b05b523ac4b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 11/26/2020 5:59 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 uses external MISC block for controlling PERST# signal. Use it
> as a reset controller.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

>  enum pcie_type {
> +	BCM4908,
>  	GENERIC,

This needs to be moved after GENERIC such that GENERIC == 0

>  	BCM7278,
>  	BCM2711,
> @@ -230,6 +233,13 @@ static const struct pcie_cfg_data generic_cfg = {
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
>  
> +static const struct pcie_cfg_data bcm4908_cfg = {
> +	.offsets	= pcie_offsets,
> +	.type		= BCM4908,
> +	.perst_set	= brcm_pcie_perst_set_4908,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +};
> +
>  static const int pcie_offset_bcm7278[] = {
>  	[RGR1_SW_INIT_1] = 0xc010,
>  	[EXT_CFG_INDEX] = 0x9000,
> @@ -282,6 +292,7 @@ struct brcm_pcie {
>  	const int		*reg_offsets;
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
> +	struct reset_control	*perst_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -747,6 +758,18 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> +static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
> +{
> +	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n") ||
> +	    WARN_ONCE(pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20, "unsupported hardware revision\n"))
> +		return;
> +
> +	if (val)
> +		reset_control_assert(pcie->perst_reset);
> +	else
> +		reset_control_deassert(pcie->perst_reset);
> +}
> +
>  static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
>  {
>  	u32 tmp;
> @@ -1206,6 +1229,7 @@ static int brcm_pcie_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
> +	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
>  	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
>  	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
> @@ -1262,11 +1286,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		clk_disable_unprepare(pcie->clk);
>  		return PTR_ERR(pcie->rescal);
>  	}
> +	pcie->perst_reset = devm_reset_control_get_optional_shared(&pdev->dev, "perst");

Is not this an exclusive reset?

> +	if (IS_ERR(pcie->perst_reset)) {
> +		clk_disable_unprepare(pcie->clk);
> +		return PTR_ERR(pcie->perst_reset);
> +	}
>  
>  	ret = reset_control_deassert(pcie->rescal);
>  	if (ret)
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
>  
> +	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);

This is likely going to cause a regression on STB, you cannot read from
most PCIe registers except the main bridge register until after
brcm_pcie_setup() has been called. I do not find the warning on an
unknown revision to be particularly helpful, can you consider leaving
the hw_rev read where it is and not warn?
-- 
Florian

--000000000000567b2b05b523ac4b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NBgcnL8bS1GD7jRZUdtUvDm/XhPjv+5arhlrB5NmaKDsRaobcoQ0vtEyAnImSb64+wEvXgPF3y7V
0LCIoQMCAwEAAaOCAdQwggHQMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNV
HQ4EFgQUjDSG6itHmsBGYhab0ncHg6PidD0wDQYJKoZIhvcNAQELBQADggEBAJD+OK9GMwW86kdo
oTOaDH8VAbGtc3cvxHH/zTSRaq+XQOUwzXeB35AgKQ7VnnW+AYsU0NILbJUrAUGctIt4fMgPi+fZ
1SJxTyzKxS0LCahS3l9aL3TEWyFOnDurmKeLcgVG5qMVXysLYDXiUGGg1I/zmOHefpv30RDNdUjD
9oUbBggB6IHlL4Y6x21gV6Cduse0xOgMrY+dXhntQimTLmuPz0b3uUVJNdtTqVG5pZwZZ/cjsGCm
QTlT5kx0VnHRHhYKS+1b2usAYk+pec77Wth9xL1gsEGVh4JmIdQpkhqGHA/m2nVkhW/WbbFsA7Im
9CNMvmz2hVgGGipcf47g+EsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0g
U0hBMjU2IC0gRzMCDE64Wkk+BtY98mx37TANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQx
IgQgRLGZJZMtLUyqLOWhuccfDvitvyFvSZNQpezTpbXAXDYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMTI4MDUwMTQzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEB
CjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAENp3l3E35y+yut7
bhb4ND/aGEIyl1ugkPgGjR9peyhvveEFNXuA+7NBXC3v86fgXrg45bkOhn8/0BqDiiOa5/fMEsar
uofVGz9mc/QZNZBMK9kVD+eMvLMjjbgB+a1y2aoA1gjgqLcruytyh1PzFU5PYxB0V1soIVp3QeCs
0+PBcKluyFsU0ViQ4K4AXLzBLuer013o8Y2XIcYT11DPcWnkFjI5FZfb4LFHffbwye/9JzFxCRs+
IBgyrcYxrqzOMe5FtovTHfbzP8S8zgyJtAhrXlXdN7hG4OVZw2vYaiwtPuQe4mEfoLMYvT5dAKhp
u/LpxLtQi1CALIlK2aKdLdE=
--000000000000567b2b05b523ac4b--
