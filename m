Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004A58F233
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiHJSQX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJSQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 14:16:22 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32726B166;
        Wed, 10 Aug 2022 11:16:21 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id g14so8708432ile.11;
        Wed, 10 Aug 2022 11:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Y/91x68apYxGU2yWKMRb1jIy4Nl3lJoSlJ5CMkz4kPA=;
        b=1UdzskyP97U2kgg0QMeLFTKvnuP2Lidz3ttrYNjSIDXoBi0AoOo+IGM32fqk9XTHn5
         FL3nbhy5Q0z2XA6ujJ953V4zeZ0rhFkmJUbo7SPCHjWqeNKnKOAhKT0oqOrlN4Qa1fxf
         GSNaywRsgUgg45ue4SbmC5OTnkZcw+WpkbbvTYwNmZfU/HWOtTDwxH6iMAiZWm1Akmgg
         e5a+fTw3qu/V1DBT4pDwPew1N3uUuZXkd7pgPcJkNPPPzigiTEtQjkpir56DQIOkQGtZ
         QFD0O34Pc8kXHoZAjy60fA0wx30D66Bn/EI9GoZ4G2zhKwhbhSyysv4avuskQRevAxk7
         612A==
X-Gm-Message-State: ACgBeo1wLd6UbNFo4pQYIRKW3cXzptniNuz0+xVZq4k2eUCTTCe1XjMQ
        UpwZdOu6+ncNxRRqkfV6soZ0575DFw==
X-Google-Smtp-Source: AA6agR6PGINNNRNrQp1oTwmQ7ZeUFMF18TZSNO/ltwhEpAraH+Zkinu+aYgb55/j2sYkpVXfj7BhRA==
X-Received: by 2002:a05:6e02:188a:b0:2de:ac0a:c623 with SMTP id o10-20020a056e02188a00b002deac0ac623mr13086561ilu.88.1660155381041;
        Wed, 10 Aug 2022 11:16:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g3-20020a02c543000000b003427e69f2b8sm7718408jaj.144.2022.08.10.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 11:16:20 -0700 (PDT)
Received: (nullmailer pid 271368 invoked by uid 1000);
        Wed, 10 Aug 2022 18:16:18 -0000
Date:   Wed, 10 Aug 2022 12:16:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220810181618.GD200295-robh@kernel.org>
References: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
 <20220729224404.GA478920@bhelgaas>
 <20220730145025.GA4005@thinkpad>
 <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
 <20220802072426.GA2494@thinkpad>
 <20220802140738.GA115652@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140738.GA115652@thinkpad>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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

pci_epc_event_ops

> +       void (*init_complete)(struct pci_epf *epf);
> +       void (*link_up)(struct pci_epf *epf);

link down?

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

*event_ops

And 'const'

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

I guess. Honestly, the I'm not all that familiar with the endpoint 
stuff.

Rob
