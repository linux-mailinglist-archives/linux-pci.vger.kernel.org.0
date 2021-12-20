Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF347B25A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 18:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbhLTRvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 12:51:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34324 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhLTRve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 12:51:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B40361284;
        Mon, 20 Dec 2021 17:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866D1C36AE7;
        Mon, 20 Dec 2021 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640022693;
        bh=shzJ+eypexoi+Ic7gMjr/q7nrJUcm8gM60BOCDV10/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/cmUa5zT6iEhEZT41ynjBBijbzw/YDq8etBAqLQzacMDo1InLs8tNcE4Vho+lRaK
         54+GYIPH4CZh8cZFRAHSL2rceXF31WCbA5Xe4deZLOvVuXXhn2IE6GCkO7n/RKkgC6
         Eo8J+D8L4A5C2WQ90H1cZwKysWJtpNQQwXd7VfYw5YBLEYxOJjHNVutLO+39Gaj7lB
         lZ9oUz+J0TRajvzRA37Y2uGM1tF1+pbuXIADTxDbzne5fLSZJBVL1FABax2gHBczTO
         8G7RUWh58JTXzisLarJUCn0Zg7L3gr/z8emZaYOBN/NfQYxeyxwuAcRhGEA9yzRCkB
         GD3Hjj8K+qe/A==
Received: by pali.im (Postfix)
        id B32F287B; Mon, 20 Dec 2021 18:51:30 +0100 (CET)
Date:   Mon, 20 Dec 2021 18:51:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add defines for normal and subtractive PCI
 bridges
Message-ID: <20211220175130.bogovgjofevwfohn@pali>
References: <20211210145352.16323-1-pali@kernel.org>
 <20211220145140.31898-1-pali@kernel.org>
 <20211220162150.GA706@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220162150.GA706@wunner.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 20 December 2021 17:21:50 Lukas Wunner wrote:
> On Mon, Dec 20, 2021 at 03:51:40PM +0100, Pali Rohár wrote:
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -178,9 +178,9 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
> >   */
> >  static const struct pci_device_id port_pci_ids[] = {
> >  	/* handle any PCI-Express port */
> > -	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
> > +	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_NORMAL, ~0) },
> >  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> > -	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
> > +	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE, ~0) },
> 
> Any harm in simply matching for 0x060400 with mask 0xffff00?

Currently are defined only class ids 0x060400 and 0x060401. I'm not sure
if PCI-SIG cannot define in future other class ids (e.g. 0x060402,
0x060403, ...) for purposes not compatible with this driver...

Anyway, proposed suggestion changes behavior in code and my patch just
add macros without changing code. So it should not be done as part of
this my patch.
