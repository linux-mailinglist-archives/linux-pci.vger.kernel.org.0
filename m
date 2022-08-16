Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE9C595E2C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiHPOPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 10:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHPOPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 10:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D5BB2DB0;
        Tue, 16 Aug 2022 07:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E1A460F0E;
        Tue, 16 Aug 2022 14:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5494C433D6;
        Tue, 16 Aug 2022 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660659309;
        bh=fV6j6QT3YLntpeSpLAm47WtsGUZFV1l2IEKhZ83mc1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlsZNfmso7ZfcKj16WUvSgyus/xrYtaVZNtj9C6//u/7wCdyrBWyQDm/EjUNebzzR
         PPiiEs1/VeVafKQKPF013uWtf2HTe828T0uLfPtSucVYPz7Xl0wAKJ0vPClA+5Ui+M
         AybRgj/+8Ku7dIYvdEuCZbpc/DHHoIDoBf0urWHC+scweKp3U5w5slk6c0EJ58DS83
         0Soz1y0b3wJk+dZxnO9EX1rIJJvqWpMfKLWWUHFhmR4q8z8sY+QzmXBKQjNoZQHTwv
         IELx8Zd2SID0oxgMeqnBfLfwT9jI3gRlU8VQvInnZiRE2I9REjOO93oT80slZKPKMF
         gzsG67eXWikEQ==
Date:   Tue, 16 Aug 2022 16:15:00 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <YvumZJdDAqo7DfBe@lpieralisi>
References: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
 <20220729224404.GA478920@bhelgaas>
 <20220730145025.GA4005@thinkpad>
 <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
 <20220802072426.GA2494@thinkpad>
 <20220802140738.GA115652@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802140738.GA115652@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 02, 2022 at 07:37:38PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Aug 02, 2022 at 12:54:37PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Aug 01, 2022 at 02:27:14PM -0600, Rob Herring wrote:
> > > On Sat, Jul 30, 2022 at 8:50 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Fri, Jul 29, 2022 at 05:44:04PM -0500, Bjorn Helgaas wrote:
> > > > > [+cc Xiaowei (author of 6bfc9c3a2c70), Hou (author of 8bcca2658558)]
> > > > >
> > > > > On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
> > > > > > On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> > > > > > > On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> > > > > > > > Platforms that cannot support their core initialization without the
> > > > > > > > reference clock from the host, implement the feature 'core_init_notifier'
> > > > > > > > to indicate the DesignWare sub-system about when their core is getting
> > > > > > > > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > > > > > > > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > > > > > > > core to dw_pcie_ep_init_complete() API which is effectively called only
> > > > > > > > after the core initialization.
> > > 
> > > > >   6) What's going on with the CORE_INIT and LINK_UP notifiers?
> > > > >      dw_pcie_ep_init_notify() is only called by qcom and tegra.
> > > > >      dw_pcie_ep_linkup() is only called by dra7xx, qcom, and tegra.
> > > > >      As far as I can tell, nobody at all registers to handle those
> > > > >      events except a test.  I think it's pointless to have that code
> > > > >      if nobody uses it.
> > > > >
> > > >
> > > > I have submitted an actual driver that makes use of these notifiers:
> > > > https://lore.kernel.org/lkml/20220502060611.58987-9-manivannan.sadhasivam@linaro.org/
> > > 
> > > Notifiers aren't the best interface in the kernel. I think they are
> > > best used if there's no real linkage between the sender and receiver.
> > > For an EPC and EPF that's a fixed interface, so define a proper
> > > interface.
> > > 
> > 
> > Fair point! The use of notifiers also suffer from an issue where the notifier
> > chain in EPC is atomic but the EPF calls some of the functions like
> > pci_epc_write_header() could potentially sleep.
> > 
> > I'll try to come up with an interface.
> > 
> 
> I thought about using a new set of callbacks that define the EPC events and
> have the EPF drivers populate them during probe time. Like below,
> 
> ```
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index e03c57129ed5..45247802d6f7 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -74,6 +74,20 @@ struct pci_epf_ops {
>                                         struct config_group *group);
>  };
>  
> +/**
> + * struct pci_epf_events - Callbacks for capturing the EPC events
> + * @init_complete: Callback for the EPC initialization complete event
> + * @link_up: Callback for the EPC link up event
> + */
> +struct pci_epc_events {
> +       void (*init_complete)(struct pci_epf *epf);
> +       void (*link_up)(struct pci_epf *epf);
> +};
> +
>  /**
>   * struct pci_epf_driver - represents the PCI EPF driver
>   * @probe: ops to perform when a new EPF device has been bound to the EPF driver
> @@ -172,6 +186,7 @@ struct pci_epf {
>         unsigned int            is_vf;
>         unsigned long           vfunction_num_map;
>         struct list_head        pci_vepf;
> +       struct pci_epc_events   *events;
>  };
>  
>  /**
> ```
> 
> When each of the event is received by the EPC driver, it will use the EPC API
> to call the relevant event callback for _each_ EPF. Like below:
> 
> ```
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6ad9b38b63a9..4b0b30b91403 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -724,10 +724,15 @@ EXPORT_SYMBOL_GPL(pci_epc_linkdown);
>   */
>  void pci_epc_init_notify(struct pci_epc *epc)
>  {
> +       struct pci_epf *epf;
> +
>         if (!epc || IS_ERR(epc))
>                 return;
>  
> -       blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> +       list_for_each_entry(epf, &epc->pci_epf, list) {
> +               if (epf->events->init_complete)
> +                       epf->events->init_complete(epf);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
> ```
> 
> Does this look good to you? I can spin up an RFC series, but wanted to check the
> interface design beforehand.

I am resuming patch reviews, have you posted a follow up ?

Just to understand where we are with this thread and start reviewing
from there, I will update patchwork accordingly (you should add
a Link: to this thread anyway in the new series).

Thanks,
Lorenzo

> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > > Rob
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
