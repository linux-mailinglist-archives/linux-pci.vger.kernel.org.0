Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B257718D5F
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 23:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjEaVjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjEaVjE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 17:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577610DD
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 14:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B160361199
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 21:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE05C433EF;
        Wed, 31 May 2023 21:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685569045;
        bh=Y75wlnG/s3w6EhCt4lznVv+Zyft2P2jQ0Lp47yr0LM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bk/h4SsWHoPBdbgbW7sSGA/fDHne/tkL8KyGs9SQ8NzQhnD83wBT+9NcXqZNk7XYs
         F69luu63jJpvCeQiK/kgz71iWukcYTwZaYLAMduKsPAo7SNQnQgbyLwp9Awzt5pwAt
         a2d0W+yv7BkzrfR17HnuqyJK1EpvoV7MSr2Tmy3nYaJsgl8vUb4dSwbLFbWUjH7HtQ
         rrF8bmp9ArhKbQ1kVfEiupwkk/6T/aOhU6LEqabzs+RNDg0+BE2O+oWCkWTPrSmnsL
         0vyQZiSbKtelREnyKQpN1/Vrqo+t+0CAXc5hZOioZAI3XnyXPpuiqkht+O6wQkPrLL
         iYtcudqqjAi2g==
Date:   Wed, 31 May 2023 16:37:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: Re: [PATCHv2] pci: add PCI_EXT_CAP_ID_PL_32GT define
Message-ID: <ZHe+E7+GOgnP2fmM@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095713.293229-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 10:57:13AM +0100, Ben Dooks wrote:
> From: Ben Dooks <ben.dooks@sifive.com>
> 
> Add the define for PCI_EXT_CAP_ID_PL_32GT for drivers that
> will want this whilst doing Gen5/Gen6 accesses.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

I applied this to pci/enumeration for v6.5, thanks.

But I'm very curious about where you expect this to be used.

> --
> v2:
>   - fixed tabs
> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index dc2000e0fe3a..e5f558d96493 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -738,6 +738,7 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>  
> -- 
> 2.39.2
> 
