Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3BF48BC8F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 02:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347876AbiALBoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 20:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbiALBoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 20:44:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE51C06173F;
        Tue, 11 Jan 2022 17:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B0A361682;
        Wed, 12 Jan 2022 01:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0A3C36AE3;
        Wed, 12 Jan 2022 01:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641951839;
        bh=ssV4IOZe/mj0Wlv5asZC4ExDpfjoHEImje+e8erdkTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lL8DtX0XUF8W3JOYxAct5pcraAVNmUX4WBgSVTaxTIB7Jg4PYIEovyDMe3bx6wBhP
         pyFAA7642KgBAzYI9n5nate65pbU9ysw5Nm9PDi8OIeu6Kx59rLF5l40erXnRXUBpR
         Y5yskVlNqBeMTP7etDovG3IzrlfMEB0G+R6JpoIwp2fj+VHTxQqaEzaMIaR3Sb8Sch
         4ruXS4i4ZTJhaXZO160ib9S5nwiGs1naEi+x6qDxCbCjiIUOkARTkB/uqPgvtups7W
         3PeR5gWS7EgP7RPxj6o/5VmN31g4znRe4OfSiHjyV4wQmm3mhP4uLcFeM/wbL8PrMJ
         Gk0o0rZnKgiWw==
Received: by pali.im (Postfix)
        id 97B49B98; Wed, 12 Jan 2022 02:43:56 +0100 (CET)
Date:   Wed, 12 Jan 2022 02:43:56 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 08/11] PCI: mvebu: Use child_ops API
Message-ID: <20220112014356.h2pm7nc3vzsvjexq@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220105150239.9628-9-pali@kernel.org>
 <CAL_Jsq+1hoAUVOzyOGZ1vVMsChhHJJpzk5HNU4Gi=Luy_8LArA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+1hoAUVOzyOGZ1vVMsChhHJJpzk5HNU4Gi=Luy_8LArA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 05 January 2022 09:41:51 Rob Herring wrote:
> On Wed, Jan 5, 2022 at 9:03 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Split struct pci_ops between ops and child_ops. Member ops is used for
> > accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops for
> > accessing real PCIe cards.
> >
> > There is no need to mix these two struct pci_ops into one as PCI core code
> > already provides separate callbacks via bridge->ops and bridge->child_ops.
> 
> I had similar patches including mvebu that I never got around to
> sending out. I pushed the branch out now at least[1].

Are you going to finish your patch series and send it? Because if yes,
I can drop this my patch in v3 and let all ->child_ops conversion for
you.
