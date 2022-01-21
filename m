Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03806496232
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbiAUPiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:38:52 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:60374 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381633AbiAUPiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:38:52 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id 3379840089
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 16:38:51 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 1C4D72802E6; Fri, 21 Jan 2022 16:38:51 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:38:50 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Message-ID: <mj+md-20220121.153534.32322.nikam@ucw.cz>
References: <20220121135718.27172-1-pali@kernel.org>
 <mj+md-20220121.143358.16196.nikam@ucw.cz>
 <20220121151246.3tlf5jdyh6jxeauv@pali>
 <mj+md-20220121.151403.26105.nikam@ucw.cz>
 <20220121152657.xsq5f5u6odsumbwp@pali>
 <mj+md-20220121.152905.30983.nikam@ucw.cz>
 <20220121153504.yhpuztk6fza3sbnm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121153504.yhpuztk6fza3sbnm@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> And in case "class+subclass+prog_if" is available but "revision" is not
> available and even it is not possible to read revision from config space
> (because e.g. due to missing permissions or limitations of win backend)?

I bet that nobody will ever check if reading of something as basic as the
revision ID succeeded. It can never fail on sane systems.

In such cases, just return a default value and log a warning.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
Nothing is smiple enough to be not screwed up.
