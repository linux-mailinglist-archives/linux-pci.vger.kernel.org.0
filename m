Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E1276CEF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 11:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgIXJVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIXJVd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 05:21:33 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64DBC0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 02:21:32 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DB01A295; Thu, 24 Sep 2020 11:21:30 +0200 (CEST)
Date:   Thu, 24 Sep 2020 11:21:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924092129.GH27174@8bytes.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924045958-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> OK so this looks good. Can you pls repost with the minor tweak
> suggested and all acks included, and I will queue this?

My NACK still stands, as long as a few questions are open:

	1) The format used here will be the same as in the ACPI table? I
	   think the answer to this questions must be Yes, so this leads
	   to the real question:
	   
	2) Has the ACPI table format stabalized already? If and only if
	   the answer is Yes I will Ack these patches. We don't need to
	   wait until the ACPI table format is published in a
	   specification update, but at least some certainty that it
	   will not change in incompatible ways anymore is needed.

So what progress has been made with the ACPI table specification, is it
just a matter of time to get it approved or are there concerns?

Regards,

	Joerg
