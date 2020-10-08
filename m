Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA0287215
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgJHJ6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 05:58:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgJHJ6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Oct 2020 05:58:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5E1DAC82;
        Thu,  8 Oct 2020 09:58:52 +0000 (UTC)
Message-ID: <2caab0c666fe3ccf5e3247a1f1a78fd8f55a36b8.camel@suse.de>
Subject: Re: [PATCH v1] PCI: brcmstb: fix error return paths in probe()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 08 Oct 2020 11:58:51 +0200
In-Reply-To: <20201001151821.27575-1-james.quinlan@broadcom.com>
References: <20201001151821.27575-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-10-01 at 11:18 -0400, Jim Quinlan wrote:
> Fixes two cases where we were returning without calling
> clk_disable_unprepare().  Although there is a common place to go on probe()
> errors (the 'fail' label), one can only jump there after executing
> brcm_pcie_setup(), so we have to add clk_disable_unprepare() calls to the
> two error paths.
> 
> Fixes: b98f52bc6495 ("PCI: brcmstb: Add control of rescal reset")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!


