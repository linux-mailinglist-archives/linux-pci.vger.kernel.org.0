Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C990575286C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGMQeu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGMQeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 12:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9E2D5B;
        Thu, 13 Jul 2023 09:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656F561A7F;
        Thu, 13 Jul 2023 16:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1E8C433C7;
        Thu, 13 Jul 2023 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689266059;
        bh=rbjhdoNGJui89b9ch3NhNSS1ouNHx4AKvMK+EP02rQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r40S2bIMHkMDhElZlg4IKNNEXJad9FaChNxfTFxnU8+PTJrqaOyYaMlH1J1rz62M4
         nIJVpxqP4xV0dSSEfqMl57bSBkbhml/Dj2hbeiufmpGVd93nArR7MXLQjSx77JE7Bv
         1jCwVcBJefBbZ1+9tQbDYcrIXLb12ZvXqdDMcIvZcVoWWlKQC3W71W8M5zsrXc5ChN
         kSYq75kDGJBMImNMdJQYxQ3l3xXafH9v/5tfClxCaBjrSYrGIY+sJ0BnKPx/y1/Oj/
         OZJL4Y1SXk+OuTmAu8IeP6J3ZmfVlRLcXSBV4nKDwIu52mKdDYCOfHF3/i708/MYDx
         iCxO3On2TFUJQ==
Date:   Thu, 13 Jul 2023 11:34:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Use struct_size()
Message-ID: <20230713163417.GA322076@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a5cc2cd322e7dea26579916ac6dda9c637aa57.1684518118.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 07:42:28PM +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand-writing it. It is less verbose, more
> robust and more informative.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pci/misc for v6.6, thanks!

> ---
>  arch/x86/pci/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index a498b847d740..0de436316a1d 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -136,14 +136,14 @@ static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr,
>  	if (ir->signature != IRT_SIGNATURE || !ir->used || ir->size < ir->used)
>  		return NULL;
>  
> -	size = sizeof(*ir) + ir->used * sizeof(ir->slots[0]);
> +	size = struct_size(ir, slots, ir->used);
>  	if (size > limit - addr)
>  		return NULL;
>  
>  	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
>  	    __pa(ir));
>  
> -	size = sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
> +	size = struct_size(rt, slots, ir->used);
>  	rt = kzalloc(size, GFP_KERNEL);
>  	if (!rt)
>  		return NULL;
> -- 
> 2.34.1
> 
