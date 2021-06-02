Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699D8398F64
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhFBP5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 11:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhFBP5r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 11:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E8F76139A;
        Wed,  2 Jun 2021 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622649364;
        bh=0+ttTFtR3wVvom3XUhqGkOd1u+wQH6+lzC3K8Fb6Go8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sEjKnbNfbSBMp7xHwr2mZkFmT7ZIJ+M+BvcoSnJLEkgXjfyhU2xzzfsuNYI7Kgg+y
         4D9fLdIhz2C8svTlEezci7xeaRsD5FBiq6AhSPaGiO/L14onlrtOqh2fAgSYV44FRK
         dKozh0xkYBQ+LRftGLgvAu1iTfqI16Kaish3xymzKgEsJLzFCudHJ4UmsodmnnhaeK
         4nriDD/S23kN1tkaAqLr2jAbyAHZBAXOb1DXo2495Dha0LLQbmVXjtY0w0Z4gjdoTX
         CRN0S7e0biMvZv8+yyS4/brYTJzT5xBFbTl+zgudv6pSHg7zx/Z+pU8xSldsIXacGF
         SpxdZCA8Yn3Wg==
Date:   Wed, 2 Jun 2021 10:55:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210602155559.GA2028037@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602120816.axi4dtnyg5gl2h2z@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 02:08:16PM +0200, Pali Rohár wrote:
> On Tuesday 01 June 2021 19:00:36 Bjorn Helgaas wrote:

> > I wonder if this could be restructured as a generic quirk in quirks.c
> > that simply set the bridge's TLS to 2.5 GT/s during enumeration.  Or
> > would the retrain fail even in that case?
> 
> If I understand it correctly then PCIe link is already up when kernel
> starts enumeration. So setting Bridge TLS to 2.5 GT/s does not change
> anything here.
> 
> Moreover it would have side effect that cards which are already set to
> 5+ GT/s would be downgraded to 2.5 GT/s during enumeration and for
> increasing speed would be needed another round of "enumeration" to set a
> new TLS and retrain link again. As TLS affects link only after link goes
> into Recovery state.
> 
> So this would just complicate card enumeration and settings.

The current quirk complicates the ASPM code.  I'm hoping that if we
set the bridge's Target Link Speed during enumeration, the link
retrain will "just work" without complicating the ASPM code.

An enumeration quirk wouldn't have to set the bridge's TLS to 2.5
GT/s; the quirk would be attached to specific endpoint devices and
could set the bridge's TLS to whatever the endpoint supports.

> Moreover here we are dealing with specific OTP/EEPROM bug in Atheros
> chips, which was confirmed that exists. As I wrote in previous email, I
> was told that semi-official workaround is do Warm Reset or Cold Reset
> with turning power off from card. Which on most platforms / boards is
> not possible.

If there's a specific bug with a real root-cause analysis, please cite
it.  The threads mentioned in the current commit log are basically
informed speculation.

Bjorn
