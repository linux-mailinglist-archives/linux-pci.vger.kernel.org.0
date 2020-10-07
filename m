Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5476C286261
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 17:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgJGPnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 11:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgJGPnR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 11:43:17 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB3B215A4;
        Wed,  7 Oct 2020 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602085396;
        bh=DUJI+Lsncz7wrko4XgbJoI2LwSo1I845y00NncUYbxM=;
        h=Date:From:To:Cc:Subject:From;
        b=LyIvekV8MmYU8u2NeMfsx7cDJDq6K7HqLGFWAplyc1bBmskANj8P6WXRPIqKWrlfT
         tDH2bLV8JvkX66Kll50YQWtDXQgGd78uDeoDiH3K+kOfDu6+mdGGGG4a3hZwbaQypT
         Vpb1Yd5TO8bpy0zAIva1xyKiFgPZlF254n4sNv4w=
Date:   Wed, 7 Oct 2020 10:43:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     Todd Brandt <todd.e.brandt@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [Bug 209321] DMAR: [DMA Read] Request device [03:00.0] PASID
 ffffffff fault addr fffd3000 [fault reason 06] PTE Read access is not set
Message-ID: <20201007154314.GA3245607@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209321

Not much detail in the bugzilla yet, but apparently this started in
v5.8.0-rc1:

  DMAR: [DMA Read] Request device [03:00.0] PASID ffffffff fault addr fffd3000 [fault reason 06] PTE Read access is not set

Currently assigned to Driver/PCI, but not clear to me yet whether PCI
is the culprit or the victim.
