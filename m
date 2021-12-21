Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BD47C330
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 16:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhLUPlU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 21 Dec 2021 10:41:20 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44117 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhLUPlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 10:41:19 -0500
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A3DC06000B;
        Tue, 21 Dec 2021 15:41:15 +0000 (UTC)
Date:   Tue, 21 Dec 2021 16:41:14 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] PCI: pci-bridge-emul: Rename
 PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
Message-ID: <20211221164114.0686f462@windsurf>
In-Reply-To: <20211221141455.30011-4-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
        <20211221141455.30011-4-pali@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Dec 2021 15:14:47 +0100
Pali Rohár <pali@kernel.org> wrote:

>  enum {
> -	PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR = BIT(0),
> +	PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD = BIT(0),
>  };

Documenting the flag here would be useful IMO, just copy/paste what you
have in your commit log. Can be done later, of course.

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com


