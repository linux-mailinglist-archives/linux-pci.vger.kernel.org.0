Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B13A49616D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381342AbiAUOq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:46:26 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:58576 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381402AbiAUOqW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:46:22 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id DE91340088
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:46:20 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id D24072802E6; Fri, 21 Jan 2022 15:46:20 +0100 (CET)
Date:   Fri, 21 Jan 2022 15:46:20 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/4] Support for PCI_FILL_DRIVER
Message-ID: <mj+md-20220121.144118.18107.nikam@ucw.cz>
References: <20220121140351.27382-1-pali@kernel.org>
 <mj+md-20220121.143128.15575.nikam@ucw.cz>
 <20220121144007.rmocpkiy32slhbzb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121144007.rmocpkiy32slhbzb@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Reported data are exactly same. Just with this change lspci can report
> driver also for non-sysfs backend (e.g. procfs backend or new WIP win32
> backend).
> 
> Basically sysfs logic from lspci executable was moved into the libpci
> library and therefore now it is available also for other applications.

I am not convinced that it is right to make something with so vague
semantics a part of libpci API.

The procfs back-end is a pretty weak motivation, because it's long obsolete
and basically I haven't dropped it yet only because it takes more effort
than letting it stay :-)

Now, the win32 back-end could be intersting, but let's make it mergeable
in its basic form first.

				Martin
