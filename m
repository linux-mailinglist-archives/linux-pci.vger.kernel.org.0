Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877CC2DC4F4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgLPRCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 12:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgLPRCp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Dec 2020 12:02:45 -0500
X-Gm-Message-State: AOAM533OsBuIwTVqNzlRfibVm9AM5mXA1Jrppwlm6E1QzO+eBrr/DI4J
        msXruEgaccDdvN19H/j+Gx/1O4evZBLJAFQPVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608138125;
        bh=VBS+XyYIAtbNDwU+cmCPanVpoUqZR1mv6ycLNrXxZBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QFJfJLApbDhJSrONIxuRt4PjNmiDL6K0c+kndXsVsgyCzI5J4+8XWUEoexyeq/n4k
         UfTp1eVqGT8jp4IuHBj4TteTEwva6qE6FnWaf+60DfU7DLGCZrKr4cxiDd465pWIVB
         5P/3zBIeprmQ2lj1Zk6nWA3tITRH6cmSeTBQSBwHAeDJUxF/ZQRygfFSVuoQUEVUSz
         OX5Kis9T8tDsa/Fy3zQ3Au7g52labeOhatCI8pi3uN1w7Fuv5JoQxUoCHh6kAraVyT
         RLJ9eXlEWKDH8Q9xi9mXA02uUVReDurP0R0hcJkRE7C1qF9m+Gkq/czpUhQsiJ/gZL
         cGcM+bwv5BMiw==
X-Google-Smtp-Source: ABdhPJwfBr+Ojyy/rdG7+RXLa3aiN3AHwkzpE4F8CAmQgz+1+Lg0018Kseqh6Fj0+lO1mgh7hvjY43lOg4SpyyYyakI=
X-Received: by 2002:a17:907:2111:: with SMTP id qn17mr30621135ejb.525.1608138123502;
 Wed, 16 Dec 2020 09:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20201215070009.27937-1-kishon@ti.com> <CAL_JsqJzi7JkMcd4NZewA=w8q6BsCkrhW3JcED63R=EyE3v29Q@mail.gmail.com>
 <1ec78477-dadc-cbef-406f-568f44b6c62d@ti.com>
In-Reply-To: <1ec78477-dadc-cbef-406f-568f44b6c62d@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Dec 2020 11:01:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLepmopGObX_r+7gtR+keaNtEAA3WA1j697T4jAWP8DHA@mail.gmail.com>
Message-ID: <CAL_JsqLepmopGObX_r+7gtR+keaNtEAA3WA1j697T4jAWP8DHA@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: cadence: Retrain Link to work around Gen2
 training defect.
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nadeem Athani <nadeem@cadence.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 16, 2020 at 9:01 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 15/12/20 9:23 pm, Rob Herring wrote:
> > On Tue, Dec 15, 2020 at 1:00 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> From: Nadeem Athani <nadeem@cadence.com>
> >>
> >> Cadence controller will not initiate autonomous speed change if strapped as
> >> Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> >>
> >> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> >> [kishon@ti.com: Enable the workaround for TI's J721E SoC]
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >> Hi Lorenzo,
> >> The previous version of the patch can be found at [1].
> >> I slightly re-worked the patch from Nadeem
> >> *) Removed additional Link Up Check
> >> *) Removed quirk from pcie-cadence-plat.c
> >> *) Also removed additional compatible
> >>    "cdns,cdns-pcie-host-quirk-retrain" added in that series
> >> *) Enabled the quirk for J721E
> >> [1] -> http://lore.kernel.org/r/20201211144236.3825-1-nadeem@cadence.com
> >>
> >>  drivers/pci/controller/cadence/pci-j721e.c    |  3 +
> >>  .../controller/cadence/pcie-cadence-host.c    | 67 ++++++++++++++-----
> >>  drivers/pci/controller/cadence/pcie-cadence.h | 11 ++-
> >>  3 files changed, 62 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> >> index dac1ac8a7615..baf729850cb1 100644
> >> --- a/drivers/pci/controller/cadence/pci-j721e.c
> >> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> >> @@ -64,6 +64,7 @@ enum j721e_pcie_mode {
> >>
> >>  struct j721e_pcie_data {
> >>         enum j721e_pcie_mode    mode;
> >> +       bool                    quirk_retrain_flag;
> >>  };
> >>
> >>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> >> @@ -280,6 +281,7 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
> >>
> >>  static const struct j721e_pcie_data j721e_pcie_rc_data = {
> >>         .mode = PCI_MODE_RC,
> >> +       .quirk_retrain_flag = true,
> >>  };
> >>
> >>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
> >> @@ -388,6 +390,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >>
> >>                 bridge->ops = &cdns_ti_pcie_host_ops;
> >>                 rc = pci_host_bridge_priv(bridge);
> >> +               rc->quirk_retrain_flag = data->quirk_retrain_flag;
> >>
> >>                 cdns_pcie = &rc->pcie;
> >>                 cdns_pcie->dev = dev;
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> index 811c1cb2e8de..773c0d1137ed 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> @@ -77,6 +77,50 @@ static struct pci_ops cdns_pcie_host_ops = {
> >>         .write          = pci_generic_config_write,
> >>  };
> >>
> >> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> >> +{
> >> +       struct device *dev = pcie->dev;
> >> +       int retries;
> >> +
> >> +       /* Check if the link is up or not */
> >> +       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> >> +               if (cdns_pcie_link_up(pcie)) {
> >> +                       dev_info(dev, "Link up\n");
> >> +                       return 0;
> >> +               }
> >> +               usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> >> +       }
> >> +
> >> +       return -ETIMEDOUT;
> >> +}
> >> +
> >> +static void cdns_pcie_retrain(struct cdns_pcie *pcie)
> >> +{
> >> +       u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> >> +       u16 lnk_stat, lnk_ctl;
> >> +
> >> +       /*
> >> +        * Set retrain bit if current speed is 2.5 GB/s,
> >> +        * but the PCIe root port support is > 2.5 GB/s.
> >
> > If you don't have the retrain quirk, wouldn't this condition never
> > happen and then the function is just a nop? So this could just be
> > called unconditionally.
>
> Yeah, but only for the quirk we have to retrain to go to GEN2 speed
> mode. Else the HW will automatically retrain and go to GEN2.

Again, so you don't need a flag for this. Comparing the speed is
enough. IOW, all you need is:

if (current speed < advertised speed)
  do retrain

The question is the condition ever true and you don't want to do a
retrain? I could see higher speeds being unstable or something, but
then 'advertised speed' would be lowered in that case (to prevent auto
retraining, right?) and the condition would be false.

Rob
