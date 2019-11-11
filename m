Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE5F796D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKREa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 12:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKREa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 12:04:30 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2FD3214DB;
        Mon, 11 Nov 2019 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573491869;
        bh=doNb8eOz52l8tpt0P5xoKExErKIHHIONmaeF0kCCE/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7zVdakTisUdglShgl9MfvKGht11oUKCRalKuhpVr5dNblS7aSNr7Xa7XUkPzreTM
         4jKtMpIYdcOpYPnlUBgTGZp+LSJU735eyMZTZw77U+nZ4bg6yat0khhbEARpCcPjPV
         Kfm5pUzD7B+LCJPl7fg7MQ59vNUZ6XCsDTTu0yAE=
Date:   Tue, 12 Nov 2019 02:04:22 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.com>
Subject: Re: [PATCH 1/2] PCI: vmd: Add bus 224-255 restriction decode
Message-ID: <20191111170422.GB10851@redsun51.ssa.fujisawa.hgst.com>
References: <20191111165302.29636-1-jonathan.derrick@intel.com>
 <20191111165302.29636-2-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111165302.29636-2-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 09:53:01AM -0700, Jon Derrick wrote:
> VMD bus restrictions are required when IO fabric is multiplexed such
> that VMD cannot use the entire bus range. This patch adds another bus
> restriction decode bit that can be set by firmware to restrict the VMD
> bus range from 224-255.

The code suggests that such a device is restricted *to* that range,
not from it.
 
> +			switch (BUS_RESTRICT_CFG(reg16)) {
> +			case(1):
> +				vmd->busn_start = 128;
> +				break;
> +			case(2):
> +				vmd->busn_start = 224;
> +				break;
> +			case(3):
> +				pci_err(vmd->dev, "Unknown Bus Offset Setting\n");
> +				return -ENODEV;
> +			default:
> +				break;
> +			}

Just a nit for consistent sytle, every other switch case looks like:

	case 1:
		...
	case 2:
		...
	case 3:
		...
