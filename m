Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EFB5DA4D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 03:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfGCBIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 21:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfGCBIF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 21:08:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07111206E0;
        Tue,  2 Jul 2019 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562102912;
        bh=fyqXNS4wOs1KzFcxMs8sN7xIFks2lnuffsrGqABj8J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGQBxfIXyr4LBTFiosFRv93ZLVxIrf0b9N5XwTGPlu4PRw4WQNuRbfLdsfGB59P9+
         f140FmhLuvCxjYuvtSGBXL+CJ5XVZHxQg2F7mihTe1D/10IUvVO0N2lPcAIHaHdnP+
         JsBqQOHXL+S+PIOUZWzQtZr7hiVzQn+GMn0geJfg=
Date:   Tue, 2 Jul 2019 16:28:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, jcm@redhat.com,
        nariman.poushin@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH 0/2] lspci: support for CCIX DVSEC
Message-ID: <20190702212829.GE128603@google.com>
References: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 27, 2019 at 10:43:53PM +0800, Jonathan Cameron wrote:
> This series adds support for near complete interpretation of CCIX DVSEC.
> Most of the CCIX base 1.0 specification is covered, but a few minor
> elements are not currently printed (some of the timeouts and credit
> types). That can be rectified in a future version or follow up patch
> and isn't necessary for this discussion.
> 
> CCIX (www.ccixconsortium.org) is a coherent interconnect specification.
> It is flexible in allowed interconnect topologies, but is overlayed
> on top of a traditional PCIe tree.  Note that CCIX physical devices
> may turn up in a number of different locations in the PCIe tree.
> 
> The topology configuration and physical layer controls and description
> are presented using PCIe DVSEC structures defined in the CCIX 1.0
> base specification.  These use the unique ID granted by the PCISIG.
> Note that, whilst it looks like a Vendor ID for this usecase it is
> not one and can only be used to identify DVSEC and related CCIX protocol
> messages.
> 
> So why an RFC?
> * Are the lspci maintainers happy to have the tool include support for
>   PCI configuration structures that are defined in other standards?
> * Is the general approach and code structure appropriate?
> * It's a lot of description so chances are some of it isn't in a format
>   consistent with the rest of lspci!
> 
> The patch set includes and example that was manually created to exercise
> much of the parser.  We also have qemu patches to emulate more complex
> topologies if anyone wants to experiment.
> 
> https://patchwork.kernel.org/cover/11015357/
> 
> Example output from lspci -t -F ccix-specex1 -s 03:00.0
> 
> 03:00.0 Class 0700: Device 19ec:0003 (prog-if 01)
> ...

> 	Capabilities: [600 v0] Designated Vendor-Specific <>
> 		Vendor:1e2c Version:0
> 		<CCIX Transport 600>
> 			TranCap:	ESM+ SR/LR RecalOnrC- CalTime: 500us QuickEqTime: 200ms/208ms
> 			ESMRateCap:	2.5 GT/s 5 GT/s 8 GT/s 16 GT/s 20 GT/s 25 GT/s 
> 			ESMStatus:	25 GT/s Cal+
> 			ESMCtl:		ESM0: 16 GT/s ESM1: 25 GT/s ESM+ ESMCompliance- LR
> 					ExtEqPhase2TimeOut: 400 ms / 408 ms  ExtEqPhase3TimeOut: 600 ms / 608 ms 
> 					QuickEqTimeout: Unknown
> 			ESMEqCtl 20GT/s:	Lane #00: Trans Presets US: 0x1 DS: 0x2

It's a minor annoyance that all these lines are longer than 80 columns.  I
know there are existing things in lspci that are wider, which are also
slightly annoying.  But you're adding a TON of them and there's a bunch of
whitespace at the beginning of each line :)

> The following grants the 'pciutils' project trademark usage of
> CCIX tradmark where relevant.
> 
> This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> you and other parties that are paticipating (the "participants") in the
> pciutils with the understanding that the participants will use CCIX's
> name and trademark only when this patch is used in association with the
> pciutils project.
> 
> CCIX is also distributing this patch to these participants with the
> understanding that if any portion of the CCIX specification will be
> used or referenced in the pciutils project, the participants will not modify
> the cited portion of the CCIX specification and will give CCIX propery
> copyright attribution by including the following copyright notice with
> the cited part of the CCIX specification:
> "© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

s/tradmark/trademark/
s/paticipating/participating/
s/propery/proper/

I guess "will not modify the cited portion" just means people will
quote it accurately?  It seems obvious that people proposing changes
to pciutils can't really modify the CCIX spec.

The above all sounds a little onerous and I doubt I would sign up to
it because I'd be afraid to mention "CCIX" in an email and I'm pretty
sure I'd forget to add the copyright notice somewhere.  But
fortunately that's up to Martin, not me.

> Jonathan Cameron (2):
>   CCIX DVSEC initial support
>   DVSEC Add an example from the ccix spec.

s/ccix/CCIX/ so they match.  No period necessary in subject line.

I don't maintain pciutils, but I like to have subject lines match in
grammatical style.  One of the above is a sentence and the other is not.
Maybe:

  Add CCIX DVSEC decoding support
  Add DVSEC example from CCIX spec

Bjorn
