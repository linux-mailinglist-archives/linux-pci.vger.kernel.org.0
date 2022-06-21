Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88244553EF1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiFUXdE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiFUXdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 19:33:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB3DF4E
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 16:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 953D7B81BB1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 23:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0541FC3411C;
        Tue, 21 Jun 2022 23:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655854379;
        bh=KUFldZDOWzF29Fw8oxWmlptCGlug7MaVxTpjrB6Z71Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=glnbAs7yOUm3A15oxIScXlj1d8r2W6PlYM03YYu5tsS7nfoFiX50dODjrF3eerESw
         Im2aFI6jXmi2eCpLTSIj2MHK5SRTeG13x6yzelkdm4nNoGGIsLa1MuJWzITKrytH1N
         s7S1vROFSmlvTsJCtG+C8yZ3kd3cZsrzU/cdXvXTJJA4o5Z3f4nK8XZnn4yMNj4aLf
         eV63CC4Ypf6OEOjLNDbQeDGTWRLDszm9fvBDZlNGD9hcRRtjCi8mR5B82ZBpQX/yIq
         QB0ScxGgUXFR/I4s9tIHyhmg7W8+s0ow6sPS37vlK4+zluPaFxneoP36GgP0tBI5t8
         owrjVtqCjyRvg==
Date:   Tue, 21 Jun 2022 18:32:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Message-ID: <20220621233257.GA1342369@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBtgZoXZikHVoLUVLGk04dzXYzdi-vdD-xaHnt0Z3BD45Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 02:59:02PM -0400, Jim Quinlan wrote:
> ...

> The original patchset was and is controversial, as it is basically a
> square peg that does not fit nicely into a round Linux hole. It took
> 11 versions of following reviewers' suggestions until it was
> accepted.  And now it has been reverted, I am wondering if it will
> ever be let in again or whether I should even try.

The original patchset [1] may have been controversial, but that's not
the issue here.  The only thing we need to solve here is to post the
four patches I reverted with a tiny change to one of them to avoid the
regression.  I don't think that should be a problem.

Bjorn

[1] https://lore.kernel.org/r/20220106160332.2143-1-jim2101024@gmail.com
