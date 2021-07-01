Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3143B943D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhGAPtR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 11:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhGAPtL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 11:49:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2BFF6140D;
        Thu,  1 Jul 2021 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625154401;
        bh=Fo6AvVX0T+1xIewne53jQHZgRx7ColYBFIZLicuS57E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HLfERLO+ag2XpeEdUQ3c+67U2cFQRMS900ys8JFNdarrsvJMkfbNx2hew1hwq+a9A
         gvNqINLoD7TLBOUYlCcWGsC1q03yev55tPj+Gd3ddWdMLfKLCMHrr8f7qLaIlO6QfJ
         LogsYURus7JMnPZxrijhTaktRpMR1HaZF+prKYL5a2q4LNhr0XEiF7HDvdyVKxMIr3
         Jn3TyNcwVME3djp1Wg6MtTGksBVjwZqg8Ibo1Dnw91c6yZNr/JOxunZ6Q46uacDnsu
         fJbdJ9/0kztzOtEWnYuLncgmAAkCE9Mb8EFuzG5M4IjHAvz7dvgEuM7Is0rKZmcQ7F
         CWTraAM9A83Gg==
Date:   Thu, 1 Jul 2021 10:46:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     narmstrong@baylibre.com, yue.wang@Amlogic.com,
        khilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
Message-ID: <20210701154634.GA60743@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619063952.2008746-1-art@khadas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Huacai]

On Sat, Jun 19, 2021 at 02:39:48PM +0800, Artem Lapkin wrote:
> Replace dublicated MRRS limit quirks by mrrs_limit_quirk from core
> * drivers/pci/controller/dwc/pci-keystone.c
> * drivers/pci/controller/pci-loongson.c

s/dublicated/duplicated/ (several occurrences)

Capitalize subject lines.

Use "git log --online" to learn conventions and follow them.

Add "()" after function names.

Capitalize acronyms appropriately (NVMe, MRRS, PCI, etc).

End sentences with periods.

A "move" patch must include both the removal and the addition and make
no changes to the code itself.

Amlogic appears without explanation in 2/4.  Must be separate patch to
address only that specific issue.  Should reference published erratum
if possible.  "Solves some issue" is not a compelling justification.

The tree must be consistent and functionally the same or improved
after every patch.

Add to pci_ids.h only if symbol used more than one place.

See
https://lore.kernel.org/r/20210701074458.1809532-3-chenhuacai@loongson.cn,
which looks similar.  Combine efforts if possible and cc Huacai so
you're both aware of overlapping work.

More hints in case they're useful:
https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

> Both ks_pcie_quirk loongson_mrrs_quirk was rewritten without any
> functionality changes by one mrrs_limit_quirk
> 
> Added DesignWare PCI controller which need same quirk for
> * drivers/pci/controller/dwc/pci-meson.c (PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3)
> 
> This quirk can solve some issue for Khadas VIM3/VIM3L(Amlogic)
> with HDMI scrambled picture and nvme devices at intensive writing...
> 
> come from:
> * https://lore.kernel.org/linux-pci/20210618063821.1383357-1-art@khadas.com/
> 
> Artem Lapkin (4):
>  PCI: move Keystone and Loongson device IDs to pci_ids
>  PCI: core: quirks: add mrrs_limit_quirk
>  PCI: keystone move mrrs quirk to core
>  PCI: loongson move mrrs quirk to core
> 
> -- 
> 2.25.1
> 
