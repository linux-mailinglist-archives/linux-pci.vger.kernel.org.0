Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A8598668
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbiHROvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiHROvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 10:51:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC05BCC11
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 07:51:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d10so1700119plr.6
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=H3yJk4PjKkBxO8MRF86o/UlGTS85Oaz5bi8fjVWZxdE=;
        b=Q1DNKTUtywOuoRfaMNyy6UGWNldEb34WlkUV8aAKz1xdXCnyjlt5Tenc5AtIH6UKMX
         GocNvWqde2bD6Jbm6lIypLmG3eLP1NxoatsEbFg/6Pf4+H7Cg7iqmm2OaEJAvovArann
         EfxSRCVnJgumR/P5gsdTGPUEX8D2sihbIh7JW5GnhZ7ZatPSjFuXGnKiHTLkjXiikRvM
         oJ9u2Y2qyag6oUJSJ9RyWtg5zK3UllxyapNF7Xz9W5CILu8ySdDlD9bMSLjL+UcG5Rz0
         VKlKIPhRutN3mKIRkLaKXLWgQvQ2Hl19Xe7tU2iiWxtNWvOjo33Rp9bNXbPi4PxL3M0b
         4PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=H3yJk4PjKkBxO8MRF86o/UlGTS85Oaz5bi8fjVWZxdE=;
        b=DVksa9NOlFODtAfAJbIL9ivPicGhpqoJ0H6Ppbw6+jW5lNUkrcBxFJzReEh2Ma/Anb
         cgT7dLJkff1Pt3pXRFGFJWbo09Cphwcd83X1GyOWQzGpwYUjHC4AvCe1PMIQ7vrOT5vG
         pzMdmhG3HPJT+t8q47H+vWilENvVGubZWJ8Kj4jcbOG2AhE5Z+PZqFbuxrA+rTe72nrk
         HKGayAEdtcAEcCh9/KYohYseDxrYqn03WKy1BkfUokz3xSjNuaeztFYXjScsAJMvDGwM
         QLYSaUTfh13gEdIGH+MKataBzTfBLf4oKPL65FlrkuKM6Fn2BZQd88eNJX7nx63A7Cxe
         9tKw==
X-Gm-Message-State: ACgBeo3g6KlzeQN3jZ7wJz0FsJ7D/EaVw0eEJLLvOwAWpgx3tO8yPih5
        Yx5G+4iG1Y/yLRu+5tWJ5K7t
X-Google-Smtp-Source: AA6agR742S8qUdw4UOT5bgN9ccpaznpYVuKYyj7Y8U9VluswWT+M4wSobtQ/yZnh5qE1vEiqMCJfcg==
X-Received: by 2002:a17:902:7c01:b0:16f:9649:be73 with SMTP id x1-20020a1709027c0100b0016f9649be73mr2899152pll.70.1660834280859;
        Thu, 18 Aug 2022 07:51:20 -0700 (PDT)
Received: from thinkpad ([117.193.212.74])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a3d8600b001f262f6f717sm3697123pjc.3.2022.08.18.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:51:20 -0700 (PDT)
Date:   Thu, 18 Aug 2022 20:21:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     ntb@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com
Subject: Re: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Message-ID: <20220818145115.GA111116@thinkpad>
References: <20220812194205.388967-1-jdmason@kudzu.us>
 <20220818060230.GA12008@thinkpad>
 <Yv5EA8uuhwn049jx@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv5EA8uuhwn049jx@kudzu.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 09:52:03AM -0400, Jon Mason wrote:
> On Thu, Aug 18, 2022 at 11:32:30AM +0530, Manivannan Sadhasivam wrote:
> > + Kishon (PCI EP Maintainer)
> > 
> > On Fri, Aug 12, 2022 at 03:42:05PM -0400, Jon Mason wrote:
> > > The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
> > > there to allow for notification of changes for it.
> > > 
> > > Signed-off-by: Jon Mason <jdmason@kudzu.us>
> > 
> > Hi Jason,
> 
> I assume you mean me.  Odd that you got my name wrong 2 lines below it
> being properly written out.
> 

Terribly sorry about that! I was reading another thread just before this
and misspelled your name.

> > I know that this patch is already in Linus's tree but I think this PCI Endpoint
> > VNTB driver is not going in a correct path. First, Kishon is not convinced with
> > the way the PCI Endpoint VNTB function driver is written currently. He prefers
> > the VirtIO approach over the current one [1].
> 
> To your point, this is already in Linus' tree.  If it is not the way
> people want it, patches accepted.
> 
> Kishon (in the thread) recommended doing it one way, and Frank
> responded he liked doing it another.  Kishon didn't respond to that
> last email.  To me, this is an acceptable technical disagreement that
> can be addressed in the future and no need to prevent working patches
> from being accepted.
> 

Kishon being the maintainer proposed an entirely different way of representing
the driver. I agree that the patch is working but maintainer's view matters and
if you don't hear from the maintainer for some time, you'll ping them (Frank
did ping but there is something called RESEND).

I'm not sure that merging the patches without an ACK from the relevant subsystem
maintainer is the right thing to do.

> > But while the conversation was still going on, the series got merged via NTB
> > tree without any ACKs from the PCI/PCI_EP maintainers. Also, note that there
> > was a patch touching the PCI Controller driver as well and that was also not
> > ACKed [2].
> 
> I put the series in my ntb-next branch, which was pulled into linux-next
> for roughly 3 months, and he did not object then (though likely he did
> not notice).  Multiple patches were submitted to the relevant mailing
> lists to address minor issues in the series (from being in linux-next)
> and most/all of those hit the PCI mailing list.  Bjorn responded to
> all of them saying they needed to go through the ntb tree (because of
> the dependency on Frank Li's original series).  So while not an
> explicit ack, it was implicit to me in that he was aware of the
> series.
> 
> Given the length of time and the public work on the series, how much
> longer should I have waited for a nack?
> 

I'd argue that you should've waited for the ACK first. I've seen and
experienced patch series hanging there for multiple releases. I'm not in favour
of not responding to the patches, maintainers do have their own work to do but
merging the patches touching the different subsystem without an ACK doesn't
sound good to me.

I don't know why he didn't object when the series got merged in this manner :/

> > If this trend is going to continue in the coming days, then I'm afraid that NTB
> > might end up being a backdoor for PCI/PCI_EP patches :(
> 
> Completely unfounded, per Bjorn's comment on
> https://lore.kernel.org/all/20220815183920.GA1960006@bhelgaas/
> 

It's now fine that NTB related PCI patches can be merged through NTB tree but
please wait for an ACK for patches touching the non-NTB drivers. If you ask me
how long you should wait, then I don't have an answer, but atleast give a
notice before doing so that it can catch the proper eyes.

Thanks,
Mani

> Thanks,
> Jon
> 
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://lore.kernel.org/all/20220222162355.32369-4-Frank.Li@nxp.com
> > [2] https://lore.kernel.org/all/20220222162355.32369-2-Frank.Li@nxp.com
> > 
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 64379c699903..47e9f86bd712 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
> > >  T:	git git://github.com/jonmason/ntb.git
> > >  F:	drivers/net/ntb_netdev.c
> > >  F:	drivers/ntb/
> > > +F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
> > >  F:	include/linux/ntb.h
> > >  F:	include/linux/ntb_transport.h
> > >  F:	tools/testing/selftests/ntb/
> > > -- 
> > > 2.30.2
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
