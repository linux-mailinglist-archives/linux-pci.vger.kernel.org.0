Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E7975EC74
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjGXHZs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGXHZr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 03:25:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF813D
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 00:25:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8b4748fe4so21856925ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690183545; x=1690788345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDyplQwPvRvqJUtSpz4KPB8cjuW/LyNB3S4Bpqy4gds=;
        b=Ojh9SkoNDltjuRlRqlRHW/JrTLwhGK7LwenodcOYGD7BtacUUZReRyNNjPqPslMCGO
         LT1tk1Ga4t4L5zB4JCt5EmQ4PJDxG0cfLNo0afwMNuEb/93Obprep2aLUgZdN1n5PME8
         JfbXTmSukY7/45Jym3UC62Zi9a/wplzPZaN5kYHRyQaT8HRkJP1JupQwUhfuuahAn+ld
         niUMYgw22mdXmI6AanTUoXVabFbOVi5KJzFtzqxHVORo4+NflXmMAWtgwXYOlDNgejNo
         6rOmK3Sg+1KhH8Fl/qeWZR5XhFzA0U9DnzznQVDeFbP4HJ+y/9AUx75yZvaKchBi4n0g
         ufrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183545; x=1690788345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDyplQwPvRvqJUtSpz4KPB8cjuW/LyNB3S4Bpqy4gds=;
        b=Yp5xw4IQyJOQIOVlFgrpFEW17Y/oKC+I1Pqob48ldCzls68ClggKW/86foPDL994r/
         O/REaaEN7z26s5z2Kd8/rhCt7H5w+/IvmtbDm65ZQKyyREkYURS/D7EsbhDMrFLX+yt0
         gpGpizwv6TX+/eoN/h1JMOl/6TjJVPm3lBJuQorlMi9ZIliu5gkb/FpOplmBs09WeK99
         ONFi1wTmJp7P7SNNOODdssBtzkJfIfrEBK8oGux9DboEXgca1wG6fJEVF948h/xYLhFt
         rN+hmJt31nzFuJ8diidFw6NO7zaBjPRt7AcJYsEiFk6ZCwcYnhM9vC3pEzx8/0u/mqij
         QATw==
X-Gm-Message-State: ABy/qLY74k1VxzndGXsq4UOOxY6GnOAewwW9Z+BLwSULIWnvm3h7iPXq
        9vCBLhRGFrV4O021bmteoruf
X-Google-Smtp-Source: APBJJlGESAj9qUhYnHGWiRX2QHHYKTGVwUdjbvGxiSpl3hKM3uZyhdeI/RihV0XoQFeDzRxiYNHUIg==
X-Received: by 2002:a17:902:e843:b0:1b8:a569:f980 with SMTP id t3-20020a170902e84300b001b8a569f980mr7309639plg.65.1690183545252;
        Mon, 24 Jul 2023 00:25:45 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001bb99e188fcsm2261052plw.194.2023.07.24.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 00:25:44 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:55:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 01/20] PCI: Add INTx Mechanism Messages macros
Message-ID: <20230724072537.GA6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-2-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:33PM +0900, Yoshihiro Shimoda wrote:
> Add "Message Routing" and "INTx Mechanism Messages" macros to enable
> a PCIe driver to send messages for INTx Interrupt Signaling.
> 
> The "Message Routing" is from Table 2-17, and the "INTx Mechanism
> Messages" is from Table 2-18 on the PCI Express Base Specification,
> Rev. 4.0 Version 1.0.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
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

-- 
மணிவண்ணன் சதாசிவம்
