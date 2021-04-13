Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2D35D8EA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 09:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbhDMHdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 03:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239240AbhDMHdD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 03:33:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C3F7613B1;
        Tue, 13 Apr 2021 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618299163;
        bh=0E4NDVSsgn4e8nD4chZqJrT6BZ9xAxdiPvSP07EJB1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BeWpHeg3WSvgeOTR/YWiYX610rvkQS+2lfuALZtwCMU+7BjTSnqez876hmLtLkPUI
         UhX7RDpc1k1TzCpQEGs5MFeMG1I+RcwWTiR4m4ISr3YjXMADpR7gqUEcE9vbYU9foL
         n5e3Z92m8SpIqzuCpJfknrXi0bs3t0oJRNsgHbwuEclQyGTl/nUaho3fKbY8/CPOFX
         /DTw+JBzybhPlohaD3eD0rG7+AGKTEwLXP25nXpDD8Pu1MRAgtQiLE3zmKdI1uRHcv
         G4vJLFQzxl2MYiNPjXDsD/TQc5ILcR6H8+21WeWG6cgjeE6IZhi7z3WIjvddBAnOqy
         HcI4pRu3CVIcw==
Date:   Tue, 13 Apr 2021 10:32:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Narendra K <narendra_k@dell.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/1] Use of =?utf-8?B?L3N5cy9i?=
 =?utf-8?B?dXMvcGNpL2RldmljZXMv4oCmL2luZGV4?= for non-SMBIOS platforms
Message-ID: <YHVJF3M1Nq4iavQl@unreal>
References: <20210412135905.1434249-1-schnelle@linux.ibm.com>
 <YHUujU1o6bdHDfmS@unreal>
 <88c62c2789d5798338736308672867f30d617794.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c62c2789d5798338736308672867f30d617794.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 13, 2021 at 08:57:19AM +0200, Niklas Schnelle wrote:
> On Tue, 2021-04-13 at 08:39 +0300, Leon Romanovsky wrote:
> > On Mon, Apr 12, 2021 at 03:59:04PM +0200, Niklas Schnelle wrote:
> > > Hi Narendra, Hi All,
> > > 
> > > According to Documentation/ABI/testing/sysfs-bus-pci you are responsible
> > > for the index device attribute that is used by systemd to create network
> > > interface names.
> > > 
> > > Now we would like to reuse this attribute for firmware provided PCI
> > > device index numbers on the s390 architecture which doesn't have
> > > SMBIOS/DMI nor ACPI. All code changes are within our architecture
> > > specific code but I'd like to get some Acks for this reuse. I've sent an
> > > RFC version of this patch on 15th of March with the subject:
> > > 
> > >    s390/pci: expose a PCI device's UID as its index
> > > 
> > > but got no response. Would it be okay to re-use this attribute for
> > > essentially the same purpose but with index numbers provided by
> > > a different platform mechanism? I think this would be cleaner than
> > > further proliferation of /sys/bus/pci/devices/<dev>/xyz_index
> > > attributes and allows re-use of the existing userspace infrastructure.
> > 
> > I'm missing an explanation that this change is safe for systemd and
> > they don't have some hard-coded assumption about the meaning of existing
> > index on s390.
> > 
> > Thanks
> 
> 
> Sure, good point. So first off yes this change does create new index
> based names also on existing systemd versions, this is known and
> intended and we'll certainly closely collaborate with any distributions
> wishing to backport this change.
> 
> As for being otherwise safe or having unintended consequences, Viktor
> (see R-b) and I recently got the following PR merged in that exact area
> of systemd to fix how hotplug slot derived interface names are
> generated:
> https://github.com/systemd/systemd/pull/19017
> In working on that we did also analyse the use of the index attribute
> for hidden assumptions and tested with this attribute added. Arguably,
> as the nature of that PR shows we haven't had a perfect track record of
> keeping this monitored but will in the future as PCI based NICs become
> increasingly important for our platform. We also have special NIC
> naming logic in the same area for our channel based platform specific
> NICs which was also contributed by Viktor.

Thanks, this PR is exciting to read, very warm words were said about
kernel developers :). Can you please summarize that will be the breakage
in old systemd if this index will be overloaded?

Thanks

> 
> Thanks,
> Niklas
> 
