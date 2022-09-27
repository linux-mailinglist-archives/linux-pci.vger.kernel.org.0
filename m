Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DA5EC2DD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiI0MiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiI0MiQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 08:38:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BF1559C5;
        Tue, 27 Sep 2022 05:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5CA6192F;
        Tue, 27 Sep 2022 12:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F12C433D6;
        Tue, 27 Sep 2022 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664282294;
        bh=020O1FVIgKst48ioe0/V4ztsG3kEabTXyp+65D7SHmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJqzVlnVpb0BI72cIveJJDufkX67SSBZFYCcXLu6tCuoHvhrrlPTdjDUb0xMazgPj
         pih6yXgYPIRyMNLxy2FzYSP6AcVvs/QJsJffwJEydd6SFfOe0vRN8YJFHrkGhAy22G
         vzLZke8NTyS87rI/pS62kZIYh5RKRupyYZLjR744=
Date:   Tue, 27 Sep 2022 14:38:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, cgel.zte@gmail.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] PCI: iproc: Remove the unneeded result
 variable
Message-ID: <YzLus6orb+t0yyD+@kroah.com>
References: <20220906071636.336853-1-ye.xingchen@zte.com.cn>
 <20220906212520.GA45166@bhelgaas>
 <YzLnmGiU7qcWkeH2@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLnmGiU7qcWkeH2@lpieralisi>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 02:07:52PM +0200, Lorenzo Pieralisi wrote:
> [+Greg]
> 
> On Tue, Sep 06, 2022 at 04:25:20PM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 06, 2022 at 07:16:36AM +0000, cgel.zte@gmail.com wrote:
> > > From: ye xingchen <ye.xingchen@zte.com.cn>
> > > 
> > > Return the value iproc_pcie_setup_ib() directly instead of storing it in
> > > another redundant variable.
> > > 
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> > 
> > This patch itself is fine, but was posted by cgel.zte@gmail.com, not by
> > "ye xingchen <ye.xingchen@zte.com.cn>", so it needs another signoff
> > and full name so the chain is complete.  For more details see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.18#n363
> 
> Greg, Bjorn,
> 
> I believe that appending a SoB like this myself is fine:
> 
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> 
> It is a SOB already in kernel commit logs - I assume
> that's the right thing to do in this case, please
> let me know if it isn't and what should we do instead.

Please just drop all patches submitted by this email address and from
zte.com.cn at this point in time as we are unable to actually determine
that they are coming from the correct developers.

Also there's no feedback from them at all, which means no one is
actually reading the email it is being purported to be sent from, which
means it should be dropped no matter what anyway.

thanks,

greg k-h
