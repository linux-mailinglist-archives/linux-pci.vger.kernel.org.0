Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031C4132F13
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 20:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgAGTNU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 14:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgAGTNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 14:13:19 -0500
Received: from chuupie.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADBD2087F;
        Tue,  7 Jan 2020 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578424399;
        bh=wRZGCPXRIXpVGF4yG5qeXLmNRj7lZ3c2miJlXJRKYV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLLC2XsvUukmCA6icVUziLQa622lKxDhid/WX1IfbhTlslj6Xs1pARnc+vII6Lp5i
         BPpkRkhdlerbQDJvbcxewu1BTifY/Ut0ow6s0swWdXzSMxoWOfvGewKwsFHulpffm5
         epiIkVkLOJZDNtlniUW8pIwRes1VsaAkU40JTmMA=
Date:   Tue, 7 Jan 2020 12:13:17 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sushma Kalakota <sushmax.kalakota@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: vmd: Add device id for VMD device 8086:467F
Message-ID: <20200107191317.GA610403@chuupie.wdl.wdc.com>
References: <20200106224122.3231-1-sushmax.kalakota@intel.com>
 <20200106224122.3231-3-sushmax.kalakota@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106224122.3231-3-sushmax.kalakota@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 03:41:22PM -0700, Sushma Kalakota wrote:
> This patch adds support for this VMD device which supports the bus
> restriction mode.

Suggested rephrasing to an imperative voice:

  Add new VMD device IDs that require the bus restriction mode.

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: Sushma Kalakota <sushmax.kalakota@intel.com>

The first sign-off should be the author, but there's no "From:" header
line for Jon. Is the attribution correct?

> @@ -868,6 +868,8 @@ static const struct pci_device_id vmd_ids[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_467F),
> +		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_4C3D),
>  		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},

Since you know all the new device ids, might as well collapse this patch
with the first one from this series.
