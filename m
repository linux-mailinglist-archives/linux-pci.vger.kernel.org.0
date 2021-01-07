Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A693C2EE7B9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 22:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAGVnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 16:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbhAGVnT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 16:43:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4E6923447;
        Thu,  7 Jan 2021 21:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610055759;
        bh=4sVtflLu0YYnAG/1h9hLJa0zeFOV+KQHKZrv4rhiU9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ml2IAUz+/8CdaFkAvtPSq3pjxKxwFn8lcMUjBpE7eAJ5EBlO/rFoi9PmhVVHsfwXm
         xRhM6L7GSgEe4y0p+4Cu44yUUcGcnjkc2RG696gTarBWuXylJp+eMEehu5Hi5elO3R
         qdNdEyAlY7UymVZyGbYb4nYGg3L5pO71BnpiUUts6fxjNChW6HfEgzfIELQTxkLE68
         nRZ2sY3qHWjXea5nxB339amni9KSf2iFbd6vBS4DZcI+6gdr9PnJqWSDISytRIgFZG
         b/1JzREl4n/R6m2Vgeq4CxY+Hc//HnlmqE8iBA5m/9wDH8dJECq2RMxBQwhex2LjKj
         MDMjLsAXsAWUg==
Date:   Thu, 7 Jan 2021 13:42:36 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     Hinko Kocevar <hinko.kocevar@ess.eu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
 <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
 <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
 <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 05, 2021 at 11:07:23PM +0000, Kelley, Sean V wrote:
> > On Jan 5, 2021, at 10:33 AM, Keith Busch <kbusch@kernel.org> wrote:
> > On Tue, Jan 05, 2021 at 04:06:53PM +0100, Hinko Kocevar wrote:
> >> On 1/5/21 3:21 PM, Hinko Kocevar wrote:
> >>> On 1/5/21 12:02 AM, Keith Busch wrote:
> >>>> Changes from v1:
> >>>> 
> >>>>    Added received Acks
> >>>> 
> >>>>    Split the kernel print identifying the port type being reset.
> >>>> 
> >>>>    Added a patch for the portdrv to ensure the slot_reset happens without
> >>>>    relying on a downstream device driver..
> >>>> 
> >>>> Keith Busch (5):
> >>>>    PCI/ERR: Clear status of the reporting device
> >>>>    PCI/AER: Actually get the root port
> >>>>    PCI/ERR: Retain status from error notification
> >>>>    PCI/AER: Specify the type of port that was reset
> >>>>    PCI/portdrv: Report reset for frozen channel
> >> 
> >> I removed the patch 5/5 from this patch series, and after testing again, it
> >> makes my setup recover from the injected error; same as observed with v1
> >> series.
> > 
> > Thanks for the notice. Unfortunately that seems even more confusing to
> > me right now. That patch shouldn't do anything to the devices or the
> > driver's state; it just ensures a recovery path that was supposed to
> > happen anyway. The stack trace says restoring the config space completed
> > partially before getting stuck at the virtual channel capability, at
> > which point it appears to be in an infinite loop. I'll try to look into
> > it. The emulated devices I test with don't have the VC cap but I might
> > have real devices that do.
> 
> I’m not seeing the error either with V2 when testing with are-inject using RCECs and an associated RCiEP.

Thank you, yes, I'm also not seeing a problem either on my end. The
sighting is still concerning though, so I'll keep looking. I may have to
request Hinko to try a debug patch to help narrow down where things have
gone wrong if that's okay.
