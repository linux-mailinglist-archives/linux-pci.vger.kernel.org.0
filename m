Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6155147C327
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhLUPj4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 21 Dec 2021 10:39:56 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60259 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhLUPj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 10:39:56 -0500
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B7BC8FF802;
        Tue, 21 Dec 2021 15:39:52 +0000 (UTC)
Date:   Tue, 21 Dec 2021 16:39:51 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] PCI: pci-bridge-emul: Make struct
 pci_bridge_emul_ops as const
Message-ID: <20211221163951.4070877f@windsurf>
In-Reply-To: <20211221141455.30011-3-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
        <20211221141455.30011-3-pali@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Dec 2021 15:14:46 +0100
Pali Rohár <pali@kernel.org> wrote:

> It is read-only constant structure, so properly mark it with const keyword.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
