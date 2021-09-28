Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF541A451
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 02:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhI1A4b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 20:56:31 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41943 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhI1A4b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 20:56:31 -0400
Received: by mail-wr1-f51.google.com with SMTP id w29so54849231wra.8;
        Mon, 27 Sep 2021 17:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n2sXzJg2SsfZ8S0g5MG0HaM4hrj/bpFvf9vFQzLvc0c=;
        b=l86AfC1ibMKeztbexCfDC77rPbyK2bLAvHzDXr+LGcAfQ6sqrC+gT2zoMCVoF/5WNW
         0iO016vOQV9UBR9sopUKldg6W6Qx8ThJ1s00aj3s8m1NdfZsKhvDbDSboOC/yoXIxXRH
         LO1fPg7gNzU2Elnx96CRqCZzeJstKnblsixHSxTgZPfxLHqz9Eec6pJNMqHTaDPv0+sn
         LiJWpv5KtOqI4S4x9grapbl47/oPNwQsFgPXjBTTdytT8rgNQM8NXey3RuOdEQj8Lklx
         tQl3TKVlIQDaAZC1OP2LG+WkuwQJCdabJyrIl+LwtXDOKWcEVdRNsguOb/bnLSOt9U6n
         Otag==
X-Gm-Message-State: AOAM530bGkmbRPCUjVWKm9+cFaTbQ6zYZ1ORXBZuyHJQ9MCp8eJngDJZ
        sQlZjiukZ1bxpJnTZlgdTRE0RHweLeSSY3s2
X-Google-Smtp-Source: ABdhPJwqkd5w1g7BZXopwb7Al1e5soWrw9CirT8+m0wKI1sd2xp4RmW6QW5X/6NfauELjq4AiwASKg==
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr3227667wrx.104.1632790491627;
        Mon, 27 Sep 2021 17:54:51 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l25sm988037wmi.29.2021.09.27.17.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 17:54:50 -0700 (PDT)
Date:   Tue, 28 Sep 2021 02:54:49 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kishon@ti.com, tjoseph@cadence.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: j721e: Fix an error handling path in
 'j721e_pcie_probe()'
Message-ID: <YVJn2SHvRcTO2tY5@rocinante>
References: <db477b0cb444891a17c4bb424467667dc30d0bab.1624794264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db477b0cb444891a17c4bb424467667dc30d0bab.1624794264.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe,

Thank you for sending the patch over!

Just a tiny nit-pick: there is no need to surround function names in single
quotes in the subject and in the commit message.

> If an error occurs after a successful 'cdns_pcie_init_phy()' call, it must
> be undone by a 'cdns_pcie_disable_phy()' call, as already done above and
> below.

Here, in the above sentence, you could simply mention that this is needed
for the device to be correctly powered down should there be an error, and
reference to the "above" and "below" code.

> Update the 'goto' to branch at the correct place of the error handling
> path.
> 
> Fixes: 49e0efdce791 ("PCI: j721e: Add support to provide refclk to PCIe connector")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 35e61048e133..8933db6ab1af 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -424,7 +424,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		ret = clk_prepare_enable(clk);
>  		if (ret) {
>  			dev_err(dev, "failed to enable pcie_refclk\n");
> -			goto err_get_sync;
> +			goto err_pcie_setup;
>  		}
>  		pcie->refclk = clk;

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
