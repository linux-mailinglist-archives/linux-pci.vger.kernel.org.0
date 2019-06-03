Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2824532D87
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFCKHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 06:07:10 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44607 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfFCKHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 06:07:10 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DF79B30001EA2;
        Mon,  3 Jun 2019 12:07:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B1DDD31CF9; Mon,  3 Jun 2019 12:07:07 +0200 (CEST)
Date:   Mon, 3 Jun 2019 12:07:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Create device link for NVIDIA GPU
Message-ID: <20190603100707.yhw4fu54vt3ykvd5@wunner.de>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
 <20190531050109.16211-3-abhsahu@nvidia.com>
 <20190531203908.GA58810@google.com>
 <d0824334-99f2-d42e-3a5e-3bdc4c1c37c8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0824334-99f2-d42e-3a5e-3bdc4c1c37c8@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 03, 2019 at 01:30:51PM +0530, Abhishek Sahu wrote:
> On 6/1/2019 2:09 AM, Bjorn Helgaas wrote:
> > > If there *is* spec language that allows dependencies like this, please
> > include the citation in your commit log.
> 
>  The PCIe specification treats each function separately but GPU case is
>  different. So, it won't be part of PCIe spec. in GPU, the different
>  kind of devices are internally coupled in HW but still needs to be
>  managed by different driver.

GPUs aren't the only devices which have these implicit dependencies.

E.g. Broadcom BCM57765 combines a Gigabit Ethernet chip in function 0
(14e4:16b4) with an SD card reader in function 1 (14e4:16bc) and AFAIK
for the latter to work, the former needs to be in D0.  I think we're
incorrectly not enforcing this dependency in the kernel yet.  That chip
was built into many MacBooks.

Indeed the inability to specify such inter-function power dependencies
in config space seems to be a gaping hole in the PCI spec.  Maybe we
should always assume that function 0 needs to be in D0 for any other
function to work?  Not sure if that would be safe.

Thanks,

Lukas
