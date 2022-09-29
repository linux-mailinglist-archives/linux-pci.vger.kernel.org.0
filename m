Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB745EFB49
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 18:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiI2QuG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiI2QuF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 12:50:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA832EF0;
        Thu, 29 Sep 2022 09:50:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sb3so4001713ejb.9;
        Thu, 29 Sep 2022 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Tlw1fMrUL0eLQi9t3IJWRrT4tpDUm8fy19QhjQRWfJE=;
        b=NZXT8wbROqUZOWF0Xo9m/345CXRRkMG0teIqYMN/TTcFggcm2Sxmac+HV2TUlKBxa7
         s7xBYiZ5RcbllhvckCgGBurAZ0sAYIMdhbhXsTtBBPSjxu0QdEELKnKCbSj3wYYEmYLB
         rzOK8oWMIbomgNTEPbm2J04NSLbnWf3TFgg8Uk20rW93q8GZChThm0m4p0982etvcdTW
         crohcJa7RChMoKs+9Dt2Fcrc/Jl9ZdYUlSprPZyU0VE2F+2gffJo/Z0EzdbpPuh5L6Z1
         nVA2Tc7MMWySH5ooJjaZHfpDb0wDeP0jMGqIuJZQQRASaaEgPt7zIPo7FFT/nvhmBahO
         Qd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Tlw1fMrUL0eLQi9t3IJWRrT4tpDUm8fy19QhjQRWfJE=;
        b=FZVymzMLaB3xZ/A6f0lY+2KG9d38UNEc0c7rk2Zg0MP7g0Q2FJjQUFVCYVbkQllOyn
         C6fv7FUD9Q6pyIEvD5n1HTu5MP1JhhchfzCoATUba+kGO5eQR5jVmv4IHuzVRWJpaay/
         14fFgHGuxAuRCEl3cWNIZ3nXSHsBuHwf/bkpwn0L7Vr06IgRHMgB7nIYT46vs8uGGTgW
         5EMFJ0kZGoDmJXrSt16mZQvOTaBCmjmmBW7xvLj6PXHi94MHLsSf/CVgZOAgoixmwDcj
         RDMffxqCkYwsuVBwccO1n4moN5ZXpc1/aNgxypCk4KShCCkaBoBVq2B9F87uCbCCMZ9y
         MC0Q==
X-Gm-Message-State: ACrzQf0lnEyvOr3yxMR5dfqaPC5HqK+tOtF1lXwsC/VGTNU0hp+SvkF+
        M5pjfPO1v5wv+KnRLg+tq1vLcsFLQBfCMuGQncI=
X-Google-Smtp-Source: AMsMyM7f1idSi3Dg/iO+5R8dZ20phxelWkRqPv3dlH2hv3ODtW7t0Ee3ZHCm16NGBr012SEqrDAk+2uhpjm+QxL2y18=
X-Received: by 2002:a17:907:270b:b0:77b:17b3:f446 with SMTP id
 w11-20020a170907270b00b0077b17b3f446mr3358000ejk.415.1664470201687; Thu, 29
 Sep 2022 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143123.28250-1-vidyas@nvidia.com> <20220926111923.22487-1-vidyas@nvidia.com>
 <CAPOBaE5X8iUTQW5QqTKFN78U=jnVvCzCj2mb4HG5S4uxBaCN1Q@mail.gmail.com> <09c23fbd-0319-5e06-6c10-dc73352131f8@nvidia.com>
In-Reply-To: <09c23fbd-0319-5e06-6c10-dc73352131f8@nvidia.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Thu, 29 Sep 2022 09:49:50 -0700
Message-ID: <CAPOBaE68E6T3X96rvW5UdGb82LmAKKRuZ=Fb0SwgdLY7Px4ohw@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Fix n_fts[] array overrun
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 Vidya Sagar <vidyas@nvidia.com> wrote:

> On 9/29/2022 7:34 AM, Han Jingoo wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, Sep 26, 2022, Vidya Sagar <vidyas@nvidia.com> wrote:
> >>
> >> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
> >> incorrectly uses pci->link_gen in deriving the index to the
> >> n_fts[] array also introducing the issue of accessing beyond the
> >> boundaries of array for greater than Gen-2 speeds. This change fixes
> >> that issue.
> >
> > Dear Vidya,
> >
> > I am just ok with this patch. By the way, do we need another patch to generalize
> > this setting? Currently, this code targets only Gen1 and Gen2. But, in
> > my opinion,
> > it is possible that this driver can be  used for more than Gen2,
> > later. PCIe Gen6
> > standard is available and Synopsys has their solution for Gen6. So, would you
> > send a new patch to generalize this thing, later?
> > Thank you.
>
> As I mentioned in the commit message, current code is incorrectly using
> 'gen' in the index and ideally n_fts programming has nothing to do with
> the speed and hence I tried to remove the 'gen' reference in the current
> patch. So, the same code (after applying this patch) should work for any
> future Synopsys IP versions supporting higher speeds.

I see. Thank you for your confirmation.

Best regards,
Jingoo Han

>
> Thanks,
> Vidya Sagar
>
> >
> > Best regards,
> > Jingoo Han
> >
> >>
> >> Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> >> ---
> >> V2:
> >> * Addressed review comments from Bjorn
> >> * Added "Acked-by: Jingoo Han <jingoohan1@gmail.com>"
> >>
> >>   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> >> index 650a7f22f9d0..3df687667f27 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >> @@ -649,7 +649,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >>          if (pci->n_fts[1]) {
> >>                  val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> >>                  val &= ~PORT_LOGIC_N_FTS_MASK;
> >> -               val |= pci->n_fts[pci->link_gen - 1];
> >> +               val |= pci->n_fts[1];
> >>                  dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> >>          }
> >>
> >> --
> >> 2.17.1
> >>
