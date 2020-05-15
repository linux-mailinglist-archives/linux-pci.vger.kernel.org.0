Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F400D1D4DF3
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOMov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgEOMov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 08:44:51 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 May 2020 05:44:51 PDT
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C2C061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 05:44:51 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E6751379; Fri, 15 May 2020 14:44:49 +0200 (CEST)
Date:   Fri, 15 May 2020 14:44:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, ashok.raj@intel.com,
        lalithambika.krishnakumar@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200515124448.GW18353@8bytes.org>
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
 <20200513151929.GA38418@bjorn-Precision-5520>
 <CACK8Z6F8ncByr92+PUHPAGudZBM4fqKiau+t=JE6P1963et3fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6F8ncByr92+PUHPAGudZBM4fqKiau+t=JE6P1963et3fQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 13, 2020 at 02:26:18PM -0700, Rajat Jain wrote:
> * A driver could be double fetching the memory, causing it to do
> different things than intended. E.g.
> * A driver could be (negligently) passing some kernel addresses to the device.
> * A driver could be using (for memory dereferencing, for e.g.) the
> address/indices, given by the device, without enough validation.
> * A driver may negligently be sharing the DMA memory with some other
> driver data in the same PAGE. Since the IOMMU restrictions are PAGE
> granular, this might give device access to that driver data.

The Intel IOMMU driver has a solution for that problem as it has iommu
based bounce-buffer dma ops. This means that a driver can't
accidentially share sensitive information on the same page with a
device.

This idea should be generalized and made available for all iommu-drivers
in the form of integrating it into the dma-iommu code, or have a
separate generic dma-ops implementation, which does:

	1) Give the device direct access to DMA buffers if they are
	   IOMMU-page aligned (both start and size).

	2) Use bounce buffering for DMA buffers that don't align with
	   iommu page-size.

This would at least eliminate this type of attack made possible by
uncautious drivers.

Regards,

	Joerg
