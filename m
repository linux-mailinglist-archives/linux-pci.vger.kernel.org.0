Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B85581360
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiGZMs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbiGZMs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 08:48:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C3237D4
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 05:48:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b10so13360228pjq.5
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/jH03fCyEN/z2zkCr25VJ3Tkpq031LGWvxOe04lyWII=;
        b=xha5OVcbcz5jOXIJyloCYnyqszkJsYvljiV15e0g9Sov6vZnDxi1SRrfQ1KNTGOmsq
         rcqImOGHQQIDD5D8/wcxpEzEBOSX8so8LkT120yuShhXV/1OUgvu27wPZHwJAn8sgtH4
         FBeYlCsq2SHU8l/+wLX7gPAce1b9G5bkbJAvL/MLgYLoErurIY0hjAcvQn6pF33FcyiQ
         uptC5PDV725sKgG9C51wIoQZ9jA/yAYiyBO5hcTXafPg5N3BQ/KCApzJYBKXtwEW67Ws
         7r0hnQv653D8+pzE5o5lr/RNlO7eCWb37VKa2LmhfVnU0gYwwUWThLAUU1FjnPBU5dPs
         lhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jH03fCyEN/z2zkCr25VJ3Tkpq031LGWvxOe04lyWII=;
        b=291esVKdD1xPcgwBvV6N/KwmtFlj36drgw2I2/+ZKUq4OIizLTC1Kp+rni87P/Ub8F
         EoMROI4vgYmg2ilB4ILzq86x5qIupQexhG9aPD9YT8u7cveEaMc8peM4ekpqKSVSyAHl
         CHUa1SkJ6oJRKVu6u+5cMdzaSz3gFLXnHFPw4b77d24J+5XWk5JTysVD6Mc5lZc9oXeE
         9oINuWfh6YXvavfqZu6ATxApzjVrZ5rHCtUFBm0ixBQJ9aBozF9cuw8tZpMStUrjkaru
         +DJkfTBFHU7LVISOs/10drjFsM9iMU97aG4EyJhZk5vr6pRfJVTGvaQEwYAurPrRa8fl
         wdkQ==
X-Gm-Message-State: AJIora/SGpNKI8AWUZt4zPCKKvF+tH4Q7+xpjf5w47U9hkploL9hk2G0
        ka/i1TMuBvcNLE5bgQ6RmwtO
X-Google-Smtp-Source: AGRyM1uZ7seD4df7QKOD60xa4LCiuzQdQhkiYQJgFZXt7s37rCfl25zFTF9HmKeGQTQPtudLFq7Y7g==
X-Received: by 2002:a17:90a:17ea:b0:1f2:9166:731c with SMTP id q97-20020a17090a17ea00b001f29166731cmr14114165pja.184.1658839703450;
        Tue, 26 Jul 2022 05:48:23 -0700 (PDT)
Received: from workstation ([59.92.103.238])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a7a8900b001f219c5ae7dsm11034658pjf.31.2022.07.26.05.48.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jul 2022 05:48:23 -0700 (PDT)
Date:   Tue, 26 Jul 2022 18:18:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: designware-ep: Move DBI access to init_complete if
 notifier is used
Message-ID: <20220726124814.GH5522@workstation>
References: <20220721083845.GA36189@thinkpad>
 <20220721153055.GA1720178@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721153055.GA1720178@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 10:30:55AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 21, 2022 at 02:08:45PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jul 19, 2022 at 05:38:14PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jul 19, 2022 at 09:13:58AM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Jul 15, 2022 at 04:39:58PM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
