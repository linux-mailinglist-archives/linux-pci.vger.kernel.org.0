Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0023D3402
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 07:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhGWEoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 00:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhGWEoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 00:44:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D10C061575;
        Thu, 22 Jul 2021 22:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xptyi13HccZ4R8P+AijEDP2b7CXavc6mEvvmsOqoBkY=; b=DJcUAYLk0+dpd/8f5g9HghlA3p
        EeZr7LTFHZmDPgmsgccuMllN8saglU98K+LzeI94X0be9lqlsEPVr/7iAdl5BonTxc0zCc4mQCaU/
        0XS+8rP7eJINp0fVuc4beaxfm32S8rHcaj8NPOZvGL08pLLZQv1cTZgC80Ly2DfcuRWJXGFoiIABb
        VsygBF0zhSBU1IUbpYEnbCV1lbWyvuZiq5uM8z0aocWQeLQIBRN3HYYObC/sX1W3TDAZCehN+t/xD
        l8WwHz5ZdXguLSoAcOt6tdlh3NGabF9wtFkidWDFN08ja2VULxLzDcnQJdYtbuO8u1wcZ8V0Zc6G1
        og1TAruw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6nfa-00B1E8-GY; Fri, 23 Jul 2021 05:24:27 +0000
Date:   Fri, 23 Jul 2021 06:24:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER interrupt during suspend
Message-ID: <YPpShrTa448OpGjA@infradead.org>
References: <CAAd53p6VN0ejKHcTRgj8mZ_iApR=KogpVZ-HkvdoZbJ=Yue98g@mail.gmail.com>
 <20210722222351.GA354095@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722222351.GA354095@bjorn-Precision-5520>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 05:23:51PM -0500, Bjorn Helgaas wrote:
> Marking both of these as "not applicable" for now because I don't
> think we really understand what's going on.
> 
> Apparently a DMA occurs during suspend or resume and triggers an ACS
> violation.  I don't think think such a DMA should occur in the first
> place.
> 
> Or maybe, since you say the problem happens right after ACS is enabled
> during resume, we're doing the ACS enable incorrectly?  Although I
> would think we should not be doing DMA at the same time we're enabling
> ACS, either.
> 
> If this really is a system firmware issue, both HP and Dell should
> have the knowledge and equipment to figure out what's going on.

DMA on resume sounds really odd.  OTOH the below mentioned case of
a DMA during suspend seems very like in some setup.  NVMe has the
concept of a host memory buffer (HMB) that allows the PCIe device
to use arbitrary host memory for internal purposes.  Combine this
with the "Storage D3" misfeature in modern x86 platforms that force
a slot into d3cold without consulting the driver first and you'd see
symptoms like this.  Another case would be the NVMe equivalent of the
AER which could lead to a completion without host activity.

We now have quirks in the ACPI layer and NVMe to fully shut down the
NVMe controllers on these messed up systems with the "Storage D3"
misfeature which should avoid such "spurious" DMAs at the cost of
wearning out the device much faster.
