Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE4A6FE72B
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 00:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjEJW1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 18:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjEJW1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 18:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38CF19D;
        Wed, 10 May 2023 15:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4755B636DE;
        Wed, 10 May 2023 22:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF8BC433D2;
        Wed, 10 May 2023 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683757637;
        bh=wAS/UqoLJWp4ietxingf4EwSToMGyS8UHVUP5W4J4Ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bXEE3i6AqGi5W8xUl6BmyRwHPkAHPGckJl1rMr5VQcY5ST9tKmsDzbLyEhYDpO6Iv
         ddCvi2RqBPOkhO7EpAt1igZbPK37RE/IcQjxWw3gsVpCcBPM2Aab8C0CxfBVJ9+00N
         +RVjYEDbRs6p3ICjMrkL1jRxQ4D7xEkrA8Faz/Hx5JAmJ1skcF51Titnk4i9tItZ7b
         Nwz1XcutJgysvU23glB6eh5UZnLUceP37xMiEzIvZTxIzypVa1c6jJev5CzHTE3HmU
         8s2opMLWvmX3Z/OjGbLUfc3s3QKRgepSbtdBEN8cL5oV3P1mVWfcch26VTSwB+S06j
         Yc8jBucywaIsw==
Date:   Wed, 10 May 2023 17:27:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] PCI: brcmstb: Don't assume 2711 bootloader leaves
 PERST# asserted
Message-ID: <ZFwaRAF5a991hwY/@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFwaA403wLnDg3TI@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 05:26:13PM -0500, Bjorn Helgaas wrote:
> ...

> > [1] https://lore.kernel.org/linux-pci/20230411165919.23955-1-jim2101024@gmail.com/T/#m39ebab8bc2827b2304aeeff470a6c6a58f46f987
> 
> Does this link go with something above?  "[1]" isn't mentioned above.
> I did look at that message, but the connection to this patch isn't
> obvious to me.

Sorry, I noticed after sending this that you and Cyril have already
taken care of this.
