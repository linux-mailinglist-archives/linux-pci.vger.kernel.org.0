Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAFB76A3F9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 00:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjGaWML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGaWMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 18:12:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F105A1FCD;
        Mon, 31 Jul 2023 15:11:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so7918886e87.3;
        Mon, 31 Jul 2023 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690841509; x=1691446309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DUlc8Zih7AFjdjr0cHfklZW7ElrNX3VLil/OBBbUrMY=;
        b=exRzhGKri0JNGp+JykLJz2qmEmiGw4jK2+r2VUkX5t9F2HieXXrZ474OQynpNlhywM
         5gcvQ9ka0fmzC0czTXYV3jyDHfkOCExHd9IGE0KJNviGJzTMl7QsEtiI0yaVS8iuEJMr
         Fbvk1wn0vgNeIE5FGqbQD198wk5ycV0izhA2NUE153zIeCKEII0IHFKAN8JASO9e/pus
         QTzzB/6rJb/h+btn8ybv1yjlIh81DvAKHJLPY6/IXDECHDnpwPWsHNuu9exnX9o0OzCh
         Wka+lFLVqq60v426LDq4Er/l46ZOxOHL7ZzRNfplKauVmRypmUjH032kIhUHL9lGwuif
         RgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841509; x=1691446309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUlc8Zih7AFjdjr0cHfklZW7ElrNX3VLil/OBBbUrMY=;
        b=fRqiLBXPJkV4bFU/1hdC+GcXr4Vv53XW5WNUHAEbhJnBoy4FS0CyCJeH4SMvbdxuMF
         Bo1fTIGrx/IBuNBig6dX2hJx20LEeu0docBcU9ElUW9qQpfMPVttPww8dQCZLxbglOPB
         8QaH+m5jD+dqkwZ1CABFLu0tUvPTrcc9pqQSlT9DARkwzCrnUkv7ujdVzKa3GMHYsrYg
         Fumv0+dz5LGWqmVIfSkp1wjksdC+cGQVsvD7cat0Ue8k/qLc946ENdHUYAN3Cqlz87k4
         DDrpH+XLdzLwu0eSSUlBdzp6A+kzjT9R8nkG58XSC1ZX/CNklnHqduJ86Vi1jrOLEs6s
         1HuQ==
X-Gm-Message-State: ABy/qLZID+H1Wn+UuIP18VyYF6q13uSIANvqydU4PaJZCRvcsMkV6x32
        iCSu7C+46XOOz7/GSYw4iYk=
X-Google-Smtp-Source: APBJJlFLRHbIxgDyV7QZdXM2yQnSJkIWhHakZtTZVVHLNId66kyMOxl/QR/vysO8GP/dRDWeCsRtWg==
X-Received: by 2002:a19:ab09:0:b0:4fe:1ecf:8ab4 with SMTP id u9-20020a19ab09000000b004fe1ecf8ab4mr695584lfe.18.1690841508500;
        Mon, 31 Jul 2023 15:11:48 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id j15-20020ac2550f000000b004fe432108aesm99177lfk.261.2023.07.31.15.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:11:48 -0700 (PDT)
Date:   Tue, 1 Aug 2023 01:11:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v18 05/20] PCI: dwc: Add outbound MSG TLPs support
Message-ID: <b6jzau7mwbnomy2whhwfbtww6p5hiikiay5jvcz5em422q2ycb@pe3au6vvcygc>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-6-yoshihiro.shimoda.uh@renesas.com>
 <20230724081250.GD6291@thinkpad>
 <qckzwhgcx7eux7qi6a27hww7wbva6r4nylxo437gnohpsxuja3@6dj2ld7qlvix>
 <OSYPR01MB5334600364096E6FDE573394D805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSYPR01MB5334600364096E6FDE573394D805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 01:18:30AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Saturday, July 29, 2023 10:41 AM
