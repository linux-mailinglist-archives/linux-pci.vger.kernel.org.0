Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C193AEB8B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUOlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 10:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUOlw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 10:41:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC64F610C7;
        Mon, 21 Jun 2021 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624286377;
        bh=AJQGZhya+hZVU6zO/cwUIXVHEh/2BetaXp4xScpcpBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvlUBmUGsaqUjQFgOD/wqKL8Lj4R9mniPixNP63F9SI2sZ9Cv/gT9NkSt3XPm9HWF
         HelJ6XDkX8pWcIhUt32tn3bBttQJVXVcKBxI1HaXjqk7CTQI3e3QwPg74PRm/pPoPF
         QCh7R2AESRXSWPynKKv1v9tCdmLvQ5JG6/ZrzGNC1JkuB5pi7NilCBcXjvzldGjw7J
         xs3AU9K/IxbkBzi+NElq3VoysLQOElj6rvXFdhYg4u0auMbwRS2X/jkpxXeOMzhfM1
         G0dPC11GSHN4m7dH5DVUWM2o6hnbTM2ya92sQnQ+0CxatQyTKY25qVTR1M+VPrd2Mw
         EWejjQOR2MDwg==
Received: by pali.im (Postfix)
        id 2623571B; Mon, 21 Jun 2021 16:39:35 +0200 (CEST)
Date:   Mon, 21 Jun 2021 16:39:34 +0200
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
Message-ID: <20210621143934.rwhdlzujz5f4yymc@pali>
References: <20210602120816.axi4dtnyg5gl2h2z@pali>
 <20210602155559.GA2028037@bjorn-Precision-5520>
 <20210602190302.d3ibdtwti4yq57vi@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602190302.d3ibdtwti4yq57vi@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 June 2021 21:03:02 Pali Rohár wrote:
> On Wednesday 02 June 2021 10:55:59 Bjorn Helgaas wrote:
> > On Wed, Jun 02, 2021 at 02:08:16PM +0200, Pali Rohár wrote:
> > > On Tuesday 01 June 2021 19:00:36 Bjorn Helgaas wrote:
> > 
> > > > I wonder if this could be restructured as a generic quirk in quirks.c
> > > > that simply set the bridge's TLS to 2.5 GT/s during enumeration.  Or
> > > > would the retrain fail even in that case?
> > > 
> > > If I understand it correctly then PCIe link is already up when kernel
> > > starts enumeration. So setting Bridge TLS to 2.5 GT/s does not change
> > > anything here.
> > > 
> > > Moreover it would have side effect that cards which are already set to
> > > 5+ GT/s would be downgraded to 2.5 GT/s during enumeration and for
> > > increasing speed would be needed another round of "enumeration" to set a
> > > new TLS and retrain link again. As TLS affects link only after link goes
> > > into Recovery state.
> > > 
> > > So this would just complicate card enumeration and settings.
> > 
> > The current quirk complicates the ASPM code.  I'm hoping that if we
> > set the bridge's Target Link Speed during enumeration, the link
> > retrain will "just work" without complicating the ASPM code.
> > 
> > An enumeration quirk wouldn't have to set the bridge's TLS to 2.5
> > GT/s; the quirk would be attached to specific endpoint devices and
> > could set the bridge's TLS to whatever the endpoint supports.
> 
> Now I see what you mean. Yes, I agree this is a good idea and can
> simplify code. Quirk is not related to ASPM code and basically has
> nothing with it, just I put it into aspm.c because this is the only
> place where link retraining was activated.
> 
> But with this proposal there is one issue. Some kernel drivers already
> overwrite PCI_EXP_LNKCTL2_TLS value. So if PCI enumeration code set some
> value into PCI_EXP_LNKCTL2_TLS bits then drivers can change it and once
> ASPM will try to retrain link this may cause this issue.

And I see there another issue which does not allow to fully move code
from aspm.c file. Bridge does not have to support changing value in
PCI_EXP_LNKCTL2_TLS register or does not support setting 2.5 GT/s bits.
So logic for these checks needs to be in code which tries to retrain
link, in our case aspm.c.

And yes, there are bridges which do not support this functionality. It
applies also for PCI bridge implemented / emulated by kernel driver
drivers/pci/pci-bridge-emul.c.

So what we can do is just to move code which sets PCI_EXP_LNKCTL2_TLS
bits, not code which reads them and verifies that bridge is in correct
state.

Current quirk code has already code path when it forbid link retraining
and therefore forbid enabling ASPM when "bad bridge" (e.g. that emulated
by kernel) is in use.
