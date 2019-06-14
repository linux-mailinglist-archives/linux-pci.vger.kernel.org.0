Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9C45811
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfFNI7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 04:59:07 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33613 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFNI7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 04:59:06 -0400
Received: from windsurf (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C61A6240007;
        Fri, 14 Jun 2019 08:58:55 +0000 (UTC)
Date:   Fri, 14 Jun 2019 10:58:54 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Fix PCI_EXP_RTCTL conf register
 writing
Message-ID: <20190614105854.4c2f270f@windsurf>
In-Reply-To: <20190614064225.24434-1-repk@triplefau.lt>
References: <20190614064225.24434-1-repk@triplefau.lt>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Fri, 14 Jun 2019 08:42:25 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> PCI_EXP_RTCTL is used to activate PME interrupt only, so writing into it
> should not modify other interrupts' mask. The ISR mask polarity was also
> inverted, when PCI_EXP_RTCTL_PMEIE is set PCIE_MSG_PM_PME_MASK mask bit
> should actually be cleared.
> 
> Fixes: 6302bf3ef78d ("PCI: Init PCIe feature bits for managed host bridge alloc")

Are you sure about this Fixes tag ? This commit seems unrelated.

The commit introducing this issue is 8a3ebd8de328301aacbe328650a59253be2ac82c.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