> > 
> > On Mon, Jul 24, 2023 at 01:42:50PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 21, 2023 at 04:44:37PM +0900, Yoshihiro Shimoda wrote:
> > > > Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for sending
> > > > MSG by iATU in the PCIe endpoint mode in near the future.
> > >
> > > It's better to specify the exact requirement here "triggering INTx IRQs"
> > > instead of implying.
> > >
> > > > PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
> > > > MsgD. So, this implementation supports the data-less messages only
> > > > for now.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > 
> > > Same comment for patch 4/20 applies here also. With that fixed,
> > 
> > Yoshihiro, as we greed with Mani in the PATCH 4/20 discussion please
> > ignore this request.
> 

> By the way, do you have any comment about my suggestion? [1]
> 
> [1]
> https://lore.kernel.org/linux-pci/TYBPR01MB5341407DC508F0B390B84090D801A@TYBPR01MB5341.jpnprd01.prod.outlook.com/
> 
> If you don't agree my suggestion, I'll ignore this request.

Your suggested is not good for several reasons:

1. You suggest to add the function caller context-wise comments to the
structure. It will cause the maintainers to keep the comments and the
callers semantics in sync which is almost always gets to be diverged
at some point.

2. dw_pcie_prog_outbound_atu() doesn't know whether it is called for
an End-point or a Root Port controller. It just maps the CPU->PCIe
spaces by means of the outbound iATU engine with the specified mapping
parameters. This makes the comments you suggest misleading. Moreover
depending on the application the low-level drivers or even the DW PCIe
core driver may decided to map them in any way. In that case the
respective change will need to update the comments too, otherwise
they'll get to be wrong which gets us to the reason 1.

3. The current arguments/fields order more-or-less preserves the
natural settings setup: first you specifies the entity index, then you
specify the mapping settings, then you specified the mapping itself
(addresses and size). Ideally the "func_no" field should be moved to
the head of the structure since it also represents the mapping entity
index but it will cause having the pads (so called "holes") if we
didn't change it type. Anyway inverting the order so the mapping
itself goes first will break that, the structure will look as if, for
instance, the device-managed function taking the device pointer
somewhere in the middle or at the tail of the arguments lists. The
most important settings which are normally initialized first will be
defined at some random place in the structure.

So to speak, it's better to keep the structure fields as is for
now.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > >
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > - Mani
> > >
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
> > > >  drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
> > > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 49b785509576..2d0f816fa0ab 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -498,7 +498,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > > >  			      upper_32_bits(atu->pci_addr));
> > > >
> > > > -	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > > > +	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
> > > >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > > >  	    dw_pcie_ver_is_ge(pci, 460A))
> > > >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > > > @@ -506,7 +506,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > >  		val = dw_pcie_enable_ecrc(val);
> > > >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> > > >
> > > > -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > > > +	val = PCIE_ATU_ENABLE;
> > > > +	if (atu->type == PCIE_ATU_TYPE_MSG) {
> > > > +		/* The data-less messages only for now */
> > > > +		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> > > > +	}
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
> > > >
> > > >  	/*
> > > >  	 * Make sure ATU enable takes effect before any subsequent config
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 85de0d8346fa..c626d21243b0 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -147,11 +147,13 @@
> > > >  #define PCIE_ATU_TYPE_IO		0x2
> > > >  #define PCIE_ATU_TYPE_CFG0		0x4
> > > >  #define PCIE_ATU_TYPE_CFG1		0x5
> > > > +#define PCIE_ATU_TYPE_MSG		0x10
> > > >  #define PCIE_ATU_TD			BIT(8)
> > > >  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> > > >  #define PCIE_ATU_REGION_CTRL2		0x004
> > > >  #define PCIE_ATU_ENABLE			BIT(31)
> > > >  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> > > > +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> > > >  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
> > > >  #define PCIE_ATU_LOWER_BASE		0x008
> > > >  #define PCIE_ATU_UPPER_BASE		0x00C
> > > > @@ -292,6 +294,8 @@ struct dw_pcie_ob_atu_cfg {
> > > >  	int index;
> > > >  	int type;
> > > >  	u8 func_no;
> > > > +	u8 code;
> > > > +	u8 routing;
> > > >  	u64 cpu_addr;
> > > >  	u64 pci_addr;
> > > >  	u64 size;
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
