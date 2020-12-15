Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D672DB4A0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 20:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLOTpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 14:45:06 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40054 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLOTpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 14:45:03 -0500
Received: by mail-oi1-f177.google.com with SMTP id p126so24644764oif.7;
        Tue, 15 Dec 2020 11:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kNsHOYW0/K8Iw/DPKmzJWiiK5sZoFhksoB+F202yDgI=;
        b=EQSxl5+uN4JwLCQkIzY59sOry9wKt+MyiCS8mVRVqAGLFN+SzUO9ehvz5VOb6AX8wU
         BTQtHe86j9JS1LkPd+p08ndIkDUtbT57NPjbLARmOM3XYY24rxdz1vhoGLurciEipiM7
         TRdr0ssxbIREpBgteqyXwj8ZWfV3Y+Vd46aGQs1iagXvX9tFhwi/bx4hqHcqI0bYQ2aG
         mbpagDclUxFydedgdG0H93xrq44d6kSN5AM1H2PLKQuLXrZXyAoyotil/UNCsmQh1M1g
         bM5xcFihDq3ePyIXZEUfWOO1jMGD93VkREyGWpFKtF5bsEW9lDhwONOLSxMez6OIP7PH
         Sa7A==
X-Gm-Message-State: AOAM5312k+JSN5+4+mpylp+Q+Kzus0/Rtb1KuDzv27lwjq5kpFa93Gih
        4qkuSm1RGn+q4T33Kqt4rg==
X-Google-Smtp-Source: ABdhPJzyGPCRd6aOPZ84yOBugaetfFJzJ9XfDKDIGiN1+6b1Q2T76Wz5FwpgJzcjgEdf477sKwU+Ww==
X-Received: by 2002:aca:4989:: with SMTP id w131mr297784oia.83.1608061462761;
        Tue, 15 Dec 2020 11:44:22 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t72sm5240241oie.47.2020.12.15.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 11:44:21 -0800 (PST)
Received: (nullmailer pid 91098 invoked by uid 1000);
        Tue, 15 Dec 2020 19:44:21 -0000
Date:   Tue, 15 Dec 2020 13:44:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201215194421.GA89317@robh.at.kernel.org>
References: <20201215102442.GA20517@suse.de>
 <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
 <20201215132504.GA20914@suse.de>
 <20201215154147.GA3885265@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215154147.GA3885265@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 09:41:47AM -0600, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 02:25:04PM +0100, Mian Yousaf Kaukab wrote:
> > On Tue, Dec 15, 2020 at 05:45:59PM +0530, Vidya Sagar wrote:
> > > Thanks Mian for bringing it to our notice.
> > > Have you tried removing the dw_pcie_setup_rc(pp); call from pcie-tegra194.c
> > > file on top of linux-next? and does that solve the issue?
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 5597b2a49598..1c9e9c054592 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port
> > > *pp)
> > >                 dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
> > > val);
> > >         }
> > > 
> > > -       dw_pcie_setup_rc(pp);
> > > +       //dw_pcie_setup_rc(pp);
> > I still see the same issue with this change.
> > Reverting b9ac0f9dc8ea works though.
> > > 
> > >         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > 
> > > I took a quick look at the dw_pcie_setup_rc() implementation and I'm not
> > > sure why calling it second time should create any issue for the enumeration
> > > of devices behind a switch. Perhaps I need to spend more time to debug that
> > > part.
> > > In any case, since dw_pcie_setup_rc() is already part of
> > > dw_pcie_host_init(), I think it can be removed from
> > > tegra_pcie_prepare_host() implemention.
> 
> I think the 2nd time is making the link go down is my guess. Tegra was 
> odd in that its start/stop link functions don't do link handling, so I 
> didn't implement those functions and left the link handling in the Tegra 
> driver.
> 
> Can you try the below patch. It needs some more work as it breaks 
> endpoint mode.

That one missed some re-init. Try this one instead

8<--------------------------------------------------------------------

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5597b2a49598..d8fed3561e91 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -933,14 +933,24 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 
 static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-	u32 val, tmp, offset, speed;
-
 	pp->bridge->ops = &tegra_pci_ops;
 
 	tegra_pcie_prepare_host(pp);
 
+	return 0;
+}
+
+static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
+{
+	u32 val, offset, speed, tmp;
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct pcie_port *pp = &pci->pp;
+
+	if (pcie->mode == DW_PCIE_EP_TYPE) {
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
+	}
+
 	if (dw_pcie_wait_for_link(pci)) {
 		/*
 		 * There are some endpoints which can't get the link up if
@@ -998,15 +1008,6 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
-{
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-
-	enable_irq(pcie->pex_rst_irq);
-
-	return 0;
-}
-
 static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