> > > > > > For controllers supporting the CORE_INIT notifier, the resources are
> > > > > > supposed to be enabled in the init_complete function. Currently,
> > > > > > these controllers are enabling the resources during probe time due to
> > > > > > the DBI access happens in dw_pcie_ep_init().
> > > > > > 
> > > > > > This creates the dependency with the host PCIe controller since the
> > > > > > resource enablement like PHY depends on host PCIe to be up. For the
> > > > > > standalone endpoint usecase, this would never work. So let's move all DBI
> > > > > > access to init_complete function if CORE_INIT notifier is used. For the
> > > > > > controllers those doesn't support this notifier, this change is a NO-OP.
> > > > > > 
> > > > > > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > > > Cc: Om Prakash Singh <omp@nvidia.com>
> > > > > > Cc: Vidya Sagar <vidyas@nvidia.com>
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > ---
> > > > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
> > > > > >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> > > > > >  2 files changed, 94 insertions(+), 45 deletions(-)
> > > > > 
> > > > > Sorry this got missed.  Seems like there are two patches to solve the
> > > > > same problem:
> > > > > 
> > > > >   1) This patch, and
> > > > >   2) Vidya's patch (https://lore.kernel.org/linux-pci/20220622040133.31058-1-vidyas@nvidia.com/)
> > > > > 
> > > > > I don't know much about dwc or this issue, but if these patches are
> > > > > functionally equivalent, I think Vidya's is a little more attractive
> > > > > because:
> > > > > 
> > > > >   - It's smaller (49 insertions(+), 39 deletions(-)).
> > > > > 
> > > > >   - "core_init_notifier" looks like sort of a corner-case feature and
> > > > >     Vidya's patch doesn't depend on it so it seems more maintainable.
> > > > > 
> > > > >   - It's more straightforward to read -- it basically just moves
> > > > >     things from dw_pcie_ep_init() to dw_pcie_ep_init_complete(), which
> > > > >     is exactly the sort of thing I expect if we're doing something out
> > > > >     of order.
> > > > 
> > > > I agree that Vidya's patch is simple but as per the feedback from
> > > > Kishon on my previous patch, I had to add some extra logic to make
> > > > sure the move of DBI access doesn't affect the non
> > > > core_init_notifier platforms.
> > > > 
> > > > So with my patch, the logic added is essentailly a NO-OP on those.
> > > 
> > > Can you include the lore URL for Kishon's feedback?  I can't find it.
> > 
> > https://patchwork.kernel.org/project/linux-pci/patch/1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com/#24633629
> 
> Thanks!  (Or the canonical permanent URL:
> https://lore.kernel.org/r/576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com)
> 
> > > If we think moving the DBI access is safe on non-core_init_notifier
> > > platforms, I'd like to do it everywhere so they're all the same.  I
> > > don't want different behavior just to avoid the risk of theoretical
> > > problems that we think should not happen.
> > 
> > One more issue Kishon pointed out was that, in the patch the
> > endpoint controller is configured after pci_epc_create(). So he
> > raised a concern that if ecp_ops is invoked before the controller
> > gets configured fully, it could result in aborts.
> > 
> > While the concern may be true for non-core_init_notifier platforms
> > (I'm not sure though) but I'm certain not for the core_init_notifier
> > ones as the EFP drivers only access EPC ops after
> > dw_pcie_ep_init_complete().
> 
> I really don't understand what "core_init_notifier" does, but it seems
> incidental to this issue.

"core_init_notifer" flag was added to let the EPF driver know that the
endpoint controller has completed its initialization. This is needed for
platforms that require refclk from the host to be active before accessing
any controller specific registers. Tegra194 and Qcom are one of those kinds.

> Is there really a connection?  It sounds
> like the only reason to check for it is to limit the scope of the
> change, not because DBI access is inherently related to
> core_init_notifier.
> 

DBI access requires refclk on the above mentioned platforms, so yes
there is a strong connection.

This patch (also mine) moves away all of the DBI access to the
init_complete() notifier callback. Because, without this patch we need
to bring-up the host first and then power-on the endpoint. Otherwise,
if the endpoint is powered-on first, it will crash as there would no
refclk from host.

> Maybe Vidya's patch needs some enhancement to cover other paths where
> DBI may be accessed before we're ready?
> 

FWIW, Vidya's patch looks good to me. I pointed out my patch just
because it covers the theoretical issue mentioned by Kishon.

Thanks,
Mani

> Bjorn
