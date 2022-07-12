Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB85726BE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiGLTyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiGLTxp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 15:53:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739AC7D;
        Tue, 12 Jul 2022 12:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81705B81BCF;
        Tue, 12 Jul 2022 19:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB4C3411C;
        Tue, 12 Jul 2022 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657655378;
        bh=iESlDrScC/rVazYwSLBhRbeFWM571m/Ic3CS9bNhtDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jExbeJVODS4jEr4Pva7YdtCUu5ofN+KmVsrG3GINIJl/IUDpY4/2HxVlLpXpar4TH
         qSZ4Xmu7KRI2lwQpl0PTlDsgLB2Iw6h4gdO8+8ehZbwxEbxbko+ryrWD3U7FYNcwEX
         /yzLUGHlV3NzkErF23VSM4O+VPrqaphloIyd+Z9s98E1S25kWCRYhzqELnTe7deU0s
         nJk90o3RWf+CUImH/jlQKwC3sCT5Jh8tH0uwQSni6Lw2XFD2xvYRvLpLBAUYHmRvgg
         KFVG41vW1OPZjA2HMLUS+ieIz38BlZEIYMZljzTuQMPhDYx6NhFVY8iPyblC8uxSP0
         9Eel3FgdjvN6A==
Date:   Tue, 12 Jul 2022 14:49:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, jdmason@kudzu.us, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] NTB: EPF: Mark pci_read and pci_write as static
Message-ID: <20220712194936.GA790126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708020035.8071-1-jrdr.linux@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 07:30:35AM +0530, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> kernel test robot throws below warning ->
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning:
> no previous prototype for 'pci_read' [-Wmissing-prototypes]
> drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning:
> no previous prototype for 'pci_write' [-Wmissing-prototypes]
> 
> mark them as static.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

IIUC this series is going via Jon.  Let me know if I need to do
anything.

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..111568089d45 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -972,7 +972,7 @@ uint32_t pci_space[] = {
>  	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
>  };
>  
> -int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
> +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
>  {
>  	if (devfn == 0) {
>  		memcpy(val, ((uint8_t *)pci_space) + where, size);
> @@ -981,7 +981,7 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
>  	return -1;
>  }
>  
> -int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
>  {
>  	return 0;
>  }
> -- 
> 2.25.1
> 
