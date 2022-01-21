Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932BC496210
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381564AbiAUP3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:29:05 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:60120 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381557AbiAUP2s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:28:48 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id A60094008A
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 16:28:45 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 8D1FE2802E6; Fri, 21 Jan 2022 16:28:45 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:28:45 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/4] Support for PCI_FILL_PARENT
Message-ID: <mj+md-20220121.152455.29865.nikam@ucw.cz>
References: <20220121142258.28170-1-pali@kernel.org>
 <mj+md-20220121.144900.19875.nikam@ucw.cz>
 <20220121152114.babpdii63tmhmfbn@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121152114.babpdii63tmhmfbn@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> All devices are parsed in sysfs_scan() function. And additional
> information, including this "parent" is filled in sysfs_fill_info()
> function. sysfs_scan() itself does not call sysfs_fill_info().
> 
> So prior calling pci_fill_info() it is required to call pci_scan_bus()
> to have ->parent member filled.

Ah, OK. My fault.

It's OK then.

			Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
A LISP programmer knows value of everything, but cost of nothing.
