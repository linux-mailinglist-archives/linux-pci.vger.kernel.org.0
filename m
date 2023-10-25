Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297BF7D7222
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJYRLc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjJYRLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:11:31 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9A132
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 10:11:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C9FF210096662;
        Wed, 25 Oct 2023 19:11:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8E1E4110AC; Wed, 25 Oct 2023 19:11:26 +0200 (CEST)
Date:   Wed, 25 Oct 2023 19:11:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Richter <sjr@debian.org>, 1015871@bugs.debian.org,
        linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Emanuele Rocca <ema@debian.org>
Subject: Re: Enabling PCI_P2PDMA for distro kernels?
Message-ID: <20231025171126.GA9661@wunner.de>
References: <20231025061927.smn5xnwpkasctpn7@pengutronix.de>
 <b909a5e6-841a-44e4-a21f-e3cddbf71816@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b909a5e6-841a-44e4-a21f-e3cddbf71816@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 25, 2023 at 10:30:07AM -0600, Logan Gunthorpe wrote:
> In addition to the above, P2PDMA transfers are only allowed by the
> kernel for traffic that flows through certain host bridges that are
> known to work. For AMD, all modern CPUs are on this list, but for Intel,
> the list is very patchy.

This has recently been brought up internally at Intel and nobody could
understand why there's a whitelist in the first place.  A long-time PCI
architect told me that Intel silicon validation has been testing P2PDMA
at least since the Lindenhurst days, i.e. since 2005.

What's the reason for the whitelist?  Was there Intel hardware which
didn't support it or turned out to be broken?

I imagine (but am not certain) that the feature might only be enabled
for server SKUs, is that the reason?

Thanks,

Lukas
