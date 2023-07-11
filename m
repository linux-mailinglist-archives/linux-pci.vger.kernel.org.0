Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC074EF41
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGKMr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKMr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 08:47:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FDF11B;
        Tue, 11 Jul 2023 05:47:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so87765811fa.2;
        Tue, 11 Jul 2023 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689079673; x=1691671673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZwIWsyHBDhjLad84NzaNva3BNfXjZe5vkLfQsOCjCc=;
        b=pSipQ/AW/mGoObrbdhJv/oCUAvq/UliTyS5/cglEVv63+SguNkGYr3f6H/Y/IG84AP
         e7WD1fpm7cUeIwneC6KY8Vswr6oN7bJ/ihMg4j5F5IyYFNXfgXsYX47taxWsJuuTyF0y
         uVjZNj4AmS8XannHsmJj1pbkUAEFOyVjqRMIlYEhf4fGff04iJAgUeeaFPbvLhE+MeNw
         rNjd5kpsTGMkV/d5K7jtXfmfpR2Ff+JeUyou0zsYmaexL0myCvU7Z8CDndwxvscM4Up6
         Kh4A5pFzQPyNNeSHbjGbmoEjSBYKkbx6PupXR0MFB43WLJ23W4N+1bp9EtpLACaZ54ND
         k5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079673; x=1691671673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZwIWsyHBDhjLad84NzaNva3BNfXjZe5vkLfQsOCjCc=;
        b=NJ6fWbtUY1cKB22A2cFPAiSpspR29JtF8NKrSExhkOviIv7LrsjrRTtlbtdwkZxFNv
         AymAK2OdfILJ3h2M/QZWPRlMnSbhCiPez9uzom/MRvjMa0Lyh6ATG2rl6FxcqjEHEkyl
         Up7imMJMC9mT70GJeg850ZL1rMYFSjLF+3dw7Qthre/1cc7uULxpqKw8bGI9VY+GEZCw
         CgYK/Iqv+aqnltUgU3kzto9mUcP7dXHNb2U26oqk4tQZWLqI4OU17yxwjRdb4udr/3qz
         jZ9xHqCiK7LqVquzjK2SlutVpWPCc7+OhVTmdMBYy/X+2aB9ScjHpkxFTyID3NlJdcH1
         h3+A==
X-Gm-Message-State: ABy/qLZrX/Ap9C2Jy0nmV3ZjVahAj0N5/qBwEcMj7LSBpREMPh0PUlep
        zAkBjpv/PEVvYVCvzICeYUk=
X-Google-Smtp-Source: APBJJlGTGVjSGfPVElIc+uEX2MYdYCtrEOxoN7Wt0fbZwaLSqMQOuoY9bsbAGNYMsMh3SViR3GwrCw==
X-Received: by 2002:a19:4f42:0:b0:4fb:7de4:c837 with SMTP id a2-20020a194f42000000b004fb7de4c837mr12264673lfk.68.1689079672996;
        Tue, 11 Jul 2023 05:47:52 -0700 (PDT)
Received: from mobilestation ([85.249.18.12])
        by smtp.gmail.com with ESMTPSA id er24-20020a05651248d800b004fb75943aa0sm305920lfb.196.2023.07.11.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:47:52 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:47:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 01/20] PCI: Add INTx Mechanism Messages macros
Message-ID: <7jry4cvtqw56xt5tbuorla5dq3ikrfboy5sltsnbe6ttdi5h7h@fqfal75irzwe>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-2-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:41:47PM +0900, Yoshihiro Shimoda wrote:
> Add "Implicit Message Routing" and "INTx Mechanism Messages" macros
> to send a message by a PCIe driver.

Adding to the patch log why they are needed would shed some light to
the patch context for the reviewers unfamiliar with the series.
Normally the submitters provide the context of the preparation patches
to simplify the review. Adding a reference to the respective part of
the PCIe specification would be also appropriate here.

Other than that no objection from my side:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/pci.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c397434057..45673cc9c724 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,24 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +/* Implicit Message Routing (r[2:0]) */
> +#define PCI_MSG_TYPE_R_ROUTING_RC	0
> +#define PCI_MSG_TYPE_R_ROUTING_ADDR	1
> +#define PCI_MSG_TYPE_R_ROUTING_ID	2
> +#define PCI_MSG_TYPE_R_ROUTING_BC	3
> +#define PCI_MSG_TYPE_R_ROUTING_LOCAL	4
> +#define PCI_MSG_TYPE_R_ROUTING_GATHER	5
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
