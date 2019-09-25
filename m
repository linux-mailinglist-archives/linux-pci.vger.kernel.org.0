Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9DBDE11
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405286AbfIYMcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 08:32:04 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50877 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405285AbfIYMcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2019 08:32:04 -0400
X-Originating-IP: 86.250.200.211
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 971A7FF80C;
        Wed, 25 Sep 2019 12:32:01 +0000 (UTC)
Date:   Wed, 25 Sep 2019 14:32:00 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Use LTSSM state to build link
 training flag
Message-ID: <20190925143200.696af4cf@windsurf>
In-Reply-To: <20190522213351.21366-3-repk@triplefau.lt>
References: <20190522213351.21366-3-repk@triplefau.lt>
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

On Wed, 22 May 2019 23:33:51 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> Aardvark's PCI_EXP_LNKSTA_LT flag in its link status register is not
> implemented and does not reflect the actual link training state (the
> flag is always set to 0). In order to support link re-training feature
> this flag has to be emulated. The Link Training and Status State
> Machine (LTSSM) flag in Aardvark LMI config register could be used as
> a link training indicator. Indeed if the LTSSM is in L0 or upper state
> then link training has completed (see [1]).
> 
> Unfortunately because after asking a link retraining it takes a while
> for the LTSSM state to become less than 0x10 (due to L0s to recovery
> state transition delays), LTSSM can still be in L0 while link training
> has not finished yet. So this waits for link to be in recovery or lesser
> state before returning after asking for a link retrain.
> 
> [1] "PCI Express Base Specification", REV. 4.0
>     PCI Express, February 19 2014, Table 4-14
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Here as well, sorry for the very long delay, and many thanks for the
great research work, including the arm-trusted-firmware fix. I reviewed
the implementation, and tested on my Armada 3720 DB board with a E1000E
NIC, and it all looks good to me.

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
