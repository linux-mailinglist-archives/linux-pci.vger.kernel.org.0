Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D50FA037F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfH1Nja convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 28 Aug 2019 09:39:30 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53103 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfH1Nja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:39:30 -0400
X-Originating-IP: 90.30.228.116
Received: from windsurf.home (atoulouse-659-1-185-116.w90-30.abo.wanadoo.fr [90.30.228.116])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E361220009;
        Wed, 28 Aug 2019 13:39:27 +0000 (UTC)
Date:   Wed, 28 Aug 2019 15:39:26 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Move static keyword to the front of
 declarations in pci-bridge-emul.c
Message-ID: <20190828153926.1d8d9d7b@windsurf.home>
In-Reply-To: <20190828131733.5817-1-kw@linux.com>
References: <20190826151436.4672-1-kw@linux.com>
        <20190828131733.5817-1-kw@linux.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Wed, 28 Aug 2019 15:17:33 +0200
Krzysztof Wilczynski <kw@linux.com> wrote:

> Move the static keyword to the front of declarations of
> pci_regs_behavior and pcie_cap_regs_behavior, and resolve
> the following compiler warning that can be seen when
> building with warnings enabled (W=1):
> 
> drivers/pci/pci-bridge-emul.c:41:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>  const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
>  ^
> drivers/pci/pci-bridge-emul.c:176:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>  const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
>  ^
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
