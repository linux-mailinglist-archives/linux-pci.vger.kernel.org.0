Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1870E579
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbjEWTbf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbjEWTbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 15:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D368E64;
        Tue, 23 May 2023 12:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63DB4635F1;
        Tue, 23 May 2023 19:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B3C4339C;
        Tue, 23 May 2023 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870271;
        bh=+QDoxFXRgj4afIFUth7xCvWHWkTLJgr2joOfGAc/Kr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xh8v74rD9lMajOUySop4xBKsnPUs+XoPrLsD5H2GHLb7wroZCivJ+ACYSAkhJ2By0
         zxuHrBYdfdP+9ziH4IQcpjrwIoAWOlzojqVKF7SUQuHXp0Lvq2yBcIbMeCOlN5zsEj
         mxY/CjJ3PbWhtpgVJ0TCay7UzV7Owx9NAcwufHVHG/JayXj6gq6uQaceu7erBax40S
         UAIJTc79w3Y1lRFVNcfbkkZmpK4bwwPWg/bc5oH4QhF501KxoyYbVcBe+etYctRcgf
         9uPHW4Qj+Hr3bXAFHO7slfSXs5Sm3SBT9uF2UccXvjFjYSZI4LfJLBgpv8wFwyAG1A
         FjMVRxnGthdFQ==
Date:   Tue, 23 May 2023 14:31:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhu YiXin <yzhu@maxlinear.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     Chuanhua Lei <lchuanhua@maxlinear.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Harliman Liem <pliem@maxlinear.com>, qwu@maxlinear.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Update entry for PCIe driver for
 Intel LGM GW SoC
Message-ID: <ZG0UfTlgZqqy78AS@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519044555.3750-2-yzhu@maxlinear.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Rahul, which I expect to bounce, but to give Rahul a chance to
respond/ack]

On Fri, May 19, 2023 at 12:45:55PM +0800, Zhu YiXin wrote:
> Rahul Tanwar is no longer at Maxlinear, so update the MAINTAINER's entry
> for the PCIe driver for Intel LGM GW SoC.
> 
> Signed-off-by: Zhu YiXin <yzhu@maxlinear.com>

This should also be acked by Chuanhua Lei, since I don't want to sign
people up for work they don't expect.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d274efff10..6091bbb0e1d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16383,7 +16383,7 @@ F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
>  F:	drivers/pci/controller/dwc/pcie-keembay.c
>  
>  PCIE DRIVER FOR INTEL LGM GW SOC
> -M:	Rahul Tanwar <rtanwar@maxlinear.com>
> +M:	Chuanhua Lei <lchuanhua@maxlinear.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> -- 
> 2.17.1
> 
