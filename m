Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7056327704B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgIXLu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIXLux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 07:50:53 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED88BC0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 04:50:52 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7689F295; Thu, 24 Sep 2020 13:50:50 +0200 (CEST)
Date:   Thu, 24 Sep 2020 13:50:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924115048.GQ27174@8bytes.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
 <20200924102953.GD170808@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924102953.GD170808@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 12:29:53PM +0200, Jean-Philippe Brucker wrote:
> It's not possible to use exactly the same code for parsing.

The access methods can be separate and don't affect the parsing logic.

> The access methods are different (need to deal with port-IO for
> built-in description on PCI, for example) and more importantly, the
> structure is different as well. The ACPI table needs nodes for
> virtio-iommu while the built-in description is contained in the
> virtio-iommu itself. So the endpoint nodes point to virtio-iommu node
> on ACPI, while they don't need a pointer on the built-in desc. I kept
> as much as possible common in structures and implementation, but in
> the end we still need about 200 unique lines on each side.

Will it hurt the non-ACPI version to have the not-needed pointers anyway
to keep the parsers the same?


	Joerg
