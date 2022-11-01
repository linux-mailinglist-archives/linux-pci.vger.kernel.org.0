Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0C6155EE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 00:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiKAXKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKAXKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 19:10:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE01C22B3B;
        Tue,  1 Nov 2022 16:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3337FCE1142;
        Tue,  1 Nov 2022 23:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A563C433D7;
        Tue,  1 Nov 2022 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667344031;
        bh=2u+m9/z02o+anFfdxYmKieuMXVak8mkqHKG1SXf/JY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gui6/koFU4fjgKpPtvlBfQnN97cyM9j25JJcHKfaivoBwTMhtdT2V8+4qwGShDsTm
         kyUtaIpGXbrR5OvH87l1rmMEwmihNtRUDgVbEhh8GoBbUx0v32Tue13U8VrMIhSwm0
         ncE4NP5lb0siImVeNwHDa8LIV6Sne9rVe8f0/UHhDtL0p+47nzQuHiiHFKp26RKXLJ
         7liUOhme7iMEqxMO5efFi/Q/QEHwDJ7r5HXoVSFXQFucVSF2b2ve5eybki1Er5HFXm
         GbIWu7HYVvxewVYMOkzg9w35Pb1WP6ozWm4ADqj2QeCaoH6n2BPap/ZljXodKKzwD4
         iMVnGiQ3DiQOQ==
Received: by pali.im (Postfix)
        id 15E3E7F8; Wed,  2 Nov 2022 00:07:09 +0100 (CET)
Date:   Wed, 2 Nov 2022 00:07:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] pci: Work around ASMedia ASM2824 PCIe link
 training failures
Message-ID: <20221101230709.fqlj3fxguprltyga@pali>
References: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
 <20221009141434.ddijf6w76cz5ch2v@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009141434.ddijf6w76cz5ch2v@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn, Krzysztof: Gentle reminder.

On Sunday 09 October 2022 16:14:34 Pali Rohár wrote:
> Bjorn, Krzysztof: could you please look at this patch series and say
> what do you think about it? It is quite strange issue for which is
> defined PCI_ANY_ID quirk... And is needs to be somehow workarounded.
> 
> On Saturday 17 September 2022 13:03:05 Maciej W. Rozycki wrote:
> > Hi,
> > 
> >  This is v5 of the change to work around a PCIe link training phenomenon 
> > where a pair of devices both capable of operating at a link speed above 
> > 2.5GT/s seems unable to negotiate the link speed and continues training 
> > indefinitely with the Link Training bit switching on and off repeatedly 
> > and the data link layer never reaching the active state.
> > 
> >  This was originally observed in a configuration featuring a downstream 
> > port of the ASMedia ASM2824 Gen 3 switch wired to the upstream port of the 
> > Pericom PI7C9X2G304 Gen 2 switch.  However in the course of review I have 
> > come to the conclusion that similarly to the earlier similar change to 
> > U-Boot it is indeed expected to be safe to apply this workaround to any 
> > downstream port that has failed link negotiation provided that:
> > 
> > 1. the port is capable of reporting the data link layer link active 
> >    status (because unlike U-Boot we cannot busy-loop continuously polling 
> >    the link training bit),
> > 
> > and:
> > 
> > 2. we don't attempt to lift the 2.5GT/s speed restriction, imposed as the
> >    basis of the workaround, for devices not explicitly known to continue 
> >    working in that case.
> > 
> > It is expected to be safe because the workaround is applied to a failed 
> > link, that is one that does not (at the time this code is executed) work 
> > anyway, so trying to bring it up cannot make the situation worse.  So this 
> > version of the workaround is attempted for all PCIe devices discovered, 
> > and only the lifting of the 2.5GT/s speed restriction is qualified by the 
> > vendor:device ID, currently one of the ASMedia ASM2824 device only.
> > 
> >  Broadening the scope of the quirk has in turn made it necessary to make 
> > some adjustments to code elsewhere and consequently what was originally a 
> > single patch has now become a small series instead.
> > 
> >  This has been verified with a SiFive HiFive unmatched board, booting with 
> > or without the workaround activated in U-Boot, which covered both the link 
> > retraining part of the quirk and the lifting of speed restriction already 
> > imposed by U-Boot.
> > 
> >  Please see individual change descriptions for further details.
> > 
> >  Questions or comments?  Otherwise please apply.
> > 
> >   Maciej
