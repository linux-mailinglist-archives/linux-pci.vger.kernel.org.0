Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1550C74E82C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 09:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGKHhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKHhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 03:37:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5E1A4
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 00:37:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668704a5b5bso4745133b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 00:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689061052; x=1691653052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZvK2hFBl2QreyCaMlmBMesCxec+o3RSBWZ6m+WqrQjc=;
        b=IBMuqXz2ei+xaYSRUoiyTMV+nF9DwxizMS7TkS0sY6g42nprWg6Lmk1/A+EwAkTHDj
         6gIEgBmN4pO8Apg4QPouUriZYbdRoUGwEIqeuKZ7qk1MHIMufDXJHiyLjAaBGLV0DaGi
         d/UHvuPWLIJGMWELVnKOX/Ye8FK0oRUON9dwH24/jjezbRPjoRGuvnnBKX9zO8Nd9BtO
         aJKQ3Y5wJcZp2dggSWh/3T8ThKPmOJyxTdSBXYN7kZcgT6XY8bJLrTl2k6TDXG6i3RiZ
         s55LJNvMceQPjCpJjmCaJAJraaaetYbutYd2cll7iPwBO96u2A1Tr8gZkQRWr1PyOu2L
         ztuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689061052; x=1691653052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvK2hFBl2QreyCaMlmBMesCxec+o3RSBWZ6m+WqrQjc=;
        b=VyYUSoTmrPautt/LwiNDZAx2h8MtFv1b+E+GT2FQWGu0d5PzYjbI/cMyhCE88loJfv
         i34jFyo+Xw/Xmq6/3PhaAADfE5XvV0FKdkSg2V475jOWAoFMYJSyzLFpIgzUXSoQwwO+
         0zcJx3vzuVlxf975MuSmm5PIz/hmW6WwHaxlZTfrmw8983uQWQL7hzzY77JLMemwFCM8
         jsE97i1Ubqu0qXK2WxGdOaN1a6tyJd0L7qgE8mbuu+hR7DFTS4vLRwVdToloVi9Pnhz4
         B8DCCK+JpMfbCqmOmwEqdBQym4cdX+03sDGBDs8Yd1LBj9qGo/x24VX/at8HAM+z/uEl
         oVkg==
X-Gm-Message-State: ABy/qLb4kSVOtrLlwCvz28VwW/e/UeZFA5jDwSroN2nIn1MLuCXDmlHI
        nEBHfYH84+/DDsHHs7+cYgHOLy0JSMD0cERP2Q==
X-Google-Smtp-Source: APBJJlFaY3Ckv7VZhy5evJmHFzIGTakYY8oWeteS9jz4V7+BpMLrCTkbIN7M+JO/HICtwgtErp4MiQ==
X-Received: by 2002:a05:6a00:1a88:b0:678:5d3c:33e8 with SMTP id e8-20020a056a001a8800b006785d3c33e8mr18084753pfv.18.1689061052377;
        Tue, 11 Jul 2023 00:37:32 -0700 (PDT)
Received: from thinkpad ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id f28-20020a63755c000000b005501b24b1c9sm891684pgn.62.2023.07.11.00.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:37:31 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:07:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <20230711073719.GA36617@thinkpad>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKwwAin4FcCETGq/@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Your commit ended up failing the probe, if dw_pcie_wait_for_link() fails for
SoCs defining start_link() callback, which is the case for all the drivers
except intel-gw. I take back my _special_ argument since it was special before
your commit and now you just made its behavior applicable to all SoCs.

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

No, IMO the offending commit was wrong in serving its purpose so a revert makes
sense. Because, if the intention was to reduce the boot delay then it did not
fix that because dw_pcie_wait_for_link() is still called from intel-gw's
host_init() callback. You just skipped another instance which is there in
dw_pcie_host_init().

So to fix this issue properly intel-gw needs to do 2 things:

1. Move the ltssm_enable to start_link() callback and get rid of
dw_pcie_wait_for_link() from its host_init() callback. If there is any special
reason to not do this way, please explain.

2. Enable async probe so that other drivers can continue probing while this
driver waits for the link to be up. This will almost make the delay negligible.

The above 2 should be done in separate patches.

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்
