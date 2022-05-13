Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6952679D
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 18:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382531AbiEMQvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382694AbiEMQvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 12:51:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF45715F;
        Fri, 13 May 2022 09:50:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq30so15541071lfb.3;
        Fri, 13 May 2022 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=g+4OgXFbH+tnPek6mWCOboiMaxTr+bgIA9ikqSqfnew=;
        b=N/E/q5507tw829xOrE6R2QmPMJkFdwFPWdmWTPUtQ1JXtvqhzvenO2sHmkqFh+22Bu
         Y2Q+xuxfoXeeuss/yp45nFBpwodzsk0Z5rJa6uYsHXz0yr8k0aZDEl9/Ppn0dOnD5SZ7
         3h/+wO1/ogkkt9B1zAMULDi+nK1X2U9Eh4TBiYNxi0P/dO/Rc6FMxOS9i8Y67/DCB0tF
         azxQPmcDYdGLGkFPC4smnQ4hNyD54vDcRqaxBO6M1oOJGuE8b+L4W3wWH5rT1ZDrODP5
         jY3DNt8j+QHz2calJ9xwTMjh9XDbr5ArR3+Ekiwnhi8qXlcyfpTAgfEn/aoRtm/0DtIJ
         W6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g+4OgXFbH+tnPek6mWCOboiMaxTr+bgIA9ikqSqfnew=;
        b=ULMiXshkp1tkuLU0wFlLQoaw2PQ7K3G85B6kPxi7DarjRg2rEGwdmBUxro/yvM8FrV
         FVHYexnwyD9eWSQwHkuJA/PyNJ9XhOULAjz5vS9ZCiFpDPg6fDpq1qeEltB6jD8fuwAW
         HjvhU8jdd75qU5y8Agja4i4JECLNPOwLvJLi2ucLjycX+PPFbl6pidh1Da3J097LTs5i
         2oclRzxMeCV7XTjjdLONY8NMAkUVLqIA74kNJicndkBkvhes6yav9pbTxTph4LAprpud
         6LuDuSZmsfDiQonu7gQLB26DGFHuFw7R5ld41AcvIkEoPx+PZfvKobawhW/DfrZV6EdA
         fnbg==
X-Gm-Message-State: AOAM530xxglgsFbqevYpLm7Px1TcAWeLnfWQONgNsFuGd5KJrLTscacW
        TAkldrEuWVlQqR1mTQ6vsg8=
X-Google-Smtp-Source: ABdhPJw1GJbBofz6ojqTWnptwRGrUfBlCPZubmCswwRzjoQ6GHsIg7n1CCFvucEx3Os4L8JgvRcHmA==
X-Received: by 2002:a05:6512:3f97:b0:44a:f67d:7d8 with SMTP id x23-20020a0565123f9700b0044af67d07d8mr3857853lfa.81.1652460646644;
        Fri, 13 May 2022 09:50:46 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id k6-20020a2ea266000000b0024f3d1daee6sm498968ljm.110.2022.05.13.09.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:50:45 -0700 (PDT)
Date:   Fri, 13 May 2022 19:50:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
Message-ID: <20220513165043.qethltwud6tn66pq@mobilestation>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
 <Yn1/GRzXNCTJnMHj@lpieralisi>
 <20220512232033.wpbr4excmftzlxdi@mobilestation>
 <20220513084957.GA17457@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513084957.GA17457@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 09:49:58AM +0100, Lorenzo Pieralisi wrote:
