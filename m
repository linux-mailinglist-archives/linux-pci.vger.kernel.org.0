Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAEC62100F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 13:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiKHMOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 07:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiKHMOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 07:14:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB783E081
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 04:14:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y13so13639969pfp.7
        for <linux-pci@vger.kernel.org>; Tue, 08 Nov 2022 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGI9zJafSo+dT15R0+N5O4QPZGOTZV+sWCo0eHtQqjw=;
        b=AS4fZ0Z7h9A3PzUkADaZKLSWmUHkX5WwU3/AoS+QyE8gcmEd5ivuv1r4W074jUR7qw
         /7BPoRPtUC2STKq+oD4AapwtFGUFQdIJ3SnPKJLTFEMbfmvHerd2gBbR1HphxonSlulM
         vrUctbIFYaTlOBkFi7RdU+MjGsnzbu9BLFQYPgXNReTXOkFIARm1D7bCCFx1QCXNX+KP
         W++CvkdOBoZZuer7udcfa+SeoRwSlfadRuuM0OcAZIqUo2yuEHWE0+AHse9Z792DRtig
         nyaECi0pbg08VYfhrBnXqQDimEnLxPgKr5yGQ+jWJtX7sHwh+kaR8SKWC/q3g1HICJgi
         ws6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGI9zJafSo+dT15R0+N5O4QPZGOTZV+sWCo0eHtQqjw=;
        b=frDfDAesrsCZAAiClvhiahRTclybRFDdav5k/WFxENYQp5QuaqPoIC6e1Y0OPEPHaF
         8evheT9hVErmcOTjz7OL+zOG5MprymSSjA+ioMIpd4Oct6VNWSL6Jkc6cpvVcHlnesGm
         dr/SWfv/GIzW7IcSoBbPk+OkZlV7YMYV5/3wcd2eqrgvT0bXHGO4skz8dgrKVM/U12b2
         wvXsl2GmweNBdUoxx9TBUXklnGyIMpz63c9HJCBbvkLHZztgw/m1Z3Qg8Nrr+Bu9SmtX
         XG0EdMwjrJKLsnMC+rQFgwMknoeCx8b1PyqZAl0LJWikCFtdiMQWfaqNM+3rLNFIE61B
         mqqA==
X-Gm-Message-State: ACrzQf1YpcqrCJ3q63J0K5li//3tbih9snIGk76RHL831TKmdygRdT9j
        WfT976woxqlTqJDKfVxCCgql
X-Google-Smtp-Source: AMsMyM72cbUVS1RNPoLSQ1s1UzXxY6tDH1n3KjTEErRKCD5Ox/XWtUcpfspBUgWrZxaLFJHljP4EWQ==
X-Received: by 2002:a63:5a63:0:b0:42f:e143:80d4 with SMTP id k35-20020a635a63000000b0042fe14380d4mr48808447pgm.456.1667909687929;
        Tue, 08 Nov 2022 04:14:47 -0800 (PST)
Received: from thinkpad ([117.207.25.46])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm5619378pgr.16.2022.11.08.04.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:14:46 -0800 (PST)
Date:   Tue, 8 Nov 2022 17:44:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20221108121440.GA29115@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221107202853.GA416802@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107202853.GA416802@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 07, 2022 at 02:28:53PM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 25, 2022 at 08:20:56PM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > During the review of the patch that fixes DBI access in PCI EP, Rob
> > suggested [1] using a fixed interface for passing the events from EPC to
> > EPF instead of the in-kernel notifiers.
> 
> > Manivannan Sadhasivam (5):
> >   PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
> >   PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
> >   PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
> >   PCI: endpoint: Use callback mechanism for passing events from EPC to
> >     EPF
> >   PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
> > 
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
> >  drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
> >  include/linux/pci-epc.h                       | 10 +----
> >  include/linux/pci-epf.h                       | 19 ++++++----
> >  6 files changed, 59 insertions(+), 51 deletions(-)
> 
> Doesn't apply cleanly on v6.1-rc1.  Does it depend on something else?

Yes, this patch:
https://lore.kernel.org/linux-pci/20220825090101.20474-1-hayashi.kunihiko@socionext.com/

Since this patch is already merged by Lorenzo, I based this series on top of
that. If that's not required, I can send a new version without that patch.

Let me know.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
