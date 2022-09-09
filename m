Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333625B38A5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIINKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 09:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIINKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 09:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DE040BF8;
        Fri,  9 Sep 2022 06:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C3461FCF;
        Fri,  9 Sep 2022 13:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C53C433C1;
        Fri,  9 Sep 2022 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662729004;
        bh=5PnnwsoB3HvLeQ2lJwrsgQqPyCQ70pR6k0Vd37d4Gaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZUyUV8+PxmN04UzLSy7b0Jj++Zz9G5bOUzl01+8cLwj/nCCgPDPAXCW3fdguamOG
         fOGVokZk9P5maRTV2uOpd9ijP4kCfkJtCtxagV2gSOuabEd1jt/xUv2ksiyenHRGeU
         IYs8vj+j0kNcPICW2/tXF8aNzEnaT52Lo4XTmvTqa8eQ6aTOa4vJ6mWtdgIiVYk/Kn
         KtMxOSMf+Q+iBSsCc1GlzPyy7SmaT2rKpjICklZOaW6deFc6r5PHPzTbM2FbqkehCS
         QljCJgX2G4ahFuwWKu2R58fA0D+FI8PDnDOopxR6K85YuZYwVl9I2H1TzHF0l6jcLX
         67PxlU/PeQqxA==
Date:   Fri, 9 Sep 2022 15:09:58 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH v2 0/5] pci_endpoint_test: Fix the return value of IOCTLs
Message-ID: <Yxs7JlQ8jzNNwvdi@lpieralisi>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 24, 2022 at 06:00:05PM +0530, Manivannan Sadhasivam wrote:
> During the review of a patch for pci_endpoint_test driver [1], Greg spotted
> the wrong usage of the return value of IOCTLs in the driver. This series
> fixes that by returning 0 for success and negative error code for failure.
> Relevant change is also made to the userspace tool and the Documentation.
> 
> Along with those, there are couple more patches fixing other small issues
> I noted.
> 
> NOTE: I have just compile tested this series. So it'd be good if someone
> can test it on the PCI endpoint setup.
> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/all/20220816100617.90720-1-mie@igel.co.jp/
> 
> Changes in v2:
> 
> * Fixed the error numbers in pci_endpoint_test
> * Added Fixes tag and CCed stable list for relevant patches. The patches
>   should get backported until 5.10 kernel only. Since for the LTS kernels
>   before that, the pci_endpoint_test driver was not supporting all commands.
> 
> Manivannan Sadhasivam (5):
>   misc: pci_endpoint_test: Fix the return value of IOCTL
>   tools: PCI: Fix parsing the return value of IOCTLs
>   Documentation: PCI: endpoint: Use the correct return value of
>     pcitest.sh
>   misc: pci_endpoint_test: Remove unnecessary WARN_ON
>   tools: PCI: Fix memory leak
> 
>  Documentation/PCI/endpoint/pci-test-howto.rst | 152 ++++++++--------
>  drivers/misc/pci_endpoint_test.c              | 167 ++++++++----------
>  tools/pci/pcitest.c                           |  48 ++---
>  3 files changed, 179 insertions(+), 188 deletions(-)

May I ask where are we with this thread ? I have noticed some key
comments from Greg that need addressing so I'd expect a new version.

Thanks,
Lorenzo
