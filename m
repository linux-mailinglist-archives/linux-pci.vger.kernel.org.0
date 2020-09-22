Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6A274A4A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVUpg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 16:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIVUpg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 16:45:36 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368EF2085B;
        Tue, 22 Sep 2020 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600807535;
        bh=xWczEJ4t6Q/OE5TPUMmmYEyyltd6MdrfWxDDmTklryU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1CJzWXroyeS814IJWLzxTdTMQEw/xfAnIN6XbVDiK+J7NKqA+pDe1seG5URBOIJ4Q
         Bg0B1UKPhEpJ2yu8E6sMjJCBGfQy5SpwyjLchgMpVbdsIk3of448X7b7EAzGvmqJ6e
         QzQrGQ3AJTa55UbeeX3ueK7bQmt1EN3wbHvItt94=
Date:   Tue, 22 Sep 2020 15:45:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] PCI/RCEC: Cache RCEC capabilities in
 pci_init_capabilities()
Message-ID: <20200922204533.GA2228232@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918204603.62100-4-sean.v.kelley@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I don't know what's going on with email, but I only see patches 3, 5,
6, 9 on the list and on lore:
https://lore.kernel.org/r/20200918204603.62100-4-sean.v.kelley@intel.com/

Similar issues with Sathy's series, where I only see patches 1, 3, 5:
https://lore.kernel.org/r/a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com/

On Fri, Sep 18, 2020 at 01:45:56PM -0700, Sean V Kelley wrote:
> Extend support for Root Complex Event Collectors by decoding and
> caching the RCEC Endpoint Association Extended Capabilities when
> enumerating. Use that cached information for later error source
...

