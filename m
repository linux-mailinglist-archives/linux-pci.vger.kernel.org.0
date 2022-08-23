Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95D59E458
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiHWM5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiHWM4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 08:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E42A708;
        Tue, 23 Aug 2022 03:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F0361596;
        Tue, 23 Aug 2022 10:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF82C433C1;
        Tue, 23 Aug 2022 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661248879;
        bh=aQOpLAOxNcwgrRcdYxm2/SGrN3a9OAXcro2hrJawsO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8mPaf7HWxeqOnl2cGCnM0eRRNf15TLSII5sa1iK1/uJB+479czwvAHpAm+7qWR48
         w3Hu66UavF8uNQJ2rydvz1GZOwyGits8XNiUlI+WToBS34/9t3jHypxPuOVVdjBVCK
         rr+ju4SpiqOJydXusPIFDpgHdti85WmX5IQGxTkmcmXDaEBNxbAPlCVCtSoblUFQke
         /066VgfbFp67nh9EuSttAsv/Ri4xF4WRB4x5b0GVgqAfMTFR2zQvsoQ0mgm/BlcRp8
         3DzGjGRcsgFcFSXBp5HqdwjHuXnuLUwLLmwgf4k5mT2cX8B8K9CkVMJgkiS/h3RVD+
         P0VXr0F6CmBcA==
Date:   Tue, 23 Aug 2022 12:01:11 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Will McVicker <willmcvicker@google.com>,
        Christoph Hellwig <hch@infradead.org>, robin.murphy@arm.com
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] PCI: dwc: Add support for 64-bit MSI target
 addresses
Message-ID: <YwSlZ8EQdX4Z6N+p@lpieralisi>
References: <20220812000327.3154251-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812000327.3154251-1-willmcvicker@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 12, 2022 at 12:03:24AM +0000, Will McVicker wrote:
> Hi All,
> 
> I've updated the series to address the review comments. Refer to the v4
> history below for the changes. Please take a look and thanks again for the
> reviews!

This series looks OK to me - it'd be good if Christoph/Robin can have
a look though before merging it.

Lorenzo

> Regards,
> Will
> 
> Will McVicker (2):
>   PCI: dwc: Drop dependency on ZONE_DMA32
>   PCI: dwc: Add support for 64-bit MSI target address
> 
> v4:
>  * Updated commit descriptions.
>  * Renamed msi_64b -> msi_64bit.
>  * Dropped msi_64bit ternary use.
>  * Dropped export of dw_pcie_msi_capabilities.
> 
> v3:
>   * Switched to a managed DMA allocation.
>   * Simplified the DMA allocation cleanup.
>   * Dropped msi_page from struct dw_pcie_rp.
>   * Allocating a u64 instead of a full page.
> 
> v2:
>   * Fixed build error caught by kernel test robot
>   * Fixed error handling reported by Isaac Manjarres
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 42 +++++++++----------
>  drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  3 files changed, 28 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 2ae08b36c06ea8df73a79f6b80ff7964e006e9e3
> -- 
> 2.37.1.559.g78731f0fdb-goog
> 
