Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53D758783
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 23:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGRVxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGRVxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 17:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6926198E;
        Tue, 18 Jul 2023 14:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6335C611DC;
        Tue, 18 Jul 2023 21:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C036C433C7;
        Tue, 18 Jul 2023 21:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689717212;
        bh=9GJl9BKrVBmnHdnk/r5SFl8lXAj76tW1SzBJ1JufEKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YAjBS1M031nA14Fa/+wmtGpYOPqBIh3RNDv+pn4g3wxGkaqCmBIZUbitjOcLMvebc
         b4ieU90GREd6txCNYrbaJ/nbL6xYCCa5oBnh/mkSpaY1bls6aYVucKYaQjxgFY00SZ
         ztXr+CFA6rddV09Y1bXytjQlNlMZIjvqhFe2uMqOnTf7sOnxA6koGVP+2sDTLvFGcZ
         e3E31wYwmAE3JUeJueS6pr5NthXVr5UDJpBM1YSIRgUJw9aRsQbgeVRfbh0Riv/fnP
         464PIjgFtQ7XgLNHw3LfgOJ2ELoTUPlwzVRVyYmd1SP+nSmghocSjx3b8q/a0hg3fp
         fI3O+3klcMCNQ==
Date:   Tue, 18 Jul 2023 16:53:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: ibmphp: make read-only arrays static
Message-ID: <20230718215330.GA496036@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627125612.724764-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 01:56:12PM +0100, Colin Ian King wrote:
> Don't populate the arrays on the stack, instead make them static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to pci/hotplug for v6.6, thanks!

> ---
>  drivers/pci/hotplug/ibmphp_pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
> index 754c3f23282e..50038e5f9ca4 100644
> --- a/drivers/pci/hotplug/ibmphp_pci.c
> +++ b/drivers/pci/hotplug/ibmphp_pci.c
> @@ -329,7 +329,7 @@ int ibmphp_configure_card(struct pci_func *func, u8 slotno)
>  static int configure_device(struct pci_func *func)
>  {
>  	u32 bar[6];
> -	u32 address[] = {
> +	static const u32 address[] = {
>  		PCI_BASE_ADDRESS_0,
>  		PCI_BASE_ADDRESS_1,
>  		PCI_BASE_ADDRESS_2,
> @@ -564,7 +564,7 @@ static int configure_bridge(struct pci_func **func_passed, u8 slotno)
>  	struct resource_node *pfmem = NULL;
>  	struct resource_node *bus_pfmem[2] = {NULL, NULL};
>  	struct bus_node *bus;
> -	u32 address[] = {
> +	static const u32 address[] = {
>  		PCI_BASE_ADDRESS_0,
>  		PCI_BASE_ADDRESS_1,
>  		0
> @@ -1053,7 +1053,7 @@ static struct res_needed *scan_behind_bridge(struct pci_func *func, u8 busno)
>  	int howmany = 0;	/*this is to see if there are any devices behind the bridge */
>  
>  	u32 bar[6], class;
> -	u32 address[] = {
> +	static const u32 address[] = {
>  		PCI_BASE_ADDRESS_0,
>  		PCI_BASE_ADDRESS_1,
>  		PCI_BASE_ADDRESS_2,
> @@ -1182,7 +1182,7 @@ static struct res_needed *scan_behind_bridge(struct pci_func *func, u8 busno)
>  static int unconfigure_boot_device(u8 busno, u8 device, u8 function)
>  {
>  	u32 start_address;
> -	u32 address[] = {
> +	static const u32 address[] = {
>  		PCI_BASE_ADDRESS_0,
>  		PCI_BASE_ADDRESS_1,
>  		PCI_BASE_ADDRESS_2,
> @@ -1310,7 +1310,7 @@ static int unconfigure_boot_bridge(u8 busno, u8 device, u8 function)
>  	struct resource_node *mem = NULL;
>  	struct resource_node *pfmem = NULL;
>  	struct bus_node *bus;
> -	u32 address[] = {
> +	static const u32 address[] = {
>  		PCI_BASE_ADDRESS_0,
>  		PCI_BASE_ADDRESS_1,
>  		0
> -- 
> 2.39.2
> 
