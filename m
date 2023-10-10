Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE877C4156
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjJJUiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjJJUiR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:38:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6E8E;
        Tue, 10 Oct 2023 13:38:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEFEC433C7;
        Tue, 10 Oct 2023 20:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970296;
        bh=nYO8lXzg88/fnDY8vcHFgWOPAdak5gG9SWwFn4Txbwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p9lcN0SAnQ4KZ0ai5ApKZxAdBKMnSWPI4ZbkWw/B2MU6ua/JpBj4aiBt6LINY9woA
         T4Dbpmn7Y+bL4rGRophFjdX6whYQx/xDGLcCPzfz+c4SaB08lNez/ycLrqnIjwqx1R
         L6tU5McFyFJO9noUXv+yPLhktCXjh1cVidABOk2tuSGuLJ4bgvsVgo6axLUopOQSOf
         WFk2xfdWqshNn8Eygtqp9VzphJhN/nEoL23zaSkRRI+UaoW8NJGZAup0pbv0//WXH0
         mQF+bUmXWy+VGV742oP3g/v8Un66hBbNfsdnELv+viVlW2X6cnmBs9OGfemcCv22G0
         4O8KMFHPLpUFg==
Date:   Tue, 10 Oct 2023 15:38:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] PCI/treewide: PCIe capability access cleanups
Message-ID: <20231010203814.GA1000165@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 03:56:40PM +0300, Ilpo Järvinen wrote:
> Instead of custom code to extract the PCIe capabilities, make the code
> more obvious using FIELD_GET/PREP().
> 
> Also cleanup some duplicated defines in e1000e.
> 
> This is just a step into the right direction, there's plenty of places
> still to cleanup which will have to wait for another patch series.
> 
> v3:
> - Remove applied patches (scsi)
> - Use pci_pcie_cap() and tweak local variable (e1000e)
> - Use the correct prefix for RDMA/hfi1
> 
> v2:
> - Remove extract_width() and use FIELD_GET() directly (IB/hfi1)
> - Convert other fields beside Link Width ones
> - Remove useless u8 casts (scsi: esas2r)
> - e1000e:
>         - Remove defines that duplicate pci_regs.h ones
>         - Convert to pcie_capability_read_word()
> 
> 
> Ilpo Järvinen (8):
>   RDMA/hfi1: Use FIELD_GET() to extract Link Width
>   media: cobalt: Use FIELD_GET() to extract Link Width
>   igb: Use FIELD_GET() to extract Link Width

>   PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
>   PCI: mvebu: Use FIELD_PREP() with Link Width
>   PCI: Use FIELD_GET() to extract Link Width

Applied these three drivers/pci patches to pci/field-get for v6.7,
thanks!

>   e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom
>     defines/code
>   e1000e: Use pcie_capability_read_word() for reading LNKSTA
> 
>  drivers/infiniband/hw/hfi1/pcie.c           |  9 ++-------
>  drivers/media/pci/cobalt/cobalt-driver.c    | 11 ++++++-----
>  drivers/net/ethernet/intel/e1000e/defines.h |  3 ---
>  drivers/net/ethernet/intel/e1000e/mac.c     | 18 ++++++++----------
>  drivers/net/ethernet/intel/igb/e1000_mac.c  |  6 +++---
>  drivers/pci/controller/dwc/pcie-tegra194.c  |  9 ++++-----
>  drivers/pci/controller/pci-mvebu.c          |  2 +-
>  drivers/pci/pci-sysfs.c                     |  5 ++---
>  drivers/pci/pci.c                           |  6 +++---
>  9 files changed, 29 insertions(+), 40 deletions(-)
> 
> -- 
> 2.30.2
> 
