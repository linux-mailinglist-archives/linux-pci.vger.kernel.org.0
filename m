Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4C5763E7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiGOOzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 10:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGOOzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 10:55:54 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FDA46DB7;
        Fri, 15 Jul 2022 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yMChqUS1P9k9RZ7lev7X/u1NHY9UHpOS0k0M7hpJ0Qw=; b=MYUg6HZk4WnUkQqe4YgjDIUM/q
        t/2trymMgvlTjfP0FiCehzgdFSAO6ZYEkhJD3xXNcWD65PIO3PISrX3nQJ5XJdmapJVn3ZmZMkSIT
        M5vk3A6QusizEJPsQw/PDLbzDJl4irHntn6X+2OEePX0v/hs1NfHFO1tXGUY03jGL2OuGPB97e1jL
        C3X0OT//Bur/WEsZUHkZXJ6ftPy4bLEnDPBXfGfLBowzSRH327Z6jADPHA6iyrQ1Q/ae6FqgR7DMN
        gGGxdMvL44G5BnZb0fY/7vmU+Tz+fjZ9JQy7wBTMm2zdwyZOI4A8UuTysK6A7f+9dlEwSYvUr78gD
        KjadXi4A==;
Received: from 201-42-109-188.dsl.telesp.net.br ([201.42.109.188] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oCMiv-000KCj-0j; Fri, 15 Jul 2022 16:55:21 +0200
Message-ID: <17fb8d12-60f9-09d5-91fa-09d5a5a9a4fd@igalia.com>
Date:   Fri, 15 Jul 2022 11:55:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] powerpc/pci: Add config option for using OF 'reg'
 for PCI domain
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220706102148.5060-1-pali@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220706102148.5060-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/07/2022 07:21, Pali Rohár wrote:
> [...] 
> Fix this issue and introduce a new option CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG.
> When this option is disabled then powerpc kernel would assign PCI domains
> in the similar way like it is doing kernel for other architectures,
> starting from zero and also how it was done prior that commit.

I found this sentence a bit weird, "in the similar way like it is doing
kernel for other architectures", but other than that:

Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Thanks for the improvement!
Cheers,


Guilherme


> 
> This option is by default enabled for powernv and pseries platform for which
> was that commit originally intended.
> 
> With this change upgrading kernels from LTS 4.4 version does not change PCI
> domain on smaller embedded platforms with fixed number of PCIe controllers.
> And also ensure that PCI domain zero is present as before that commit.
> 
> Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Changes in v2:
> * Enable CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG by default on powernv and pseries
> ---
>  arch/powerpc/Kconfig             | 11 +++++++++++
>  arch/powerpc/kernel/pci-common.c |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index f66084bc1dfe..053a88e84049 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -386,6 +386,17 @@ config PPC_OF_PLATFORM_PCI
>  	depends on PCI
>  	depends on PPC64 # not supported on 32 bits yet
>  
> +config PPC_PCI_DOMAIN_FROM_OF_REG
> +	bool "Use OF reg property for PCI domain"
> +	depends on PCI
> +	default y if PPC_PSERIES || PPC_POWERNV
> +	help
> +	  By default PCI domain for host bridge during its registration is
> +	  chosen as the lowest unused PCI domain number.
> +
> +	  When this option is enabled then PCI domain can be determined
> +	  also from lower bits of the OF / Device Tree 'reg' property.
> +
>  config ARCH_SUPPORTS_UPROBES
>  	def_bool y
>  
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 068410cd54a3..7f959df34833 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -74,7 +74,6 @@ void __init set_pci_dma_ops(const struct dma_map_ops *dma_ops)
>  static int get_phb_number(struct device_node *dn)
>  {
>  	int ret, phb_id = -1;
> -	u32 prop_32;
>  	u64 prop;
>  
>  	/*
> @@ -83,7 +82,8 @@ static int get_phb_number(struct device_node *dn)
>  	 * reading "ibm,opal-phbid", only present in OPAL environment.
>  	 */
>  	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
> -	if (ret) {
> +	if (ret && IS_ENABLED(CONFIG_PPC_PCI_DOMAIN_FROM_OF_REG)) {
> +		u32 prop_32;
>  		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
>  		prop = prop_32;
>  	}
