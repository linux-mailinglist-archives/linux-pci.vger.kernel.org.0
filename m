Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A851668A131
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 19:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBCSIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 13:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjBCSIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 13:08:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D564B772
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 10:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 516B761F51
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 18:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AD4C4339B;
        Fri,  3 Feb 2023 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675447714;
        bh=eSBFEKZ9mYQKLYeP8tZPLD9dNADnlwR/PbZRJOtDzGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KmLk967KW4Sq9pmrAh5BXjEOTRcENLJwW1dKNN806+T+2Mh/nDg8hh6r/qDJRieLJ
         ABCdo2zz2ZegUsufDUnbSYUu+bO7kUcV27+4l8WbXGHKCFWhKMOahQhzSXgng+8ZD7
         VvxZirrXybh4l0HdYIYOZjR6zw86De+nPeyRQrg2AWGmUgSSsuMyvuZfvS6KYkE14f
         kmYEQIAAo4jPljXQsQzvVsVpTx1tv5RONFoDmCsyvfOHPuT2/E8vgGRX9h6AxJX7IP
         1biA4wa3Q/heRK5K/4emAn8NObm9r6uTKGMg7MHpojobY04ij3UkRI/a1N+4/G3xKQ
         ak7ZF8GkWs0MA==
Date:   Fri, 3 Feb 2023 12:08:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [RESEND PATCH v2] PCI: dwc: Round up num_ctrls if num_vectors is
 less than MAX_MSI_IRQS_PER_CTRL
Message-ID: <20230203180833.GA2030884@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669080013-225314-1-git-send-email-shawn.lin@rock-chips.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 09:20:13AM +0800, Shawn Lin wrote:
> Some SoCs may only support 1 RC with a few MSIs support that the total number of MSIs is
> less than MAX_MSI_IRQS_PER_CTRL. 

I'm not quite sure what this sentence says.  Maybe it should be split
into two sentences?

> In this case, num_ctrls will be zero which fails setting
> up MSI support. Fix it by rounding up num_ctrls to at least one.

If you have occasion to repost, please rewrap the commit log to fit in
75 columns.

Krzysztof or Lorenzo will likely fix this when applying otherwise.

Bjorn
