Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B732E7DEC
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 05:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgLaEIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 23:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaEIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 23:08:18 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21BDC061573;
        Wed, 30 Dec 2020 20:07:37 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D98FB2800B3D7;
        Thu, 31 Dec 2020 05:07:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CFA4D40DBA; Thu, 31 Dec 2020 05:07:35 +0100 (CET)
Date:   Thu, 31 Dec 2020 05:07:35 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
Message-ID: <20201231040735.GA2075@wunner.de>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
 <9ca0fb46-9e65-31e2-103f-1c98ce8362c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca0fb46-9e65-31e2-103f-1c98ce8362c7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 30, 2020 at 11:56:04PM +0100, Heiner Kallweit wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3024,7 +3024,9 @@ void pci_pm_init(struct pci_dev *dev)
>  	u16 status;
>  	u16 pmc;
>  
> -	pm_runtime_forbid(&dev->dev);
> +	if (pci_acpi_forbid_runtime_pm())
> +		pm_runtime_forbid(&dev->dev);
> +

Generic PCI code usually does not call ACPI-specific functions directly,
but rather through a pci_platform_pm_ops callback.

FWIW, if platform_pci_power_manageable() returns true, it can probably
be assumed that allowing runtime PM by default is okay.  So as a first
step, you may want to call that instead of adding a new callback.

Thanks,

Lukas
