Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305E1646244
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 21:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLGUSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLGUSL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 15:18:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D227B4CF;
        Wed,  7 Dec 2022 12:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298E261BF8;
        Wed,  7 Dec 2022 20:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A6DC433D6;
        Wed,  7 Dec 2022 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670444289;
        bh=h3U7EzRtCZQgyPxwnNtDvjFwUAeLC440zGFSMJH8/cQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AEqrc3nvBV1GgSys+ypZY0QQYm1FA9gEhOnBGTBJwH/rxnaL5jYAyyDF+hiy86Q8K
         0FOBZSme2+hs06q6J1Kip6ThRBIU3LylUqnGsIvdh4lsmE0c5p4Q/hdAb4Ea1dbd+p
         2PpJkYUfUScS6wn5yWNGM8C/Q0KbOhIsBeQYERPrRjyEu10CtYLjkLx6CbceLOZ5HQ
         +yBSdSbl9/QSspPDTb7vtzpVWkOz8pH9sLKvZqg304KGi75txg24bQYuyyMKfU/+pm
         mWmL+Cxy1IIY2UAXKX86ifhJVZOr4/YdWfzj2KyBuwE7ocTWGBXWtAF8gNMrMn7+oA
         yNXWJ5qxW96tg==
Date:   Wed, 7 Dec 2022 14:18:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <20221207201807.GA1468291@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5DhigXLHMZPhI/E@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 10:55:06AM -0800, Dmitry Torokhov wrote:
> ...
> I wonder if you could also consider picking up the mvebu patch:
> 
> 	https://lore.kernel.org/all/Y3KbhIi4ZsSO7+Cl@google.com/
> 
> pci-mvebu.c is the very last user of of_get_named_gpio_flags() in the
> next tree, which we also want to stop exporting.

Sure, but the 0-day bot found a couple issues, which I haven't
bothered to look into:

  https://lore.kernel.org/all/202211151503.HLlq2Z4B-lkp@intel.com/

Bjorn
