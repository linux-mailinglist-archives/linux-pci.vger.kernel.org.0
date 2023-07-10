Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4674DB53
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGJQmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 12:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGJQmS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 12:42:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E071C0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jul 2023 09:42:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so2951737a12.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Jul 2023 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689007337; x=1691599337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qyi+g/4iN33+N4r7PmkYNOIpNbVkOIVV3SbpVL/0f78=;
        b=xmE/dpStOPoOn/tGY/8KyGhVQRn4mEfShDCdd6LU8SRddth8exKS6tDSgXfAdH6+gq
         +0+vOwSXUFPJyZ3MoYLLFa7IJcVC1ba0u6+8yYcgewZBF+YWg7FIFwnAAbwHOav/Zcrd
         XGHh/rjQIusc2SoGg12X/t+TuQuUSbJULC/TBlZ2RNLktoGUekoJkMIDgZ+O0ZbxCNOl
         lxEf+rdCkkevPj6uNS8uUH630/mu9gX6Kk1GMR28xQ2Z4Sf8rkyyU06u0Q/LbYn2HboC
         GsCh1uHQqkcuRC10wYt6yae6IYLkvzsF/784TfHZ6hfEQXQPmK2NpMMcmLJELvtMJkKK
         hFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689007337; x=1691599337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qyi+g/4iN33+N4r7PmkYNOIpNbVkOIVV3SbpVL/0f78=;
        b=Usae2jdZIrLwfjEohAfi8DzEyM6aRWsyJQ6DV4CC9DyPsez8+Oi8PKZSy7O5kRSVH9
         kRsUDj4UH/mkaWzpP6LbxmGSq6hcPKnR6zwO/tkxW+M2ZhmnldlHPgTFZ/F1JZcwNCYo
         rCrL8/O5r+ZgP29DhC9PY3tmAAxaQP5+3sVHf0LV7XTHZLK6yKJMmheFzPNl8Beuaks+
         lX2JxTL4/WemuM0pZXKFcDHw/k7hAKlrM9RIiKRIJxIonpYUZlDyU5bUT0D/A52bmoIH
         lk6Hd9KXgqSMZoxQmil6GfHl87z5GPmL2RcggLEpGqfZbstHoqsLXETDS/lhthmfsJ5x
         AgYA==
X-Gm-Message-State: ABy/qLaGucZeG3mRxVZKw5LIFVvv/1yg5He13si/I4PuyoZ3e1/B7NID
        pmVDUpaWGfDPs1QXZbe+1yDhZw==
X-Google-Smtp-Source: APBJJlGjPfyzkP5hzN8DXAx5SI3f2kqPRoqJacRX6cKy96iaNXVUSCslRKvAST+6RpCpSUG3SWkAIQ==
X-Received: by 2002:a17:90b:897:b0:265:780e:5edc with SMTP id bj23-20020a17090b089700b00265780e5edcmr17815145pjb.10.1689007336914;
        Mon, 10 Jul 2023 09:42:16 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090ad25200b00263f8915aa3sm6551689pjw.31.2023.07.10.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:42:16 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:12:07 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZKw03xjH5VdL/JHD@google.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKwwAin4FcCETGq/@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 10, 2023 at 09:51:22PM +0530, Ajay Agarwal wrote:
> On Fri, Jul 07, 2023 at 02:47:56PM +0200, Johan Hovold wrote:
> > On Thu, Jul 06, 2023 at 06:28:11PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 06, 2023 at 10:26:10AM +0200, Johan Hovold wrote:
> > 
> > > > Finally, note that the intel-gw driver is the only driver currently not
> > > > providing a start_link callback and instead starts the link in its
> > > > host_init callback, and which may avoid an additional one-second timeout
> > > > during probe by making the link-up wait conditional. If anyone cares,
> > > > that can be done in a follow-up patch with a proper motivation.
> > 
> > > The offending commit is bogus since it makes the intel-gw _special_ w.r.t
> > > waiting for the link up. Most of the drivers call dw_pcie_host_init() during the
> > > probe time and they all have to wait for 1 sec if the slot is empty.
> Mani, can you please explain how my commit made the intel-gw driver
> special? The intel driver actually fails the dw_pcie_host_init if the
> link does not come up. That was my motivation behind adding the fail
> logic in the core driver as well.
> > 
> > Just to clarify, the intel-gw driver starts the link and waits for link
> > up in its host_init() callback, which is called during probe. That wait
> > could possibly just be dropped in favour of the one in
> > dw_pcie_host_init() and/or the driver could be reworked to implement
> > start_link().
> > 
> > Either way, the call in dw_pcie_host_init() will only add an additional
> > 1 second delay in cases where the link did *not* come up.
> > 
> > > As Johan noted, intel-gw should make use of the async probe to avoid the boot
> > > delay instead of adding a special case.
> > 
> > Indeed.
> > 
> > Johan
> Johan, Mani
> My apologies for adding this regression in some of the SOCs.
> May I suggest to keep my patch and make the following change instead?
> This shall keep the existing behavior as is, and save the boot time
> for drivers that do not define the start_link()?
> 
> ```
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cf61733bf78d..af6a7cd060b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -492,11 +492,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>                 if (ret)
>                         goto err_remove_edma;
> 
> -               if (pci->ops && pci->ops->start_link) {
> -                       ret = dw_pcie_wait_for_link(pci);
> -                       if (ret)
> -                               goto err_stop_link;
> -               }
> +               if (pci->ops && pci->ops->start_link)
> +                       dw_pcie_wait_for_link(pci);
>         }
> 
>         bridge->sysdata = pp;
> ```
I just realized that Fabio pushed exactly the same patch as I suggested
here:
https://lore.kernel.org/all/20230704122635.1362156-1-festevam@gmail.com/.
I think it is better we take it instead of reverting my commit.
