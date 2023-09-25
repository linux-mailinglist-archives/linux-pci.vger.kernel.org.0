Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497A07AD68E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjIYLBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIYLBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 07:01:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779AECE;
        Mon, 25 Sep 2023 04:01:08 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso102397511fa.1;
        Mon, 25 Sep 2023 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695639666; x=1696244466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eTBxZZU7UuADeXMDeF8c920iXLcf57XjxaCYN0qlUg=;
        b=dnU1W3jG/WCLwzIlxetncICrE5TQHSZ1QKGf4iPFpo9n4Fxy4spgunebDgekmixMYv
         m1bABBnp3Ot2tUiC+WnzwsQMyoD/rvT2lwPBpNju/wbrti4JpQcGeeL3NU6qwHRyRm+l
         N9Wesfh8DQ2ek73hWsYYJH09T7MgJQelNMqF98oWEUkodOgDzXcdCiMV850BB8aTDlbE
         qEw4FA+Bns+nIjRzc3fhBoP9ca+zl90QetKPN1HZY8yYgwuA8krYRUYradkOxtZHYGbB
         kWebjZMCdjpsrpDJYv+ZZWK/l/Ot6nMbCSzdIN8cMVVhasmwkUNsIIXWZt/gsr78YOMr
         L0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639666; x=1696244466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eTBxZZU7UuADeXMDeF8c920iXLcf57XjxaCYN0qlUg=;
        b=s683YCrSZOy8z/Ff7aBHrZvIlJ6Ov60DwPBduJ/wbxihT7dnYcgHEGKGssi9hTkTE5
         mw6d9EZxKVjN3wmavnTIPCqOtKnU0EXVHB98VXbQVeURMKCAVCII65Yhzubc4OatDLaQ
         vY5RH2K59eltvy6cLo77ZXXyiLhGvyranG8SFVN5yIomWkcYJWKDSXV8k/ECQmZHnaCE
         2riP2CtNda30J1aQf3daRpzIg+JQbeCsO/JiqvPYg73aVz1brFJPM38/SYbRvdkL8uQD
         Lz3HwnYFQCe/jL95eTEeM9jWd868BEYWJcKfJalUH/NxjcnzdinZ/m77bN043R4/Svzs
         X6yg==
X-Gm-Message-State: AOJu0YwriH2zJfEYWHBVYT8EL509W8pH9Q/DBRrxmP0MM+zenkDLFDuB
        0PN5p/ozQeBgQNrcJQaKc4Q=
X-Google-Smtp-Source: AGHT+IGwevIX8bLx2iVFmRaDv8ZLLfTYrHbf5jK0+ffPQNklJPV2bKmphiwrJXTlkHNpmg6ncfNG5Q==
X-Received: by 2002:a2e:9b01:0:b0:2bc:c3ad:f41b with SMTP id u1-20020a2e9b01000000b002bcc3adf41bmr5520078lji.2.1695639666262;
        Mon, 25 Sep 2023 04:01:06 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j23-20020a2e3c17000000b002bff365c7bfsm2137100lja.35.2023.09.25.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:01:05 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:01:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v22 08/16] PCI: dwc: endpoint: Introduce .pre_init() and
 .deinit()
Message-ID: <f4fc5zajzr7b7ewvejsfjmcaf2ulutfvz6zzvnyxzdn7a5vza2@frx5sfjcco4l>
References: <20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com>
 <20230925072130.3901087-9-yoshihiro.shimoda.uh@renesas.com>
 <enciy4d6trdw5yaltdk6uytllljod7e54e3fsk7a3ht44j3azc@d5bethiemcxj>
 <TYBPR01MB5341BD0A0B2B7500ED6DBB7FD8FCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB5341BD0A0B2B7500ED6DBB7FD8FCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro

On Mon, Sep 25, 2023 at 10:24:07AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Monday, September 25, 2023 7:08 PM
> > 
> > On Mon, Sep 25, 2023 at 04:21:22PM +0900, Yoshihiro Shimoda wrote:
> > > Renesas R-Car Gen4 PCIe controllers require vendor-specific
> > > initialization before .init().
> > >
> > > To use dw->dbi and dw->num-lanes in the initialization code,
> > > introduce .pre_init() into struct dw_pcie_ep_ops. While at it,
> > > also introduce .deinit() to disable the controller by using
> > > vendor-specific de-initialization.
> > >
> > > Note that the ep_init in the struct dw_pcie_ep_ops should be
> > > renamed to init later.
> > >
> > > [kwilczynski: commit log]
> > > Link:
> > > https://lore.kernel.org/linux-pci/20230825093219.2685912-13-yoshihiro.shimoda.uh@renesas.com/
> > > 
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
> > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index a8bcbc57ef86..d34a5e87ad18 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -637,6 +637,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > >  			      epc->mem->window.page_size);
> > >
> > >  	pci_epc_mem_exit(epc);
> > > +
> > > +	if (ep->ops->deinit)
> > > +		ep->ops->deinit(ep);
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
> > >
> > > @@ -740,6 +743,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	ep->phys_base = res->start;
> > >  	ep->addr_size = resource_size(res);
> > >
> > > +	if (ep->ops->pre_init)
> > > +		ep->ops->pre_init(ep);
> > > +
> > >  	dw_pcie_version_detect(pci);
> > >
> > >  	dw_pcie_iatu_detect(pci);
> > > @@ -794,7 +800,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  			       ep->page_size);
> > >  	if (ret < 0) {
> > >  		dev_err(dev, "Failed to initialize address space\n");
> > > -		return ret;
> > > +		goto err_ep_deinit;
> > >  	}
> > >
> > >  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > > @@ -831,6 +837,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  err_exit_epc_mem:
> > >  	pci_epc_mem_exit(epc);
> > >
> > > +err_ep_deinit:
> > > +	if (ep->ops->deinit)
> > > +		ep->ops->deinit(ep);
> > > +
> > >  	return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index e10f7e18b13a..8c637392ab08 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -330,7 +330,9 @@ struct dw_pcie_rp {
> > >  };
> > >
> > >  struct dw_pcie_ep_ops {
> > 
> > > +	void	(*pre_init)(struct dw_pcie_ep *ep);
> > >  	void	(*ep_init)(struct dw_pcie_ep *ep);
> > > +	void	(*deinit)(struct dw_pcie_ep *ep);
> > 
> > Please, note you promised to release sometime in future a cleanup
> > patch which drops the "ep_" prefix from here and from the
> > dw_pcie_host_ops structure.)
> > 
> > https://lore.kernel.org/linux-pci/20230802104049.GB57374@thinkpad/
> 

> Since this patch series is not merged into the pci.git / next branch yet,
> I should not include any cleanup patches, I think. In other words, this patch
> series still seems under review now.

Yeah. BTW sorry to hear that. Get new comments after you have already
got your series merged in. It must have been frustrating for you.
Sometimes it happens though...(

But my message was relevant to another series, which you hopefully
will submit sometimes later. It was just a reminder in addition to the
notes you placed in the commit log to the patch:
[PATCH v22 01/16] PCI: dwc: endpoint: Add multiple PFs support for dbi2

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > 
> > -Serge(y)
> > 
> > >  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> > >  			     enum pci_epc_irq_type type, u16 interrupt_num);
> > >  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> > > --
> > > 2.25.1
> > >
