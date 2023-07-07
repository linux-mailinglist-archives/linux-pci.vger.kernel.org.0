Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7374AADE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGGF7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 01:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjGGF73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 01:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2E01FC8;
        Thu,  6 Jul 2023 22:59:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9DF61781;
        Fri,  7 Jul 2023 05:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA23C433C7;
        Fri,  7 Jul 2023 05:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688709562;
        bh=1df7wJ5JvcGHftBxD2iqTzYXp4hDfpxiLwelJO4deNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9NedX2oMA2BVHX+h/90AAsqscVg9UmDOd31k/KKmG5qhizkDJNly5iiNy94gueup
         C6lCbcFrX6eSbn+/kTde4RC/IXir591vgQGDPsXgTmx21B2pr4K+UCiiRR+aYBMixT
         Q67O3AuxQLUhqw8e2FFkAplM5Q/bz1S5n9STYYvI3Hlcd5iQc3RqE2erF+SBOuYDRm
         Bdi3N5JFsntj6IxCdWlIj11hfJAmG+frboZu0ScJ+c/2hGXsq9yrPF0kDLi/9YxC7e
         +v0SIWYYeLir9pVQfwgyUdTX1Ehviqkw2kHSRS/HpIR9JGsrclPmyLmOtzMjcwOScQ
         Tovh7COHbxL1g==
Date:   Fri, 7 Jul 2023 11:29:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
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
Subject: Re: [PATCH v2 3/8] PCI: epf-mhi: Add dtate change op
Message-ID: <20230707055906.GC6001@thinkpad>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688122331-25478-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 04:22:06PM +0530, Krishna chaitanya chundru wrote:
> Add dstate host op for MHI EPF.
> 

Use "D-state" everywhere. Also the subject should be:

"PCI: epf-mhi: Add support for handling D-state notification from EPC"

Fix the commit message accordingly.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 13 +++++++++++++
>  include/linux/mhi_ep.h                       |  3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 9c1f5a1..64ff37d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -339,6 +339,18 @@ static int pci_epf_mhi_bme(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_mhi_dstate_change(struct pci_epf *epf, pci_power_t state)
> +{
> +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> +	struct device *dev = &epf->dev;
> +
> +	mhi_cntrl->dstate = state;
> +	dev_info(dev, "D-state changeg to %s\n", pci_power_name(state));

This can be removed since we already print the state in pci driver.

- Mani

> +
> +	return 0;
> +}
> +
>  static int pci_epf_mhi_bind(struct pci_epf *epf)
>  {
>  	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> @@ -394,6 +406,7 @@ static struct pci_epc_event_ops pci_epf_mhi_event_ops = {
>  	.link_up = pci_epf_mhi_link_up,
>  	.link_down = pci_epf_mhi_link_down,
>  	.bme = pci_epf_mhi_bme,
> +	.dstate_change = pci_epf_mhi_dstate_change,
>  };
>  
>  static int pci_epf_mhi_probe(struct pci_epf *epf,
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index f198a8a..c3a0685 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/dma-direction.h>
>  #include <linux/mhi.h>
> +#include <linux/pci.h>
>  
>  #define MHI_EP_DEFAULT_MTU 0x8000
>  
> @@ -139,6 +140,8 @@ struct mhi_ep_cntrl {
>  
>  	enum mhi_state mhi_state;
>  
> +	pci_power_t dstate;
> +
>  	u32 max_chan;
>  	u32 mru;
>  	u32 event_rings;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
