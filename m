Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139ED351B5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 23:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDVQI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 17:16:08 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38050 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDVQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 17:16:08 -0400
Received: by mail-wm1-f48.google.com with SMTP id t5so183236wmh.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2019 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LhLSypOW9eEI9FrLebgFNQ023mgsanhRlBmqRqaKH8=;
        b=DB1f081XOEIYiO+XPUFzSHj+wTzFUlTQyO/mCt6sXG2zzgQq6gKxoRBmidaLihy7md
         Y/oKCJIK3rznJw+x4YC567yHM5+Qjnemes/tW4nMzcAnkT/UTQcFp/gHGQ0nlbjIBpkV
         ou3wDNEFgn5ZKdCDagPh+cq/3D229OcNLbqG3WTVknlmTDOFxyV+XFBSS+hHUqFcNrNS
         YT23YwGIZlbTKHXoUdcKnIjpCt+vYDmHIf16z3vhoBAaPSekGC74N6EcsO7ZDhDjj3L/
         SQF/tEKDGWkPIB+abSziCAqCWd2xvU12p2eKSVUWkkWra2x9XnMantgNqHpVBeIxjABr
         SAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LhLSypOW9eEI9FrLebgFNQ023mgsanhRlBmqRqaKH8=;
        b=ZZlTIM3aAJdAakN5Lr7qc4798seo6GNpTn4fQSfNOhXih6oJ7B0y+TCcaNeolpNAkJ
         qGfUuCYtqEFmUzASFAVNBu9GbhEzpzrRi9ZWY+qAkJibONOqBB/GVSZclSFa/SunYe6a
         cuLgVE5guJwiMlpumUp4FZmbUFgs79wFs+d/gnt+yiCs457iX3H28Weiv8Cs7PPCpC0Z
         dHxCAJSNqAeKP+zJ3cBsYjtI3aI30qTgb/C34WKg9DqAOZNSFCJMehB/pwViYYFcm+Ri
         yNyei6rLwsE3thWuZcQEjb2KPcjxyp4m9ApycGmjuhMSarWzMh3nw2yfAU5SQDtN/1/b
         4TIg==
X-Gm-Message-State: APjAAAWntUqiOFX7SzBnO5YFyj5nexHqp2JbfMVl4OQxy//KjLcEuxeh
        4+JIlb8q0zRD07ngHvUC22Yot+lnzOQiHn8NDCBFnTQkS6s=
X-Google-Smtp-Source: APXvYqxvUTJEkr1DnaWygDWy/4qusF2MNIC7WBZ9dpXPnc0TcjVY0az8H0+7pUI3bOxF3Ri/Z/T8zEr08JZb61B2z9M=
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr19170911wma.118.1559682965882;
 Tue, 04 Jun 2019 14:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com>
 <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com> <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
 <8e4ccf44-9e4f-8007-ddcc-431440f9d533@amd.com>
In-Reply-To: <8e4ccf44-9e4f-8007-ddcc-431440f9d533@amd.com>
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Tue, 4 Jun 2019 14:15:54 -0700
Message-ID: <CAOQPn8vE4SbDBt_fu3YsqysHspjZ9rumsDHT9RQe+ZT7HUfKCQ@mail.gmail.com>
Subject: Re: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
To:     Gary R Hook <ghook@amd.com>
Cc:     "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 9, 2019 at 1:03 PM Gary R Hook <ghook@amd.com> wrote:
>
> On 4/24/19 5:04 PM, Eric Pilmore wrote:
> >
> > Thanks the for the response.  We are using the correct device for the
> > dma_alloc_coherent(). Upon further investigation what we are finding
> > is that apparently the AMD IOMMU support can only manage one alias, as
> > opposed to Intel IOMMU support which can support multiple. Not clear
> > at this time if it's a software limitation in the AMD IOMMU kernel
> > support or an imposed limitation of the hardware. Still investigating.
>
> Please define 'alias'?

Hi Gary,

I appreciate the response. Sorry for the late reply. Got sidetracked
with other stuff.

I will try to answer this as best I can. Sorry if my terminology might
be off as I'm still a relative newbie with some of this.

The "alias" is basically another BDF (or ProxyID) that wants to be
associated with the same IOMMU resources as some primary BDF.
Reference <drivers/pci/quirks.c>. In the scenario that we have we are
utilizing NTB and through this bridge will come requests (TLPs) that
will not necessarily have the ReqID as the BDF of the switch device
that contains this bridge. Instead, the ReqID will be a "translated"
(Proxy) BDF of sourcing devices on the other side of the
Non-Transparent Bridge. In our case our NTB is a Switchtec device and
the quirk quirk_switchtec_ntb_dma_alias() is used as a means of
associating these aliases (aka ProxyID or Translated ReqID) with the
NT endpoint in the local host. On Xeon platforms, the framework
supports allowing multiple aliases to be defined for a particular
IOMMU and everything works great. However, with the AMD cpu, it
appears the IOMMU framework is only accepting just one alias. Note
Logan's earlier response @ Mon, Apr 22, 10:31 AM. In our case the one
that is accepted is via the path for a processor Read, but Processor
Writes go through a slightly different path resulting in a different
ReqID. As Logan points out it seems since the AMD IOMMU code is only
accepting one alias, the Write ReqID looks foreign and thus results in
the IOMMU faults.

>
> The IO_PAGE_FAULT error is described on page 142 of the AMD IOMMU spec,
> document #48882. Easily found via a search.
>
> The flags value of 0x0070 translates to PE, RW, PR. The page was
> present, the transaction was a write, and the peripheral didn't have
> permission. That implies that mapping hadn't been done.
>
> Not being sure how that device presents, or what you're doing with IVHD
> info, I can't comment further. I can say that the AMD IOMMU provides for
> a single exclusion range, but as many unity ranges as you wish.

I'm currently not doing anything with IVHD. The devices on the other
side of the NTB that need to be aliased can be anything from a remote
Host processor, NVMe drive, GPU, etc., anything that wants to send a
memory transaction to the local host.

If you have any insight into how the AMD IOMMU support in the kernel
could be extended for multiple aliases, or whether there is a hardware
limitation that restricts it to just one, that would be greatly
appreciated.

Thanks,
Eric




-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom
it is addressed and may contain information that is privileged,
confidential, proprietary, or otherwise exempt from disclosure under
applicable law. If you believe you have received this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
