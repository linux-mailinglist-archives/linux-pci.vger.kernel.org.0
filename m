Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AD47F988
	for <lists+linux-pci@lfdr.de>; Mon, 27 Dec 2021 00:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhLZXz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 18:55:56 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:44232 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhLZXzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 18:55:55 -0500
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 95F9B280874; Mon, 27 Dec 2021 00:55:54 +0100 (CET)
Date:   Mon, 27 Dec 2021 00:55:54 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 pciutils] lspci: Show Slot Power Limit values above EFh
Message-ID: <mj+md-20211226.235545.94583.nikam@ucw.cz>
References: <mj+md-20211226.224245.85126.nikam@ucw.cz>
 <20211226233408.21204-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226233408.21204-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

> PCI Express Base Specification rev. 3.0 has the following definition for
> the Slot Power Limit Value:
> 
> =======================================================================
> When the Slot Power Limit Scale field equals 00b (1.0x) and Slot Power
> Limit Value exceeds EFh, the following alternative encodings are used:
>   F0h = 250 W Slot Power Limit
>   F1h = 275 W Slot Power Limit
>   F2h = 300 W Slot Power Limit
>   F3h to FFh = Reserved for Slot Power Limit values above 300 W
> =======================================================================
> 
> Replace function power_limit() by show_power_limit() which also prints
> power limit value. Show reserved value as string ">300W".

Thanks, applied.

					Martin
