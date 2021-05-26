Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F66D391CF4
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhEZQYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 12:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232363AbhEZQYj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 12:24:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C9CE613CA;
        Wed, 26 May 2021 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622046188;
        bh=EC/2FajTeQPvMVJu8QFCw8CA3KxI3R6E2U7b7VFhw7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OqFvy1CCupJA3GVoDKXRFZa5F85ZK0/mtdmFp+AuVxA4KFOyM4zzHqw+lr5giCimC
         tES7XtjSLd0dN3sxeObEe9RBjpCXsOrTFXZBT+Eq5B9NJraDOQN20shmb8BwlVkdIQ
         EIw5/YTcJ9LBhtdKlaImPW3eDG7qitX0zHlKbBXyqtKTyr/c+9VHkODEoc+AZxdkGM
         ZWzaoAiTGBJ/FCn6IDMu6UPuWQeixt5zyvCGYE2FojXsiVXU/vT5WXj7L84SQdVlQi
         AZ+EbHHGqFHZCES9TmpCoIZvKLZBGpbbcLPwdBAQWw4A2o0U+m6rQkVQSdvP6oo3lp
         tkEF+EjLZDxqw==
Date:   Wed, 26 May 2021 11:23:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lambert Wang <lambert.q.wang@gmail.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: add pci_dev_is_alive API
Message-ID: <20210526162306.GA1299430@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATamay8WTiJnB=5OLYdFTqVUcRF9LarN6_1Eej3QUgFzWRnkA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 02:12:38PM +0800, Lambert Wang wrote:
> ...
> The user is our new PCI driver under development for WWAN devices .
> Surprise removal could happen under multiple circumstances.
> e.g. Exception, Link Failure, etc.
> 
> We wanted this API to detect surprise removal or check device recovery
> when AER and Hotplug are disabled.
> 
> I thought the API could be commonly used for many similar devices.

Be careful with this.  pci_device_is_present() is not a good way to
detect surprise removal.  Surprise removal can happen at any time, for
example, it can occur after you call pci_device_is_present() but
before you use the result:

  present = pci_device_is_present(pdev);
  /* present == true */
  /* device may be removed here */
  if (present)
    xxx; /* this operation may fail */

You have to assume that *any* operation on the device can fail because
the device has been removed.  In general, there's no response for a
PCIe write to the device, so you can't really check whether a write
has failed.

There *are* responses for reads, of course, if the device has been
removed, a read will cause a failure response.  Most PCIe controllers
turn that response into ~0 data to satisfy the read.  So the only
reliable way to detect surprise removal is to check for ~0 data when
doing an MMIO read from the device.  Of course, ~0 may be either valid
data or a symptom of a failure response, so you may have to do
additional work to distinguish those two cases.

Bjorn
