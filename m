Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD757496138
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiAUOjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:39:10 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:58212 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231265AbiAUOjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:39:10 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jan 2022 09:39:10 EST
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id 3CCCB40085
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:31:42 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 3150F2802E6; Fri, 21 Jan 2022 15:31:42 +0100 (CET)
Date:   Fri, 21 Jan 2022 15:31:42 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/4] Support for PCI_FILL_DRIVER
Message-ID: <mj+md-20220121.143128.15575.nikam@ucw.cz>
References: <20220121140351.27382-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121140351.27382-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Both procfs and sysfs provides information about used PCI driver.
> Add support for a new libpci string property PCI_FILL_DRIVER, fill it in
> both procfs ans sysfs provides and use it in lspci instead of lspci own
> sysfs code for retrieving driver.

Is there any meaningful difference in the reported data?

				Martin
