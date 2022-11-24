Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6371C6374F8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiKXJTf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiKXJTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:19:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692D1173C9
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 01:19:33 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so1115755pjg.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 01:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MaYzrsKaOUsi6MQmV9y7yVqR3tMclv0waDqtUyim+g=;
        b=tft3yg81KscY4rqgi3gLlrBZExjeXAYKm4lMoVl6h2a9wKoYqNTQ24JMQ3b+Yoo7HD
         KlLRk+3fHiUZticy3xPRebIC+ScjEG/UEnBB7qX05MZwl6M8vPjqERA2rdcPeUgmczwF
         7f1L7hMy+LrCdvNdiMiIwBxNslMFGkzYZX3bN3RGkdyE6b7vrErz8Zhz++RMHmrjD783
         Az33vstBw4zqkVWs9mJP6dMvzXOcM7ShoWjmgMWSuFE9kYpQuhn8aOZEKsUn4n3jnTWy
         quUXwc/Wvb1NdBsfcFjns9NK+sc4cFjHzJqFh0fZ+AdQhmU9QIszZwRGK6mZqQV0l50u
         Otpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MaYzrsKaOUsi6MQmV9y7yVqR3tMclv0waDqtUyim+g=;
        b=Si6J0KvQrYMyZ8XZ4iwO23yFTzFRhaQ/nyR5YocNwgZ7XCHoQ33sPyGj/WdXqQmPjz
         vQ+nCse+qfC5HqJL8Y3EZuZf+DI0HU+QEjiu7yf8p8F8vxeZ8Yi9OcDN+v6J3H7MoS0y
         XR7bpmukg11GnicPWYc9YksC9wVDMKuYugtgqJRmg4qpiLDQOro09aHW0T/jvltx+Ses
         A3EUebc+QYAhDZ7FEztjl8gKNouFohoEnbt7OV/draJqNAAGjBO9/drqgLwNxG55JfGR
         IdnQzdw4zopZzv65FAOelH5CmPiLdq8NHaVBtSRXsr7KtHuJ/BfaWGBh8KLaQW7z3XIQ
         dg0A==
X-Gm-Message-State: ANoB5pkYtYT/ctQGyw3M4yHnfHkyy44QyM6oT+OY5KldfkTr/Sg+d4e0
        GuREg4QP5bvQeHdFqqs+fp4D
X-Google-Smtp-Source: AA0mqf7bQu1RigIIFc6rH9iH8QZPqzGJwIPGNwOQ99KG6wgrm6TUgNaS+V9f68CDfw4mETtLc7Qzow==
X-Received: by 2002:a17:903:258b:b0:189:1b50:f9e with SMTP id jb11-20020a170903258b00b001891b500f9emr13744776plb.74.1669281572754;
        Thu, 24 Nov 2022 01:19:32 -0800 (PST)
Received: from thinkpad ([59.92.97.13])
        by smtp.gmail.com with ESMTPSA id z3-20020a626503000000b0056bee23a80bsm699118pfb.137.2022.11.24.01.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:19:31 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:49:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     lpieralisi@kernel.org, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lznuaa@gmail.com, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change doorbell
 register offset calc mathod
Message-ID: <20221124091921.GD5119@thinkpad>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124055036.1630573-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 24, 2022 at 12:50:35AM -0500, Frank Li wrote:
> In drivers/ntb/hw/epf/ntb_hw_epf.c
> ntb_epf_peer_db_set()
> {
>    ...
>    db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
>    writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
>                db_offset);
>    ...
> }
> 
> The door register offset's formular is
> 	offset = db_entry_size * interrupt_num + db_offset[interrupt_number]

You did not mention the DB BAR here. Without that, this calculation doesn't
make sense.

> 
> Previous db_entry_size is 4, all db_offset is 0.

s/Previous/Previously

> 	irq | offset
>        --------------
>          0     0
>          1     4
>          2     8
>         ...
> 
> Change to db_entry_size is 0 and db_offset is 0, 4, 8, ...
> So we can get the same map value between irq and offset. This will be
> convenience for hardware doorbell register memory map.
> 

In your irq-imx-mu-msi.c driver, the msi_address is calculated as:

```
u64 addr = msi_data->msiir_addr + 4 * data->hwirq;
```

So the MSI addresses itself are of 4 bytes width. So the offsets will be
separated by 8 bytes like, 0, 8, 16,... and this won't match the MSI addresses
as they are 4 bytes apart.

So you want to change the offset to 0, 4, 8,... by zeroing db_entry_size,
right?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 04698e7995a5..0d744975f815 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -461,11 +461,11 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	ctrl->num_mws = ntb->num_mws;
>  	ntb->spad_size = spad_size;
>  
> -	ctrl->db_entry_size = sizeof(u32);
> +	ctrl->db_entry_size = 0;
>  
>  	for (i = 0; i < ntb->db_count; i++) {
>  		ntb->reg->db_data[i] = 1 + i;
> -		ntb->reg->db_offset[i] = 0;
> +		ntb->reg->db_offset[i] = sizeof(u32) * i;

If my above understanding is correct, then you could just reassign
"db_entry_size" in epf_ntb_epc_msi_init().

Thanks,
Mani

>  	}
>  
>  	return 0;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
