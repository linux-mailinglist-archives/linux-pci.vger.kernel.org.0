Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12C5403FF9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 21:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352201AbhIHTob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 15:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235043AbhIHToI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 15:44:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A23D61175;
        Wed,  8 Sep 2021 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631130179;
        bh=lsxX5ns0vd9qjIxl0tkZDbvNTXIGeC6E6WDGq/Z4uiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0s4fH58Kb+xlt9Jnh+qVRFBFbpARCHW7WP1LjrCNkRab9krOtSQLwMSlAmmXmkAZ
         OO5mEXI5bu9sQwuG0ialv9OpFGgO20W5nubFXZYl4HjsVcowx1RSH416W63Aj5E0oZ
         kjVKX2wBXL2oINGsqXAuNRvuaan5YT8NZEkg8NELg9aU7ltzjvjh8Uwm+WT2sfkxv1
         O8XyeS6KrU+FBIPWUdN5et6dmQIcjyTPr4heBWl0GDMDC+9O+UCiQmb6ZqQbC7OADz
         BnzOzpWov7QbCCJdeqjEBCtGsdOUWfKdRqifsh6Z1q/GKTxUHbKXF2qz58bMGwxra8
         ymqFYw+iOV1OQ==
Received: by pali.im (Postfix)
        id 59229708; Wed,  8 Sep 2021 21:42:57 +0200 (CEST)
Date:   Wed, 8 Sep 2021 21:42:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 5/5] PCI: aardvark: Implement workaround for PCIe
 Completion Timeout
Message-ID: <20210908194257.nhn4iexqkzdv7ijz@pali>
References: <20210624222621.4776-1-pali@kernel.org>
 <20210624222621.4776-6-pali@kernel.org>
 <20210825195953.7ylfnplurhfixabg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825195953.7ylfnplurhfixabg@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 25 August 2021 21:59:53 Pali Rohár wrote:
> On Friday 25 June 2021 00:26:21 Pali Rohár wrote:
> > Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
> > document describes in erratum 3.12 PCIe Completion Timeout (Ref #: 251),
> > that PCIe IP does not support a strong-ordered model for inbound posted vs.
> > outbound completion.
> > 
> > As a workaround for this erratum, DIS_ORD_CHK flag in Debug Mux Control
> > register must be set. It disables the ordering check in the core between
> > Completions and Posted requests received from the link.
> > 
> > It was reported that enabling this workaround fixes instability issues and
> > "Unhandled fault" errors when using 60 GHz WiFi 802.11ad card with Qualcomm
> > QCA6335 chip under significant load which were caused by interrupt status
> > stuck in the outbound CMPLT queue traced back to this erratum.
> > 
> > This workaround fixes also kernel panic triggered after some minutes of
> > usage 5 GHz WiFi 802.11ax card with Mediatek MT7915 chip:
> > 
> >     Internal error: synchronous external abort: 96000210 [#1] SMP
> >     Kernel panic - not syncing: Fatal exception in interrupt
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> > Patch was originally written by Thomas and is already for a long time part
> > of Marvell SDK. I have just re-written/re-applied it on top of mainline
> > kernel and also wrote a new updated commit message.
> > 
> > Please note that this patch is questionable as Bjorn has some objections
> > and nobody, including Marvell, was not able to explain erratum nor what
> > is workaround exactly doing. Documentation about this topic is basically
> > missing.
> 
> See also https://lore.kernel.org/linux-pci/20210723221710.wtztsrddudnxeoj3@pali/

Hello Lorenzo. For now let just this one patch (5/5) as is. As we do not
know how to process this issue and there is open (above) question.

I hope that Marvell people would respond to this above issue.

Other remaining patches in this series are fine.

> > We just know that it fixes real kernel crashes when using WiFi cards.
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 9ff68abd8d1e..231f4469d87e 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -167,6 +167,8 @@
> >  #define     LTSSM_L0				0x10
> >  #define     RC_BAR_CONFIG			0x300
> >  #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
> > +#define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
> > +#define     DIS_ORD_CHK				BIT(30)
> >  
> >  /* PCIe core controller registers */
> >  #define CTRL_CORE_BASE_ADDR			0x18000
> > @@ -450,6 +452,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  		PCIE_CORE_CTRL2_TD_ENABLE;
> >  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
> >  
> > +	/* Disable ordering checks, workaround for erratum 3.12 "PCIe completion timeout" */
> > +	reg = advk_readl(pcie, DEBUG_MUX_CTRL_REG);
> > +	reg |= DIS_ORD_CHK;
> > +	advk_writel(pcie, reg, DEBUG_MUX_CTRL_REG);
> > +
> >  	/* Set lane X1 */
> >  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> >  	reg &= ~LANE_CNT_MSK;
> > -- 
> > 2.20.1
> > 
