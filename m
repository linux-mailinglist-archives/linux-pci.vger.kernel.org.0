Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B45E5E6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCN7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 09:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfGCN7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 09:59:44 -0400
Received: from localhost (84.sub-174-234-39.myvzw.com [174.234.39.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F41E218A4;
        Wed,  3 Jul 2019 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562162383;
        bh=9jZQ+xkADDFcvlMkther+QWiQF9N7WPn19dHdCUcdJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vrOSy5n7+9jskmOih+YCm2qC0fiZpZUcrmgqI0SUk1XzVg5r8xd9SZ7WGFWNP8jk0
         lTtiqUFV35QEFa+QYJ9vOJf3jUQrXQSDj8Xb+Yn2RODFehXFcct8+Yy0LdhyIzpKH2
         19gu9RidHEYafUdvqQaslt+8Az+TYsWmWf5IQ8Sg=
Date:   Wed, 3 Jul 2019 08:59:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Hao Zheng <yinhe@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, nanhai.zou@linux.alibaba.com,
        quan.xu0@linux.alibaba.com, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
Subject: Re: [PATCH 0/2] PCI/IOV: Resolve regression in SR-IOV VF cfg_size
Message-ID: <20190703135941.GL128603@google.com>
References: <156046609596.29869.5839964168034189416.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156046609596.29869.5839964168034189416.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
> The commit reverted in the first patch introduced a regression where
> only the first VF reports the correct config space size, subsequent VFs
> report 256 bytes of config space.  Replace this in the second patch
> with an assumption that all VFs support extended config space by virtue
> of the SR-IOV spec requiring a PCIe capability and reachability of the
> PF extended config space already being proven by the existence of the
> VF.  Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       Revert: PCI/IOV: Use VF0 cached config space size for other VFs
>       PCI/IOV: Assume SR-IOV VFs support extended config space.

Applied to pci/virtualization for v5.3 with Kuppuswamy's reviewed-by on
2/2, thanks!

>  drivers/pci/iov.c   |    2 --
>  drivers/pci/pci.h   |    1 -
>  drivers/pci/probe.c |   26 ++++++++++++--------------
>  3 files changed, 12 insertions(+), 17 deletions(-)
