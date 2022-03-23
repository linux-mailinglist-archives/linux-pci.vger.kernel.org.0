Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306954E4AFA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 03:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiCWCiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbiCWCip (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 22:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6370857;
        Tue, 22 Mar 2022 19:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA434614D1;
        Wed, 23 Mar 2022 02:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC36C340EC;
        Wed, 23 Mar 2022 02:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648003036;
        bh=lidTMFrvgsD4QNxlYdNfhfYSm5MsACsoLgJwIQ3WW6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QJWgbJaKhND3p8maoI9Bjz9VY0auADyH0KFPYaLcCYy6fC8PuTUakQRgw8aTfDCB3
         m8tbXe4UdlAXTJ84jVqmQwpebyGCrNBCVkkZjwGXS/R7pUtQZiCOMV7pt4ThkuJ7BY
         9HRD51pyi1lSm8Yx+ij+o8j9Fyeji7fF37z6ywu8TCX/Ok+PZdOrcKJNow92AwjCP4
         +/Vla3UiUsKkrNP6i/8i25Gmchy85p4I3z34evPt+ixn009tqvHujKd/r95e0yA5E+
         qGOoO+O5qkEGeU4A9t5kNYavFSMfmSU5xIs2WjX/cC25r7V6Ji6VytyU22HVXPeVM3
         qeRSfoDXl0TeQ==
Date:   Tue, 22 Mar 2022 21:37:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: cadence: Enable Controller to respond to
 received PTM Requests
Message-ID: <20220323023714.GA1244184@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH9NwWec6ovS1xQbuPsB5duskJdmK_qv4t+URTK6thCvGNST7w@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 22, 2022 at 02:20:14PM +0100, Christian Gmeiner wrote:
> Am Do., 10. März 2022 um 13:14 Uhr schrieb Christian Gmeiner
> <christian.gmeiner@gmail.com>:
> >
> > Hi all
> >
> > > This enables the Controller [RP] to automatically respond with
> > > Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
> > > and PCI_PTM_CTRL_ENABLE bits are both set.
> > >
> > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>

We're in the middle of the merge window right now, but I'm sure
Lorenzo will be able to look at it after -rc1.  This looks fine to me.

> > > ---
> > >  drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
> > >  2 files changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > > index fb96d37a135c..940c7dd701d6 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > > @@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
> > >         return ret;
> > >  }
> > >
> > > +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> > > +{
> > > +       u32 val;
> > > +
> > > +       val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> > > +       cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);

Lorenzo will likely wrap this line to fit in 80 columns like the rest
of the file, or if you rebase to v5.18-rc1 and post a v3, you could do
so.

> > > +}
> > > +
> > >  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
> > >  {
> > >         struct cdns_pcie *pcie = &rc->pcie;
> > > @@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> > >         if (rc->quirk_detect_quiet_flag)
> > >                 cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
> > >
> > > +       cdns_pcie_host_enable_ptm_response(pcie);
> > > +
> > >         ret = cdns_pcie_start_link(pcie);
> > >         if (ret) {
> > >                 dev_err(dev, "Failed to start link\n");
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> > > index c8a27b6290ce..1ffa8fa77a8a 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > > @@ -116,6 +116,10 @@
> > >  #define LM_RC_BAR_CFG_APERTURE(bar, aperture)          \
> > >                                         (((aperture) - 2) << ((bar) * 8))
> > >
> > > +/* PTM Control Register */
> > > +#define CDNS_PCIE_LM_PTM_CTRL  (CDNS_PCIE_LM_BASE + 0x0da8)
> > > +#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN  BIT(17)
> > > +
> > >  /*
> > >   * Endpoint Function Registers (PCI configuration space for endpoint functions)
> > >   */
> > > --
> > > 2.35.1
> > >
> >
> > This patch should be ready to land - or is anything missing?
> >
> 
> Gentle ping.
> 
> -- 
> greets
> --
> Christian Gmeiner, MSc
> 
> https://christian-gmeiner.info/privacypolicy
