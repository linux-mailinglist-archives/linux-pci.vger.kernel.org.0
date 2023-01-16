Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6E966B849
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 08:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjAPHgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 02:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjAPHgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 02:36:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377DEC4A;
        Sun, 15 Jan 2023 23:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6DB7B80D1B;
        Mon, 16 Jan 2023 07:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23729C433EF;
        Mon, 16 Jan 2023 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673854560;
        bh=+LEK/p0aR7GFm7WL+gdmi6ckOz4YMx0HfCxEZNMp2HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmoRfDJ2VOZZ5iryiW4pbGvvco/rsGaT6VClYX1g3n3qYy8k9V0m/ANLT8MiP9vfD
         iSVn0KzJOvt9MVht7qQ1ZpWX9kE4QCvguEddb3zOsuz3fqFVSZgbiqBuROesIsXMRx
         r+i1oOD8Htql1OscpXSR/5ZGhg+w4falqN3luYWiTtOS3mg33STW6mK+hnodk7vyre
         aJGO1m/7/L27aMZ2PEsPv9yEp8GAqIzZ0USn5VSXbEbBZ/szQIk1N/XK7tUM6iaw9a
         yp1AbzHpkbZccjiSGaF9WDlTNZsUWhD0rNtjuNp07NN2s1GKd6a2/4YSYBLZ9GFRhU
         0PDryhbY8A0Kg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHK2T-00026s-B4; Mon, 16 Jan 2023 08:36:18 +0100
Date:   Mon, 16 Jan 2023 08:36:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: qcom: Add support for modular builds
Message-ID: <Y8T+cZ1jvnkGPz1l@hovoldconsulting.com>
References: <20221017114705.8277-1-johan+linaro@kernel.org>
 <Y8F98UTZNgQpX6UG@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8F98UTZNgQpX6UG@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 04:51:13PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Oct 17, 2022 at 01:47:03PM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > There's no rush with this, but I figured I'd send an updated version
> > that has been rebased on 6.1-rc1 (where post_deinit() has been removed).
> > 
> > I also broke out the qcom_pcie_host_deinit() handler in a separate patch
> > as the host_deinit() callback has now been added to dwc core and can be
> > used to fixes some late-probe error handling.
> 
> Waiting for the dust to settle on patch 2, does it make sense to
> merge patch 1 on its own ?

Sure, please do.

I haven't found the time and motivation to reiterate the arguments for
why I think blocking patch 2 is misguided, but I'm still confident that
anyone reviewing the arguments will reach the same conclusion (e.g. if
you want to dig through the archives). I'll get to it eventually.

Johan

> > Changes in v3
> >  - rebase on 6.1-rc1 where post_deinit() has been removed
> >  - split out host-init error handling
> >  - add Stan's ack
> > 
> > Changes in v2
> >  - rebase on next-20220720 (adjust context)
> >  - add Rob and Mani's reviewed-by tags
> > 
> > 
> > Johan Hovold (2):
> >   PCI: qcom: Fix host-init error handling
> >   PCI: qcom: Add support for modular builds
> > 
> >  drivers/pci/controller/dwc/Kconfig     |  2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c | 39 +++++++++++++++++++++++---
> >  2 files changed, 36 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 2.37.3
> > 
