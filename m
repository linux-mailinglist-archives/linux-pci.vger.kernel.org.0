Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9C4C3A4D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 01:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiBYA1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 19:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBYA1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 19:27:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2A4BB91;
        Thu, 24 Feb 2022 16:26:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 931E661CF1;
        Fri, 25 Feb 2022 00:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D3EC340EF;
        Fri, 25 Feb 2022 00:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645748804;
        bh=Kd4X7W9ZMN0FCx1p2jz2OwD19f/vEq5w2Uk3RbeSIZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OqjZy/1BoP++iTIAtMdnU3jNB/b/urH3EPCTmgtJI9oGnZ7s2QKZPbcpUBPLQd4BI
         SiTh9LV8apNFtMn0b4LL8GP42UcfGTWYBudEY7O199HUXBUVPzvwk61+4SyhNm29SF
         B6ivsljK7DaXwPgFSvm4B5ZhRjLNOiU7hC4k25IUFjesc1bDXONGcGGKUGrYe63YZy
         dX0i3vZAC3l2wZ1CehmPOlAi+tA9/pVrMObBqick/+9Je9mrtvSRQ77gLbsE6EHkGq
         rAAoPhZCcKWW6147nm53oITZgHwKnK6GV/zJO3KLRT19yZXOuF7dEaDdgJyn2jLpvp
         xyfF6NrYsna+Q==
Date:   Thu, 24 Feb 2022 18:26:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 11/12] PCI: mvebu: Implement support for legacy INTx
 interrupts
Message-ID: <20220225002642.GA306717@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222155030.988-12-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 04:50:29PM +0100, Pali Rohár wrote:
> This adds support for legacy INTx interrupts received from other PCIe
> devices and which are reported by a new INTx irq chip.
> ...

> +	port->intx_irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						      &mvebu_pcie_intx_irq_domain_ops,
> +						      port);

Already merged, so no need to change this, but in the future, can you
wrap to fit in 80 columns like the rest of the file?

> +	if (port->intx_irq <= 0) {
> +		dev_warn(dev, "%s: legacy INTx interrupts cannot be masked individually, "
> +			      "%pOF does not contain intx interrupt\n",

This is one exception: generally I think quoted strings, especially in
log messages users might see, should be joined no matter how long it
makes the line so they are easier to grep for.
