Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244D66D8668
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjDES6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjDES6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 14:58:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C26E7E
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 11:58:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a1b23f49e2so111035ad.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Apr 2023 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680721092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uF/GWlWvG/Tqd7xZnqk6+z1z8ng2ZczSoQf0IxH0nxE=;
        b=mTLcOThNPraoToNCDo62CKn3q0zTBrE4OUIgJMokbRoEjFiclTOQAC9ufE6sPzF2q2
         0ROTVYH70JUwqpE0+oYoLViPsETO5UheRiBAVTKmruopCUIQnoeUtERMtR7Z0PzaM/pX
         WKCLnOI7q4KJV6m8Yn6iazjA/iG8cMUajRwEd1JtrtdZr0BvxnZZ1iGU7o+GXqXIpqt4
         D+dzgUG0jx8FqwnWAyGg8EI3onHVXFkm4GVPKPnec8aCPL+mzZHqNmGSbJou6X/7FlQl
         QuXMWUYWGK0Xuuou8B7Br5skBfwL25AJ0WEePA2SWttvlE+AusSKoQYCac1lpRNn6uxR
         wynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uF/GWlWvG/Tqd7xZnqk6+z1z8ng2ZczSoQf0IxH0nxE=;
        b=BzkPLBycASRJmFlk1+NLkAAyWhuZBa5wu6nYIIsNWTeFN62zPDt7vjRJtpSsIu/3Df
         yVSO72MstQ3Gl3DxZUiAY8vnzIKIzWCY45DfdI8A4gnuFwShMF5RMCk4jFfJBEjVKz99
         PKWbQT2D2zXmhpQ3abZcBqvdsfqBuQs4nCOojHK+iAGiSac8FSWbIfaZU3rHqZetm4M+
         KH7MDaV+7h/rmrLoEmazDJJoTfO/YXnETeh0gFrH8pvT71w6xGLQOvlsjf4kXon0oIo5
         nLRJk0PQiF9wdSjwQvhs09XE/RvihDoVEJR/iZKM9XFyqye0p+KLs9yMVEnsM3nC4URb
         hDpw==
X-Gm-Message-State: AAQBX9f95GXrCAPs7Wg7DcysU9arjih4V4v1JxCKtfBoj9hdD6RAmMFx
        pcdhN8TyBUO5RrKVRcJVCkYGEA==
X-Google-Smtp-Source: AKy350bAeZQvqaU/ztHd1scjIH9GtWNSI+ys3t1nF/pvEZZ3JLmOfyhLEGWdtmnD3176tx7+P41gog==
X-Received: by 2002:a17:903:50e:b0:1a1:ea19:8f40 with SMTP id jn14-20020a170903050e00b001a1ea198f40mr21348plb.18.1680721091709;
        Wed, 05 Apr 2023 11:58:11 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id m129-20020a632687000000b0050be4ff460esm9748194pgm.4.2023.04.05.11.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:58:10 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:58:07 -0700
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
Message-ID: <ZC3Ev7qnUDdG0cFd@google.com>
References: <ZC12lN9Cs0QlPhVh@lpieralisi>
 <20230405182753.GA3626483@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405182753.GA3626483@bhelgaas>
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

On 04/05/2023, Bjorn Helgaas wrote:
> On Wed, Apr 05, 2023 at 03:24:36PM +0200, Lorenzo Pieralisi wrote:
> > On Thu, Mar 16, 2023 at 06:05:02PM -0500, Sajid Dalvi wrote:
> > > On Tue, Feb 28, 2023 at 10:36 PM Sajid Dalvi <sdalvi@google.com> wrote:
> > > >
> > > > Thanks for your review Jingoo.
> > > > Sajid
> > > >
> > > > On Tue, Feb 28, 2023 at 4:04 PM Han Jingoo <jingoohan1@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 27, 2023, Sajid Dalvi <sdalvi@google.com> wrote:
> > > > > >
> > > > > > In dw_pcie_host_init() regardless of whether the link has been started
> > > > > > or not, the code waits for the link to come up. Even in cases where
> > > > > > start_link() is not defined the code ends up spinning in a loop for 1
> > > > > > second. Since in some systems dw_pcie_host_init() gets called during
> > > > > > probe, this one second loop for each pcie interface instance ends up
> > > > > > extending the boot time.
> > > > > >
> > > > > > Call trace when start_link() is not defined:
> > > > > > dw_pcie_wait_for_link << spins in a loop for 1 second
> > > > > > dw_pcie_host_init
> > > > > >
> > > > > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > > >
> > > > > (CC'ed Krzysztof Kozlowski)
> > > > >
> > > > > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > > > >
> > > > > It looks good to me. I also checked the previous thread.
> > > > > I agree with Krzysztof's opinion that we should include
> > > > > only hardware-related features into DT.
> > > > > Thank you.
> > > > >
> > > > > Best regards,
> > > > > Jingoo Han
> > > > >
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index 9952057c8819..9709f69f173e 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > >                 ret = dw_pcie_start_link(pci);
> > > > > >                 if (ret)
> > > > > >                         goto err_remove_edma;
> > > > > > -       }
> > > > > >
> > > > > > -       /* Ignore errors, the link may come up later */
> > > > > > -       dw_pcie_wait_for_link(pci);
> > > > > > +               /* Ignore errors, the link may come up later */
> > > > > > +               dw_pcie_wait_for_link(pci);
> > > > > > +       }
> > > > > >
> > > > > >         bridge->sysdata = pp;
> > > > > >
> > > > > > --
> > > > > > 2.39.2.722.g9855ee24e9-goog
> > > > > >
> > > 
> > > @bhelgaas Can this be picked up in your tree:
> > >  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/
> > 
> > This patch seems fine to me. The question I have though is why the
> > *current* code is written the way it is. Perhaps it is just the way
> > it is, I wonder whether this change can trigger a regression though.
> 
> The new code will look basically like this:
> 
>   if (!dw_pcie_link_up(pci)) {
>     dw_pcie_start_link(pci);
>     dw_pcie_wait_for_link(pci);
>   }
> 
> If the link is already up by the time we get here, this change means
> we won't get this message emitted by dw_pcie_wait_for_link():
> 
>   dev_info(pci->dev, "PCIe Gen.%u x%u link up\n", ...)
> 
> I don't know how important that is, but I bet somebody cares about it.
> 
> From the commit log, I expected the patch to do something based on
> whether ->start_link() was defined, but there really isn't a direct
> connection, so maybe the log could be refined.
> 
> Bjorn
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

After taking a deeper dive into this patch, I found that [1] changes the
original intent which was to skip the call to dw_pcie_wait_for_link()
when pci->ops->start_link is NULL. I talked to Sajid offline and he
agreed we should put back the start_link NULL check. The updated patch
should look like this:

  if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
    ret = dw_pcie_start_link(pci);
    if (ret)
      goto err_free_msi;
    dw_pcie_wait_for_link(pci);
  }


...which will ensure that we don't call dw_pcie_wait_for_link() when
pci->ops->start_link is NULL.

With regards to the log, I think there are 2 ways to solve this:

1) We could also call dw_pcie_wait_for_link() in a new else if
   dw_pcie_link_up() returns 1.
2) We could add this to the top of dw_pcie_wait_for_link() and leave the
   code as is:

   if (!pci->ops || !pci->ops->start_link)
     return 0;

I kind of like (2) since that solves both Sajid's original issue and
will keep the original log.

[1] https://lore.kernel.org/all/20220624143428.8334-14-Sergey.Semin@baikalelectronics.ru/

Regards,
Will
