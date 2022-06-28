Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B195D55D8CA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiF1Lms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344308AbiF1Lmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 07:42:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48503335C;
        Tue, 28 Jun 2022 04:42:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x3so21818459lfd.2;
        Tue, 28 Jun 2022 04:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xKv0jSbhATLdx/2YfNSCHZ2Xwoi8Xh24Aoj/0OhvT4U=;
        b=hT+Hxe3Jbrwrkigmz+hXYy1wTm87YEJ1Ogs7gLj6E71bVSq55ORHEWDCIfgNf76h26
         uaZ498T6Ae1hDbH54YuUhKvk5oRB4ku0keW/WC5kyAzIp1NDDpG+AKbzGAjc6jqiSDr6
         apfGS9fRKOLLZCOjsOCJaKRNoKc6IXKK4zTHySjqM7tn3iGBwOW7h96Rj+9O552j1pdd
         IN7mVEU1z+y0iZKDxi+z/6YYriN9NoCL1LeL5v6jVKxZwWCWI10nCjZoa4FVuLT9z7gw
         ojsBuYHPZbzikaRSjFolcPqJfHeh/xJbbwKl3GKk6f4WyjunwmIpPtyrfh140lgfOC9w
         iHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xKv0jSbhATLdx/2YfNSCHZ2Xwoi8Xh24Aoj/0OhvT4U=;
        b=5MvxvxT5f0OUHLBsQGJrJ5wy8/aG/jvXUTfcLm/81vBGBgEH7Na37bY1HPWcZqAnKY
         b1LCtTru9Xa5ukiahKpzyZo8R2MDJwvLO+bIgoJxlntfARXeJBhBaSaIdkmxLsgBQDox
         xXNEw7J5XVU9A1D8qyn8M6n1C+tZhAGeAn9rMx8Hu/+qfxVNjBXzhWoE7auIRQQtmbwr
         CXl1gVwaIR1+c5zvRDX9Vcl8q3EHiU1Uxk7Xz3FTlntemia0elxHm1LOdwBXiLrfDUDV
         rxo0JNgxyi/Tevva/xpt+NB5x3V0+WlUiskVSsU0+DRkppUXbmmQEQkvaHa6LRY2XuC4
         tj9A==
X-Gm-Message-State: AJIora8+Q9uXB1v2xcB3+ncLKa7ejyPAZiieYz3jAVRkiq3xje2QUcam
        hYjZrMbyyMhaTeiANtjCoTix3h2cUsQknQ==
X-Google-Smtp-Source: AGRyM1sPAajM1xgbnaqEvZ5NvM5rnKT4pFfwoMEpbbSlZ6VmuRKkBKKrBzKWV5Z1hyikXE1dcMqFpw==
X-Received: by 2002:a05:6512:39d0:b0:481:ed:666 with SMTP id k16-20020a05651239d000b0048100ed0666mr12224325lfu.379.1656416550857;
        Tue, 28 Jun 2022 04:42:30 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id 22-20020ac25f56000000b00481153a3c13sm1118425lfz.205.2022.06.28.04.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:42:29 -0700 (PDT)
Date:   Tue, 28 Jun 2022 14:42:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Chocron <jonnyc@amazon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH RESEND v5 03/18] PCI: dwc: Disable outbound windows for
 controllers with iATU
Message-ID: <20220628114226.frdsgk2xe2o7z5xx@mobilestation>
References: <20220624143428.8334-4-Sergey.Semin@baikalelectronics.ru>
 <20220627224058.GA1784787@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627224058.GA1784787@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

