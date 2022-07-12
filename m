Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4755726F0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 22:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiGLUFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiGLUFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 16:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94FB31E0;
        Tue, 12 Jul 2022 13:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFBD061A18;
        Tue, 12 Jul 2022 20:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF412C3411C;
        Tue, 12 Jul 2022 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657656329;
        bh=NVC3O1+3jbEWbsQSOefVDw/Rq43RuVITkdHYb2LaSng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lc0KZQVP7KjHF67Qx928PqPGvSzFrJp6trF9oLHwu/FGj8Q1OxR33uhz8kgT7WPC9
         V6mhck2Na8An/iJAtDh+acFZLHqSGv/aDbFsLqKpnzyY7jtBPtpwJCUMuHL2+cI7FX
         zTBzxKwHqVjew/C5D6/pZB/ElhMwWaql7hJ5wwEuCKbWE8ZKSQxWjTZP4aDqWS10ZQ
         TZmazZW5Rg+k7RrMdjeloPooiZbtmcvy67MpWCniwY5zGWamfVUAZzIKgbQe/TNaXI
         SFTnjq923fVDgeUKXGKc1f/2fpOmuNDMptw0sSNeAuf1mzPH6umKpoD0VVh6xqBX7q
         ssbpu6xOaX1jw==
Date:   Tue, 12 Jul 2022 15:05:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, jdmason@kudzu.us, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several globals
 to statics
Message-ID: <20220712200527.GA791291@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704132559.2859918-1-trix@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 09:25:59AM -0400, Tom Rix wrote:
> sparse reports
> drivers/pci/endpoint/functions/pci-epf-vntb.c:956:10: warning: symbol 'pci_space' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: symbol 'pci_read' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: symbol 'pci_write' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:989:16: warning: symbol 'vpci_ops' was not declared. Should it be static?
> 
> These functions and variables are only used in pci-epf-vntb.c, so their storage
> class specifiers should be static.
> 
> Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> Signed-off-by: Tom Rix <trix@redhat.com>

Handled via Jon, I guess?

I'm unclear on the future direction of pci-epf-vntb.c.  Jon, are you
signing up to maintain this?  MAINTAINERS doesn't seem to reflect
that, even in next-20220712, so you're not being copied on everything.

If you are planning to merge and maintain this file, it would be
helpful to me if you acknowledge patches you merge so I know to ignore
them.

> ---
> v2,3 : Change commit prefix
> 
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..6f0775b1fec3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -953,7 +953,7 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
>  
>  #define VPCI_BUS_NUM 0x10
>  
> -uint32_t pci_space[] = {
> +static uint32_t pci_space[] = {
>  	(VNTB_VID | (VNTB_PID << 16)),	//DeviceID, Vendor ID
>  	0,		// status, Command
>  	0xffffffff,	// Class code, subclass, prog if, revision id
> @@ -972,7 +972,7 @@ uint32_t pci_space[] = {
>  	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
>  };
>  
> -int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
> +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
>  {
>  	if (devfn == 0) {
>  		memcpy(val, ((uint8_t *)pci_space) + where, size);
> @@ -981,12 +981,12 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
>  	return -1;
>  }
>  
> -int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
>  {
>  	return 0;
>  }
>  
> -struct pci_ops vpci_ops = {
> +static struct pci_ops vpci_ops = {
>  	.read = pci_read,
>  	.write = pci_write,
>  };
> -- 
> 2.27.0
> 
