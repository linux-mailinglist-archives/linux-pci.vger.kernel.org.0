Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38F9487F4A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 00:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiAGXRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 18:17:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44614 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAGXRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 18:17:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CB5A61FC5
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 23:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607FAC36AE5;
        Fri,  7 Jan 2022 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641597455;
        bh=zvCY63wkuhA6xusndM1kWXxr+uS2GDbkVZWNJx3BRJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QaKfTzWMgOtbyVvZcR0o2lq0qnN0rfqWo0ZOaogLd7CnphHsFSnvhQRA6kQ+gFMX2
         tapu6l9bx/OKOJH4PGpay61ZZ6DItuQPCjt5fMYwwGzKN4S0ytd+ZeVC5HUWcqll4F
         14QpbHySjN9OVmobc2lYq61MgHc2KC3DduCgNsAeIgtkSq4p6pSG7jSFnNZI2iLWrd
         X4TXHpVMzdife9MpNlvf5/Vcr8h/8ZJsgsRt9HdkwAcU+vFbcsWF5/GyZ2Y7xf6+CI
         hEsVde8T0ZohQ0O+auwhp/DFt6m4weMhq0kkLKl7uL2G8QGPgYfO3uO13lS8Lq0OXd
         9cc4Miap0tAuA==
Date:   Fri, 7 Jan 2022 17:17:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Zachary Zhang <zhangzg@marvell.com>,
        Wilson Ding <dingwei@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 3/3] PCI: aardvark: Implement emulated root PCI bridge
Message-ID: <20220107231734.GA426583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107212736.GA404447@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Pali; sorry, I meant to cc you on this but forgot]

On Fri, Jan 07, 2022 at 03:27:38PM -0600, Bjorn Helgaas wrote:
> On Fri, Jun 29, 2018 at 11:22:31AM +0200, Thomas Petazzoni wrote:
> 
> > +static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> > +{
> > +	struct pci_sw_bridge *bridge = &pcie->bridge;
> 
> > +	/* Support interrupt A for MSI feature */
> > +	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
> 
> Only 3.5 years later, IIUC, this is the value you get when you read
> PCI_INTERRUPT_PIN, so I think this should be PCI_INTERRUPT_INTA, not
> PCIE_CORE_INT_A_ASSERT_ENABLE.
> 
> Readers expect to get the values defined in the PCI spec, i.e.,
> 
>   PCI_INTERRUPT_UNKNOWN
>   PCI_INTERRUPT_INTA
>   PCI_INTERRUPT_INTB
>   PCI_INTERRUPT_INTC
>   PCI_INTERRUPT_INTD
> 
> Bjorn
