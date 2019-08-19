Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A05922E8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 13:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHSL6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 07:58:45 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54143 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSL6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 07:58:45 -0400
X-Originating-IP: 90.30.228.116
Received: from windsurf.home (atoulouse-659-1-185-116.w90-30.abo.wanadoo.fr [90.30.228.116])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EB5ACC0003;
        Mon, 19 Aug 2019 11:58:40 +0000 (UTC)
Date:   Mon, 19 Aug 2019 13:58:39 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix misspelled words.
Message-ID: <20190819135839.1d3a8ca7@windsurf.home>
In-Reply-To: <20190819115306.27338-1-kw@linux.com>
References: <20190819115306.27338-1-kw@linux.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Aug 2019 13:53:06 +0200
Krzysztof Wilczynski <kw@linux.com> wrote:

> Fix misspelled words in include/linux/pci.h, drivers/pci/Kconfig,
> and in the documentation for Freescale i.MX6 and Marvell Armada 7K/8K
> PCIe interfaces.  No functional change intended.
> 
> Related commit 96291d565550 ("PCI: Fix typos and whitespace errors").
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 2 +-
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt   | 2 +-

For pci-armada8k.txt:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
