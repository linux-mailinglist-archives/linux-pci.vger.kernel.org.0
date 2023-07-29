Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA7A767B49
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jul 2023 03:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbjG2BmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbjG2BmB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 21:42:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0F5FC6;
        Fri, 28 Jul 2023 18:41:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so40833421fa.1;
        Fri, 28 Jul 2023 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690594854; x=1691199654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+4un2S12MNeLk48dddI463RnMVd5ZvfC6ZDNwqm2WY=;
        b=Cs022PjvGR4KlBDbNZ+V/v8cXxcQVff3nr/h8gWXXjQ7RbyrrulxBUDh8A2omTAfuw
         fZ8b4rJVc+GdLnhLyRGlrpGmlFtwpQuJ/BeMK4kOubZAMr5kQ/76LhAkd36Km+7TGFyX
         2x5mynN8ZbPA8Gm7XolLKXliKx/fs1/ofTc2NtNnbrhod6pqkMbKo3f6RpRVLwGergyE
         nkBcgaQIxy/6kCZ9xErLODMYFZugQbP4RwHsUEGXE6mZBg6o8mzTS9FngLUeZaBQ3l8K
         isGUys1lhQOArAxholsuLPTkJgbA9J8LAPxbLq5StP6pKrJTA9LtwaGjSZztZpxfYe4K
         kR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690594854; x=1691199654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+4un2S12MNeLk48dddI463RnMVd5ZvfC6ZDNwqm2WY=;
        b=dO3E2u+7bpF6OVqKzkeuvDhpy0uUORLL6jdYjC3mDmBjsL7VJJeHBytkEOVPGKpeQO
         NzRkoqlVMhrbKRmuWwdsZDaVC7PkLExjJAHHwqNUOerN7YNzmajHD1M020npf2BEak+O
         kFSBh+IPJFJgr4LOjM3VPaJdezV6c3MG34/DHavVWWlXyX5odOpDnhPw73OdRs1ooc2D
         bSGYlTWX0dozBHd8bWzwkOJCtj5md2AJZVsUaGSs95rm5ZlAHp5hPg0DZgUWBEshXVe0
         lqRh6/V7vaizbt7vIyJ5OfR6y7DU4YFgl1pRhDb3QoyXdl2UHxZkoHpnzAGdBAVOf79f
         +8IQ==
X-Gm-Message-State: ABy/qLZNFYa9QM3cWWpnC6Oypi9Eqohg3yQ0jASeuECCsQHTPVuZl5UR
        QlKxvQuqHGbia6qeR1xlqw4=
X-Google-Smtp-Source: APBJJlHsHdHP/+h1ZNpVvjYr/pfRqz0whfoLOEDefhBITb0tvFPR3Dp42fCGRfqgdRBqx6t0Q7fo7A==
X-Received: by 2002:a2e:978f:0:b0:2b9:b066:66a4 with SMTP id y15-20020a2e978f000000b002b9b06666a4mr2987821lji.4.1690594853644;
        Fri, 28 Jul 2023 18:40:53 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id f9-20020a2ea0c9000000b002b6dba16f28sm1222160ljm.127.2023.07.28.18.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 18:40:53 -0700 (PDT)
Date:   Sat, 29 Jul 2023 04:40:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 05/20] PCI: dwc: Add outbound MSG TLPs support
Message-ID: <qckzwhgcx7eux7qi6a27hww7wbva6r4nylxo437gnohpsxuja3@6dj2ld7qlvix>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-6-yoshihiro.shimoda.uh@renesas.com>
 <20230724081250.GD6291@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724081250.GD6291@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 01:42:50PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 21, 2023 at 04:44:37PM +0900, Yoshihiro Shimoda wrote:
> > Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for sending
> > MSG by iATU in the PCIe endpoint mode in near the future.
> 
> It's better to specify the exact requirement here "triggering INTx IRQs"
> instead of implying.
> 
> > PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
> > MsgD. So, this implementation supports the data-less messages only
> > for now.
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 

> Same comment for patch 4/20 applies here also. With that fixed,

Yoshihiro, as we greed with Mani in the PATCH 4/20 discussion please
ignore this request.

-Serge(y)

> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 49b785509576..2d0f816fa0ab 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -498,7 +498,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> >  			      upper_32_bits(atu->pci_addr));
> >  
> > -	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > +	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > @@ -506,7 +506,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> >  		val = dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >  
> > -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > +	val = PCIE_ATU_ENABLE;
> > +	if (atu->type == PCIE_ATU_TYPE_MSG) {
> > +		/* The data-less messages only for now */
> > +		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> > +	}
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
> >  
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 85de0d8346fa..c626d21243b0 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -147,11 +147,13 @@
> >  #define PCIE_ATU_TYPE_IO		0x2
> >  #define PCIE_ATU_TYPE_CFG0		0x4
> >  #define PCIE_ATU_TYPE_CFG1		0x5
> > +#define PCIE_ATU_TYPE_MSG		0x10
> >  #define PCIE_ATU_TD			BIT(8)
> >  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> >  #define PCIE_ATU_REGION_CTRL2		0x004
> >  #define PCIE_ATU_ENABLE			BIT(31)
> >  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> > +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> >  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
> >  #define PCIE_ATU_LOWER_BASE		0x008
> >  #define PCIE_ATU_UPPER_BASE		0x00C
> > @@ -292,6 +294,8 @@ struct dw_pcie_ob_atu_cfg {
> >  	int index;
> >  	int type;
> >  	u8 func_no;
> > +	u8 code;
> > +	u8 routing;
> >  	u64 cpu_addr;
> >  	u64 pci_addr;
> >  	u64 size;
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
