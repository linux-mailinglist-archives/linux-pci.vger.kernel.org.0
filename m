Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC94961EB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381525AbiAUPVV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381509AbiAUPVS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:21:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF4C06173D
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 07:21:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9416D61961
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD09C340E1;
        Fri, 21 Jan 2022 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642778477;
        bh=6y7BgOC5yrqDZ5OM1c3HwDUbY09C+oV3gU5eV3jGErY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRLPDGYBidvzuBeLhCVq4T0OlzbmQtuWfHw5TU6qnxHEqna7lJrsOayhCEebXLYIp
         o/q500OvwlazXd02ctmVDhd7NNbu/nZnoQOxsI7ya85mi8OKJqUEltWyVMdTeXcFSz
         mZmMhwrOHnpX24iHINWZoNYY4lbZeEuHOEP8hILF9NXWQ8twC+qd3jgH4crlnxBmWy
         2NH2KjrTbrXU6oQGRtNKj+8q8YddeCvPSOFwQb4HhC8X/7qiuiKMRNelrVM3c3zW5R
         VaEwZIPxPu+y5pjFYakFPfDQCXSyf1IMIeEg7Up9Go7h5/qwcHH3v2nZo7s7g29mra
         MjEAEHLaY41Gg==
Received: by pali.im (Postfix)
        id 6631A857; Fri, 21 Jan 2022 16:21:14 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:21:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/4] Support for PCI_FILL_PARENT
Message-ID: <20220121152114.babpdii63tmhmfbn@pali>
References: <20220121142258.28170-1-pali@kernel.org>
 <mj+md-20220121.144900.19875.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20220121.144900.19875.nikam@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 January 2022 15:51:34 Martin Mareš wrote:
> Hello!
> 
> > Extend libpci API with a new option PCI_FILL_PARENT to fill parent
> > device for the current enumerated device. This can be useful in
> > situation when non-complaint PCI-to-PCI bridge-like device with Type 0
> > header is present in the system and behind this bridge are either
> > endpoint devices or another non-compliant bridges. This applies e.g.
> > for notoriously broken Galileo and Marvell PCI and PCIe devices.
> > lspci can will use PCI_FILL_PARENT information from the system if
> > config space does not provide enough information to build topology.
> 
> Looks reasonable, but please put a better explanation in pci.h
> (in particular, mention that this is not guaranteed to be available).

Ok!

> When reading the implementation in the sysfs backend, I wonder how you
> can guarantee that at the moment of parsing the child device, the parent
> device is already known to libpci.

All devices are parsed in sysfs_scan() function. And additional
information, including this "parent" is filled in sysfs_fill_info()
function. sysfs_scan() itself does not call sysfs_fill_info().

So prior calling pci_fill_info() it is required to call pci_scan_bus()
to have ->parent member filled.
