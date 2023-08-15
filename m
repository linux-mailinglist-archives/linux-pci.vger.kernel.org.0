Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B177D16B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 19:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjHOR4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjHOR4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 13:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC122C1
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 10:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5170064813
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 17:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7D9C433C8;
        Tue, 15 Aug 2023 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122181;
        bh=utvsbPCDEn/v13ZQGZ6Zerunk7My2jCipKdwTA4ir3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ss//IbLmAuMfbydXMwQwnneSTx6u1GhhHi312hceUpaGFP/imfGJbO0wL/Lp60bpH
         Z5ubx5j6RWpDVe150w3oTz+0oXcmMpdQr7SN8t8UJHapqaYK+RPtDs5QlU9VxBF9h0
         4hUXl3NaE83H5YH+hEB+e/3zSzT57YnQiW7tnNtRsSsK97WT1CJKKu2Rrrw1V4wBvk
         mhRpCYsOe09lKGSLLln3qRhZ6dLePWKgWYDsCJYxu1+ymmggJBXw5AMJpQZnc6Z1va
         Tm/zlx+lmZ2IPNG7UIthogYckg0z9JnvtUXBt46czSoNnrEgXYnXYYSTNQ96dmPsfO
         BeCaTJhkGo68w==
Date:   Tue, 15 Aug 2023 12:56:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-pci@vger.kernel.org, liwei391@huawei.com,
        wangxiongfeng2@huawei.com
Subject: Re: [PATCH] x86/PCI: Use pci_dev_id() to simplify the code
Message-ID: <20230815175619.GA232335@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815022440.3513792-1-zhangjialin11@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 10:24:40AM +0800, Jialin Zhang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code a little bit.

s/for a pci/for a PCI/
s/mannually/manually/

Or you could use the commit log I tweaked for the similar drivers/pci
patches:

  When we have a struct pci_dev *, use pci_dev_id() instead of manually
  composing the ID from dev->bus->number and dev->devfn.

If you fix the typos or update the commit log:

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  arch/x86/pci/pcbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
> index 4f15280732ed..fc05ec31cabf 100644
> --- a/arch/x86/pci/pcbios.c
> +++ b/arch/x86/pci/pcbios.c
> @@ -412,7 +412,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
>  		"1:"
>  		: "=a" (ret)
>  		: "0" (PCIBIOS_SET_PCI_HW_INT),
> -		  "b" ((dev->bus->number << 8) | dev->devfn),
> +		  "b" (pci_dev_id(dev)),
>  		  "c" ((irq << 8) | (pin + 10)),
>  		  "S" (&pci_indirect));
>  	return !(ret & 0xff00);
> -- 
> 2.25.1
> 
