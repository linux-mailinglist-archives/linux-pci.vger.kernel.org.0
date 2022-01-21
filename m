Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0722449613D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351099AbiAUOkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:40:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33310 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351094AbiAUOkM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:40:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B41BB81E6A
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0014CC340E1;
        Fri, 21 Jan 2022 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642776010;
        bh=qopPS3G5h7BDHxwbw9JU5CqUcVjHHYyVwjwMZuOFq2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSLd6cnzduO7xgw5YzH3M88vO8mNAFwrauVmNuUr/fMoB/GAWADt3ICveDFVcZb35
         hmCKnL8++o7nO3MVfRUbLLEALidfEDu38sSCnPn+RYy+A6SWH6lMKuNHkIihDgxEXP
         OgOndKKUNcG7BAoKJ0flZKTwOfGTYoR+uoK0FPCje2oo3Ug/zKHfJzcqzd7Zi0xx8S
         oak+rxiyhsOa2yPkrtt9d+3r5vpNXfY4Tn/gS/2zpRMknyeTyZAi5qRH8laBG+LfAm
         argzeICDswtZKuNhzBxn8oMinLp54PfsqUYN4Q11SLRbLWS4ijnC/JXsbK7xzRVJ4t
         Wj8pKbVbdWPtA==
Received: by pali.im (Postfix)
        id 80221857; Fri, 21 Jan 2022 15:40:07 +0100 (CET)
Date:   Fri, 21 Jan 2022 15:40:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/4] Support for PCI_FILL_DRIVER
Message-ID: <20220121144007.rmocpkiy32slhbzb@pali>
References: <20220121140351.27382-1-pali@kernel.org>
 <mj+md-20220121.143128.15575.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20220121.143128.15575.nikam@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 January 2022 15:31:42 Martin Mareš wrote:
> Hello!
> 
> > Both procfs and sysfs provides information about used PCI driver.
> > Add support for a new libpci string property PCI_FILL_DRIVER, fill it in
> > both procfs ans sysfs provides and use it in lspci instead of lspci own
> > sysfs code for retrieving driver.
> 
> Is there any meaningful difference in the reported data?

Reported data are exactly same. Just with this change lspci can report
driver also for non-sysfs backend (e.g. procfs backend or new WIP win32
backend).

Basically sysfs logic from lspci executable was moved into the libpci
library and therefore now it is available also for other applications.


So difference for -A linux-proc is following:

Without this patch series:
./lspci -A linux-proc -s 00:02.0 -v
00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA controller])
        Subsystem: Dell 4th Gen Core Processor Integrated Graphics Controller
        Flags: bus master, fast devsel, latency 0, IRQ 33
        Memory at f5800000 (64-bit, non-prefetchable) [size=4M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at f000 [size=64]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: <access denied>

And with this patch series:
./lspci -A linux-proc -s 00:02.0 -v
00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA controller])
        Subsystem: Dell 4th Gen Core Processor Integrated Graphics Controller
        Flags: bus master, fast devsel, latency 0, IRQ 33
        Memory at f5800000 (64-bit, non-prefetchable) [size=4M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at f000 [size=64]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: i915
