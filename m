Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7AE3D18CA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhGUUa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 16:30:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:7490 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGUUa2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 16:30:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208402604"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="208402604"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 14:11:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="511935931"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 14:11:03 -0700
Date:   Wed, 21 Jul 2021 14:10:36 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 0/8] PCI/MSI, x86: Cure a couple of inconsistencies
Message-ID: <20210721211036.GA676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721191126.274946280@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:11:26PM +0200, Thomas Gleixner wrote:
> A recent discussion about the PCI/MSI management for virtio unearthed a

nit:
virtio or VFIO? :-)

> violation of the MSI-X specification vs. writing the MSI-X message: under
> certain circumstances the entry is written without being masked.
> 
> While looking at that and the related violation of the x86 non-remapped
> interrupt affinity mechanism a few other issues were discovered by
> inspection.

Cheers,
Ashok
