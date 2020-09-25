Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E962784A3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIYKAY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 25 Sep 2020 06:00:24 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35398 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgIYKAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 06:00:23 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 902B13B0D6E;
        Fri, 25 Sep 2020 09:51:44 +0000 (UTC)
X-Originating-IP: 86.206.245.199
Received: from windsurf.hq.k.grp (lfbn-tou-1-420-199.w86-206.abo.wanadoo.fr [86.206.245.199])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EE9C8240016;
        Fri, 25 Sep 2020 09:51:20 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:51:20 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add me as a reviewer for PCI aardvark
Message-ID: <20200925115120.40977e7b@windsurf.hq.k.grp>
In-Reply-To: <20200925092115.16546-1-pali@kernel.org>
References: <20200925092115.16546-1-pali@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Pali,

On Fri, 25 Sep 2020 11:21:15 +0200
Pali Rohár <pali@kernel.org> wrote:

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> I have provided more fixes to this driver, I have needed functional
> specification for this PCI controller and also hardware for testing
> and developing (Espressobin V5 and Turris MOX B and G modules).
> 
> Thomas already wrote [1] that is less involved in this driver, so I
> can help with reviewing/maintaining it.
> 
> [1] - https://lore.kernel.org/linux-pci/20200513135643.478ffbda@windsurf.home/

Acked-by: Thomas Petazzzoni <thomas.petazzoni@bootlin.com>

I would certainly be fine if you were OK to switch from a R: to a M: line.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
