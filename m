Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E31796C8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 18:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDRer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 12:34:47 -0500
Received: from 8bytes.org ([81.169.241.247]:50024 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbgCDRer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 12:34:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EE5B22E2; Wed,  4 Mar 2020 18:34:45 +0100 (CET)
Date:   Wed, 4 Mar 2020 18:34:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        kevin.tian@intel.com, linux-pci@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
        bhelgaas@google.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304173441.GB3315@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
 <20200304074854.3ea958a1@jacob-XPS-13-9365>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304074854.3ea958a1@jacob-XPS-13-9365>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 04, 2020 at 07:48:54AM -0800, Jacob Pan wrote:
> For emulated VT-d IOMMU, GIOVA can also be build as first level page
> tables then pass to the host IOMMU to bind. There is no need to shadow
> in this case, pIOMMU will do nested translation and walk guest page
> tables.

Right, but that requires hardware support. A pure software emulation of
VT-d requires the full shadow of the guest io-page-table.

> I thought we have the universal device properties to abstract DT and
> ACPI (via _DSD). Is that an option?

I don't know whether this was considered, Jean-Philippe?


Regards,

	Joerg
