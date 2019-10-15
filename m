Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B41D8243
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 23:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfJOVgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 17:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfJOVgi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 17:36:38 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB0D20854;
        Tue, 15 Oct 2019 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571175397;
        bh=aMw709beM1rE8T7vybZcuJLSLiqFPzJHotrEtAZ9suw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1u4ZjfYyt3WgWzgBm8iqJwwNFm27RBd6GtDbCEvm1NexWbrPYkkyyIlQ/Kgj4LF8V
         kTRc6IUZyGmxMdyN332GwEFVn2nBCD1+SwnRwIAgf08rOuNMkDAzWpQSfdNXLO4aub
         cnMbsgaHG9rmVnqghp9hGuZAP72kWnarIRjXJc9g=
Date:   Tue, 15 Oct 2019 16:36:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH 0/3] PCI/ATS: Clean up unnecessary stubs and exports
Message-ID: <20191015213635.GA177798@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009225354.181018-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 09, 2019 at 05:53:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Most of the ATS/PRI/PASID interfaces are only used by IOMMU drivers that
> can only be built statically, not as modules.  A couple are only used by
> the PCI core and don't need to be visible outside at all.
> 
> These are intended to be cleanup only, but let me know if they would break
> something.
> 
> Bjorn Helgaas (3):
>   PCI/ATS: Remove unused PRI and PASID stubs
>   PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()
>   PCI/ATS: Make pci_restore_pri_state(), pci_restore_pasid_state()
>     private
> 
>  drivers/pci/ats.c       | 14 --------------
>  drivers/pci/pci.h       |  4 ++++
>  include/linux/pci-ats.h | 15 ---------------
>  3 files changed, 4 insertions(+), 29 deletions(-)

I applied these to pci/virtualization for v5.5, with Kuppuswamy's
Reviewed-by on the first and Joerg's on all three.  Thank you both for
taking a look!

Bjorn
