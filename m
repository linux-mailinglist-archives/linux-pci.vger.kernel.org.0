Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B03188781
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgCQO3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 10:29:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQO3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 10:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7z/qRxga4zxFQzMbdlVAFmOAN3gxS3gRvlOl2y87r0=; b=MVy9U3XVAq591GDprSJyimjw3a
        dbTEUD0ngTn2Nej8EgDNTrNALQERuyBVfpsfLunyRPNUbY1PGMRVr2DltZEDiGch7j0vrHTNZkc1Y
        LCJOjctwu2vKz4umcibAYl+IwAzVsEqz0BVsiezpct1JcmlF96IFi5umKumVZWXEtMxViJCrXiAq7
        h804aoyrir9DGPrb/nk1+BZPrFzucZtFjS/MvC969Jko6kfKUbbvJWsf3HRj7Y4XJpQLciEzwtmDU
        m1IL5fyjfJjHngHFcMDUqR5qmMWALsFJbBeGCzK1thBoRtJFnN7sndtvsG3MdWcrZIGuT2sTWVl4G
        dNoUZvhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDDV-000097-Qj; Tue, 17 Mar 2020 14:29:13 +0000
Date:   Tue, 17 Mar 2020 07:29:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikel Rychliski <mikel@mikelr.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH 3/4] drm/radeon: iounmap unused mapping
Message-ID: <20200317142913.GB23471@infradead.org>
References: <20200303033457.12180-1-mikel@mikelr.com>
 <20200303033457.12180-4-mikel@mikelr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303033457.12180-4-mikel@mikelr.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 02, 2020 at 10:34:56PM -0500, Mikel Rychliski wrote:
> Now that pci_platform_rom creates a new mapping to access the ROM
> image, we should remove this mapping after extracting the BIOS.

This and the next patch really need to be folded into the previous
one to avoid regressions (assuming my other suggestion doesn't work
for some reason).
