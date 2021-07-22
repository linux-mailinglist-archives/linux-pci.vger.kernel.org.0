Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFB3D28C8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhGVP6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 11:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232743AbhGVP6M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 11:58:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4FA9613B9;
        Thu, 22 Jul 2021 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626971927;
        bh=K22sXvT77+U4vZ2hm8O0W74Lzv6RbJaEUTbBahny+ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HDxNhU+V6DtqKv7PeJsAlCxpURgndzXbeq0+ncNCAJ9HtAx4EXS5bzr2jrcn8oPqb
         yzdGl/6wsKu1IjuwuZRZaKRYu8N7r7QfF8EkBrSpx5BwGK1rcWGCRM87XbPBabUA2m
         jgutFvBqPwSeOjL5Vpd/KuzWjRoTqmKyMAT/DmR0UXSn/ai2o2l1AdqU8wvQMONLdW
         2eTV4guMTvdgLKaSKa6BXhe+ux4l1GIgB0f2RfOGqwsYxeMrI9Urb4/hwKMyEGj78z
         iUWJ4FOpqSiC8x31ZHDMm9SHnkB8NWkv4x96v9EkrX59Nv+nHNHQu4qnmxU63KWr45
         Af421fP2LU7jg==
Date:   Thu, 22 Jul 2021 11:38:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: do not ignore link errors
Message-ID: <20210722163845.GA314985@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721171142.GA189373@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 12:11:42PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 21, 2021 at 05:28:21PM +0200, Christian Gmeiner wrote:
> > This fixes long boot delays of about 10 seconds.
> > 
> > I am working on a device powered by an TI am65 SoC where
> > we have a PCIe expansion slot. If there is no PCIe device
> > connected I see boot delays caused by pci_host_probe(..).

Oh, and I forgot to mention: Please follow the convention of
capitalizing the first word of the subject (use "git log --oneline
drivers/pci/controller/dwc/pcie-designware-host.c" to see what the
convention is).

Also, the commit log does not actually say what the patch *does*.
Please include an imperative statement about what it does in the
commit log.  https://chris.beams.io/posts/git-commit/ has good tips.
