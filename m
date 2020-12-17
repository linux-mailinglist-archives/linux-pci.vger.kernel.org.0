Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB652DD374
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 15:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgLQO7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 09:59:41 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:43720 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgLQO7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2020 09:59:40 -0500
Received: by mail-oo1-f53.google.com with SMTP id y14so3561873oom.10;
        Thu, 17 Dec 2020 06:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5VjKnDqQoi4q0yPvGH6QyQ5V2T/NqP9kdac1+AUhHgA=;
        b=DaddrN3FV4i2u/J6rbxP08/NigG4ojsM9wSiDprGjVfaPA2S5Rv5IGjHUPYf3zjCNS
         1tGguPu6u1B6RmEtsyNRB2pFc+TUiJ6F68dXATIEOmrwMWCcQOC/bRbyhrXGGXrMJqkf
         MN9oHyVQ6p0b4aMo2QFGiyYA1Srl0gkQXN5TQLnuKIlRTfH5+BqFPe8S3icAkWGtzKCt
         dykxY77O/rWyDI06Kg96lRebkH1cfIFlntmgPl/YqbPCeog1ICvDv2d8LEHwR+JexK9h
         s5Ps36zP3ZmsCSkfncwltnQXBNRDtBh9mALg7ntO9xEWxImIyM6/WQjBanxzZsgnvBNu
         O2rw==
X-Gm-Message-State: AOAM531RcTPzT4m5EBIHpYEvJS2mA9w6dqcPqqFR1Lc3XnrjhjNyxsFC
        WW+KjS14yJyatMLYA5iGQQ==
X-Google-Smtp-Source: ABdhPJyJnrB34C0qZ7LoDwE1P5GLi9fASSOpxm3PgAm6Kqnhbc7Yqv3DkfJjQ88pgai4kxPkB1yH/Q==
X-Received: by 2002:a4a:ded4:: with SMTP id w20mr28734536oou.49.1608217139053;
        Thu, 17 Dec 2020 06:58:59 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s9sm1124774oie.53.2020.12.17.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:58:58 -0800 (PST)
Received: (nullmailer pid 3949962 invoked by uid 1000);
        Thu, 17 Dec 2020 14:58:57 -0000
Date:   Thu, 17 Dec 2020 08:58:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dwc: tegra194: issue with card containing a bridge
Message-ID: <20201217145857.GA3941403@robh.at.kernel.org>
References: <20201215102442.GA20517@suse.de>
 <9a8abc90-cf18-b0c8-3bcb-efbe03f0ca4c@nvidia.com>
 <20201215132504.GA20914@suse.de>
 <20201215154147.GA3885265@robh.at.kernel.org>
 <20201215205235.GC20914@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215205235.GC20914@suse.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 09:52:35PM +0100, Mian Yousaf Kaukab wrote:
> On Tue, Dec 15, 2020 at 09:41:47AM -0600, Rob Herring wrote:
> > On Tue, Dec 15, 2020 at 02:25:04PM +0100, Mian Yousaf Kaukab wrote:
> > > On Tue, Dec 15, 2020 at 05:45:59PM +0530, Vidya Sagar wrote:
> > > > Thanks Mian for bringing it to our notice.
> > > > Have you tried removing the dw_pcie_setup_rc(pp); call from pcie-tegra194.c
> > > > file on top of linux-next? and does that solve the issue?
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > index 5597b2a49598..1c9e9c054592 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > @@ -907,7 +907,7 @@ static void tegra_pcie_prepare_host(struct pcie_port
> > > > *pp)
> > > >                 dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
> > > > val);
> > > >         }
> > > > 
> > > > -       dw_pcie_setup_rc(pp);
> > > > +       //dw_pcie_setup_rc(pp);
> > > I still see the same issue with this change.
> > > Reverting b9ac0f9dc8ea works though.
> > > > 
> > > >         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > > 
> > > > I took a quick look at the dw_pcie_setup_rc() implementation and I'm not
> > > > sure why calling it second time should create any issue for the enumeration
> > > > of devices behind a switch. Perhaps I need to spend more time to debug that
> > > > part.
> > > > In any case, since dw_pcie_setup_rc() is already part of
> > > > dw_pcie_host_init(), I think it can be removed from
> > > > tegra_pcie_prepare_host() implemention.
> > 
> > I think the 2nd time is making the link go down is my guess. Tegra was 
> > odd in that its start/stop link functions don't do link handling, so I 
> > didn't implement those functions and left the link handling in the Tegra 
> > driver.
> > 
> > Can you try the below patch. It needs some more work as it breaks 
> > endpoint mode.

[...]

> Boot is ok with this patch. Some improvement in lspci as well:

Some improvement? Meaning not completely working still?

> # lspci
> 0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
> 0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
> 0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)
> 0005:01:00.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)

This patch was closer to the original flow, but would not have worked if 
DLFE disabled mode was needed.

Please give this patch a try:

8<--------------------------------------------------------
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5597b2a49598..0515897b2f3a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -853,12 +853,14 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 }
 
-static void tegra_pcie_prepare_host(struct pcie_port *pp)
+static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
+	pp->bridge->ops = &tegra_pci_ops;
+
 	if (!pcie->pcie_cap_base)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
@@ -907,10 +909,24 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
-	dw_pcie_setup_rc(pp);
-
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
+	return 0;
+}
+
+static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
+{
+	u32 val, offset, speed, tmp;
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct pcie_port *pp = &pci->pp;
+	bool retry = true;
+
+	if (pcie->mode == DW_PCIE_EP_TYPE) {
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
+	}
+
+retry_link:
 	/* Assert RST */
 	val = appl_readl(pcie, APPL_PINMUX);
 	val &= ~APPL_PINMUX_PEX_RST;
@@ -929,19 +945,10 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
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
+		if (!retry)
+			return 0;
 		/*
 		 * There are some endpoints which can't get the link up if
 		 * root port has Data Link Feature (DLF) enabled.
@@ -975,10 +982,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
 		dw_pcie_writel_dbi(pci, offset, val);
 
-		tegra_pcie_prepare_host(pp);
+		tegra_pcie_dw_host_init(pp);
+		dw_pcie_setup_rc(pp);
 
-		if (dw_pcie_wait_for_link(pci))
-			return 0;
+		retry = false;
+		goto retry_link;
 	}
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
@@ -998,15 +1006,6 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
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
