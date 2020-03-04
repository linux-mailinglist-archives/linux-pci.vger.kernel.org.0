Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE0179B4F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 22:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbgCDVy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 16:54:56 -0500
Received: from 8bytes.org ([81.169.241.247]:50074 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388399AbgCDVyz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 16:54:55 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D7A532E2; Wed,  4 Mar 2020 22:54:54 +0100 (CET)
Date:   Wed, 4 Mar 2020 22:54:49 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rothman, Michael A" <michael.a.rothman@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304215449.GE3315@8bytes.org>
References: <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
 <20200304153821.GE646000@myrica>
 <20200304174045.GC3315@8bytes.org>
 <20200304133744.00000fdb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304133744.00000fdb@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 04, 2020 at 01:37:44PM -0800, Jacob Pan (Jun) wrote:
> + Mike and Erik who work closely on UEFI and ACPICA.
> 
> Copy paste Erik's initial response below on how to get a new table,
> seems to confirm with the process you stated above.
> 
> "Fairly easy. You reserve a 4-letter symbol by sending a message
> requesting to reserve the signature to Mike or the ASWG mailing list or
> info@acpi.info

Great! I think this is going to be the path forward here.

Regards,

	Joerg

> 
> There is also another option. You can have ASWG own this new table so
> that not one entity or company owns the new table."
