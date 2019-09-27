Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D976EC0143
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfI0IeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 04:34:23 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47353 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfI0IeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 04:34:23 -0400
X-Originating-IP: 86.250.200.211
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9C4DA24000C;
        Fri, 27 Sep 2019 08:34:21 +0000 (UTC)
Date:   Fri, 27 Sep 2019 10:34:20 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Don't rely on jiffies while holding
 spinlock
Message-ID: <20190927103420.48bb9335@windsurf>
In-Reply-To: <20190927083142.8571-1-repk@triplefau.lt>
References: <20190927083142.8571-1-repk@triplefau.lt>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Remi,

Thanks for the new iteration!

On Fri, 27 Sep 2019 10:31:42 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index fc0fe4d4de49..ee05ccb2b686 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -175,7 +175,8 @@
>  	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
>  	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
>  
> -#define PIO_TIMEOUT_MS			1
> +#define PIO_RETRY_CNT			10
> +#define PIO_RETRY_DELAY			2 /* 2 us*/

So this changes the timeout from 1ms to just 20us, a division by 50
from the previous timeout value. From my measurements, it could
sometime take up to 6us from a single PIO read operation to complete,
which is getting close to the 20us timeout.

Shouldn't PIO_RETRY_CNT be kept at 500, so that we keep using a 1ms
timeout ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
