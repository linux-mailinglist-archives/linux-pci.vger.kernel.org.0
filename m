Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5324D4FC9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 17:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbiCJQxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 11:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244227AbiCJQxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 11:53:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38D198ECC;
        Thu, 10 Mar 2022 08:52:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D4D61D00;
        Thu, 10 Mar 2022 16:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6280C340F4;
        Thu, 10 Mar 2022 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646931128;
        bh=ElymF9bFBBy1n24Im00MyTY3vz1EhoElO8yoHTyT2Zg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z70GlNfyR7y91BnSVAjrftfXRydpAHUstcfbT9kmLqCpC8Xi5BIJ4bUql++NwerUQ
         mv+2o9v/HbYoXIxSh/yPNi9dU0ijzdfXyE4I1+2olecaFEXzFkvoUqSQOFMqOTrMcZ
         s5KuQfMnUoU+6nTRDN0DPraDx6M6Jtky3H4lP056kVAwQv036ELq4uZZPUKxpRRZjt
         /AihjRI1VnAnB4w/jYrsxXj3occUe+v/MobUfDePfOfl6aJYwPpH9FDEK5yy8Jxjja
         p47PJ0RyxTVJeehnyCe1dUX8/XjqL8KcBGb1bUd2fD/wWT89BjadXIe+v6QCynrBiv
         /Fl6gs1yoqCgA==
Date:   Thu, 10 Mar 2022 10:52:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Toan Le <toan@os.amperecomputing.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 01/14] sizes.h: Add SZ_1T macro
Message-ID: <20220310165206.GA163581@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b020d8dcedb2753a894722147a0b5de25b2ae29b.1646847561.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 09, 2022 at 06:44:35PM +0100, Christophe Leroy wrote:
> Today drivers/pci/controller/pci-xgene.c defines SZ_1T
> 
> Move it into linux/sizes.h so that it can be re-used elsewhere.
> 
> Link: https://lore.kernel.org/r/575cb7164cf124c75df7cb9242ea7374733942bf.1642752946.git.christophe.leroy@csgroup.eu
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  This patch is already in linux-next but not in Linus' tree yet

What would you like me to do about this?  It's in linux-next, which
means it will go to Linus' tree during the next merge window.

But this is 01/14; are there other patches that I should be looking
at?  Do I need to coordinate this with other patches that depend on
it?

>  drivers/pci/controller/pci-xgene.c | 1 -
>  include/linux/sizes.h              | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 0d5acbfc7143..77c1fe7e11f9 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -49,7 +49,6 @@
>  #define EN_REG				0x00000001
>  #define OB_LO_IO			0x00000002
>  #define XGENE_PCIE_DEVICEID		0xE004
> -#define SZ_1T				(SZ_1G*1024ULL)
>  #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
>  
>  #define XGENE_V1_PCI_EXP_CAP		0x40
> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
> index 1ac79bcee2bb..84aa448d8bb3 100644
> --- a/include/linux/sizes.h
> +++ b/include/linux/sizes.h
> @@ -47,6 +47,8 @@
>  #define SZ_8G				_AC(0x200000000, ULL)
>  #define SZ_16G				_AC(0x400000000, ULL)
>  #define SZ_32G				_AC(0x800000000, ULL)
> +
> +#define SZ_1T				_AC(0x10000000000, ULL)
>  #define SZ_64T				_AC(0x400000000000, ULL)
>  
>  #endif /* __LINUX_SIZES_H__ */
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
