Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E357E752
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 21:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiGVTY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVTY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 15:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643E15F13D;
        Fri, 22 Jul 2022 12:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F29C7618E3;
        Fri, 22 Jul 2022 19:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC00C341C6;
        Fri, 22 Jul 2022 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658517896;
        bh=rc2TARnnEHdU37RCNbO/dNcdcOLxZd9/3lQoxs1lxHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TBxQmimIVApy1pG/KwFsv+C5Ie0TlOT9uuNXf7pw4vugMuxs9VZOsJT/bMP4l6SGR
         3/tHKhV3Wq5ICR4ELv7Uwe2Ul5cd+F01mLAUGAl6IwP+Luprq2L+snhr5hdv42VXtA
         FsSIM0yAb7OMJ2FKcPsiqBKAz9kuLURsKImSSfwgiP/HR2R1W5Xy2mMM4BGcifDNYr
         F/Sx3GwquYwldy96GmeGLkEKU3X9LNfUgjQw3U1PPOz0FotLQWdYt9RcoVTIshLcn/
         sbHe8qFMOBFUPS4cvCiC+iXeEWdiiV1++0NFLR8UGS6SwaoXDoEk8iovpPBRpJAV0F
         3nB+4IZsoeQGg==
Date:   Fri, 22 Jul 2022 14:24:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, bhelgaas@google.com, michals@xilinx.com
Subject: Re: [PATCH] MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers
Message-ID: <20220722192454.GA1923798@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618052022.10388-1-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 18, 2022 at 10:50:22AM +0530, Bharat Kumar Gogada wrote:
> Add maintainer for driver and documentation of Xilinx Versal
> CPM Root Port device.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>

Applied to pci/ctrl/xilinx-cpm for v5.20, thanks!

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..a07f926d7e93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15063,6 +15063,14 @@ L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/*spear*
>  
> +PCI DRIVER FOR XILINX VERSAL CPM
> +M:	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> +M:	Michal Simek <michal.simek@amd.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +F:	drivers/pci/controller/pcie-xilinx-cpm.c
> +
>  PCMCIA SUBSYSTEM
>  M:	Dominik Brodowski <linux@dominikbrodowski.net>
>  S:	Odd Fixes
> -- 
> 2.17.1
> 
