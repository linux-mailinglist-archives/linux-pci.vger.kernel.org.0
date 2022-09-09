Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0B5B3827
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIIMtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIIMtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 08:49:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8710BA6B;
        Fri,  9 Sep 2022 05:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 712D1B82244;
        Fri,  9 Sep 2022 12:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BFEC433C1;
        Fri,  9 Sep 2022 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662727739;
        bh=FeHjRuLe0boJyzS2Fj4YPjY3cnCYgA8xgvP/gp2wT1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NHjGLlG5NgktL5pqUAXBtRxtF7NQJj2yClTkIh/OIqafkRV9eLdzhS0+r/VysnfLX
         eMFwyyelYVpFkBSgszD4qbgjhsFVhqjg4j/xM5o+jzEXZFHN4GWG6xvPdyNSlB2+DM
         LlqclfSRdmjZ48V/sG4Gq7A0HyjozS/CnDyiv/1ZDhpjR9BM5eUe0Ky8sp38iNIG60
         cFjqTWPCo4R6Wk4fORvhyF0lxRSaQTmRzOkwfXV/88BRuNAKx5Nwr3oC/LeC8n8kQV
         /fOKwfgnXRrGa6HYxNxheVl6q9ime+ftJ+/YhVUzC7Dg4zrfrkZAKkkKUpDFVYI9/B
         0QKy/fHHDraMQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oWdRI-009Bb4-UQ;
        Fri, 09 Sep 2022 13:48:57 +0100
MIME-Version: 1.0
Date:   Fri, 09 Sep 2022 13:48:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzys?= =?UTF-8?Q?ztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: do not leak reset GPIO on unbind/unload/error
In-Reply-To: <YxsEfcTAw0v/JFes@lpieralisi>
References: <YxatO5OaI2RpxQ2M@google.com> <YxsEfcTAw0v/JFes@lpieralisi>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <19af505c00efeb2166fdcfca1de0948b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lpieralisi@kernel.org, dmitry.torokhov@gmail.com, alyssa@rosenzweig.io, robh@kernel.org, kw@linux.com, bhelgaas@google.com, marcan@marcan.st, sven@svenpeter.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-09-09 10:16, Lorenzo Pieralisi wrote:
> Nit: please capitalize beginning of the sentence in the subject - 
> that's
> what we do for PCI controllers commits.
> 
> "PCI: apple: Do not leak reset GPIO on unbind/unload/error"
> 
> On Mon, Sep 05, 2022 at 07:15:23PM -0700, Dmitry Torokhov wrote:
>> The driver allocates reset GPIO in apple_pcie_setup_port() but neither
>> releases the resource, nor uses devm API to have it released
>> automatically.
>> 
>> Let's fix this by switching to devm API. While at it let's use generic
>> devm_fwnode_gpiod_get() instead of OF-specific 
>> gpiod_get_from_of_node()
>> - this will allow us top stop exporting the latter down the road.
>> 
>> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> 
> Should I take it via the PCI tree ? Usually we send fixes through -rcX
> only if the fix applies to code merged last merge window, which is not
> the case here, so I would queue if for v6.1.

I think 6.1 is perfectly fine.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
