Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B158F49618D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbiAUOvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 09:51:36 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:58816 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351303AbiAUOvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 09:51:35 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id 4078840085
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 15:51:34 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 3AE712802E6; Fri, 21 Jan 2022 15:51:34 +0100 (CET)
Date:   Fri, 21 Jan 2022 15:51:34 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/4] Support for PCI_FILL_PARENT
Message-ID: <mj+md-20220121.144900.19875.nikam@ucw.cz>
References: <20220121142258.28170-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121142258.28170-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Extend libpci API with a new option PCI_FILL_PARENT to fill parent
> device for the current enumerated device. This can be useful in
> situation when non-complaint PCI-to-PCI bridge-like device with Type 0
> header is present in the system and behind this bridge are either
> endpoint devices or another non-compliant bridges. This applies e.g.
> for notoriously broken Galileo and Marvell PCI and PCIe devices.
> lspci can will use PCI_FILL_PARENT information from the system if
> config space does not provide enough information to build topology.

Looks reasonable, but please put a better explanation in pci.h
(in particular, mention that this is not guaranteed to be available).

When reading the implementation in the sysfs backend, I wonder how you
can guarantee that at the moment of parsing the child device, the parent
device is already known to libpci.

				Martin
