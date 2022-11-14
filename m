Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD6627A53
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 11:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiKNKVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 05:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiKNKVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 05:21:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D672BF6
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 02:21:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h14so9915098pjv.4
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 02:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOykPAShtcDnSm8B/lMqW9jQYVBE4YszcqB7NewFe4Y=;
        b=yhr7Ykz8EYUcL1QwYpBHdPgxSBIuGxpoO79FVtYisWf3Tjom8sZXYHqyBaXiU/AmXt
         AG7Xaiq6CRtql1fSVkYT9qbegTYyFbXk20ehGfF0PF9grj9rnj0y720C8ChzRnRJyuLN
         uy0q69faJXm1OY9kY3zQ2o+17Y0hyheqLcsDlMVE4TTvE5TYFvSVU80c6YJNdeNkFBtl
         MCStooiHuqKk9awg4+6APq/P3j16JTZAnLFLochx9vwRIDHwL1ig7NLPur1Zl4sLCR0D
         0n0Nd1LnvcVI4u+Moa+15iazwlDiUk03TuCWP+I5hKvbE7FBO6UUGcYKj5NzHewqoR5k
         iPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOykPAShtcDnSm8B/lMqW9jQYVBE4YszcqB7NewFe4Y=;
        b=LbWAY4ko7f2AZZlpTjcH2FfIAN7xLg/YLfeo6xY1U+tSS2FZPp387iAj64Cu+y5uCn
         IeH/yBFSAjNk7WmhknrSJZ4ALwgya7Wf6cb+t3LzSV1R4pmo42GQCwM9h7f0/AlYkvhx
         bx9+PK5ImSCel0OwWIJhxs0QTRPpAcoKi0t1J+FbQfgJSMrj2BvknNC+yEc7GFRdxIKW
         ylTyqVTgz79ubL2T9y2f6P7LlCA3vILQVOJB8gNb4ZbmOsQHnqZbn7sRBvPN+FxFs7Er
         LlqPkA4409Z8Rwzpfhx2AtkITIVU1q9qgvdZMNVps/GqeC/K9HPK1exMl8JmkR6y7SRg
         ZY6A==
X-Gm-Message-State: ANoB5plHG1UcO2v4HAc2j0LiAyXyqr9M7s/RrQLq4PJLp2TZjKTh3lz3
        ovA9G8DqGz2oWjOJl+FTvHib
X-Google-Smtp-Source: AA0mqf7kEeBsHBzUXTz8IUWEQIgI3A4BEAEBUl3EtdXX0LnuSo7d73OC9HmqtQZ/xKzGY4j4e0Oowg==
X-Received: by 2002:a17:903:12cf:b0:17f:9021:dd4e with SMTP id io15-20020a17090312cf00b0017f9021dd4emr13393091plb.141.1668421261517;
        Mon, 14 Nov 2022 02:21:01 -0800 (PST)
Received: from thinkpad ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b00183e2a96414sm7031187plg.121.2022.11.14.02.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:21:00 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:50:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        kishon@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20221114102055.GJ3869@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221114073316.GI3869@thinkpad>
 <Y3IS+KIPGmEvcWmT@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3IS+KIPGmEvcWmT@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 11:05:44AM +0100, Lorenzo Pieralisi wrote:
> On Mon, Nov 14, 2022 at 01:03:16PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 25, 2022 at 08:20:56PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > During the review of the patch that fixes DBI access in PCI EP, Rob
> > > suggested [1] using a fixed interface for passing the events from EPC to
> > > EPF instead of the in-kernel notifiers.
> > > 
> > > This series introduces a simple callback based mechanism for passing the
> > > events from EPC to EPF. This interface is chosen for satisfying the below
> > > requirements:
> > > 
> > > 1. The notification has to reach the EPF drivers without any additional
> > > latency.
> > > 2. The context of the caller (EPC) needs to be preserved while passing the
> > > notifications.
> > > 
> > > With the existing notifier mechanism, the 1st case can be satisfied since
> > > notifiers aren't adding any huge overhead. But the 2nd case is clearly not
> > > satisfied, because the current atomic notifiers forces the EPF
> > > notification context to be atomic even though the caller (EPC) may not be
> > > in atomic context. In the notification function, the EPF drivers are
> > > required to call several EPC APIs that might sleep and this triggers a
> > > sleeping in atomic bug during runtime.
> > > 
> > > The above issue could be fixed by using a blocking notifier instead of
> > > atomic, but that proposal was not accepted either [2].
> > > 
> > > So instead of working around the issues within the notifiers, let's get rid
> > > of it and use the callback mechanism.
> > > 
> > > NOTE: DRA7xx and TEGRA194 drivers are only compile tested. Testing this series
> > > on the real platforms is greatly appreciated.
> > > 
> > 
> > Lorenzo, can this series be merged for v6.2 since all the patches are reviewed
> > now?
> 
> Patch (2) isn't (or I missed something) - we should be looking for
> review/testing on it.
> 

Yes, 2/5 doesn't have a review tag yet. But as per comments from Vidya on v3
[1], I believe it is okay to get merged.

But I'll ping on that patch anyway.

Thanks,
Mani

[1] https://lore.kernel.org/lkml/5ec4b46f-2590-bd34-f6fa-e4e2eeb38b7b@nvidia.com/

> Thanks,
> Lorenzo
> 
> > Thanks,
> > Mani
> > 
> > > Thanks,
> > > Mani
> > > 
> > > [1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
> > > [2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org
> > > 
> > > Changes in v4:
> > > 
> > > * Added check for the presence of event_ops before involing the callbacks (Kishon)
> > > * Added return with IRQ_WAKE_THREAD when link_up event is found in the hard irq
> > >   handler of tegra194 driver (Vidya)
> > > * Collected review tags
> > > 
> > > Changes in v3:
> > > 
> > > * As Kishon spotted, fixed the DRA7xx driver and also the TEGRA194 driver to
> > >   call the LINK_UP callback in threaded IRQ handler.
> > > 
> > > Changes in v2:
> > > 
> > > * Introduced a new "list_lock" for protecting the epc->pci_epf list and
> > >   used it in the callback mechanism.
> > > 
> > > Manivannan Sadhasivam (5):
> > >   PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
> > >   PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
> > >   PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
> > >   PCI: endpoint: Use callback mechanism for passing events from EPC to
> > >     EPF
> > >   PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
> > > 
> > >  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
> > >  drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
> > >  include/linux/pci-epc.h                       | 10 +----
> > >  include/linux/pci-epf.h                       | 19 ++++++----
> > >  6 files changed, 59 insertions(+), 51 deletions(-)
> > > 
> > > -- 
> > > 2.25.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
