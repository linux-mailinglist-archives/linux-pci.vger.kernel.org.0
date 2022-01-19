Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529C24943DD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 00:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbiASX1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 18:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbiASX1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 18:27:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F26C061574;
        Wed, 19 Jan 2022 15:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC3F8B81C20;
        Wed, 19 Jan 2022 23:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDEAC004E1;
        Wed, 19 Jan 2022 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642634829;
        bh=j26N5z+/AFp+CE/b/8ADogVrq10CxvEhy4fNb9oi1qU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HQMaXsLiIseNH7j9GOO6+9RGJzF3nNPAQTmEB64helXObiyNaLLp7TZAkjNuP17HB
         Lr75Ylh8V5XsTxm7vjNCpgVTzKqLME1vTH1WCYlBeEg8Grj5hzvqiHh3bHrmEFIUso
         bEVfl+sGNb+hS6hxrdLcGPdWAibITb+iDCXTTV7jtQ55/1N1GlElIIbBnvNk5UdJ+w
         VW4pxeclD6t24hflrv+7lO9H89wtKPmytf3Sd+onHVQhwi4fQR0Q+c6bdfDyvVnatr
         Ot9RoAZPZ3pB85HLfrl/AvODrAT9OkhFhmJSYdwKFip5M0XFY+XEJBH1n+paFGKaOE
         CKhmrGT4C9p3A==
Date:   Wed, 19 Jan 2022 17:27:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <20220119232707.GA975859@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118161314.GA871416@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 18, 2022 at 10:13:14AM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 17, 2022 at 11:03:55PM +0100, marek.vasut@gmail.com wrote:

> > +	instr &= ~0xf;
> > +	if ((instr == 0xf57ff060 || instr == 0xf3bf8f60) &&
> > +	    (pc == (u32)&rcar_pci_read_reg_workaround_start + 4)) {
> > +		/*
> > +		 * If the instruction being executed was a read,
> > +		 * make it look like it read all-ones.
> > +		 */
> > +		instr = *(unsigned long *)(pc - 4);
> > +		reg = (instr >> 12) & 15;
> > +
> > +		if ((instr & 0x0c100000) == 0x04100000) {
> > +			if (instr & 0x00400000)
> > +				val = 255;
> > +			else
> > +				val = -1;
> 
> Can you please use PCI_SET_ERROR_RESPONSE() or something similar here
> to make this greppable?

I should have mentioned that PCI_SET_ERROR_RESPONSE() was added in the
current merge window, so it will appear in v5.17-rc1.

Bjorn
