Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FB247F970
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 23:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhLZWuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 17:50:54 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:60616 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhLZWuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 17:50:54 -0500
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 4A0A5280874; Sun, 26 Dec 2021 23:50:53 +0100 (CET)
Date:   Sun, 26 Dec 2021 23:50:53 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 pciutils] libpci: Fix intel_sanity_check() function
Message-ID: <mj+md-20211226.225044.86309.nikam@ucw.cz>
References: <mj+md-20211226.215029.60895.albireo@ucw.cz>
 <20211226224703.20445-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226224703.20445-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

> Function intel_sanity_check() calls conf1_read() which access d->domain
> field. But intel_sanity_check() does not initialize this field and so
> conf1_read() access some random data on stack.
> 
> Tests showed that intel_sanity_check() always fails as in d->domain is
> stored some non-zero number.
> 
> Fix this issue by zeroing struct pci_dev d in intel_sanity_check() as
> sanity check is verifying PCI devices at domain 0.

Thanks, applied.

				Martin
