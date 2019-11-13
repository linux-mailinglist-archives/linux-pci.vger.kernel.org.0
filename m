Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5FFB1B7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKMNts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 08:49:48 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:58103 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbfKMNts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 08:49:48 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUt1c-00023o-CE; Wed, 13 Nov 2019 14:49:36 +0100
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: add MSI capability
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 14:58:57 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <andrew.murray@arm.com>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, <james.quinlan@broadcom.com>,
        <mbrugger@suse.com>, <phil@raspberrypi.org>,
        <jeremy.linton@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20191112155926.16476-6-nsaenzjulienne@suse.de>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-6-nsaenzjulienne@suse.de>
Message-ID: <d8cae6625265f95441019e33129febcd@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: nsaenzjulienne@suse.de, andrew.murray@arm.com, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, eric@anholt.net, wahrenst@gmx.net, james.quinlan@broadcom.com, mbrugger@suse.com, phil@raspberrypi.org, jeremy.linton@arm.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-11-12 17:08, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
>
> This commit adds MSI to the Broadcom STB PCIe host controller. It 
> does
> not add MSIX since that functionality is not in the HW.  The MSI
> controller is physically located within the PCIe block, however, 
> there
> is no reason why the MSI controller could not be moved elsewhere in
> the future.
>
> Since the internal Brcmstb MSI controller is intertwined with the 
> PCIe
> controller, it is not its own platform device but rather part of the
> PCIe platform device.
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