> On Fri, May 13, 2022 at 02:20:33AM +0300, Serge Semin wrote:
> > On Thu, May 12, 2022 at 10:41:45PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, May 04, 2022 at 12:22:47AM +0300, Serge Semin wrote:
> > > > This patchset is a second one in the series created in the framework of
> > > > my Baikal-T1 PCIe/eDMA-related work:
> > > > 
> > > > [1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> > > > Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> > > > [2: In-progress v2] PCI: dwc: Various fixes and cleanups
> > > > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> > > > [3: In-progress v1] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > > > Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> > > > [4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> > > > Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> > > > 
> > > > Note it is very recommended to merge the patchsets in the same order as
> > > > they are placed in the list above in order to prevent possible merge/build
> > > > conflicts. Nothing prevents them from being reviewed synchronously though.
> > > > 
> > > > As it can be easily inferred from the patchset title, this series is about
> > > > the DW PCIe Root Port/End-point driver fixes and the code cleanups, where
> > > > fixes come before the cleanup patches. The patchset starts with adding the
> > > > stop_link() platform-specific method invocation in case of the PCIe host
> > > > probe procedure errors. It has been missing in the cleanup-on-error path
> > > > of the DW PCIe Host initialization method. After that there is a patch
> > > > which fixes the host own cfg-space accessors for the case of the
> > > > platform-specific DBI implementation. Third the unrolled CSRs layout is
> > > > added to the iATU disable procedure. Fourth the disable iATU procedure is
> > > > fixed to be called only for the internal ATU as being specific for the
> > > > internal ATU implementation. Last but no least the outbound iATU extended
> > > > region setup procedure is fixed to have the INCREASE_REGION_SIZE flag set
> > > > based on the limit-address - not the region size one.
> > > > 
> > > > Afterwards there is a series of cleanups. It concerns the changes like
> > > > adding braces to the multi-line if-else constructions, trailing new-lines
> > > > to the print format-string, dropping unnecessary version checking, and
> > > > various code simplifications and optimizations.
> > > 
> > > Hi,
> > > 
> > > I went through the series and I don't have any specific objections.
> > > 
> > 
> > > We can try to queue it for v5.19, with the caveat that the fixes
> > > _need_ testing on several DWC platforms
> > 
> > Alas I can't deliver that. But Manivannan has done a testing on his
> > Qualcomm devices.
> 

> Fixes need testing. I don't want to merge fixes that break platforms
> on which you can't test.

Every submitted change needs testing, but in most of the cases a
full comprehensive evaluation just can't be delivered. It doesn't mean
the changes can't be accepted especially if they are logically correct,
well justified, tested on several platforms and already reviewed. All
of that has been already done for this and following up patchsets.

> 
> Also, fixes need bug reports and as far as I can see I have not
> seen any reported that point at current mainline failures.

I reported that there are issues in the current code implementation.
They are thoroughly described in the patch logs and fixed by the
corresponding patches. But anyway I couldn't find in any kernel doc
that having a bug report is required to post fixes patch. It's like
waiting for kernel to crash/hangup/etc before getting permission to fix
its bugs.

Note, having Fixes tag doesn't mean the patch always need to be merged
in into the stable trees. It just indicates the commit originating the
issue, helps to review the change and if necessary assists the stable
kernel team in determining which stable kernel versions should receive
your fix (Documentation/process/submitting-patches.rst:555).

Also note I haven't Cc'ed the stable team reviewers so basically the
patches aren't strictly required to be merged into the stable kernels.

> 
> > > (and I _strongly_ encourage
> > > DWC maintainers to chime in). To sum it up:
> > > 
> > 
> > > - It is a mixture of clean-ups and fixes. I would prefer having the
> > >   cleanups earlier in the series and rebase (if there is a need, I
> > >   can try to reshuffle the patches myself) the fixes on top. That
> > >   because we may have to drop some of the fixes (and if we merge them
> > >   we may have to revert them as cleanly as we can),
> > 
> > Normally fixes patches go before ahead of the rest of the series to
> > simplify the backporting procedure (makes Greg's life much easier).
> 

> See above. We should not have fixes and cleanups in the
> same series 

What kernel document describes that requirement?

> and I am not taking fixes that can affect other
> platforms unless they are tested.
> 
> > Revertability has much less priority. In the worst case an additional
> > fixes patch is more preferable especially if the original patch has
> > been reviewed, accepted and most likely backported. Only if the patch
> > author didn't provide a fix then the reversion is proceeded. So I
> > wouldn't recommend to reshuffle the patches.
> 
> Feel free to ignore what I say, my comments still stand.
> 
> > >   my concern is that
> > >   they require testing on a number of platforms you have not been
> > >   exposed to
> > 
> > This series and another patchsets have been available for testing for
> > about two months now. There have been more than enough time to give it
> > a try and review.
> 

> Sure. To merge fixes they need to be tested on platforms before
> we can accept them and we need bug reports to show they are fixing
> something in the first place.

see my comment above regarding the requirement you are stating. There
must be some confusion regarding stable kernel patches, having bug
reports and full cross-platform testing. If you suggest to wait while
the series are tested on all the supported platforms we most likely will
never get then merged in.

> 
> > > - Kbot complained about patch (3)
> > 
> > Could you be more specific what it was complaining about? I haven't
> > got any relevant message in none of my emails.
> 

> https://lore.kernel.org/linux-pci/202205041128.dPzBiZsY-lkp@intel.com

Thanks. For some reason it was missing in both of my inboxes. Most
likely it was dropped by the corporate spam bot. But I am wondering
how come Kbot just removed my gmail address from Cc...

Anyway the report is reasonable. I'll fix it in v3.

> 
> > > - I will have comments about the commit logs but I can try to fix them
> > >   myself
> > 
> > Feel free to submit your comments. I'll take them into account in v3.
> > 
> > > 
> > > I have concerns especially about patches (2, 3, 4, 5, 8, 9), because
> > > they can affect DWC platforms other than the ones you are testing on.
> > 
> > Basically any generic code change affects the dependent platforms. If
> > you don't see any exact issue in mind then I don't see any reason to
> > sustain the series any longer especially seeing it has been already
> > tested on an alternative platform.
> 
> See above.
> 
> > > The cleanups we can definitely queue them up.
> > 
> > > As I said, and there
> > > is nothing I can do about it, I will be off the radar for two months
> > > from wednesday,
> > 
> > As I noted this isn't good since I haven't noticed much activity for
> > the last two months. Alas Bjorn hasn't participated in the review
> > process either. I can offer a help with reviewing the patches
> > concerning the DW PCIe drivers since during the patchsets development
> > I've got a good notion regarding the DWC drivers and HW internals. But
> > it only concerns the DW PCIe Host/End-point code.
> 

> We(I) don't have DWC HW 

So basically you are maintaining the part for which you don't have
neither hw reference manual nor hw instance, right? This isn't easy
task I'd say. I offered my help twice, but you tend to ignore it. Note
I don't expect that accepting the help means immediately merging my
patches in. They still need to go through the review process.

> and DWC maintainers are supposed to review DWC
> code. We maintain the generic bits in host controller drivers to
> make sure they guarantee a uniform behaviour across hosts.

I would have agreed with you if we didn't have the series tested on
other than mine hardware and haven't had any review comment posted so
far. But the patchset has been available for review for quiet a while.
During that time it was tested on another platform and even got RB
tags from a person having HW instances and reference manuals.

> 
> That's what I have to say. If you want your code merged we need
> to find a way to get DWC maintainers to test it and provide
> review,

Isn't Manivanna review and tests enough? Isn't me having a bunch of
DWC PCIe hw manuals and testing on at least one DWC PCIe IP-core
instance enough?

If not what do you suggest then? There is no dedicated DWC maintainer
for the generic DWC PCIe bits, the patchset has been hanging out on
review for about two months, and you are going to be away for the next
two months. Waiting for two more months until someone gets to appear
and finds a time to test it out? Really, four months for just 13
patches seems too much.

What I can suggest in this matter is to resend the series today with
all the depended platforms mailing lists in Cc (shall I explicitly add
the maintainers too?). If no serious problem reported until Wednesday
and if I fixed all the reported notes/comments until then, you get to
merge the patchset(s) in. What do think about this?

> I agree with you that feedback is lacking and that's
> something that has to be solved.

As I see it this is the main reason of all the arguing above. I think
that there was enough feedback for all the patchsets during the last
two months. You say there wasn't.

-Sergey

> 
> Thanks for your patience.
> 
> Lorenzo
> 
> > > please try to repost with the Kbot issue fixed and
> > 
> > See my comment above regarding kbot.
> > 
> > -Sergey
> > 
> > > with the comments above in mind and I will do my best to queue as
> > > many patches from this series as possible for v5.19.
> > > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > New features like adding two-level DT bindings abstraction, adding better
> > > > structured IP-core version interface, adding iATU regions size detection
> > > > and the PCIe regions verification procedure, adding dma-ranges support,
> > > > introducing a set of generic platform clocks and resets and finally adding
> > > > Baikal-T1 PCIe interface support will be submitted in the next part of the
> > > > series.
> > > > 
> > > > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> > > > Changelog v2:
> > > > - Fix the end address of the example in the patch log with
> > > >   the INCREASE_REGION_SIZE flag usage fixup. It should be
> > > >   0x1000FFFF and not 0x0000FFFF (@Manivannan).
> > > > - Add the cleanup-on-error path to the dw_pcie_ep_init() function.
> > > >   (@Manivannan)
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > > > Cc: Frank Li <Frank.Li@nxp.com>
> > > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > 
> > > > Serge Semin (13):
> > > >   PCI: dwc: Stop link in the host init error and de-initialization
> > > >   PCI: dwc: Don't use generic IO-ops for DBI-space access
> > > >   PCI: dwc: Add unroll iATU space support to the regions disable method
> > > >   PCI: dwc: Disable outbound windows for controllers with iATU
> > > >   PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
> > > >   PCI: dwc: Add braces to the multi-line if-else statements
> > > >   PCI: dwc: Add trailing new-line literals to the log messages
> > > >   PCI: dwc: Discard IP-core version checking on unrolled iATU detection
> > > >   PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
> > > >   PCI: dwc: Deallocate EPC memory on EP init error
> > > >   PCI: dwc-plat: Simplify the probe method return value handling
> > > >   PCI: dwc-plat: Discard unused regmap pointer
> > > >   PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration
> > > > 
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++--
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 66 +++++++++++++++----
> > > >  .../pci/controller/dwc/pcie-designware-plat.c | 13 ++--
> > > >  drivers/pci/controller/dwc/pcie-designware.c  | 48 +++++++++-----
> > > >  4 files changed, 109 insertions(+), 40 deletions(-)
> > > > 
> > > > -- 
> > > > 2.35.1
> > > > 