On Mon, Jun 27, 2022 at 05:40:58PM -0500, Bjorn Helgaas wrote:
> [+cc Jonathan for pcie-al.c, Kishon for pci-keystone.c]
> 
> On Fri, Jun 24, 2022 at 05:34:13PM +0300, Serge Semin wrote:
> > In accordance with the dw_pcie_setup_rc() method semantics and judging by
> > what the comment added in commit dd193929d91e ("PCI: designware: Explain
> > why we don't program ATU for some platforms") states there are DWC
> > PCIe-available platforms like Keystone (pci-keystone.c) or Amazon's
> > Annapurna Labs (pcie-al.c) which don't have the DW PCIe internal ATU
> > enabled and use it's own address translation approach implemented. In
> > these cases at the very least there is no point in touching the DW PCIe
> > iATU CSRs. Moreover depending on the vendor-specific address translation
> > implementation it might be even erroneous. So let's move the iATU windows
> > disabling procedure to being under the corresponding conditional statement
> > clause thus performing that procedure only if the iATU is expected to be
> > available on the platform.
> 

> Added Jonathan and Kishon to make sure pcie-al.c and pci-keystone.c
> (the only two drivers that override the default dw_child_pcie_ops)
> won't be broken by skipping the outbound window disable.

Makes sense. Thanks.

> 
> > Fixes: 458ad06c4cdd ("PCI: dwc: Ensure all outbound ATU windows are reset")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index bc9a7df130ef..d4326aae5a32 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -543,7 +543,6 @@ static struct pci_ops dw_pcie_ops = {
> >  
> >  void dw_pcie_setup_rc(struct pcie_port *pp)
> >  {
> > -	int i;
> >  	u32 val, ctrl, num_ctrls;
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  
> > @@ -594,19 +593,22 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> >  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> >  
> > -	/* Ensure all outbound windows are disabled so there are multiple matches */
> > -	for (i = 0; i < pci->num_ob_windows; i++)
> > -		dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
> > -
> >  	/*
> >  	 * If the platform provides its own child bus config accesses, it means
> >  	 * the platform uses its own address translation component rather than
> >  	 * ATU, so we should not program the ATU here.
> >  	 */
> >  	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> > -		int atu_idx = 0;
> > +		int i, atu_idx = 0;
> >  		struct resource_entry *entry;
> >  
> > +		/*
> > +		 * Ensure all outbound windows are disabled so there are
> > +		 * multiple matches
> 

> I know you only moved this comment and didn't change the wording, but
> do you know what it means?  What "multiple matches" is it talking
> about, and why are they important?

AFAIU the In/Out-bound windows disabling procedure is a kind of
cleanup-before-usage pattern. So if the DW PCIe controller has been
used by a bootloader with non-DT-based (dma-)ranges setup, and hasn't
been reset by the low-level driver, some windows can be left
opened/configured. It may cause unpleasant side effects on the further
controller utilization. Although I don't see much room for the bugs in
this part since the iATU setup is overwritten from lowest index to the
highest one afterwards anyway and in accordance with the HW ref.
manual the first-match region will be used for the CPU<->PCIe IOs
translation. Basically should we leave the in/out-bound windows setup
uncleared the only thing that may cause problems/unexpected IO results
is the not-overridden iATU regions. It won't be that much of the
problem, but more like an unexpected behaviour, for instance, a random
MWr/MRd TLPs (depending on the bootloader iATU setup) generation on an
attempt to access some MMIO ranges, which aren't supposed to be used
by the system anyway.

Anyway as Rob said in the commit 458ad06c4cdd ("PCI: dwc: Ensure all
outbound ATU windows are reset") indeed it won't hurt to perform the
cleanup. It shall make the system state more predictable.

> 
> I guess Rob previously moved it with 458ad06c4cdd ("PCI: dwc: Ensure
> all outbound ATU windows are reset") [1], and it looks like maybe the
> point is to *avoid* having an outbound transaction match multiple
> windows?  So maybe this comment should say this?
> 
>   Disable all outbound windows to make sure a transaction can't match
>   multiple windows.

You are right. I can fix the text on v6 of the series.

-Sergey

> 
> [1] https://git.kernel.org/linus/458ad06c4cdd
> 
> > +		 */
> > +		for (i = 0; i < pci->num_ob_windows; i++)
> > +			dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
> > +
> >  		/* Get last memory resource entry */
> >  		resource_list_for_each_entry(entry, &pp->bridge->windows) {
> >  			if (resource_type(entry->res) != IORESOURCE_MEM)
> > -- 
> > 2.35.1
> > 
