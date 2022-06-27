Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EC855CE2C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiF0Vx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 17:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiF0Vx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 17:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B95625E
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 14:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F0061838
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 21:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C267C341CB;
        Mon, 27 Jun 2022 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656366835;
        bh=sLHkwi3BDW28dHYmKIPkRaprqM8DBL4X0Qfolya6fI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T9BUsnaa7J/X1O4kQgf4Vm4CYxS+tkQPXY4cWF38uvWV0SgTZa1jT8hq5YZxa7g8g
         MX4Qeub9SBWm5UHJSWLEkDp3stuXi8f64TwBJJSDdVoLEuVWab+Rra0fBVPZyySo/l
         XDbhzWYIv9nsv62a3dUthvmHi81rRKBpkntwdRrRMANMQHJBg0Gs/3OT0KOEs8hhYe
         pXoI8LOX6KG52ZlXMFtLYLQ0kbtp6Ol/Dp9tehzO+Yya4tocLXR/uoMZRt+tXutVhd
         c+0QcYZPXFP7PuXHDIfMv2kbEpOTLJ5sjR84R0yVjIKQt6Z6HvpBCUALm04NiwZswW
         BqoMrmF4eRCvQ==
Date:   Mon, 27 Jun 2022 16:53:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V14 1/7] PCI/ACPI: Guard ARM64-specific mcfg_quirks
Message-ID: <20220627215353.GA1781942@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617074330.12605-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 03:43:24PM +0800, Huacai Chen wrote:
> Guard ARM64-specific quirks with CONFIG_ARM64 to avoid build errors,
> since mcfg_quirks will be shared by more than one architectures.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

pci_mcfg.o is only built when CONFIG_ACPI_MCFG=y.  Where's the patch
that sets CONFIG_ACPI_MCFG=y for loongson?

I see that "PCI: loongson: Add ACPI init support" adds the #ifdef
CONFIG_LOONGARCH here, but AFAICS we still won't build it.

> ---
>  drivers/acpi/pci_mcfg.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..63b98eae5e75 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -41,6 +41,8 @@ struct mcfg_fixup {
>  static struct mcfg_fixup mcfg_quirks[] = {
>  /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
>  
> +#ifdef CONFIG_ARM64
> +
>  #define AL_ECAM(table_id, rev, seg, ops) \
>  	{ "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
>  
> @@ -169,6 +171,7 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	ALTRA_ECAM_QUIRK(1, 13),
>  	ALTRA_ECAM_QUIRK(1, 14),
>  	ALTRA_ECAM_QUIRK(1, 15),
> +#endif /* ARM64 */
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> -- 
> 2.27.0
> 
