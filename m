Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166A47F96E
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 23:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhLZWt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 17:49:27 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:60300 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhLZWt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 17:49:26 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Dec 2021 17:49:26 EST
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 08ED6280874; Sun, 26 Dec 2021 23:43:09 +0100 (CET)
Date:   Sun, 26 Dec 2021 23:43:09 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 pciutils] lspci: Show Slot Power Limit values above EFh
Message-ID: <mj+md-20211226.224245.85126.nikam@ucw.cz>
References: <20210403114857.n3h2wr3e3bpdsgnl@pali>
 <20211101144740.14256-1-pali@kernel.org>
 <YYABw84admN1+8Ly@casper.infradead.org>
 <20211124124611.wi6u77pnparg2563@pali>
 <mj+md-20211226.220617.62062.albireo@ucw.cz>
 <20211226224147.19960-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226224147.19960-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +  if (scale == 0 && value >= 0xF0) {
> +    /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
> +    if (value >= 0xF3) {
> +      printf(">300W");
> +      return;
> +    }
> +    value = scale0_values[value - 0xF0];
> +  }

Thanks!

One more request: please fix coding style to match the rest of lspci.

				Martin
