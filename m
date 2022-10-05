Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220965F58D3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 19:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJERKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 13:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiJERKG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 13:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1B17E03
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 10:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4408E6157B
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 17:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1EC433C1;
        Wed,  5 Oct 2022 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664989797;
        bh=7Al7p0e/Q/CYLSbHwqp4FxI9dzTo05HhqENFiFyAqCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nmfz7mChzVjUzFqQoBSN2be04TElAXdvi/AM9x4mRNKPt5IGKidpcmb2/O8bHCB2d
         frV5AUzb5WIUGFDsPMqHoDuoYCJOPj1OGQgt218CCOMSfm7xNLnMDzH8HCfwm1FV5g
         3cnC4A33NQON8GghVxJcix2nZoEIYIDvn00Rw3g8naUCU8mghAkohgZCxGKb7inyL2
         hQvWl3bCLPWEd6bV6pr/0DmSA7UDnaoC44T0fwFns5E9VQDuussIvWRyHkZihYuIsc
         pCkcWJZ3/OFqJWP3Fhmuc4ue95tkgATgYrxm3I5JuZj7DON+TzlfwQhab5WYiFtVmh
         2Z4im25G7zBoQ==
Date:   Wed, 5 Oct 2022 12:09:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Ramesh Errabolu <ramesh.errabolu@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: Understanding P2P DMA related errors
Message-ID: <20221005170955.GA2300238@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d3b257a-c125-fdd6-e29f-229e54679f45@deltatee.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 05, 2022 at 09:54:50AM -0600, Logan Gunthorpe wrote:
> On 2022-10-04 22:42, Ramesh Errabolu wrote:
> > Hi,
> > 
> > Thanks for taking a look at this. I will see if I can add 0x09A2 to the
> > whitelist and see what happens. But could you clarify my reading of the
> > device tree. In the tree I don't see an AMD device attached to the
> > 0x09A2 device. Is that a misread on my part? Would appreciate it if you
> > could shed light on this aspect.

Ramesh, just FIYI, your emails aren't making it to the mailing list,
probably because they're "too fancy," e.g., they are multi-part or
contain HTML.  See http://vger.kernel.org/majordomo-info.html

You can see the effect at
https://lore.kernel.org/all/5d3b257a-c125-fdd6-e29f-229e54679f45@deltatee.com/
The archive contains Logan's responses, but not the emails from you
that Logan is responding to.

Bjorn
