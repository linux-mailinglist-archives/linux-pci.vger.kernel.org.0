Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BB74E78C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGKGwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGKGv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 02:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F750136;
        Mon, 10 Jul 2023 23:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5766132C;
        Tue, 11 Jul 2023 06:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC7EC433C8;
        Tue, 11 Jul 2023 06:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689058316;
        bh=Z9ivX8eJ/lXQ9bZDCm1ns2xF/81RV2oFuTHoehDONQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSEWMiJPxvW8OHWpMAbd/2Km6jkdjAKbe4El+4QvNxNT5id8rVklKpLjtMNR1N4Jq
         AU7DU0t1Mjurutc/4HqrTD3uLjnUbsIjjWsQ8u9K7zLOk6rQ++a9+7nteuTgUWZi31
         Sc8P1nQ7fYLFGmPAbSfC1CGoUdv36J0aBU4fdI9uNnkmuCf5PdADoq5TSTLpFYQYws
         2w47CqvnhbPfm5SwftsRSvrbXMUPP1XMC47ZJTWPcOU0AzChLy378s5KiIO95EpN6r
         8+TaUp1VlDVIarwBBa6EQ8pGBVuQl8/D8ZPySUetYy+b9iEBWRlBjoP7yG8KBvFIQA
         37rRBffoBenvw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qJ7EV-00070G-26;
        Tue, 11 Jul 2023 08:52:24 +0200
Date:   Tue, 11 Jul 2023 08:52:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Ajay Agarwal <ajayagarwal@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZKz8J1jM7zxt3wR7@hovoldconsulting.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <ZKw03xjH5VdL/JHD@google.com>
 <20230710170608.GA346178@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710170608.GA346178@rocinante>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 02:06:08AM +0900, Krzysztof Wilczyński wrote:

> > > > > > Finally, note that the intel-gw driver is the only driver currently not
> > > > > > providing a start_link callback and instead starts the link in its
> > > > > > host_init callback, and which may avoid an additional one-second timeout
> > > > > > during probe by making the link-up wait conditional. If anyone cares,
> > > > > > that can be done in a follow-up patch with a proper motivation.

> The whole conversation above about the intel-gw driver: would something
> need to be addressed here?  Or can I pick the suggested fix?

No, it's just another indication that the offending commit was confused.

All mainline drivers already start the link before that
wait-for-link-up, so the commit in question makes very little sense.
That's why I prefer reverting it, so as to not pollute the git logs
(e.g. for git blame) with misleading justifications.

> > > My apologies for adding this regression in some of the SOCs.
> > > May I suggest to keep my patch and make the following change instead?
> > > This shall keep the existing behavior as is, and save the boot time
> > > for drivers that do not define the start_link()?
> [...]
> 
> > I just realized that Fabio pushed exactly the same patch as I suggested
> > here:
> > https://lore.kernel.org/all/20230704122635.1362156-1-festevam@gmail.com/.
> > I think it is better we take it instead of reverting my commit.
> 
> Will do.  I will also make sure that we have correct attributions in place.

As I mentioned in the commit message, I think the commit should just be
reverted and if there's a valid argument to be made for a similar type
of change (without the breakage), that can be done as a follow-up with a
proper motivation.

Johan
