Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303E6373BA4
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhEEMpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 08:45:00 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:40265 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhEEMpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 08:45:00 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id DE0802800B6C9;
        Wed,  5 May 2021 14:44:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CFD67DF725; Wed,  5 May 2021 14:44:02 +0200 (CEST)
Date:   Wed, 5 May 2021 14:44:02 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: xhci_pci & PCIe hotplug crash
Message-ID: <20210505124402.GB29101@wunner.de>
References: <20210505120117.4wpmo6fhvzznf3wv@pali>
 <YJKK7SDIaeH1L/fC@kroah.com>
 <20210505123346.kxfpumww5i4qmhnk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505123346.kxfpumww5i4qmhnk@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 02:33:46PM +0200, Pali Rohár wrote:
> I just spotted this crash during debugging PCIe controller driver
> pci-aardvark.c with trying to expose its link down events via "hot plug"
> interrupt and corresponding link layer state flags.
> 
> And because in whole call trace I see only generic PCIe and USB code
> path without any driver specific parts, I suspect that this is not PCIe
> controller-specific issue but rather something "wrong" in genetic PCIe
> (or USB) code. That is why I sent this email, so maybe somebody else
> find something suspicious here.
> 
> But still there is a chance that issue can be also in pci-aardvark.c
> driver and somehow it masked its issue and propagated it into generic
> PCIe hot plug code path.

If you hot-remove the XHCI controller, accesses to its MMIO space
will fail.  xhci_irq() seems to perform such MMIO accesses.

Normally this should happen silently and MMIO accesses just return
with a fabricated "all ones" response.  Chances are however that the
Aardvark controller raises a synchronous external abort instead.
Perhaps you can teach it not to do that.

Thanks,

Lukas
