Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0D5A0AB8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiHYHtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiHYHtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 03:49:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A271A0333;
        Thu, 25 Aug 2022 00:49:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MCw8s2Q2rz4xV7;
        Thu, 25 Aug 2022 17:49:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1661413773;
        bh=k/K7Js7dK6dxOfVTDaXcqeIh7AqfvCWAPYJNJN8qsTQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DccTqgAEj8cQsbTwecf0Jayd3dBrvqd6U8m1Lt7V86aEL++OLOLr5xIxGu99atBxI
         8Op6ppf0sepvXsD0m6OkdhzaHfgImYUmJPGiLiq3nJiq3ntzUck+GTN3FvFJV27GEU
         4w0hN5KCHxMDg62pj4Q+gPJPSNhBdDSy7LVx3iHwYtaZaFf76dZGxLlkVEdYTsuVes
         cPfKQfSYwJCazV/Fwg8Wr1BfDBHuNGe+IzPBEfhXpzHVzAtNwu/5Xk0J6aE7z/Syo7
         WRJmfyOLeFBd2IapKcyLn3WNadQqoAlge4tptmNzYmzmPjrBmjIwoZb83LvI3srdMO
         Qu38O06uVNhzg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Enable PCI domains in /proc when PCI bus
 numbers are not unique
In-Reply-To: <20220820115113.30581-1-pali@kernel.org>
References: <20220820115113.30581-1-pali@kernel.org>
Date:   Thu, 25 Aug 2022 17:49:28 +1000
Message-ID: <878rnclq47.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> On 32-bit powerpc systems with more PCIe controllers and more PCI domains,
> where on more PCI domains are same PCI numbers, when kernel is compiled
> with CONFIG_PROC_FS=3Dy and CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT=3Dy
> options, kernel prints "proc_dir_entry 'pci/01' already registered" error
> message.

Thanks, I'll pick this up.

> This regression started appearing after commit 566356813082 ("powerpc/pci:
> Add config option for using all 256 PCI buses") in case in each mPCIe slot
> is connected PCIe card and therefore PCI bus 1 is populated in for every
> PCIe controller / PCI domain.
>
> The reason is that PCI procfs code expects that when PCI bus numbers are
> not unique across all PCI domains, function pci_proc_domain() returns true
> for domain dependent buses.
>
> Fix this issue by setting PCI_ENABLE_PROC_DOMAINS and PCI_COMPAT_DOMAIN_0
> flags for 32-bit powerpc code when CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> is enabled. Same approach is already implemented for 64-bit powerpc code
> (where PCI bus numbers are always domain dependent).

We also have the same in ppc4xx_pci_find_bridges().

And if we can eventually make CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
the standard behaviour on 32-bit then everything would behave the same
and we could simplify pci_proc_domain() to match what other arches do.

cheers


> Fixes: 566356813082 ("powerpc/pci: Add config option for using all 256 PC=
I buses")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  arch/powerpc/kernel/pci_32.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index ffc4e1928c80..8acbc9592ebb 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -249,6 +249,15 @@ static int __init pcibios_init(void)
>=20=20
>  	printk(KERN_INFO "PCI: Probing PCI hardware\n");
>=20=20
> +#ifdef CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
> +	/*
> +	 * Enable PCI domains in /proc when PCI bus numbers are not unique
> +	 * across all PCI domains to prevent conflicts. And keep PCI domain 0
> +	 * backward compatible in /proc for video cards.
> +	 */
> +	pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);
> +#endif
> +
>  	if (pci_has_flag(PCI_REASSIGN_ALL_BUS))
>  		pci_assign_all_buses =3D 1;
>=20=20
> --=20
> 2.20.1
