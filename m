Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823DA47CDAD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 08:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbhLVHw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 02:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLVHwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 02:52:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711AFC061574;
        Tue, 21 Dec 2021 23:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G/2YVv3eobEHhE9ekDUsUs29N7O2hC1dhrLDdQRGfCA=; b=I4MzcQ8sMbIxJGGDZNIbxftAd6
        0OWS9+NAZvis9eC3yhPYe+4Ea+cMo7D6ZhPVgOGOfubuQ+/aOnftFLoyDJ2qROnHoeT1+1a0AQhmz
        y97kH3zoIExLfMeD+csbS2hp7ctfFS32VuOim6z8UetzlelURopkjD/8/NzSWL7/g/uUKvGb8kPPW
        0Edq3T+AGshHPXRB71mcdD+LI4mmr2v6oTtb9pmDZi3NKoLPBHw8UnBEdaV0SZghqZNLBDDIq3Pa5
        5z/rKwYWNxDJMx2vnMWgNHQ+BhatMUCTopMdm2VrSW9IeDHiRsF9pyOoJv/JEztkp7JbeyIDc5RRU
        wiwn+8og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzwOW-009YG4-09; Wed, 22 Dec 2021 07:50:40 +0000
Date:   Tue, 21 Dec 2021 23:50:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        francisco.munoz.ruiz@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
Message-ID: <YcLYz0x5oawOEHnI@infradead.org>
References: <20211220172848.GA1006510@bhelgaas>
 <e87a297cc74cca02fa1a8f5aa9562489a4db26b3.camel@linux.intel.com>
 <CACK8Z6F812_DYVr=sxRXxhtPxyCw206U=jW6CFt6T-MyKJXMgQ@mail.gmail.com>
 <9b540d4f11bb4e2e1422b641df1f5e84aa68602f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b540d4f11bb4e2e1422b641df1f5e84aa68602f.camel@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 21, 2021 at 01:11:26PM -0800, David E. Box wrote:
> The reason why BIOS is not programming these values is because when VMD is
> enabled the ports are not visible to BIOS. This would apply to any BIOS
> including those used by ChromeOS.
> And because BIOS doesn't see these ports ...

Isn't VMD enabled by the BIOS?  The bios should be able see them the
same way as Linux does.  But given that the whole point of VMD is to hide 
these ports from Windows it obviously doesn't.  For Linux and thus for
ChromeOS VMD is completely pointless, so give that the ChromeOS people
aren't as dumb as some people at Intel I'm pretty sure they won't enable
it and just use the ports as normal one and avoid this whole
self-inflicted pain.

If only Intel could give the OS a way to disable VMD at runtime and
discover the actual ports, then we would not have this whole nightmare
of having to support it.
