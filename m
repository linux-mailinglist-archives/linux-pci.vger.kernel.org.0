Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2A1E675F
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404969AbgE1Q0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 12:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404861AbgE1Q0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 12:26:07 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580F32071A;
        Thu, 28 May 2020 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590683166;
        bh=s5WtZilSKS4X6kw5tJ9m1befitlJa6Gd3ymV9rp2Huo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QJ8XwJziej2LVUH3WGmExbcLGJl66V+bX+uVnDH7P08JF42paigOFM8rFHZymUes8
         IHKwzmDEnBGG4wlvSWEFsI9d+qvslFg02fFP7W+BNVE3Bxnee4X13xHBaNMztvYfti
         GccBKAoioIeSuSU5Kjbi583P4iRXW7xzHDUh08Fw=
Date:   Thu, 28 May 2020 11:26:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200528162604.GA323482@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528143141.29956-1-pali@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 28, 2020 at 04:31:41PM +0200, Pali Rohár wrote:
> When there is no PCIe card connected and advk_pcie_rd_conf() or
> advk_pcie_wr_conf() is called for PCI bus which doesn't belong to emulated
> root bridge, the aardvark driver throws the following error message:
> 
>   advk-pcie d0070000.pcie: config read/write timed out
> 
> Obviously accessing PCIe registers of disconnected card is not possible.
> 
> Extend check in advk_pcie_valid_device() function for validating
> availability of PCIe bus. If PCIe link is down, then the device is marked
> as Not Found and the driver does not try to access these registers.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 90ff291c24f0..53a4cfd7d377 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -644,6 +644,9 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
>  	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
>  		return false;
>  
> +	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
> +		return false;

I don't think this is the right fix.  This makes it racy because the
link may go down after we call advk_pcie_valid_device() but before we
perform the config read.

I have no objection to removing the "config read/write timed out"
message.  The "return PCIBIOS_SET_FAILED" in the read case probably
should be augmented by setting "*val = 0xffffffff".

>  	return true;
>  }
>  
> -- 
> 2.20.1
> 
