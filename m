Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A61785542
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjHWKSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjHWKSy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 06:18:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB110F;
        Wed, 23 Aug 2023 03:18:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so42927821fa.0;
        Wed, 23 Aug 2023 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692785901; x=1693390701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqL5rT9eEMblIWm5xVmqZIjJ0FlOc2kYm22GUWTmiYk=;
        b=HNDUKkfJaUEFjMYiqpjdXpKcZSsIvetBHsmIj42xNserRXHDTdZt++QkK6eZLxwiyl
         Wd8YwakK6pmKA6Bh2KfbMYd/rZELG+zHiaBnqWr4kc000B2mfKw5LVov2d14oYqe1SAd
         Oqdb26pKt7oAU+SSyMZhNbwc1o3jPmp0PZd5+WGeWIaHi5zSIudjvHfCdwP0xzMJbBRS
         4kWfy6wc+yvqpn2PgkN1OJCFDXs/MUjkXXKIVUlAVXCClUPVSp9FnNZ/Sn3tg1XhWBtR
         iHSZ8aipFwh7f0CW014a6duvHAUULf3Hrr87mdPmdxXZiCGVkE80fcQa6q7wQZ/zCSzX
         pibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692785901; x=1693390701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqL5rT9eEMblIWm5xVmqZIjJ0FlOc2kYm22GUWTmiYk=;
        b=Q8toiBezACF8PIYKAwN7XGwB4VJ+4N3XIJHA81zLXJ+fBlT7EnTl7xOlRVqq7TfcEL
         gkpj+66z+YmeZGNuQ3E5ezLYbtWyzF25nfXKSkPrHrhs3yWNrlKWeURrMbbAsW4bRHOu
         ltS0k2yx90JgS4jbtTqvGBdt0mLHXIpdsnRnRSFj5JeNiS2nTdtUsfcnyBkXialdZpOO
         J0xzf9c5B3s1KGV4TQbb3hkNbyyIagASsCSpSz2b4IYMS+v6xVRs2zmlYG0CjlQmUwVF
         ntJVYV3Wghksn26D5mqCEmckaAHDCUeBpBtbJ+e3QyJ5lGs5LifpC5lDZhoegf3mN6YK
         su3g==
X-Gm-Message-State: AOJu0YwobsbIynWArqMEjkj+AYqWzX6/X30IMXHOxLyKSScglFfJ/34g
        4TdQfgW2rQl31DLyD1cePPA=
X-Google-Smtp-Source: AGHT+IEPb0bWjvtUox2YlnaFpYYVWtBz4DJSg+0KR2D2AjzmNwne7OVOOBuO2ksy3Ds0kihqI9k2rQ==
X-Received: by 2002:a2e:6e10:0:b0:2b9:cb50:7043 with SMTP id j16-20020a2e6e10000000b002b9cb507043mr9623503ljc.2.1692785900680;
        Wed, 23 Aug 2023 03:18:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651c103100b002b6ee99fff2sm3163983ljm.34.2023.08.23.03.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:18:20 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:18:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v19 01/19] PCI: Add INTx Mechanism Messages macros
Message-ID: <iutmgdc4ux7bnbfvl6bqtyifxw6kytx2pge66pvsbhe2tzisrm@wjsp5aahbymc>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823091153.2578417-2-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:11:35PM +0900, Yoshihiro Shimoda wrote:
> Add "Message Routing" and "INTx Mechanism Messages" macros to enable
> a PCIe driver to send messages for INTx Interrupt Signaling.
> 
> The "Message Routing" is from Table 2-17, and the "INTx Mechanism
> Messages" is from Table 2-18 on the PCI Express Base Specification,
> Rev. 4.0 Version 1.0.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/pci.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c397434057..0b6df6c2c918 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,24 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +/* Message Routing (r[2:0]) */

> +#define PCI_MSG_TYPE_R_ROUTING_RC	0
> +#define PCI_MSG_TYPE_R_ROUTING_ADDR	1
> +#define PCI_MSG_TYPE_R_ROUTING_ID	2
> +#define PCI_MSG_TYPE_R_ROUTING_BC	3
> +#define PCI_MSG_TYPE_R_ROUTING_LOCAL	4
> +#define PCI_MSG_TYPE_R_ROUTING_GATHER	5

I've just noticed. Using "R" and "Routing" simultaneously is
redundant since "R" means routing. Just "R" would be enough.
Thus PCI_MSG_TYPE_R_* would mean the R[2:0] subfield of the Message
(Msg/MsgD) TLPs and we would shorten out the name length.

-Serge(y)

> +
> +/* INTx Mechanism Messages */
> +#define PCI_MSG_CODE_ASSERT_INTA	0x20
> +#define PCI_MSG_CODE_ASSERT_INTB	0x21
> +#define PCI_MSG_CODE_ASSERT_INTC	0x22
> +#define PCI_MSG_CODE_ASSERT_INTD	0x23
> +#define PCI_MSG_CODE_DEASSERT_INTA	0x24
> +#define PCI_MSG_CODE_DEASSERT_INTB	0x25
> +#define PCI_MSG_CODE_DEASSERT_INTC	0x26
> +#define PCI_MSG_CODE_DEASSERT_INTD	0x27
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.25.1
> 
