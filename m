Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183526D86C5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDETXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDETXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 15:23:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874824ED2
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 12:23:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a273b3b466so111185ad.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Apr 2023 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680722632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DRIWNvg6XZhs4LfiKJrEHIsoLeWRLmaLzAOUbmZeUIQ=;
        b=kYiSIPlvaAdtY8uiTjFB22ywpmPruu8pumj2R492/MIJoR2DtDKVfznt1EtbKaSaQa
         gdGqBL0ltAnGXQL27fVXVsg3nP36sVQTg1g9L0TIz1OGouh7uO8azQ9s//Xv3nOk/8WM
         5g4IcGHL+i6cGSsR1TjMYjMtr8PPpjMoJ3STKazh2jM/GgFk+ty+0YBDHG7L0L9QJkm3
         2fq6b7zzUWoA8AlqkkfD0mAPRoenEk7ksununR5gX0t37yGcKTBoq1naRM2UywhYqkD8
         ObSYMf2wV8QXhrM3CYEA/ZJZ6WPV4dJ2RVT1SxLAioYsFa/vSxy/KHwUShKNBGyxIyTw
         USvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRIWNvg6XZhs4LfiKJrEHIsoLeWRLmaLzAOUbmZeUIQ=;
        b=Cz8ICV7LWNvAKrTu7uZknfmT4UlbFWDxDPp5/Ci5c+HE7xHfMXoZO6CupKvGASa6z0
         yxkmDecSqX+v566+wXJKhW9Jh4FO/XKizYSXaJcbTgTbdm2altadWfDVFnnRc8G905eZ
         wdjrV94tSdP+OSOODNZ9uJgDBsN/3tqhRXsBuFzkLwjEud7s8xJVF1uJLBJJh8qoZM8m
         WlrkG5r5W1Nxific/VmqwmStfYgnmj0Gn+BQnGZ02owfZ1HkxS4jUCiyGvnTc2r9Vzog
         crMufYx3wCutUYIIOSfkrMNcWUiWbuQyxMnvmw2FtVBvwBDv0YxfiYrqgq03leNvRi/+
         ZkEA==
X-Gm-Message-State: AAQBX9ev/WbtFJjHxZbTyIpzK1s1J5/OMuAoFmfdCwfoASFswVY1WYm9
        uVIxAiwx3pqvMNC5NgbFEbE1gw==
X-Google-Smtp-Source: AKy350YkzfVf2fy7LAO4VO6fm4pbXqwaToWynx58lUYTN/kWXKa6chf/0Mc+PfTk3SuZPpVn9yMocQ==
X-Received: by 2002:a17:902:ab85:b0:1a2:914e:fe00 with SMTP id f5-20020a170902ab8500b001a2914efe00mr33393plr.14.1680722631706;
        Wed, 05 Apr 2023 12:23:51 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id je3-20020a170903264300b00196807b5189sm10458008plb.292.2023.04.05.12.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:23:50 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:23:47 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sajid Dalvi <sdalvi@google.com>,
        Han Jingoo <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZC3Kw4AYiMKY7nCR@google.com>
References: <ZC12lN9Cs0QlPhVh@lpieralisi>
 <20230405182753.GA3626483@bhelgaas>
 <ZC3Ev7qnUDdG0cFd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZC3Ev7qnUDdG0cFd@google.com>
