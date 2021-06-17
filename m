Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A291D3ABA3E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhFQRID (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 13:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhFQRID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 13:08:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEAAC06175F
        for <linux-pci@vger.kernel.org>; Thu, 17 Jun 2021 10:05:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y15so5525719pfl.4
        for <linux-pci@vger.kernel.org>; Thu, 17 Jun 2021 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spDOLTpTEkP0pQRlVnvSw7EzDBOy7ixf6KlEeu5zAFw=;
        b=gvFkjdJ8/nWFYJ6eh4eGwDZH3O/FzRYCKAixYJ+bNuEKuwuss5/DVmrjbX+uVysNvs
         i+qXxnRozSclnhV9Ko6zmIrYMI87h5HmYTek2HI51jvn+xNCD0bg4XrN4Yqp9qib8CR9
         CUbQjexgtNkQUUYY4uYwd9nqQU44N+MdMqNFnAuiyyvQF/75BrkWVJgcEymLk/Yr4jeG
         LXwy06acDKVCdG2uCzuuG+EAuw4cXh15bV4ak7aa62CQzu1ula2LAtWnB2igv14GYA4W
         lXzfTYxIUy2PbsQtOWmWpcG+YtKPZhkz3VQN8S2EtJE6uuvXzzN4PNXTSebZUa2p7xNz
         g78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spDOLTpTEkP0pQRlVnvSw7EzDBOy7ixf6KlEeu5zAFw=;
        b=dhT7QsbJzcLxLt5YnkA1Zy8/ATfj4xbxYhkAMVa7Aqz5k817PBntgqTlz3DoFRWVo9
         tubQRz1lQVZxCjRCuNHgkOtuoGFKhy6z1Lq8NTNGc5BhpEc84zhGEG0H40gwLI+dd/nB
         nFxuuO2y0B43pvDvY1iHb188ZZ9e4qtkB4fQnjBTnOJaJ9q/Kdjity+PLH1/2gWuxH9R
         +LWr5XqDL0k5wdMCDrGQ8L1dAey74RtKH+IqQAL+dmDnOdREssEfQE7Lx2I2AUU2RYEi
         fxB5kNExarW7nogVtip+Fmit+uPc/ukwkSSh6eli4Wh3hhtO/lOqXdtEIjDslswf/95D
         uxyQ==
X-Gm-Message-State: AOAM532Cp4N3z/ivBLbqhLDi6okzlU4mpKognzwy0Q4rwKQ+Tsk3bpMJ
        DVAh48IpAI8r3LJdWkl2uqAv
X-Google-Smtp-Source: ABdhPJwaG6/j71e6DUZJ1nF3XYcWFet57gwEKHoW0R5fI/eRI2bpxAbaOGhdC3lH0rW9KnnXYL+7tA==
X-Received: by 2002:a63:d117:: with SMTP id k23mr5831729pgg.60.1623949554810;
        Thu, 17 Jun 2021 10:05:54 -0700 (PDT)
Received: from workstation ([120.138.13.64])
        by smtp.gmail.com with ESMTPSA id nv1sm5562052pjb.43.2021.06.17.10.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jun 2021 10:05:54 -0700 (PDT)
Date:   Thu, 17 Jun 2021 22:35:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org
Subject: Re: [PATCH 0/5] PCI: endpoint: Add support for additional notifiers
Message-ID: <20210617170549.GA3075@workstation>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
 <9fd37c43-e2ab-f5b2-13dc-a23bd83d3c7b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd37c43-e2ab-f5b2-13dc-a23bd83d3c7b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 12:42:07AM +0530, Om Prakash Singh wrote:
> Hi Mani,
> Adding more notifier types will surely help but I believe the list is not
> exhaustive. What you are trying here is to pass various vendor-specific epc
> interrupts to EPF driver. That can be taken care by a single notifier
> interface as well, "pci_epc_custom_notify" from your implementation.

That's what I initially thought eventhough not all the notifiers are
vendor specific. But Kishon suggested to add notifiers for generic ones
such as BME, PME etc... and that sounded reasonable to me.

> This
> also requires to have pre-defined values of "data" argument to standardize
> the interface.
> 

No, I don't think we can standardize the arguments to "custom" notifier.
The custom notifier is supposed to deal with vendor specific events and
I don't see any benefit on standardizing it. I see it more like an
opaque driver_data field where we pass driver specific arguments.

Thanks,
Mani

> your thoughts?
> 
> Thanks,
> Om
> 
> On 6/16/2021 5:29 PM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hello,
> > 
> > This series adds support for additional notifiers in the PCI endpoint
> > framework. The notifiers LINK_DOWN, BME, PME, and D_STATE are generic
> > for all PCI endpoints but there is also a custom notifier (CUSTOM) added
> > to pass the device/vendor specific events to EPF from EPC.
> > 
> > The example usage of all notifiers is provided in the commit description.
> > 
> > Thanks,
> > Mani
> > 
> > Manivannan Sadhasivam (5):
> >    PCI: endpoint: Add linkdown notifier support
> >    PCI: endpoint: Add BME notifier support
> >    PCI: endpoint: Add PME notifier support
> >    PCI: endpoint: Add D_STATE notifier support
> >    PCI: endpoint: Add custom notifier support
> > 
> >   drivers/pci/endpoint/pci-epc-core.c | 89 +++++++++++++++++++++++++++++
> >   include/linux/pci-epc.h             |  5 ++
> >   include/linux/pci-epf.h             |  5 ++
> >   3 files changed, 99 insertions(+)
> > 
> > --
> > 2.25.1
> > 
