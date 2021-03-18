Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788C93405A4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 13:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCRMix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 08:38:53 -0400
Received: from foss.arm.com ([217.140.110.172]:39760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhCRMiY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 08:38:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB1831B;
        Thu, 18 Mar 2021 05:38:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158C53F718;
        Thu, 18 Mar 2021 05:38:21 -0700 (PDT)
Date:   Thu, 18 Mar 2021 12:38:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Karkra, Kapil" <kapil.karkra@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>,
        "kw@linux.com" <kw@linux.com>
Subject: Re: [PATCH v4 0/2] VMD MSI Remapping Bypass
Message-ID: <20210318123817.GA27487@e121166-lin.cambridge.arm.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
 <0a70914085c25cf99536d106a280b27819328fff.camel@intel.com>
 <YFMYWrghas6og2pN@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMYWrghas6og2pN@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 10:07:38AM +0100, joro@8bytes.org wrote:
> On Wed, Mar 17, 2021 at 07:14:17PM +0000, Derrick, Jonathan wrote:
> > Gentle reminder, for v5.13 ?
> 
> This should go through the PCI tree, Bjorn?

I will start queuing code next week, noted.

Thanks,
Lorenzo
