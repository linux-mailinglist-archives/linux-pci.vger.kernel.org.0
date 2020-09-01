Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863ED259EEF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 21:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIATFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Sep 2020 15:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgIATFx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Sep 2020 15:05:53 -0400
Received: from localhost (113.sub-72-107-119.myvzw.com [72.107.119.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE6C207D3;
        Tue,  1 Sep 2020 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598987152;
        bh=ugHGtD4AymiHx3XQBknlMEY/bDkqvJrRiG4TdIz97Mo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cFHdz4uWRDM7HfOxJA5sJf12PUiNHh6uqbXfULFrdcSok7Z8gn3xsX8cC7gkMlteI
         UTYtHYDoXjgoII59try2aqmBJVsjtJ3xpz7oZ4GLF1RSCizh8u2XymOwTAAKUIkAqr
         jW+D+/5OSIi+jqhA552JE4stZ6cjKQLzIH9gNPZg=
Date:   Tue, 1 Sep 2020 14:05:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Replace use of snprintf() with scnprintf() in
 show() functions
Message-ID: <20200901190551.GA197986@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200824233918.26306-1-kw@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 11:39:15PM +0000, Krzysztof Wilczyński wrote:
> Replace use of snprintf() with scnprintf() in order to adhere to the
> rules in Documentation/filesystems/sysfs.txt, as per:
> 
>   show() must not use snprintf() when formatting the value to be
>   returned to user space. If you can guarantee that an overflow
>   will never happen you can use sprintf() otherwise you must use
>   scnprintf().
> 
> Also resolve the following Coccinelle warnings, for example:
> 
>   drivers/pci/p2pdma.c:69:8-16: WARNING: use scnprintf or sprintf
>   drivers/pci/p2pdma.c:78:8-16: WARNING: use scnprintf or sprintf
>   drivers/pci/p2pdma.c:56:8-16: WARNING: use scnprintf or sprintf
> 
> The Coccinelle warning was added in commit abfc19ff202d ("coccinelle:
> api: add device_attr_show script").
> 
> There is no change to the functionality.
> 
> Related:
>   https://patchwork.kernel.org/patch/9946759/#20969333
>   https://lwn.net/Articles/69419
> 
> Krzysztof Wilczyński (3):
>   PCI: Replace use of snprintf() with scnprintf() in
>     resource_alignment_show()
>   PCI: sysfs: Replace use of snprintf() with scnprintf() in
>     driver_override_show()
>   PCI/P2PDMA: Replace use of snprintf() with scnprintf() in show()
>     functions
> 
>  drivers/pci/p2pdma.c    | 8 ++++----
>  drivers/pci/pci-sysfs.c | 2 +-
>  drivers/pci/pci.c       | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

Squashed together and applied to pci/misc for v5.10, thanks!
