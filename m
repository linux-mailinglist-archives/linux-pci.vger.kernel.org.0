Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828B83EC162
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhHNIZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 04:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237401AbhHNIZV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Aug 2021 04:25:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1FF160EE2;
        Sat, 14 Aug 2021 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628929493;
        bh=Cfglcap9UZcx9wX6xKYoZqz19Fj5k5vI6Kkv/t63bcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFOl3ekhuAWp//OuaV7Ll1WAiurWd9WCi2VYoaNzWtTerRyFrPYyvFKh0mXhMqqKv
         UbvZ52LqOa1k+6pLuJZY+tzTtGxQiLlaWMcIydv/JrYNuHvTdxzhXZfFAAuG0asx6r
         w1loc7s7qITMXX2Sp4zG5E3jUXZl1R9Gr76mbjPA=
Date:   Sat, 14 Aug 2021 10:24:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mchehab+huawei@kernel.org,
        Jonathan.Cameron@huawei.com, leon@kernel.org,
        schnelle@linux.ibm.com, bilbao@vt.edu, luzmaximilian@gmail.com,
        linuxarm@huawei.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] PCI/MSI: Clarify the irq sysfs ABI for PCI devices
Message-ID: <YRd90p6Kcxpq6cbp@kroah.com>
References: <20210813122650.25764-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813122650.25764-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 14, 2021 at 12:26:50AM +1200, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> /sys/bus/pci/devices/.../irq has been there for many years but it has never
> been documented. This patch is trying to document it. Plus, irq ABI is very
> confusing at this moment especially for MSI and MSI-x cases. MSI sets irq
> to the first number in the vector, but MSI-X does nothing for this though
> it saves default_irq in msix_setup_entries(). Weird the saved default_irq
> for MSI-X is never used in pci_msix_shutdown(), which is quite different
> with pci_msi_shutdown(). Thus, this patch also moves to show the first IRQ
> number which is from the first msi_entry for MSI-X. Hopefully, this can
> make irq ABI more clear and more consistent.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 8 ++++++++
>  drivers/pci/msi.c                       | 6 ++++++
>  2 files changed, 14 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
