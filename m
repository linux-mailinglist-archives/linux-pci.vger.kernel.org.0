Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA616E2736
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDNPpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDNPpv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 11:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B852AF01
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 08:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 834576214C
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 15:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A95C4339E;
        Fri, 14 Apr 2023 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681487145;
        bh=iUBkDAjnkn3g+xryX3UvkO+3ekTEw34Q/V8Cr6dY+Tw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MzxcxOmBkz/e929Fjy9aAuUT0gv1wma8wHtN1kGZ7INJ1X9FpKHNrGqYJCuaX+ioo
         9LDys/u9uEv8tyt6ptF48Mj9H2vY5MUz2/UShFiMPHG9QOmd/28Rt6h4HSMnjBlhRX
         KNebZIZ0H1+t4R4K2iLeleH3oUX4QFP8tfffQHOWrvZP+QrdbyAQwX1ScP9V4h5+Fj
         CBxewOaVml7MJHT3DoBGYI2zumdchef/MCyCTT7TBvQ9D2wdqfB+9+05rkJbSTBq6P
         2guK3t26OUw9wbOeTH7DEPshtYSjkJUs4opU3DgRTd8Yesi5wtnLPOmU7Msr6K3Mue
         PfPVQbtYYWZSQ==
Date:   Fri, 14 Apr 2023 10:45:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion
 detection
Message-ID: <20230414154544.GA195887@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20cfd32d-0e4c-a928-fc26-1c4c47972ece@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 13, 2023 at 10:50:03AM +0900, Damien Le Moal wrote:
> My apologies for not replying to the series cover letter as I do not have it
> locally (due to WD on-going network issues).

Oh, I forgot to mention that in this situation where a message is lost
for some reason (or if I want to reply to a thread that I didn't
receive directly), lore is a great resource.

For example, here's the cover letter on lore:

  https://lore.kernel.org/r/20230330085357.2653599-1-damien.lemoal@opensource.wdcom

and there's a link to download the entire thread as an mbox file.
Then it's easy to uncompress it, point mutt at it, and respond.
There's also a sample "git send-email" line to respond, but I've never
actually used that.

Might not fit your workflow, but just FYI in case it's ever useful.

Bjorn
