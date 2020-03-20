Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A018C748
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 07:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCTGBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 02:01:10 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42095 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTGBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 02:01:10 -0400
Received: by mail-il1-f196.google.com with SMTP id p2so4531021ile.9;
        Thu, 19 Mar 2020 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjONg8yiV++s7AEg3MOYmPgQp6a8jlgxr6ibWdVRk5c=;
        b=fUZfI/kqA4/KR4qk6BcLZrEDXuOzINoGwY28KFZCJwxz9pLEyNuAtfQpdVIY3YWcWF
         8AzbOGbXAfWscXAZZjtIhnOUAPXgUdzZEx7TpYJOPOmge3TUu0mfaD/XW0ib2aUUWZqV
         lzUWLNsNVVD72jIi0YF7dBf4/MVf0IJP1JcM5DJ6am8knHu/voDXj9v0Mp2ERoqorM9a
         XGkAOsUi/9hEdZc4+Xh7ocBbDrqQSTPEuXs8By2YzwzoXAhwfs6eqzo10UuiT3zfSdn5
         WhWtU3T39K6G5CwqlTZBY3Z/y/FLV74EM/dWjqVMMwPqhhwFA4Rc9fdJggOu36aELf8Y
         wHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjONg8yiV++s7AEg3MOYmPgQp6a8jlgxr6ibWdVRk5c=;
        b=VmAnBIQzLt1zSX4lZn0DcpcqYxGC1n9rJQuvYuelzqqSctgm0aIdK+vXKYsrhlOSP0
         V6Ez6+B9WKYgNy/6LfchMhfWUjRB7C0H4ddZJEhGp/HHsQmtfrmszFYrf4kKfdJ5HMwA
         HS+8lLMhihyGQd1eGgd+MAl0S6kQcg1DytRAsCERQPHEgTKYBdzZNDyFhmKmdtSCeNT1
         BnjruCLRV/16ukJg7c7p2rriJZZymbZHEFXVRCfAaNn1fFVzlMjIaSdelWGMEp0uPFrQ
         OOJUwtqtojDe+RKfhUCUKkIB/GH45vfHrUjN7m1hGUzuZEz2UNcSnndiU/N1NU968qWJ
         nYQw==
X-Gm-Message-State: ANhLgQ0xiXzN5jvKnXa4xHfwCSHCs4N9VbIHGrWaux9FLQajcsw4Stqc
        AHkVGlgULfH8a4pu+nWOarl9zLNs2xyBcyP89ZiBywo/EJbWuA==
X-Google-Smtp-Source: ADFU+vuTrYEY3sl6rSv1E2UUZ0BY3WHb8YZiptc0jERRQs4fk1Xp4Aks7zCu4zs1+b7RBPurdubM6idMkVJKourR8Hc=
X-Received: by 2002:a92:83ca:: with SMTP id p71mr6226891ilk.278.1584684069474;
 Thu, 19 Mar 2020 23:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <1584621380-21152-1-git-send-email-hqjagain@gmail.com>
 <20200319173710.GA7433@e121166-lin.cambridge.arm.com> <e16eb1a7-6ada-a8ed-c308-6fc5c9a8b7be@nvidia.com>
In-Reply-To: <e16eb1a7-6ada-a8ed-c308-6fc5c9a8b7be@nvidia.com>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Fri, 20 Mar 2020 14:00:59 +0800
Message-ID: <CAJRQjodvnA4xooVbTUQMVRB3_JQ6oJrJoQLV32idGJ3CNYcnQQ@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: dwc: fix compile err for pcie-tagra194
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        anders.roxell@linaro.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, amurray@thegoodpenguin.co.uk,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 1:15 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 3/19/2020 11:07 PM, Lorenzo Pieralisi wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Mar 19, 2020 at 08:36:20PM +0800, Qiujun Huang wrote:
> >> make allmodconfig
> >> ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> >> ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> >> ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> >> make[2]: *** [__modpost] Error 1
> >> make[1]: *** [modules] Error 2
> >> make: *** [sub-make] Error 2
> >>
> >> need to export the symbols.
> >>
> >> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> >> ---
> >>   drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >
> > I have squashed this in with the original patch.
> >
> > @Vidya: is this something we missed in the review cycle ? Asking just
> > to make sure it was not me who made a mistake while merging the code.
> My apologies. I wasn't compiling the driver as a module (instead built
> into the kernel image)
> BTW, I see
> ERROR: modpost: "dw_pcie_ep_init"
> [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
> also along with the above three. So I think even dw_pcie_ep_init() needs
> to be exported.

OK, I'll send v2 to add dw_pcie_ep_init.

>
> Thanks,
> Vidya Sagar
> >
> > Thanks,
> > Lorenzo
> >
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> index 4233c43..60d62ef 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> @@ -18,6 +18,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> >>
> >>        pci_epc_linkup(epc);
> >>   }
> >> +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> >>
> >>   void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> >>   {
> >> @@ -25,6 +26,7 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> >>
> >>        pci_epc_init_notify(epc);
> >>   }
> >> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
> >>
> >>   static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
> >>                                   int flags)
> >> @@ -535,6 +537,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >>
> >>        return 0;
> >>   }
> >> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> >>
> >>   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >>   {
> >> --
> >> 1.8.3.1
> >>
