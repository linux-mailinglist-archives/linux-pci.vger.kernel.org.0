Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6564276BB04
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjHARWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjHARWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 13:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7B211E;
        Tue,  1 Aug 2023 10:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1DCF6154F;
        Tue,  1 Aug 2023 17:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C27C433C7;
        Tue,  1 Aug 2023 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690910518;
        bh=FvTrayG0aB9pBS56Qi18iMvVg3XJECQTzUNoJcvfVxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTg8YtjpaBdEyllcrmu65iWMgj74xz2mpu+ThdUY8cWF+84k4nm+EiWPIwktyvaO/
         OD5Y+be8QlhnRdR+PCnVwUmUtBME8/DE1nSc2FIRxIflgSBdWYFTwqT4aBTvf4snXb
         O1gVgPwUxCgUS8rEJv7BLxEReymjCD7vzvKhFWiatvEdLrQofd1eE6plTSVs1s74/A
         6Ma9EuBOspIfKipNOb7U62xfz5hgp1Hg3spssqoMfzA39l4DwDnCoJhHQQ0sYi8HU2
         wBUXqAkLOo5D9dpFQ5aT4L3TAh6VlWzc9s+tdXWoelzuH5TIhitkStIEEQcQmPxIXh
         kFLYI0QlKRiZw==
Date:   Tue, 1 Aug 2023 22:51:42 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
Subject: Re: [PATCH v4 3/9] PCI: epf-mhi: Add support for handling D-state
 notify from EPC
Message-ID: <20230801172142.GA76659@thinkpad>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-4-git-send-email-quic_krichai@quicinc.com>
 <20230728040949.GF4433@thinkpad>
 <1cfa6656-8130-ce1d-e28e-3665f12cc76a@quicinc.com>
 <0a6ca984-9797-88b1-ae12-c64916f6c61c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a6ca984-9797-88b1-ae12-c64916f6c61c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 10:31:42AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 7/31/2023 11:05 AM, Krishna Chaitanya Chundru wrote:
> > 
> > On 7/28/2023 9:39 AM, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 13, 2023 at 12:40:12PM +0530, Krishna chaitanya chundru
> > > wrote:
> > > > Add support for handling D-state notify for MHI EPF.
> > > > 
> > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > ---
> > > >   drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
> > > >   include/linux/mhi_ep.h                       |  3 +++
> > > >   2 files changed, 14 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > > b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > > index 9c1f5a1..ee91bfc 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > > > @@ -339,6 +339,16 @@ static int pci_epf_mhi_bme(struct pci_epf *epf)
> > > >       return 0;
> > > >   }
> > > >   +static int pci_epf_mhi_dstate_notify(struct pci_epf *epf,
> > > > pci_power_t state)
> > > > +{
> > > > +    struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > > > +    struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> > > > +
> > > > +    mhi_cntrl->dstate = state;
> > > Where is this variable being used? Also, don't we need any locking?
> > > 
> > > - Mani
> > 
> > we are using this variable in wakeup host op which is introduced on
> > patch [PATCH v4 8/9] PCI: epf-mhi: Add wakeup host op
> > 
> > I will add lock in my next series.
> > 
> > - KC
> 
> Mani, as this is being called from IRQ context do we need to add any lock
> here.
> 

Notifiers are invoked in process context. And here, the context doesn't matter
as either way you need locking to prevent concurrent access to dstate variable.

But I think it is safe to ignore lock for now provided that wakeup_host callback
is only called while MHI is in M3 state. Even if dstate changes while processing
wakeup_host, it won't affect the behavior.

- Mani

> - KC
> 
> > 
> > > 
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   static int pci_epf_mhi_bind(struct pci_epf *epf)
> > > >   {
> > > >       struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > > > @@ -394,6 +404,7 @@ static struct pci_epc_event_ops
> > > > pci_epf_mhi_event_ops = {
> > > >       .link_up = pci_epf_mhi_link_up,
> > > >       .link_down = pci_epf_mhi_link_down,
> > > >       .bme = pci_epf_mhi_bme,
> > > > +    .dstate_notify = pci_epf_mhi_dstate_notify,
> > > >   };
> > > >     static int pci_epf_mhi_probe(struct pci_epf *epf,
> > > > diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> > > > index f198a8a..c3a0685 100644
> > > > --- a/include/linux/mhi_ep.h
> > > > +++ b/include/linux/mhi_ep.h
> > > > @@ -8,6 +8,7 @@
> > > >     #include <linux/dma-direction.h>
> > > >   #include <linux/mhi.h>
> > > > +#include <linux/pci.h>
> > > >     #define MHI_EP_DEFAULT_MTU 0x8000
> > > >   @@ -139,6 +140,8 @@ struct mhi_ep_cntrl {
> > > >         enum mhi_state mhi_state;
> > > >   +    pci_power_t dstate;
> > > > +
> > > >       u32 max_chan;
> > > >       u32 mru;
> > > >       u32 event_rings;
> > > > -- 
> > > > 2.7.4
> > > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
