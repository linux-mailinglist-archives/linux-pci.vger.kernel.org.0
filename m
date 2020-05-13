Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6F1D18A8
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbgEMPFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 11:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbgEMPFV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 11:05:21 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB5B205ED;
        Wed, 13 May 2020 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589382321;
        bh=fYO8JH34C0Fa8TeL6MWg6T7hkyBbRx2lT9T57V5nNEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0tKUfYB77rF36GhX7vkFhCKsL4lNCdQvDfludtEaZw7LsyojeBSDDENwYvHu/81/s
         EB6koZK9gpStML0lzTQBXWljUMfwvQ4eXMASGhivk55joAMwLjTNoCK+ucFP1k3ZJq
         bqUI7wU4B2/1GPj9/BMcti5tWT0+/tLj8eYP3WGo=
Date:   Wed, 13 May 2020 10:05:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v9 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200513150518.GA321047@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08C2301A-7349-4044-80F4-0B0520780DB9@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 13, 2020 at 09:20:08AM +0800, Jiaxun Yang wrote:
> 于 2020年5月13日 GMT+08:00 上午2:06:02, Bjorn Helgaas <helgaas@kernel.org> 写到:
> >On Tue, May 12, 2020 at 03:43:56PM +0800, Jiaxun Yang wrote:
> >> This controller can be found on Loongson-2K SoC, Loongson-3
> >> systems with RS780E/LS7A PCH.
> >> 
> >> The RS780E part of code was previously located at
> >> arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> >> driver implementation.
> >> 
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >
> >> +static void system_bus_quirk(struct pci_dev *pdev)
> >> +{
> >> +	u16 tmp;
> >> +
> >> +	/* 
> >> +	 * These devices are not sharing resouces with rest of devices
> >> +	 * on host bus and firmware will ensure their BARs are placed
> >> +	 * in safe ranges. Also there might be some config registers
> >> +	 * in their config space so kernel shouldn't ignore them.
> >
> >"Firmware ensuring BARs are placed in 'safe' ranges" is not a
> >sufficient answer.  As I said before, Linux needs to know both the
> >ADDRESS and the SIZE of whatever non-standard BARs these are.
> >Otherwise, we're liable to assign that space to a different device.
> 
> The address assigned to these devices will never be a part of resources
> belongs to the host bridge. That's enforced by hardware and firmware,
> so address conflict would never happen.
> 
> I'm doing like this to ensure kernel will discover this device but do nothing
> about assignment of resources to it.

OK, that's really ugly, but I guess we can't do anything about it.  It
would be helpful to make the comment say something like:

  The address space consumed by these devices is outside the resources
  of the host bridge.

Side note: in ACPI systems, the ACPI namespace is supposed to describe
all resources consumed by all devices.  Does DT have a similar
expectation?  Is there something in DT that tells us about the address
space used by these devices?  Even if that space never overlaps with
the PCI host bridge apertures, it might be useful to show the space in
/proc/iomem and similar places.

Bjorn
