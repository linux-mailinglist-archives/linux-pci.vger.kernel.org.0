Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7A26FD51
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIRMrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 08:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgIRMrN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 08:47:13 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505E623600;
        Fri, 18 Sep 2020 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600433232;
        bh=T2S8dkpDTSwWKVpBKiH0LOb9Www4+IJXitnPi6pfvQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zQlHWti5x0Rtt729xb+cWuja0eA8sW7ZIkA9eO1fi/XzXq48oBvSuSif1C19KU1pw
         P6YtwpwN8n2MaoEqIdDLIqF2P1KhL+QXPMqAQKlaxYODQLnnrhEJrrCxyYBLs7s52h
         oNg/fKAS4lDc5rTrWZ2BJKczDaPKFX/h2wF+qFJI=
Date:   Fri, 18 Sep 2020 07:47:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Message-ID: <20200918124710.GA1800067@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 11:02:07AM +0000, Z.q. Hou wrote:

> But now the SError is exactly caused by the first access of the
> non-existent function, I dug into the kernel enumeration code and
> found it will fire a 4Byte CFG read transaction to read the Vendor
> ID and Device ID together, so I suspect the root cause is access the
> Device ID of a non-existent function triggers SError.
> 
> So the alternative solution seems to correct the PCIe enumeration, I
> will submit a patch to let the first access only read the Vendor ID.

If it is incorrect for the first access to be a 32-bit read of both
the Vendor and the Device ID, please cite the relevant section of the
spec in your patch.

I don't like to make changes to generic code to accommodate specific
pieces of hardware because then we restrict future changes based on
some device that will soon be obsolete and forgotten.

I'm pretty sure the spec language about CRS handling is careful to
talk about "reads that *include* Vendor ID", not just "reads of Vendor
ID", so the implication is that it covers 32-bit reads as well as
16-bit reads.

Bjorn
