Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926963B4F08
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZOkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 10:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZOkl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Jun 2021 10:40:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBB3961C2F;
        Sat, 26 Jun 2021 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624718299;
        bh=XBNV7PAmGF76msYV03s+Dw/NGShCLS8n02pNLLWn3XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvLdY2C70M3b5+9u5iHBLAlibexRey1MUWAeDjKJO2e3jyjMknlAnb0HyFUZpwRsK
         ovKXhbt813xNwUlVmpYPxDk+/cArWglM5CRT/jIakMiOpklKs7CV+EqCI80mWb2w1T
         +bmZSFRy8Nuj/9FfSuPXrB4QBi4TJSp5A7PZCzj7vffGBUTr8w7l67IDBFVVsatwMX
         3gSt8bB+YIiTPNZ7alRt8HShkhiiwH1OqKA6jT0o2lRd3BOhFMC5r4fvSUGOQbofca
         0y0BWOcUt3hL97Og5C2fs737Jl8Sie6kKGsb770tj7gvu7zJAW/rNOhk+0uw3v+zja
         CVbcI1zcR/wzQ==
Received: by pali.im (Postfix)
        id 2D06A264; Sat, 26 Jun 2021 16:38:16 +0200 (CEST)
Date:   Sat, 26 Jun 2021 16:38:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210626143816.2p4qwwzuxfeys2y2@pali>
References: <20210621142855.gnqtj3ofovx7xryr@pali>
 <20210625201936.GA3293099@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625201936.GA3293099@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 25 June 2021 15:19:36 Bjorn Helgaas wrote:
> On Mon, Jun 21, 2021 at 04:28:55PM +0200, Pali Rohár wrote:
> > On Wednesday 16 June 2021 16:38:19 Bjorn Helgaas wrote:
> > > On Wed, Jun 02, 2021 at 09:03:02PM +0200, Pali Rohár wrote:
> > > > On Wednesday 02 June 2021 10:55:59 Bjorn Helgaas wrote:
> > > > > On Wed, Jun 02, 2021 at 02:08:16PM +0200, Pali Rohár wrote:
> > > > > > On Tuesday 01 June 2021 19:00:36 Bjorn Helgaas wrote:
> > > > > 
> > > > > > > I wonder if this could be restructured as a generic quirk
> > > > > > > in quirks.c that simply set the bridge's TLS to 2.5 GT/s
> > > > > > > during enumeration.  Or would the retrain fail even in
> > > > > > > that case?
> > > > > > 
> > > > > > If I understand it correctly then PCIe link is already up
> > > > > > when kernel starts enumeration. So setting Bridge TLS to 2.5
> > > > > > GT/s does not change anything here.
> > > > > > 
> > > > > > Moreover it would have side effect that cards which are
> > > > > > already set to 5+ GT/s would be downgraded to 2.5 GT/s
> > > > > > during enumeration and for increasing speed would be needed
> > > > > > another round of "enumeration" to set a new TLS and retrain
> > > > > > link again. As TLS affects link only after link goes into
> > > > > > Recovery state.
> > > > > > 
> > > > > > So this would just complicate card enumeration and settings.
> > > > > 
> > > > > The current quirk complicates the ASPM code.  I'm hoping that
> > > > > if we set the bridge's Target Link Speed during enumeration,
> > > > > the link retrain will "just work" without complicating the
> > > > > ASPM code.
> > > > > 
> > > > > An enumeration quirk wouldn't have to set the bridge's TLS to
> > > > > 2.5 GT/s; the quirk would be attached to specific endpoint
> > > > > devices and could set the bridge's TLS to whatever the
> > > > > endpoint supports.
> > > > 
> > > > Now I see what you mean. Yes, I agree this is a good idea and
> > > > can simplify code. Quirk is not related to ASPM code and
> > > > basically has nothing with it, just I put it into aspm.c because
> > > > this is the only place where link retraining was activated.
> > > > 
> > > > But with this proposal there is one issue. Some kernel drivers
> > > > already overwrite PCI_EXP_LNKCTL2_TLS value. So if PCI
> > > > enumeration code set some value into PCI_EXP_LNKCTL2_TLS bits
> > > > then drivers can change it and once ASPM will try to retrain
> > > > link this may cause this issue.
> > > 
> > > I guess you mean the amdgpu, radeon, and hfi1 drivers.  They
> > > really shouldn't be mucking with that stuff anyway.  But they do
> > > and are unlikely to change because we don't have any good
> > > alternative.
> > 
> > Yea, these are examples of such drivers... Maybe it is a good idea
> > to ask those people why changing PCI_EXP_LNKCTL2_TLS is needed. As
> > these drivers are often derived from codebase of shared multisystem
> > drivers or from common documentation, it is possible that original
> > source has this code as a workaround or common pattern used in other
> > operating systems, not related to linux...
> > 
> > > One way around that would be to add some quirk code to
> > > pcie_capability_write_word().  Ugly, but we do have something sort
> > > of similar in pcie_capability_read_word() already.
> > 
> > Bjorn, do you really want such ugly hack in
> > pcie_capability_write_word?  It is common code used and called from
> > lot of places so it may affect whole system if in future somebody
> > changes it again...
> 
> I don't know which is uglier, a quirk in pcie_capability_write_word()
> or a quirk in aspm.c that has nothing to do with ASPM.  They're both
> ugly :)

Ok :-)

> FWIW, in pcie_capability_write_word() I would envision not a check for
> Atheros, but rather something like a "dev->max_target_link_speed" that
> could be set by an Atheros quirk.  It does get uglier if we want to
> restrict the bridge's link speed via a quirk, then unrestrict it when
> the endpoint is unplugged.
> 
> I know pcie_downgrade_link_to_gen1() only returns failure for corner
> cases that "should not occur,"

It is not only corner case. It happens _always_ with at least two
pci drivers.

As I wrote in other email due to this issue, some quirk code which
allows / disallows link retraining is required in aspm.c file.

> but I don't like the fact that it's
> possible to change Common Clock Configuration without doing the
> retrain.  That would leave us with incorrect ASPM exit latencies,
> which is really hard to debug.

I see... Any idea how to solve this issue?

> Here's the relevant text in the spec (PCIe r5.0):
> 
>   7.5.3.6 Link Capabilities
> 
>     L0s Exit Latency - This field indicates the L0s exit latency for
>     the given PCI Express Link. The value reported indicates the
>     length of time this Port requires to complete transition from L0s
>     to L0. ...
> 
>     Note that exit latencies may be influenced by PCI Express
>     reference clock configuration depending upon whether a component
>     uses a common or separate reference clock.
> 
>   7.5.3.6 Link Control
>     Common Clock Configuration - When Set, this bit indicates that
>     this component and the component at the opposite end of this Link
>     are operating with a distributed common reference clock. ...
> 
>     After changing the value in this bit in both components on a Link,
>     software must trigger the Link to retrain by writing a 1b to the
>     Retrain Link bit of the Downstream Port.
