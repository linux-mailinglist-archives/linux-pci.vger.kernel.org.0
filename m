Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD332B140
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 11:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfE0J0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 05:26:07 -0400
Received: from 8bytes.org ([81.169.241.247]:40176 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfE0J0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 May 2019 05:26:06 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BF9BB26B; Mon, 27 May 2019 11:26:04 +0200 (CEST)
Date:   Mon, 27 May 2019 11:26:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com, bhelgaas@google.com,
        frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu,
        eric.auger@redhat.com, tnowicki@caviumnetworks.com,
        kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        bharat.bhushan@nxp.com
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Message-ID: <20190527092604.GB21613@8bytes.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190512123022-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512123022-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
> OK this has been in next for a while.
> 
> Last time IOMMU maintainers objected. Are objections
> still in force?
> 
> If not could we get acks please?

No objections against the code, I only hesitated because the Spec was
not yet official.

So for the code:

	Acked-by: Joerg Roedel <jroedel@suse.de>

