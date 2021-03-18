Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0680340176
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 10:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCRJIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 05:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCRJHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 05:07:42 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81E4C06174A
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 02:07:42 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 92B822D8; Thu, 18 Mar 2021 10:07:40 +0100 (CET)
Date:   Thu, 18 Mar 2021 10:07:38 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Karkra, Kapil" <kapil.karkra@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>,
        "kw@linux.com" <kw@linux.com>
Subject: Re: [PATCH v4 0/2] VMD MSI Remapping Bypass
Message-ID: <YFMYWrghas6og2pN@8bytes.org>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
 <0a70914085c25cf99536d106a280b27819328fff.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a70914085c25cf99536d106a280b27819328fff.camel@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 17, 2021 at 07:14:17PM +0000, Derrick, Jonathan wrote:
> Gentle reminder, for v5.13 ?

This should go through the PCI tree, Bjorn?
