Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1082DB052
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 16:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgLOPmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 10:42:33 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45093 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgLOPma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 10:42:30 -0500
Received: by mail-oi1-f177.google.com with SMTP id f132so23741021oib.12;
        Tue, 15 Dec 2020 07:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbSdKfHG54/E/3eD2yVHW2JO4FE/Mb+iNnd+PiM7f9Q=;
        b=cemtsBI3i7lvTbY4SouC7YLBfoszRSGJ0tzh2xCFMsA9kEsgdPEKiaOuobEDUEX73e
         4+zFi/UtpeTBYISwWVi3kvl+tMzGne0IVjCi3xeRN1fSJqbfgyHNwZD9lUlhLtd4m6Wh
         VCcvcsFC8GpxS4BhDhC5uBaiQ367oij/ioo8hOJC9NOyDOU7sOM0VF9dBycMRrH2achJ
         IpFkPrS9++DhL33xm2v9Of9jFeKgF4lFPCNUshqRS71e32UIDm2jnRbpy93AVEKnDcjC
         uqfbHVVYD7tVGUpyBBHTQUjDpbpLxGYELcyVnXTOg4r/+vOilFJiRTZYXm6pz6hg3qPz
         NjrQ==
X-Gm-Message-State: AOAM533n5YGulHEduZ0J7BVF98FqeLpA/Lo3QujxTPbBwW07C7OlQ8UD
        ZbeH0v76PuYLQHR5EycTmGyuDLyMdw==
X-Google-Smtp-Source: ABdhPJwpjJlFsNVoUGgLP7QP6orUNf6ZCw3S+UX6zIhpbnj9iGfNsG1e/BJ8cE3fPOmQvNXoPQvukA==
X-Received: by 2002:a05:6808:18:: with SMTP id u24mr6819744oic.89.1608046909781;
        Tue, 15 Dec 2020 07:41:49 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j2sm482463otq.78.2020.12.15.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 07:41:48 -0800 (PST)
Received: (nullmailer pid 3901273 invoked by uid 1000);
        Tue, 15 Dec 2020 15:41:47 -0000
Date:   Tue, 15 Dec 2020 09:41:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201215154147.GA3885265@robh.at.kernel.org>
References: <20201215102442.GA20517@suse.de>
 <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
 <20201215132504.GA20914@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215132504.GA20914@suse.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 02:25:04PM +0100, Mian Yousaf Kaukab wrote:
> On Tue, Dec 15, 2020 at 05:45:59PM +0530, Vidya Sagar wrote:
> > Thanks Mian for bringing it to our notice.
> > Have you tried removing the dw_pcie_setup_rc(pp); call from pcie-tegra194.c
> > file on top of linux-next? and does that solve the issue?
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 5597b2a49598..1c9e9c054592 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port
> > *pp)
> >                 dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
> > val);
> >         }
> > 
> > -       dw_pcie_setup_rc(pp);
> > +       //dw_pcie_setup_rc(pp);
> I still see the same issue with this change.
> Reverting b9ac0f9dc8ea works though.
> > 
> >         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > 
> > I took a quick look at the dw_pcie_setup_rc() implementation and I'm not
> > sure why calling it second time should create any issue for the enumeration
> > of devices behind a switch. Perhaps I need to spend more time to debug that
> > part.
> > In any case, since dw_pcie_setup_rc() is already part of
> > dw_pcie_host_init(), I think it can be removed from
> > tegra_pcie_prepare_host() implemention.

I think the 2nd time is making the link go down is my guess. Tegra was 
odd in that its start/stop link functions don't do link handling, so I 
didn't implement those functions and left the link handling in the Tegra 
driver.

Can you try the below patch. It needs some more work as it breaks 
endpoint mode.

8<--------------------------------------------------------------------

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 648e731bccfa..49bb487b16ae 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -907,9 +907,32 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
-	dw_pcie_setup_rc(pp);
-
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
+}
+
+static int tegra_pcie_dw_host_init(struct pcie_port *pp)
+{
+	pp->bridge->ops = &tegra_pci_ops;
+
+	tegra_pcie_prepare_host(pp);
+	tegra_pcie_enable_interrupts(pp);
+
+	return 0;
+}
+
+static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
+{
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
+
+	return !!(val & PCI_EXP_LNKSTA_DLLLA);
+}
+
+static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
+{
+	u32 val, offset, speed, tmp;
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct pcie_port *pp = &pci->pp;
 
 	/* Assert RST */
 	val = appl_readl(pcie, APPL_PINMUX);
@@ -929,17 +952,6 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	appl_writel(pcie, val, APPL_PINMUX);
 
 	msleep(100);
-}
-
-static int tegra_pcie_dw_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-	u32 val, tmp, offset, speed;
-
-	pp->bridge->ops = &tegra_pci_ops;
-
-	tegra_pcie_prepare_host(pp);
 
 	if (dw_pcie_wait_for_link(pci)) {
 		/*
@@ -975,7 +987,8 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
 		dw_pcie_writel_dbi(pci, offset, val);
 
-		tegra_pcie_prepare_host(pp);
+		tegra_pcie_dw_host_init(pp);
+		dw_pcie_setup_rc(pp);
 
 		if (dw_pcie_wait_for_link(pci))
 			return 0;
@@ -985,25 +998,6 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 		PCI_EXP_LNKSTA_CLS;
 	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
 
-	tegra_pcie_enable_interrupts(pp);
-
-	return 0;
-}
-
-static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
-{
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
-
-	return !!(val & PCI_EXP_LNKSTA_DLLLA);
-}
-
-static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
-{
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-
-	enable_irq(pcie->pex_rst_irq);
-
 	return 0;
 }
 
