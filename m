Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86DB4656EA
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352904AbhLAUQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbhLAUPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:15:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A6C061757;
        Wed,  1 Dec 2021 12:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5357BB82145;
        Wed,  1 Dec 2021 20:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC998C53FAD;
        Wed,  1 Dec 2021 20:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638389524;
        bh=eMeOuQfLiYUGCjNeDFRCNedqWvUNJvdoY3J07uoZN7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZM6I1D52AWPSN+5QArmPvuKjy5PvyGkchbJ7yYLh3tKlqbKi2QL0VE4+i+NspFX6O
         sUaeJlCPX3IpK6ux120o0yrdepFoAYVGrW+jg/Sk+IKt4FcUSk0pfY2agf6FnPeQvQ
         d1qq+d3TIrRvZPgAQ6B4qR1bmTuLTdy1j1q3x7b8eaRhgbnzOpZreJC4XzOeYlR9cG
         px86Qmf6nmrrJrtMxLQCcl8+u5U/qLwYy1JTzAQf2+G/izE9ZVhu7h5vWi2hV4LUta
         gNwNkNs5toTxvgWg+UrIVQ3KU1CT8wAqogScXsh1SYZEz/L45skcLoJU4GDAsYnWRd
         AYJvKcE0SXS1w==
Date:   Wed, 1 Dec 2021 14:12:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: mt7621: Kconfig: completely enable driver for
 'COMPILE_TEST'
Message-ID: <20211201201202.GA2831888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115070809.15529-6-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For subject:

  PCI: mt7621: Allow COMPILE_TEST for all arches

On Mon, Nov 15, 2021 at 08:08:09AM +0100, Sergio Paracuellos wrote:
> Since all MIPS specific code has been moved from the controller driver side
> there is no more stoppers to enable the driver to be completely enable for
> 'COMPILE_TEST'. Hence, remove MIPS conditional statement.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index e917bb3652bb..105ec7dcccc9 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -332,7 +332,7 @@ config PCIE_APPLE
>  
>  config PCIE_MT7621
>  	tristate "MediaTek MT7621 PCIe Controller"
> -	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> +	depends on (RALINK && SOC_MT7621) || COMPILE_TEST
>  	select PHY_MT7621_PCI
>  	default SOC_MT7621
>  	help
> -- 
> 2.33.0
> 
