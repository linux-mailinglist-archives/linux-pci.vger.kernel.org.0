Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E836F3513
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjEARev (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjEARet (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 13:34:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436E131;
        Mon,  1 May 2023 10:34:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8bca69e8bso27031881fa.3;
        Mon, 01 May 2023 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682962485; x=1685554485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qDertiE/stwvspc2q5M0aytmBGASM3Bx9bVGlotrTI=;
        b=H1PD/IwYaXhSBtmhDB7BvSoHGdrbiodRXgHgi0jJFXhvPlL9vmJkCI4ZDW4zfghPxu
         HrNaLIN6nXeHm2js3jM0/0jd66WLfJRI1rc7LL4o+adtxftsIrAgyFTWS+27jxXLbhR9
         i3AIBfG/7JgUn99YcytxevRIz33yzMJb4cR9dDGSVSTh+nHO74GUlSxSkogIWKkTRVn/
         Lm2d+RVxbC6fft7oq1Bjd8gRybxyOhThoGAsQFav8ZMDTLP567No2HfPkDRdEuEaxYj2
         h2lzvX5cICzdqphEhAPGRf+l7Bi+dqMWXsHfCoiahUo+gpJjtOC6Gg6y8nCySTE6dO0r
         fuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962485; x=1685554485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qDertiE/stwvspc2q5M0aytmBGASM3Bx9bVGlotrTI=;
        b=aVfk2igx67rQx9iCDUNisprkiAfz2oJi3IzY05ofyLd6sQ4+P0dpOHKmueeTmKLHEh
         UC21IWHeYmY4FtwfrULTPgAOzAXWoHCeFxZYcUKXETyPcTRx6MKj5K5D1SAziW1y1Okd
         xVd84vS12LIBztLlcpYUkAd0e9SomCCkvSh2VphWBfq77Y9crNBu03dpgU18HxdqDncd
         X//HjAiXNcDYlhIbiLxVDMO0iTOep2hWie3dDx+bno9Tvu0f6/UhLcNU1b48bfGXwhr0
         vbf32PEIMf+LVY4dkkJMFSFjZ1/FlCx8seJ2mf+GJHTlUkXBSm2oCi4HGza7WeBNgBm5
         suNA==
X-Gm-Message-State: AC+VfDyanA/F+Nm72AMweYjaE/BhLRldicJEqDiB5MKsUBnIPdHqvV5B
        ip/5nHTXxKvqal2rNeVMyrY=
X-Google-Smtp-Source: ACHHUZ5aybLjN1UxarBAuIcxFC0JqilXu2MAFrZTB14DEx4FQybAgyoLcOdNa/gkhlzp/kl6M5FKiA==
X-Received: by 2002:a2e:9bd1:0:b0:2a9:f640:2032 with SMTP id w17-20020a2e9bd1000000b002a9f6402032mr3755800ljj.5.1682962485045;
        Mon, 01 May 2023 10:34:45 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id z8-20020a2e7e08000000b002a777ce224dsm4750711ljc.138.2023.05.01.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:34:44 -0700 (PDT)
Date:   Mon, 1 May 2023 20:34:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v14 03/21] PCI: Add INTx Mechanism Messages macros
Message-ID: <20230501173442.reje55nattksdpuk@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-4-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-4-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:39PM +0900, Yoshihiro Shimoda wrote:
> Add "Message Routing" and "INTx Mechanism Messages" macros to send
> a message by a PCIe driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
>  drivers/pci/pci.h                             | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f9182f8d552f..205bbcc6af27 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -9,6 +9,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  

> +#include "../../pci.h"

Unrelated change since the new macros are left unused in the framework
of this patch. Please move it to the patch which implies using the new
defines and where the included header file content is required.

>  #include "pcie-designware.h"
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2475098f6518..4be376c121a4 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -11,6 +11,25 @@
>  
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
>  
> +/* Message Routing */
> +#define PCI_MSG_ROUTING_RC	0
> +#define PCI_MSG_ROUTING_ADDR	1
> +#define PCI_MSG_ROUTING_ID	2
> +#define PCI_MSG_ROUTING_BC	3
> +#define PCI_MSG_ROUTING_LOCAL	4
> +#define PCI_MSG_ROUTING_GATHER	5
> +
> +/* INTx Mechanism Messages */
> +#define PCI_CODE_ASSERT_INTA	0x20
> +#define PCI_CODE_ASSERT_INTB	0x21
> +#define PCI_CODE_ASSERT_INTC	0x22
> +#define PCI_CODE_ASSERT_INTD	0x23
> +#define PCI_CODE_DEASSERT_INTA	0x24
> +#define PCI_CODE_DEASSERT_INTB	0x25
> +#define PCI_CODE_DEASSERT_INTC	0x26
> +#define PCI_CODE_DEASSERT_INTD	0x27
> +

> +

Excessive new line. Please drop it.

-Serge(y)

>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.25.1
> 
