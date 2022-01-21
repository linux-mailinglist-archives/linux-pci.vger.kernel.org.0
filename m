Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E76549613F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351130AbiAUOkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:40:52 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:58344 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231265AbiAUOku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:40:50 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id 36E8F40088
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:40:49 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 2E45A2802E6; Fri, 21 Jan 2022 15:40:49 +0100 (CET)
Date:   Fri, 21 Jan 2022 15:40:49 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/5] libpci: generic: Implement SUBSYS also for
 PCI_HEADER_TYPE_BRIDGE
Message-ID: <mj+md-20220121.144016.17855.nikam@ucw.cz>
References: <20220121135718.27172-1-pali@kernel.org>
 <20220121135718.27172-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121135718.27172-4-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> +        case PCI_HEADER_TYPE_BRIDGE:
> +          if (pci_read_word(d, PCI_STATUS) & PCI_STATUS_CAP_LIST)
> +            {
> +              byte been_there[256];
> +              int where, id;
> +
> +              memset(been_there, 0, 256);
> +              where = pci_read_byte(d, PCI_CAPABILITY_LIST) & ~3;
> +              while (where && !been_there[where]++)

Please don't. There should be a single implementation of capability list
walking in libpci, not everybody doing his own.

				Martin
