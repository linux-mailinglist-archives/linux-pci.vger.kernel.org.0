Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB3763012
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjGZIkq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 04:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjGZIkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 04:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831030DC;
        Wed, 26 Jul 2023 01:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 729CB61874;
        Wed, 26 Jul 2023 08:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5EFC433C7;
        Wed, 26 Jul 2023 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690360208;
        bh=MZlsqwvEaKa/yI517K0J73nbY/02V1t5zyWzamkHD0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lf3Q0IFo+0kftu2Q+mAiF4qDpgo7ZXqFt18LOlsbvcdugsNuXy7AuE9Kdu0oXUKLQ
         lt8jSGL0UtPI0AQcYCZoF+SRqwEymKlrHrWWM+BBjpXkGG5oEd9fyj/+G4t94pPMAH
         C1AmgiK2Wv6v/7LVP/ldj9Iw57Ncot1s/HEibpg4Uv470e08UT0BDUX6rwHIscz8UV
         TcH2Tpj5EOmgHxmWA/IXR6/+uCxDX0dYeTrgRtfYcQdX3Hk03pMfw7zZN6XxBj7acz
         DUT2ADqXYTuW3ggwvPGUxB/Zst/uiGlgsHxvsTDCc7lBsySB7KyFL8G2nWP2cVa6wh
         nvsZKOl3Rj3/w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOZua-0003qO-1p;
        Wed, 26 Jul 2023 10:30:24 +0200
Date:   Wed, 26 Jul 2023 10:30:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZMDZoJgBtURn-Vf5@hovoldconsulting.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230725200515.GA663333@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725200515.GA663333@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 25, 2023 at 03:05:15PM -0500, Bjorn Helgaas wrote:
> [+cc Fabio, Xiaolei, Jon]
> 
> On Thu, Jul 06, 2023 at 10:26:10AM +0200, Johan Hovold wrote:
> > This reverts commit da56a1bfbab55189595e588f1d984bdfb5cf5924.
> > 
> > A recent commit broke controller probe by returning an error in case the
> > link does not come up during host initialisation.
> > 
> > As explained in commit 886a9c134755 ("PCI: dwc: Move link handling into
> > common code") and as indicated by the comment "Ignore errors, the link
> > may come up later" in the code, waiting for link up and ignoring errors
> > is the intended behaviour:
> > 
> > 	 Let's standardize this to succeed as there are usecases where
> > 	 devices (and the link) appear later even without hotplug. For
> > 	 example, a reconfigured FPGA device.
> > 
> > Reverting the offending commit specifically fixes a regression on
> > Qualcomm platforms like the Lenovo ThinkPad X13s which no longer reach
> > the interconnect sync state if a slot does not have a device populated
> > (e.g. an optional modem).
> > 
> > Note that enabling asynchronous probing by default as was done for
> > Qualcomm platforms by commit c0e1eb441b1d ("PCI: qcom: Enable async
> > probe by default"), should take care of any related boot time concerns.
> > 
> > Finally, note that the intel-gw driver is the only driver currently not
> > providing a start_link callback and instead starts the link in its
> > host_init callback, and which may avoid an additional one-second timeout
> > during probe by making the link-up wait conditional. If anyone cares,
> > that can be done in a follow-up patch with a proper motivation.
> > 
> > Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
> > Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > Cc: Sajid Dalvi <sdalvi@google.com>
> > Cc: Ajay Agarwal <ajayagarwal@google.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> da56a1bfbab5 appeared in v6.5-rc1, so we should definitely fix this
> before v6.5.
> 
> Based on the conversation here, I applied this to for-linus for v6.5.
> 
> I looked for Bjorn A's report but couldn't find it; I'd like to
> include the URL if there is one.  I did add the reports from Fabio
> Estevam, Xiaolei Wang, and Jon Hunter (Fabio and Xiaolei even included
> patches).

Bjorn only mentioned to me off-list that that something was wrong with
PCI in linux-next and that it prevented us from reaching the sync state.
So there is no URL to a public report to link to.

> Current commit log, corrections/additions welcome:
> 
>   This reverts commit da56a1bfbab55189595e588f1d984bdfb5cf5924.
> 
>   Bjorn Andersson, Fabio Estevam, Xiaolei Wang, and Jon Hunter reported that
>   da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started") broke
>   controller probing by returning an error in case the link does not come up
>   during host initialisation, e.g., when the slot is empty.

I think that adding the corresponding Reported-by tags and Links after
my SoB below should be enough to credit reports that I was not aware of
when investigating this.

But if you decide to rewrite this paragraph, then please spell out "for
example" as I would not use "e.g." outside of parentheses.

>   As explained in commit 886a9c134755 ("PCI: dwc: Move link handling into
>   common code") and as indicated by the comment "Ignore errors, the link may
>   come up later" in the code, waiting for link up and ignoring errors is the
>   intended behaviour:
> 
>     Let's standardize this to succeed as there are usecases where devices
>     (and the link) appear later even without hotplug. For example, a
>     reconfigured FPGA device.
> 
>   Reverting the offending commit specifically fixes a regression on Qualcomm
>   platforms like the Lenovo ThinkPad X13s which no longer reach the
>   interconnect sync state if a slot does not have a device populated (e.g. an
>   optional modem).
> 
>   Note that enabling asynchronous probing by default as was done for Qualcomm
>   platforms by commit c0e1eb441b1d ("PCI: qcom: Enable async probe by
>   default"), should take care of any related boot time concerns.
> 
>   Finally, note that the intel-gw driver is the only driver currently not
>   providing a .start_link() callback and instead starts the link in its
>   .host_init() callback, which may avoid an additional one-second timeout
>   during probe by making the link-up wait conditional. If anyone cares, that
>   can be done in a follow-up patch with a proper motivation.
> 
>   [bhelgaas: add Fabio Estevam, Xiaolei Wang, Jon Hunter reports]
>   Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
>   Link: https://lore.kernel.org/r/20230704122635.1362156-1-festevam@gmail.com/
>   Link: https://lore.kernel.org/r/20230705010624.3912934-1-xiaolei.wang@windriver.com/
>   Link: https://lore.kernel.org/r/6ca287a1-6c7c-7b90-9022-9e73fb82b564@nvidia.com
>   Link: https://lore.kernel.org/r/20230706082610.26584-1-johan+linaro@kernel.org
>   Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>   Reported-by: Fabio Estevam <festevam@gmail.com>
>   Reported-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>   Reported-by: Jon Hunter <jonathanh@nvidia.com>
>   Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>   Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>   Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   Cc: Sajid Dalvi <sdalvi@google.com>
>   Cc: Ajay Agarwal <ajayagarwal@google.com>

Looks like you've "sorted" the trailers here instead of keeping the
temporal order (which would make it more clear what you added after I
posted the patch) and adding each Link after its corresponding
Reported-by tag (e.g. as suggested by checkpatch these days).

Johan
