Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7B1BAB81
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 19:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgD0Rll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 13:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0Rlk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 13:41:40 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0931B20775;
        Mon, 27 Apr 2020 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588009300;
        bh=4+FdGDK3qcemswCFDQJ5mLkfrtJ2whwh+PcMpzPVew4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sBSXhyCjUGWmK++mfBvXr0kaSLxdlfr3oeRmvokzZ6lFXclYQyrNdvWgkUaxJcLjZ
         roYxZ6f4/fHsbu2cjQBPQpCwbR8qTD+06NOnMFQOOSH/GO/WUlTmGgzJANn9arbWMD
         /ZqYd6YoPtZKptl5pVBNBnm8MfidEqFjLFdYmCRI=
Date:   Mon, 27 Apr 2020 12:41:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
Message-ID: <20200427174138.GA207841@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVGkM_-5q+pSOtQ5nBPGzMeOpRTJUqekYnvjiPMFepqLw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo]

On Sat, Apr 25, 2020 at 10:55:21AM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 24, 2020 at 9:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [+cc Vaibhav]
> >
> > Alternate less redundant subject:
> >
> >   PCI: rcar: Add suspend/resume support
> 
> Note that there's both pcie-rcar.c (this driver, for R-Car Gen2 and Gen3
> PCIe) and pci-rcar-gen2.c (for R-Car Gen2 PCI).
> People tend to use the prefix "PCI: rcar: " for both :-(

Yeah, that's pretty broken, thanks for pointing this out!

For most drivers we use a chipset name ("keystone", "imx6", "tegra",
etc) as the changlog tag.  That's nice because it gives space for
multiple drivers from the same vendor, but I don't know anything
similarly specific for the R-Car drivers.

pci-rcar-gen2.c seems to be for some sort of internal Conventional PCI
bus?  The "gen2" is confusing because "Gen 2" is more commonly used
for PCIe than for Conventional PCI.

I would propose keeping "rcar" for the PCIe driver and using
"rcar-pci" for the Conventional PCI one, but the Conventional PCI one
(pci-rcar-gen2.c) seems pretty inactive.  The most recent commits are
from 2018, and they're trivial cleanups.  So I'm doubtful that anybody
will remember when the next change comes in.

Bjorn
