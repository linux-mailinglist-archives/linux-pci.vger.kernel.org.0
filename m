Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAE49568C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 00:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbiATXAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 18:00:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50110 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiATXAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 18:00:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A03A61926;
        Thu, 20 Jan 2022 23:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4629CC340E0;
        Thu, 20 Jan 2022 23:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642719652;
        bh=yrxtLQYE3Yeaemcy819dMJ8llPOZboFgoHhGTaIxnLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Hg/Hvy8fdbrtcd1LKqYf0scpfbBmxrOl+9Gl9E23kTIus26WLT2137a/+eknF6gwq
         77RadoqmjIqQhfTCrFqUqZWy9U7FB1NGPiFB0ldvBXQgA7yXP/AgGH37pz6hxsM6/B
         /kBpxVgpxSXHQ0z9uUbPIqJtS2ILMs9Dv13BlqQ0IF/zFDI3DsSV3sqG/eR8Bi5e1g
         tA0bQ1nSHwpjsqkHel9nUN12nPAAI1OOYCjUKJ9NhF9Jn2fL1lqYspP9BMktRNF59n
         tZDec5BHTV4FxLu8zOyF4rXg8N3pe7+ATEPfX4QkMJvVkpx6Cb/KyTzBzfm2kTOHnE
         l62qK7hKdiTdg==
Date:   Thu, 20 Jan 2022 17:00:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
Message-ID: <20220120230050.GA1077958@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3eebg9puj.fsf@t19.piap.pl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 30, 2021 at 10:18:44AM +0200, Krzysztof Hałasa wrote:
> Pali, et al,
> 
> I'm encountering a problem booting an i.MX6-based device (Gateworks
> Ventana SBC). This is apparently a known issue:
> https://lkml.org/lkml/2020/7/16/388
> 
> Do you guys know of a fix for this? Booting this machine reliably is
> lately impossible.

Hi Krzysztof, is this still an issue?

e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute") and
similar patches appeared in v5.13, and they should resolve things like
this:

  sysfs: cannot create duplicate filename '/devices/platform/soc/d0070000.pcie/pci0000:00/0000:00:00.0/config'

But your report is different because it looks like we have a problem
when creating a *directory*:

> sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/0000:e0'

and then it seems that we corrupted a pointer:

> Unable to handle kernel paging request at virtual address 6f736572 (ASCII = "reso")

which is even more worrisome.

Bjorn
