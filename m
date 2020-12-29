Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3A2E7440
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 22:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgL2VWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Dec 2020 16:22:51 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:58849 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL2VWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2020 16:22:51 -0500
Received: from windsurf (unknown [91.174.235.35])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D3861240002;
        Tue, 29 Dec 2020 21:22:06 +0000 (UTC)
Date:   Tue, 29 Dec 2020 22:22:05 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, mparab@cadence.com,
        pthombar@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v6 1/2] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Message-ID: <20201229222205.576549d1@windsurf>
In-Reply-To: <20201228140510.14641-2-nadeem@cadence.com>
References: <20201228140510.14641-1-nadeem@cadence.com>
        <20201228140510.14641-2-nadeem@cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

The commit title is incorrect, it doesn't match what the patch is doing.

On Mon, 28 Dec 2020 15:05:09 +0100
Nadeem Athani <nadeem@cadence.com> wrote:

> Moving the function above to remove compilation error.
> No changes in function.

Which compilation error? I guess there is no compilation error, except
after your apply your PATCH 2/2. Is this correct ?

If so, this should be explained in this commit log: "Move the function
cdns_pcie_host_wait_for_link() further up in the file, as it's going to
be used by upcoming additional code in the driver."

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
