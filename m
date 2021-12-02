Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34839466ADB
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 21:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348944AbhLBUZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 15:25:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41464 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348819AbhLBUY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 15:24:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 128CFB82496;
        Thu,  2 Dec 2021 20:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF2CC00446;
        Thu,  2 Dec 2021 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638476461;
        bh=GmcknGIcoVCZgqVue0xQLgkzb6RY836ixyVzh/vFqvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4Bw4IyhRfySNUjrlIXIzauC+uqolhaeUFr/YwQ/bsV1z9KlQaPFkSrzSFWLTJZUF
         dNeHiONQeN8eOO1GWsgMN4aOYYD6jr2V/KAVenxfxXuOwe1rUcWvtSVmOu38Qavevf
         cUE/oHaTcPwpuHuapXVoCpx8YlrMtW9sgLkZgI31dOoeB3cORmOndD3b4ajJ1A3fmH
         pbRqwHzSjN9/96+RlSINhWZYPxoMMTIhZuhQZnLMKz7ITTuhVfpqB+4d++3CaDd7G3
         IqjvjGINyz5h7PqkOjfF+GkdaIxhqA79c8I+EsUg2X0GeOvKSI5DWn9yreZgjfWlnR
         Vo++ZUnGPDx8g==
Received: by pali.im (Postfix)
        id 81370820; Thu,  2 Dec 2021 21:20:58 +0100 (CET)
Date:   Thu, 2 Dec 2021 21:20:58 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: pci-bridge-emul: Various fixes
Message-ID: <20211202202058.3zwy4yqocrkt7tvs@pali>
References: <20211124155944.1290-1-pali@kernel.org>
 <20211130142652.30654ce5@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130142652.30654ce5@thinkpad>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 30 November 2021 14:26:52 Marek Behún wrote:
> On Wed, 24 Nov 2021 16:59:38 +0100
> Pali Rohár <pali@kernel.org> wrote:
> 
> > This patch series contains various fixes for pci-bridge-emul code.
> > This code is used only by pci-aardvark.c and pci-mvebu.c drivers.
> > 
> > Pali Rohár (6):
> >   PCI: pci-bridge-emul: Make expansion ROM Base Address register
> >     read-only
> >   PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config
> >     space
> >   PCI: pci-bridge-emul: Add definitions for missing capabilities
> >     registers
> >   PCI: pci-bridge-emul: Fix definitions of reserved bits
> >   PCI: pci-bridge-emul: Correctly set PCIe capabilities
> >   PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
> > 
> >  drivers/pci/controller/pci-aardvark.c |   4 +-
> >  drivers/pci/controller/pci-mvebu.c    |   8 ++
> >  drivers/pci/pci-bridge-emul.c         | 113 ++++++++++++++++++++++----
> >  3 files changed, 108 insertions(+), 17 deletions(-)
> > 
> 
> I will send v2 of this series with the third patch dropped, since it
> will be applied via aardvark batch 3 series.
> 
> Marek

I marked third patch at patchwork as "Superseded" (as now it was applied
into pci/aardvark branch) and so there is no need to resend same patches
again.
