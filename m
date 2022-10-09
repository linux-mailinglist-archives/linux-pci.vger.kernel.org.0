Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94415F8BA9
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJIOOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Oct 2022 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJIOOl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2022 10:14:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702810AE;
        Sun,  9 Oct 2022 07:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18C40B80C90;
        Sun,  9 Oct 2022 14:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC2C433D6;
        Sun,  9 Oct 2022 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665324877;
        bh=X378QBRR8uUAznBT9JVX5MswNKa0iT9BSFp/VnH8/dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3basKIALIDNa79aZVYQ6yXrCAkbuKz2cJzJUushtKiYyaOKQ8yFc8QMdUYChbnPc
         AvOcwU0Qm1AX9DvPk3Mu/HL/SKAEDZ+kN4eaoebHd7Yn74sg7e1q3v63AVPkUN9Ndv
         r+NZOy1qKMyPys1N/J1pNbzYRYTaI306N3s1NSxY4tLjOPVkhZtMdsmW03th4mx9nJ
         bYEb/+AbYjN+ZCx9GzrrcSAbDVGJ7fZUVmOGqF4LrqsrFDqGtRGqTjSmLXcdLIt0Zf
         Tm4kp0/qne4BOut0LSdTUFYez5oWLPh9EFc43t0hZa6lrNjwqKz79m4WoCCY/a0KrW
         o+1FssHt7zf5g==
Received: by pali.im (Postfix)
        id C3FEC7C1; Sun,  9 Oct 2022 16:14:34 +0200 (CEST)
Date:   Sun, 9 Oct 2022 16:14:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] pci: Work around ASMedia ASM2824 PCIe link
 training failures
Message-ID: <20221009141434.ddijf6w76cz5ch2v@pali>
References: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn, Krzysztof: could you please look at this patch series and say
what do you think about it? It is quite strange issue for which is
defined PCI_ANY_ID quirk... And is needs to be somehow workarounded.

On Saturday 17 September 2022 13:03:05 Maciej W. Rozycki wrote:
> Hi,
> 
>  This is v5 of the change to work around a PCIe link training phenomenon 
> where a pair of devices both capable of operating at a link speed above 
> 2.5GT/s seems unable to negotiate the link speed and continues training 
> indefinitely with the Link Training bit switching on and off repeatedly 
> and the data link layer never reaching the active state.
> 
>  This was originally observed in a configuration featuring a downstream 
> port of the ASMedia ASM2824 Gen 3 switch wired to the upstream port of the 
> Pericom PI7C9X2G304 Gen 2 switch.  However in the course of review I have 
> come to the conclusion that similarly to the earlier similar change to 
> U-Boot it is indeed expected to be safe to apply this workaround to any 
> downstream port that has failed link negotiation provided that:
> 
> 1. the port is capable of reporting the data link layer link active 
>    status (because unlike U-Boot we cannot busy-loop continuously polling 
>    the link training bit),
> 
> and:
> 
> 2. we don't attempt to lift the 2.5GT/s speed restriction, imposed as the
>    basis of the workaround, for devices not explicitly known to continue 
>    working in that case.
> 
> It is expected to be safe because the workaround is applied to a failed 
> link, that is one that does not (at the time this code is executed) work 
> anyway, so trying to bring it up cannot make the situation worse.  So this 
> version of the workaround is attempted for all PCIe devices discovered, 
> and only the lifting of the 2.5GT/s speed restriction is qualified by the 
> vendor:device ID, currently one of the ASMedia ASM2824 device only.
> 
>  Broadening the scope of the quirk has in turn made it necessary to make 
> some adjustments to code elsewhere and consequently what was originally a 
> single patch has now become a small series instead.
> 
>  This has been verified with a SiFive HiFive unmatched board, booting with 
> or without the workaround activated in U-Boot, which covered both the link 
> retraining part of the quirk and the lifting of speed restriction already 
> imposed by U-Boot.
> 
>  Please see individual change descriptions for further details.
> 
>  Questions or comments?  Otherwise please apply.
> 
>   Maciej
