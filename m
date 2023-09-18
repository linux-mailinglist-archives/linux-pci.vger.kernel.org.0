Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575427A5324
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIRTdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 15:33:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E044F7;
        Mon, 18 Sep 2023 12:33:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E229C433C7;
        Mon, 18 Sep 2023 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695065620;
        bh=+buqqO/wnxA4xEuxrSuwfqJ0mRpiDdrP2TUcBhwJcy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EP2czQnXqV3N/X+pRZ3nA3IWx9Wrh9dTvgTacetMYvPO53Kd83yuL2gu69e6GgQXt
         nqJJ0rbiYlX9IMqs1uCuTu5k8PRA8bIVnukUODB3D9wr5vUCxeAuEiq6QfuTRoZbGY
         N9uOjmzLLpcKlzQd+ILTKna0mSwLZEOtXQfLjNdK+uTbJKcSwUejh9TpyCJZOCgEG5
         Kw0kM7uFvTgk/hUsTEuid8aRWJ0GPDQatmnlq/Athc3tR2374nuUvWkFF+MqK0tJRY
         i1SKCkwRO5Ni8zeIwhIMWQhmalHYtID0DVURUIPCUvsSyg2l0C5z2aMWTNvGfJJyvF
         bWhT++gEtXS1w==
Date:   Mon, 18 Sep 2023 14:33:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/30] drivers/pci: Add SH7751 Host bridge
 controller
Message-ID: <20230918193337.GA203483@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87db26af4a30210ab54519b91bb8541e88519185.1694596125.git.ysato@users.sourceforge.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 06:23:33PM +0900, Yoshinori Sato wrote:

Update subject line and include a commit log.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/pci/controller/Kconfig  | 9 +++++++++
>  drivers/pci/controller/Makefile | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index c0c3f2824990..037ff44bd1e8 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -342,6 +342,15 @@ config PCIE_XILINX_CPM
>  	  Say 'Y' here if you want kernel support for the
>  	  Xilinx Versal CPM host bridge.
>  
> +config PCI_SH7751
> +	bool "Renesas SH7751 PCI controller"
> +	depends on OF
> +	depends on CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST
> +	select PCI_HOST_COMMON
> +	help
> +	  Say 'Y' here if you want kernel to support the Renesas SH7751 PCI
> +	  Host Bridge driver.

Sort this so it appears in alpha order by vendor, device in
menuconfig, etc.

Since I didn't get the entire series, here are the whitespace errors
from git-am:

  Applying: arch/sh: head_32.S passing FDT address to initialize function.
  .git/rebase-apply/patch:25: trailing whitespace.
  Applying: Documentation/devicetree: Add renesas,sh7751-cpg binding document.
  .git/rebase-apply/patch:66: space before tab in indent.
		  clocks = <&xtal>;
  Applying: drivers/irqchip: SH7751 IRL external encoder with enable gate.
  .git/rebase-apply/patch:33: new blank line at EOF.

