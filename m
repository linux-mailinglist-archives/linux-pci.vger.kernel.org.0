Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3375EC213
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 14:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiI0MIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiI0MIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 08:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E2A2A9F;
        Tue, 27 Sep 2022 05:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D7F60EF1;
        Tue, 27 Sep 2022 12:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F11CC433D6;
        Tue, 27 Sep 2022 12:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664280479;
        bh=ICu0Mbj7QJ+Q9rgfCJL0ERLgAyF1QTBOrSbazfxcV8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8jWz48QdCdkCpBHDo8SrbZyq2yp/aty3qEKLFySWdlBWePxkemalROMgE2XqWky3
         t0tv+8tbkuoRIv8LGQbVuz4m7P+NPWp4xj9hFU1ZyFJk+K0+99snDljH7njF+NjZN3
         t/2VCIMp6VQWJEyWtsMfhsZkTuTSbCHkM7JrD4VOGvhXTj6pVnC9FIWyeK+JdSWkpd
         ez3Cg45AfWOgQP3p//NxzRGDs8MN8K3iqmU+kJD6xox07kmOVdr7Cy+bPP0fGAtuPY
         Qndq+L+XgcyMpDAN4pwr2wRoqtMnDDgRdtguRWdZh8Ld5PNrwXk380yFJCnrc2wfJW
         XqoSVNiYhjl2Q==
Date:   Tue, 27 Sep 2022 14:07:52 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, gregkh@linuxfoundation.org
Cc:     cgel.zte@gmail.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] PCI: iproc: Remove the unneeded result
 variable
Message-ID: <YzLnmGiU7qcWkeH2@lpieralisi>
References: <20220906071636.336853-1-ye.xingchen@zte.com.cn>
 <20220906212520.GA45166@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906212520.GA45166@bhelgaas>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Greg]

On Tue, Sep 06, 2022 at 04:25:20PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 06, 2022 at 07:16:36AM +0000, cgel.zte@gmail.com wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> > 
> > Return the value iproc_pcie_setup_ib() directly instead of storing it in
> > another redundant variable.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> 
> This patch itself is fine, but was posted by cgel.zte@gmail.com, not by
> "ye xingchen <ye.xingchen@zte.com.cn>", so it needs another signoff
> and full name so the chain is complete.  For more details see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.18#n363

Greg, Bjorn,

I believe that appending a SoB like this myself is fine:

Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

It is a SOB already in kernel commit logs - I assume
that's the right thing to do in this case, please
let me know if it isn't and what should we do instead.

Thanks,
Lorenzo

> Bjorn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
