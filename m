Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168092EB2A5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbhAESdp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 13:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbhAESdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 13:33:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B232022D57;
        Tue,  5 Jan 2021 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609871585;
        bh=qyt63K9LPIhK5OB3c/WpgFr1pCK0PotwaIdPHvAEMWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTHzQTxrwzb5XJkHPgdvgIYu+HgwTQ5RCLxfXuMFg40Kfa4EtVmL/X3gqR0jdIu51
         iy2ktOq/1gDkjTRLzoi6LeIPuFXd76avT2DE3S7amlztFaGwQ1StyCzuxrUrbf8Oyq
         jBX59a7NGDXN2HSSi+zgnnc3OfPKci2wzIzuHeMoyToupqEPZ+U4swznPzHSNNP4er
         IfBGwihEl7qQ8vTBrcf0Pj59NTE0JB8H/pslVxhT+u4x5dWEN+5jVu2vEfIHwpMLBX
         3QIIA/acAt4yRn8zppZZqbXzgaz2q5VhwxGsXYwM/tZgnevE20IOhmw2dfnAT0dYVB
         NQIupJFABXLgw==
Date:   Tue, 5 Jan 2021 10:33:02 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
 <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 05, 2021 at 04:06:53PM +0100, Hinko Kocevar wrote:
> On 1/5/21 3:21 PM, Hinko Kocevar wrote:
> > On 1/5/21 12:02 AM, Keith Busch wrote:
> > > Changes from v1:
> > > 
> > >    Added received Acks
> > > 
> > >    Split the kernel print identifying the port type being reset.
> > > 
> > >    Added a patch for the portdrv to ensure the slot_reset happens without
> > >    relying on a downstream device driver..
> > > 
> > > Keith Busch (5):
> > >    PCI/ERR: Clear status of the reporting device
> > >    PCI/AER: Actually get the root port
> > >    PCI/ERR: Retain status from error notification
> > >    PCI/AER: Specify the type of port that was reset
> > >    PCI/portdrv: Report reset for frozen channel
> 
> I removed the patch 5/5 from this patch series, and after testing again, it
> makes my setup recover from the injected error; same as observed with v1
> series.

Thanks for the notice. Unfortunately that seems even more confusing to
me right now. That patch shouldn't do anything to the devices or the
driver's state; it just ensures a recovery path that was supposed to
happen anyway. The stack trace says restoring the config space completed
partially before getting stuck at the virtual channel capability, at
which point it appears to be in an infinite loop. I'll try to look into
it. The emulated devices I test with don't have the VC cap but I might
have real devices that do.