X-Spam-Status: No, score=-14.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/05/2023, William McVicker wrote:
> On 04/05/2023, Bjorn Helgaas wrote:
> > On Wed, Apr 05, 2023 at 03:24:36PM +0200, Lorenzo Pieralisi wrote:
> > > On Thu, Mar 16, 2023 at 06:05:02PM -0500, Sajid Dalvi wrote:
> > > > On Tue, Feb 28, 2023 at 10:36 PM Sajid Dalvi <sdalvi@google.com> wrote:
> > > > >
> > > > > Thanks for your review Jingoo.
> > > > > Sajid
> > > > >
> > > > > On Tue, Feb 28, 2023 at 4:04 PM Han Jingoo <jingoohan1@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 27, 2023, Sajid Dalvi <sdalvi@google.com> wrote:
> > > > > > >
> > > > > > > In dw_pcie_host_init() regardless of whether the link has been started
> > > > > > > or not, the code waits for the link to come up. Even in cases where
> > > > > > > start_link() is not defined the code ends up spinning in a loop for 1
> > > > > > > second. Since in some systems dw_pcie_host_init() gets called during
> > > > > > > probe, this one second loop for each pcie interface instance ends up
> > > > > > > extending the boot time.
> > > > > > >
> > > > > > > Call trace when start_link() is not defined:
> > > > > > > dw_pcie_wait_for_link << spins in a loop for 1 second
> > > > > > > dw_pcie_host_init
> > > > > > >
> > > > > > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > > > >
> > > > > > (CC'ed Krzysztof Kozlowski)
> > > > > >
> > > > > > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > > > > >
> > > > > > It looks good to me. I also checked the previous thread.
> > > > > > I agree with Krzysztof's opinion that we should include
> > > > > > only hardware-related features into DT.
> > > > > > Thank you.
> > > > > >
> > > > > > Best regards,
> > > > > > Jingoo Han
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
> > > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > index 9952057c8819..9709f69f173e 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > @@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > > >                 ret = dw_pcie_start_link(pci);
> > > > > > >                 if (ret)
> > > > > > >                         goto err_remove_edma;
> > > > > > > -       }
> > > > > > >
> > > > > > > -       /* Ignore errors, the link may come up later */
> > > > > > > -       dw_pcie_wait_for_link(pci);
> > > > > > > +               /* Ignore errors, the link may come up later */
> > > > > > > +               dw_pcie_wait_for_link(pci);
> > > > > > > +       }
> > > > > > >
> > > > > > >         bridge->sysdata = pp;
> > > > > > >
> > > > > > > --
> > > > > > > 2.39.2.722.g9855ee24e9-goog
> > > > > > >
> > > > 
> > > > @bhelgaas Can this be picked up in your tree:
> > > >  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/
> > > 
> > > This patch seems fine to me. The question I have though is why the
> > > *current* code is written the way it is. Perhaps it is just the way
> > > it is, I wonder whether this change can trigger a regression though.
> > 
> > The new code will look basically like this:
> > 
> >   if (!dw_pcie_link_up(pci)) {
> >     dw_pcie_start_link(pci);
> >     dw_pcie_wait_for_link(pci);
> >   }
> > 
> > If the link is already up by the time we get here, this change means
> > we won't get this message emitted by dw_pcie_wait_for_link():
> > 
> >   dev_info(pci->dev, "PCIe Gen.%u x%u link up\n", ...)
> > 
> > I don't know how important that is, but I bet somebody cares about it.
> > 
> > From the commit log, I expected the patch to do something based on
> > whether ->start_link() was defined, but there really isn't a direct
> > connection, so maybe the log could be refined.
> > 
> > Bjorn
> > 
> > -- 
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > 
> 
> After taking a deeper dive into this patch, I found that [1] changes the
> original intent which was to skip the call to dw_pcie_wait_for_link()
> when pci->ops->start_link is NULL. I talked to Sajid offline and he
> agreed we should put back the start_link NULL check. The updated patch
> should look like this:
> 
>   if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
>     ret = dw_pcie_start_link(pci);
>     if (ret)
>       goto err_free_msi;
>     dw_pcie_wait_for_link(pci);
>   }
> 
> 
> ...which will ensure that we don't call dw_pcie_wait_for_link() when
> pci->ops->start_link is NULL.
> 
> With regards to the log, I think there are 2 ways to solve this:
> 
> 1) We could also call dw_pcie_wait_for_link() in a new else if
>    dw_pcie_link_up() returns 1.
> 2) We could add this to the top of dw_pcie_wait_for_link() and leave the
>    code as is:
> 
>    if (!pci->ops || !pci->ops->start_link)
>      return 0;
> 
> I kind of like (2) since that solves both Sajid's original issue and
> will keep the original log.
> 
> [1] https://lore.kernel.org/all/20220624143428.8334-14-Sergey.Semin@baikalelectronics.ru/
> 
> Regards,
> Will

Below is what I'm thinking will do the job. I verified on a Pixel 6
(which doesn't have start_link() defined) that we don't have the 1
second wait from dw_pcie_wait_for_link() during probe.

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 8e33e6e59e68..1bf04324ad2d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -648,13 +648,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
 	u32 offset, val;
 	int retries;
+	int link_up = dw_pcie_link_up(pci);
 
-	/* Check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (dw_pcie_link_up(pci))
-			break;
+	if (!link_up && !(pci->ops && pci->ops->start_link))
+		return 0;
 
+	/* Check if the link is up or not */
+	for (retries = 0; !link_up && retries < LINK_WAIT_MAX_RETRIES; retries++) {
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+
+		link_up = dw_pcie_link_up(pci);
 	}
 
 	if (retries >= LINK_WAIT_MAX_RETRIES) {

