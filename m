Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4A47C335
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhLUPmZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 21 Dec 2021 10:42:25 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35123 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhLUPmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 10:42:24 -0500
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id ADB15FF819;
        Tue, 21 Dec 2021 15:42:21 +0000 (UTC)
Date:   Tue, 21 Dec 2021 16:42:20 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] PCI: pci-bridge-emul: Add support for new flag
 PCI_BRIDGE_EMUL_NO_IO_FORWARD
Message-ID: <20211221164220.33d1589a@windsurf>
In-Reply-To: <20211221141455.30011-5-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
        <20211221141455.30011-5-pali@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Dec 2021 15:14:48 +0100
Pali Rohár <pali@kernel.org> wrote:

> Like PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD, this new flag specifies that
> emulated PCI bridge does not support forwarding of IO requests in given
> range between primary and secondary buses. This flag should be used as
> argument for pci_bridge_emul_init() for hardware setup without IO support.
> 
> Setting this flag cause that IO base and limit registers are read-only.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Looks good. As said on PATCH 03/11, perhaps just a snippet of
documentation in pci-bridge-emul.h to describe the semantic of the new
flag.

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
