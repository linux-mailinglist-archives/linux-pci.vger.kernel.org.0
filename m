Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4558F788
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 08:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiHKGWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 02:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHKGWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 02:22:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5D7D7B5
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 23:22:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M3Gv938kvz4x1L;
        Thu, 11 Aug 2022 16:22:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1660198965;
        bh=+wiW3psmm6CZl6wElCrFpx786nCBT9Ynt+1sfGkPkQs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=geVgM6JbeQwzS+Vekw4TCoMXu54Zo5DiZukfgg0asSfhyUU1WZH1k5Wd8PrGAb8xs
         YCqRImP962Ho0sUUN4mxATtyvSx2q4MUmWfgSB2lLO6TSsFyhFDyBdU+daYCXwk7hU
         GHsRUiGNq0RQplu/XsNd8N69sKV93vUxH+gZ1XsIMYTbISSIUTxGpUJAlBeYN8NAIF
         19qvb1gCr+0YDzZ6Pkovi41zHqjF9HiU/Pf8YN069SKqbZqg/G7P5jbm1TOe2l+60U
         eT2FrEdr56NXw6OUFWi6BWi180edv4aaxUivxHb29AG90vUiWZZw8ZxqYWFz9jM2wf
         EkcvTum/eyB3Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc:     oohall@gmail.com, linux-pci@vger.kernel.org,
        benh@kernel.crashing.org, Russell Currey <ruscur@russell.cc>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as EEH maintainer
In-Reply-To: <20220806085301.25142-1-ruscur@russell.cc>
References: <20220806085301.25142-1-ruscur@russell.cc>
Date:   Thu, 11 Aug 2022 16:22:43 +1000
Message-ID: <87lervcn9o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Russell Currey <ruscur@russell.cc> writes:
> I haven't touched EEH in a long time I don't have much knowledge of the
> subsystem at this point either, so it's misleading to have me as a
> maintainer.

Thank you for your service.

> I remain grateful to Oliver for picking up my slack over the years.

Ack.

But I wonder if he is still happy being listed as the only maintainer.
Given the status is "Supported" that means "Someone is actually paid to
look after this" - and I suspect Oracle are probably not paying him to
do that?

Should we change the status? Or just drop the entry entirely and fold it
into the top-level powerpc one?

cheers

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a9f77648c107..dfe6081fa0b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15639,7 +15639,6 @@ F:	drivers/pci/endpoint/
>  F:	tools/pci/
>  
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> -M:	Russell Currey <ruscur@russell.cc>
>  M:	Oliver O'Halloran <oohall@gmail.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> -- 
> 2.37.1
