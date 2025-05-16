Return-Path: <linux-pci+bounces-27841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB3AB98ED
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49EC3A8D16
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F522FF5E;
	Fri, 16 May 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpTEnYeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80F22F76B;
	Fri, 16 May 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388053; cv=none; b=BXejlTKjacv1S7+goI0of4cY0KU25kHa814NbIA3KOWDZ20EARSpCcd3fVO7h2UyY4i0yv0FNm9zjyBs0m4CGNIm4Fs3JJ3p5UugcgZAd+cWLipGkguFk1RPaeUqh6QHalnf4/wuodzHG92L3JG87ncZkS6DskcO+TY3qOHsVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388053; c=relaxed/simple;
	bh=r/PSjbXy9CjaxKxTjIH4c/qfPkOWog12QPV34Z0bSMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MomC6UmcHhSMKjCJXVh3yekG24MQfnwAoH192IHLaDqXISm8HAIhm/oiebNyt+L2aRe87YJuEx+97q9i5siv6iFrK9it10ln+UQZJJ99+5w1bIFtjCC6skoLoYsSYuG0OJvPL8MWWwVk+3/NpXU+GRRjr2hQtfmcVOqKnjGon+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpTEnYeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02BDC4CEE4;
	Fri, 16 May 2025 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747388052;
	bh=r/PSjbXy9CjaxKxTjIH4c/qfPkOWog12QPV34Z0bSMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpTEnYeuhHxbdhFVuXDvyL0PIDev3vH8B4dnA6upfTyc7gxbf/RfhLS7A6Ds6zvhy
	 m14B0coZz+9+SRL8MyFmjZewoRkAZ5AX5FP+zfulLt86kDgGe1TQuuEOJSNApjeM6s
	 lxqFVuhkUtISatnD5TAwBP6NFU7tP2HyRuRz9M95U8nlvSji7Z8P5Y+UkBIpsvgm7T
	 0Y8wOPRcQnnPBPlqK3IKPmOqT4kJUtCT9aD909F7yfc6jJGCFYII/nZA7Zy7tKsOVN
	 oNRB93UqBkJasekS6ig9e7n2f/qAM8E+cgZaJkfSHMhZ0tW18HrATYe3BI1UjdKpW1
	 HXrA3RPPiz+Og==
Date: Fri, 16 May 2025 11:34:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kwilczynski@kernel.org>
Cc: Hans Zhang <Hans.Zhang@cixtech.com>, kernel test robot <lkp@intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbcGNpOnNsb3QtcmVz?=
 =?utf-8?Q?et_1=2F1=5D_drivers=2Fpci=2Fcontroller=2Fdwc=2Fpcie-dw-rockchip?=
 =?utf-8?Q?=2Ec=3A721=3A58=3A_error?= =?utf-8?Q?=3A?= use of undeclared
 identifier 'PCIE_CLIENT_GENERAL_CON'
Message-ID: <aCcGkN-9pN-jUwkS@ryzen>
References: <202505152337.AoKvnBmd-lkp@intel.com>
 <KL1PR0601MB4726782470E271865672B2079D90A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
 <20250515162405.GA511285@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515162405.GA511285@rocinante>

Hello Krzysztof,


FYI: your name appears corrupted in my inbox.

From: Krzysztof Wilczy��ski <your-email-address>

Perhaps because:
Content-Type: text/plain; charset=us-ascii

instead of UTF-8?


On Fri, May 16, 2025 at 01:24:05AM +0900, Krzysztof Wilczy��ski wrote:
> (+Cc Mani for visibility)
> 
> Hello,
> 
> > Please merge it into the following branch; otherwise, this compilation error will occur.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/pci/controller/dwc/pcie-dw-rockchip.c:721:58: error: use of undeclared identifier 'PCIE_CLIENT_GENERAL_CON'
> >      721 |         rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE, PCIE_CLIENT_GENERAL_CON);
> >          |                                                                 ^
> >    1 error generated.
> 
> Sorry about this!
> 
> I moved changes from the slot-reset to the controller/dw-rockchip branch,
> to make sure everything has proper dependencies now.  Hopefully, there
> won't be any more issues.


Comparing the commit that landed on the branch, with Wilfred's patch on the
mailing list, I did notice this diff:


diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 9a952871e4d0..c4bd7e0abdf0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -556,7 +556,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
                return ret;
        }
 
-       /* unmask DLL up/down indicator and hot reset/link-down reset irq */
+       /* Unmask DLL up/down indicator and hot reset/link-down reset IRQ. */
        val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
        rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
 
@@ -747,11 +747,11 @@ static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
 
        ret = pp->ops->init(pp);
        if (ret) {
-               dev_err(dev, "Host init failed: %d\n", ret);
+               dev_err(dev, "host init failed: %d\n", ret);
                goto deinit_clk;
        }
 
-       /* LTSSM enable control mode */
+       /* LTSSM enable control mode. */
        val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
        rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
@@ -762,11 +762,11 @@ static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
 
        ret = dw_pcie_setup_rc(pp);
        if (ret) {
-               dev_err(dev, "Failed to setup RC: %d\n", ret);
+               dev_err(dev, "failed to setup RC: %d\n", ret);
                goto deinit_clk;
        }
 
-       /* unmask DLL up/down indicator and hot reset/link-down reset irq */
+       /* Unmask DLL up/down indicator and hot reset/link-down reset IRQ. */
        val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
        rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
 
@@ -774,9 +774,9 @@ static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
        if (ret)
                goto deinit_clk;
 
-       /* Ignore errors, the link may come up later */
+       /* Ignore errors, the link may come up later. */
        dw_pcie_wait_for_link(pci);
-       dev_dbg(dev, "Slot reset completed\n");
+       dev_dbg(dev, "slot reset completed\n");
        return ret;
 
 deinit_clk:



Reviewing the diff, the changes looks fine to me, but I strongly think
that if the actual code is modified from the submission (rather than
just fixing some minor grammar in the commit message), the (unwritten?)
rule is that the person should add a:

[person: describe modifications from the original submission]

line after the Signed-off-by of the original submission, such that,
e.g. if there is a bug in one of the lines that were changed, the
original author does not unfairly get blamed for some code that he
didn't write.

When only modifying the commit log, there is no possibility that a
functional change was introduced, but as soon as the code/diff is
changed, there is a change that a functional change is introduced
(intentional or not), so there is a big difference between the cases
(in my humble opinion).


Kind regards,
Niklas

