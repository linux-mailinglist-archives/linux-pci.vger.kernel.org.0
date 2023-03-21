Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F97E6C3AB2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCUTe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCUTe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:34:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B0057D0A;
        Tue, 21 Mar 2023 12:33:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z42so16655552ljq.13;
        Tue, 21 Mar 2023 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wm8MQJivihHpRBhX5jhq2CsoTzKuk96liIpsYQdFPy8=;
        b=HMJfHmVwTQKZVYAQsEecuyAc3DSoCa+z/mMKv3aQSC/3xylrzRHSj9szKW9x313igz
         JaFEDw7KHd4QlE88XUqHegUDNoDqDMZ9gvboaQ4yggKLNe9qGBkt4TUlU7n8AjRT7/J5
         cy7TaV5jI+027wHG9ji3Efjln5GjAKS4g7fm7IgXkGP25rJHUMzWDpODhop+uP3RnRsS
         Q50IWASMn/lgFBlSXGmMDiGZp2hdxyzctW2cHn7EEX2SUxu7l9bt4TgECowOpykm+Hul
         00GKG3aBZrM4LaNvQC8/3gkc074g4NmhO7yqQsczlrNGXrg8lcLwjwJM9qL38WHMKZ1w
         yiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm8MQJivihHpRBhX5jhq2CsoTzKuk96liIpsYQdFPy8=;
        b=slCKSpQ+o+4XwlOs0JO+xpOsFG3s2M+jFN8jrizoSjocKlb4sUupKUbFV38gVvME7P
         9vBkGHX/ZqXOGd5TAKgvyDwout7jVoTmXOwCSleq1dn0PBa/HP+ZS4IZ+lwduekMBKx1
         FqjzjXzirSoGbu6EGrshuL5rKDYFUdowN7UFBUbfFaiMutAMC3hE89IgGP2T5cYqVhbI
         35JbE5TYryCAfWb3BZfXcM3UFV9h5cgjUTeVs2+MPL4K+giDeT1FJEj79IFtvQN0YVYa
         /xtQcO8UQnoIcoDd9r6gUoA3w/bdFHL1MKhdYbSaP/ngcKQs+S4XFwKLACDWa0sAe9Os
         yNRQ==
X-Gm-Message-State: AO0yUKWUc4rkdkVJ4Fy3D4vMy29jepKzA/X8KUwaHZgP3K+0iPgrBjqc
        LrW9pR2RfXsbOZ6+p3FRDTenWHcoJOqPHg==
X-Google-Smtp-Source: AK7set+lirdhq1D1avVPH/PjwULAjPrtvtxKZnsmYTtDU3KN3f7BsCj91nCTNDUqNIDMzmX63s37Pg==
X-Received: by 2002:a2e:8ecf:0:b0:295:b0ed:ee8 with SMTP id e15-20020a2e8ecf000000b00295b0ed0ee8mr1195980ljl.46.1679427216330;
        Tue, 21 Mar 2023 12:33:36 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id g5-20020a2e9385000000b002959d2cc975sm2356301ljh.37.2023.03.21.12.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:33:35 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:33:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 01/13] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230321193333.2o2gefhcuzk7sub7@mobilestation>
References: <20230321090255.cca6xowea6k6fud4@mobilestation>
 <20230321185228.GA2405946@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321185228.GA2405946@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 01:52:28PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 21, 2023 at 12:02:55PM +0300, Serge Semin wrote:
> > On Fri, Mar 10, 2023 at 09:34:58PM +0900, Yoshihiro Shimoda wrote:
> > > The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> > > "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> > > the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> > > Therefore, unexpected register value is possible to be used
> > > to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> > > So, change reading timing of PCIE_PORT_LINK_CONTROL register to fix
> > > the issue.
> > 
> > My version of the commit log:
> > < If CDM_CHECK capability is set then the local variable 'val' will be
> > < overwritten in the dw_pcie_setup() method in the PL_CHK register
> > < initialization procedure. Thus further variable usage in the framework of
> > < the PCIE_PORT_LINK_CONTROL register initialization at the very least must
> > < imply the variable re-initialization. Alas it hasn't been taken into
> > < account in the commit ec7b952f453c ("PCI: dwc: Always enable CDM check if
> > < "snps,enable-cdm-check" exists"). Due to that the PCIE_PORT_LINK_CONTROL
> > < register will be written with an improper value in case if the CDM-check
> > < is enabled. Let's fix this by moving the PCIE_PORT_LINK_CONTROL CSR
> > < updated to be fully performed after the PL_CHK register
> > < initialization.
> > 
> > > 
> > > Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > Looks good. Thanks.
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > @Bjorn, if it's possible could you please take this patch to a
> > fixes(-ish) branch of your tree and merge it in the next rc-cycle?
> > It definitely fixes a bug in the DW PCIe core driver.
> 

> I applied this patch only to for-linus for v6.3.  I adapted the commit
> message as follows, let me know if you spot a mistake:
> 
>   PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled
>   
>   If CDM_CHECK is enabled (by the DT "snps,enable-cdm-check" property), 'val'
>   is overwritten by PCIE_PL_CHK_REG_CONTROL_STATUS initialization.  Commit
>   ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check"
>   exists") did not account for further usage of 'val', so we wrote improper
>   values to PCIE_PORT_LINK_CONTROL when the CDM check is enabled.
>   
>   Move the PCIE_PORT_LINK_CONTROL update to be completely after the
>   PCIE_PL_CHK_REG_CONTROL_STATUS register initialization.
>   
>   [bhelgaas: commit log adapted from Serge's version]

Sounds good. Thanks!

* I'll keep reviewing the rest of the patches in the series. There are
several aspects which I think is possible to improve/optimize.

-Serge(y)

> 
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 53a16b8b6ac2..8e33e6e59e68 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -1001,11 +1001,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > >  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > >  	}
> > >  
> > > -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > > -	val &= ~PORT_LINK_FAST_LINK_MODE;
> > > -	val |= PORT_LINK_DLL_LINK_EN;
> > > -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > > -
> > >  	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
> > >  		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> > >  		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> > > @@ -1013,6 +1008,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > >  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> > >  	}
> > >  
> > > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > > +	val &= ~PORT_LINK_FAST_LINK_MODE;
> > > +	val |= PORT_LINK_DLL_LINK_EN;
> > > +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > > +
> > >  	if (!pci->num_lanes) {
> > >  		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > >  		return;
> > > -- 
> > > 2.25.1
> > > 
> > > 
