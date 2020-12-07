Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C492D1584
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLGQE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 11:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGQE6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 11:04:58 -0500
Date:   Mon, 7 Dec 2020 10:04:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607357057;
        bh=RcQN6hi2+QUTTg3RgfKP/MkKpJmDe7uaH6ZMpw9eQew=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=S6cLeNzsfNULWr9n5lz3TXRh3VC87bTiisOe2GcMw0NKLXzeNXqLDY7l0So09VOJt
         ozX1kRHaEONpgMz51Eu6HlMdmcl6F/vwGLOmJrrZpnY5vrJb4jDSCPNsd/4+nKk56W
         K7ibT5J5xc5wrObvbSFtpOVkfH9DJ2ErM8SRl0inw0TDC9g0ROF8fYlt+H+xKZ8/vW
         y95SgS3NyoYBzmBwa+dwLX6zyJpOYDCOcMGrabbiRCIutxck5zX5CWmHRGdBRjJUTi
         ZHTyDt9UYWzb0uvPuQObRN4Q6Xt5F0e8Wpyk87RVSCjNSyBS0/S9t/wQ8hPsBYm0zs
         iy9+prKeIMeXA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, Damien.LeMoal@wdc.com,
        linux-block@vger.kernel.org, bjorn@helgaas.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Message-ID: <20201207160416.GA2256630@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207145258.GA16899@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 07, 2020 at 02:52:58PM +0000, Christoph Hellwig wrote:
> Can we take a step back?  I think in general drivers should not bother
> with pci_find_capability.  Both mtip32xx and skd want to find out if
> the devices are PCIe devices, skd then just prints the link speed for
> which we have much better helpers, mtip32xx than messes with DEVCTL
> which seems actively dangerous to me.

Yes, that's a much better idea.  Plus it would be a much more
interesting mentorship project.
