Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18B265CD56
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 07:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjADGsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 01:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjADGrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 01:47:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC913E37;
        Tue,  3 Jan 2023 22:46:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C21615B1;
        Wed,  4 Jan 2023 06:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEB0C433D2;
        Wed,  4 Jan 2023 06:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672814816;
        bh=Ce2cVNmnHW33oC2dbbxBr7ty/7AVWh3XFhy+5mBUDp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIpEuo0+/ygOTG8Dz2hbZZkPNeitPdV7IPTHKzKtcImcXcXEeEXcrc4uInwuSp4aS
         CX5f7suvudBp8+mEqLj04JdokYLnhTEOFF4kzcUS/G1MDNHC55858EeEx4ormv0rZ4
         ZkvFHCjfUpfRfY4XbLycUyBfuZTjkkoFCPTc72lRwHXjOcvhv4Wknd0bCCDQwHdHtV
         VquhUvSY10TqwxPvbJQ6rBpeLyuDmWDTJzanwgaXP7BCx/otUp0yrElxnYNPeqpqJu
         61iuuNF4jWICeh3NQg6p7y/F410/YNGx7CHnEHb4qxWIn+voOuEE1LGbSO3P6zL3Gt
         ZVV3bwXa963lA==
Date:   Wed, 4 Jan 2023 08:46:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Neftin, Sasha" <sasha.neftin@intel.com>,
        Frederick Zhang <frederick888@tsundere.moe>
Subject: Re: [PATCH] PCI/AER: Rate limit the reporting of the correctable
 errors
Message-ID: <Y7Ug3F6AIhaAiqCD@unreal>
References: <20230103191418.GA1011392@bhelgaas>
 <e6e53119-a249-a03f-c9eb-3caafbe5d983@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e53119-a249-a03f-c9eb-3caafbe5d983@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 10:27:33AM +0530, Rajat Khandelwal wrote:
> Hi Bjorn,
> 
> Thanks for the acknowledgement.
> 
> On 1/4/2023 12:44 AM, Bjorn Helgaas wrote:
> > [+cc Paul, Sasha, Leon, Frederick]
> > 
> > (Please cc folks who have commented on previous versions of your
> > patch.)
> > 
> > On Tue, Jan 03, 2023 at 10:25:48PM +0530, Rajat Khandelwal wrote:
> > > There are many instances where correctable errors tend to inundate
> > > the message buffer. We observe such instances during thunderbolt PCIe
> > > tunneling.

<...>

> > > [54982.838808] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001000/00002000
> > > [54982.838817] igc 0000:2b:00.0:    [12] Timeout
> > Please remove the timestamps; they don't contribute to understanding
> > the problem.
> 
> --> Sure.

Please don't add "-->" or any marker to replies. It breaks mail color
scheme.

> 
> > 
> > > This gets repeated continuously, thus inundating the buffer.
> > Did you verify that we actually clear the Correctable Error Status
> > register?
> 
> --> This patch targets only rate limiting the correctable errors since they are
> non-fatal, and they kind of inundate the CPU logs, particularly during thunderbolt
> connections. It doesn't have an impact anywhere else.
> As per your suggestion in the igc patch, I found rate limiting as a doable option
> currently. Have eradicated any kind of masking the bits.

You didn't answer on the asked question. "Did you verify that we actually clear
the Correctable Error Status register?".

Thanks
