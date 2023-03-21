Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC146C3994
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 19:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCUSwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 14:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCUSwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 14:52:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103FBDC9;
        Tue, 21 Mar 2023 11:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81ACFB81977;
        Tue, 21 Mar 2023 18:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF96C433D2;
        Tue, 21 Mar 2023 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679424750;
        bh=OYQIvSSfu+5pnXb7ch/rzsrmHUW3SLly7IYqnR7JYI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aF8fgigZ7V53bAZL34wXeB+rj+1wJtymL88yTdNNM5XIkM09r4znMQQ758BpGAgKv
         RIcm8oEEzTRntOOEkR5VCetMbdVEBGPiKBzKGyiEQ9DcOmdEiEvyBwTT+Au95GHEwc
         YDMKPgzib+C+vAEnwFg9oDPEOv9WgzUgFV29HWBHbn77vViFRDZstcA5nxgk63ouH8
         AnPB/t/5ne9pwDjbhGc1n+rLnhQzkHHAi+2Dy30iQ1LrcmryC40p2yXbT+yvPpx+3s
         LEOwsqeE7Rz9F7HMLebhIWem2KnAbdSsOl7JVXowHqNwlqHaVChU1N2UAMpnu9vBjC
         fhZ/n7UZSDxlg==
Date:   Tue, 21 Mar 2023 13:52:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 01/13] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230321185228.GA2405946@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321090255.cca6xowea6k6fud4@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 12:02:55PM +0300, Serge Semin wrote:
> On Fri, Mar 10, 2023 at 09:34:58PM +0900, Yoshihiro Shimoda wrote:
> > The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> > "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> > the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> > Therefore, unexpected register value is possible to be used
> > to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> > So, change reading timing of PCIE_PORT_LINK_CONTROL register to fix
> > the issue.
> 
> My version of the commit log:
> < If CDM_CHECK capability is set then the local variable 'val' will be
> < overwritten in the dw_pcie_setup() method in the PL_CHK register
> < initialization procedure. Thus further variable usage in the framework of
> < the PCIE_PORT_LINK_CONTROL register initialization at the very least must
> < imply the variable re-initialization. Alas it hasn't been taken into
> < account in the commit ec7b952f453c ("PCI: dwc: Always enable CDM check if
> < "snps,enable-cdm-check" exists"). Due to that the PCIE_PORT_LINK_CONTROL
> < register will be written with an improper value in case if the CDM-check
> < is enabled. Let's fix this by moving the PCIE_PORT_LINK_CONTROL CSR
> < updated to be fully performed after the PL_CHK register
> < initialization.
> 
> > 
> > Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Looks good. Thanks.
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> @Bjorn, if it's possible could you please take this patch to a
> fixes(-ish) branch of your tree and merge it in the next rc-cycle?
> It definitely fixes a bug in the DW PCIe core driver.

I applied this patch only to for-linus for v6.3.  I adapted the commit
message as follows, let me know if you spot a mistake:

  PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled
  
  If CDM_CHECK is enabled (by the DT "snps,enable-cdm-check" property), 'val'
  is overwritten by PCIE_PL_CHK_REG_CONTROL_STATUS initialization.  Commit
  ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check"
  exists") did not account for further usage of 'val', so we wrote improper
  values to PCIE_PORT_LINK_CONTROL when the CDM check is enabled.
  
  Move the PCIE_PORT_LINK_CONTROL update to be completely after the
  PCIE_PL_CHK_REG_CONTROL_STATUS register initialization.
  
  [bhelgaas: commit log adapted from Serge's version]

> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 53a16b8b6ac2..8e33e6e59e68 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1001,11 +1001,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> >  	}
> >  
> > -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > -	val &= ~PORT_LINK_FAST_LINK_MODE;
> > -	val |= PORT_LINK_DLL_LINK_EN;
> > -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > -
> >  	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
> >  		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> >  		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> > @@ -1013,6 +1008,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> >  	}
> >  
> > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > +	val &= ~PORT_LINK_FAST_LINK_MODE;
> > +	val |= PORT_LINK_DLL_LINK_EN;
> > +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > +
> >  	if (!pci->num_lanes) {
> >  		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> >  		return;
> > -- 
> > 2.25.1
> > 
> > 
