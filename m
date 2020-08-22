Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4799324E6B6
	for <lists+linux-pci@lfdr.de>; Sat, 22 Aug 2020 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgHVJi3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Aug 2020 05:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHVJi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Aug 2020 05:38:29 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A5520738;
        Sat, 22 Aug 2020 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598089109;
        bh=oZNt87juyUph93Ar3dAdKT06sYZuhi9gBt4yTFyhVjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dem8q0qAS/gWNFLCDlEZghrJDUCVF2j2Ho4Kp8K7HX+lJdwvOqj+3+6ZIDb7LKi99
         pTlBNQltltZJ6kyioRDDHtBarPL//kZpesEczNKpj8lSnfWfQpD6UdDLHEkE/KrAVG
         7xoBEDBS5Piwqer66i0bZAzXIgrD/0QGInq2UKl8=
Received: by pali.im (Postfix)
        id 9E62C860; Sat, 22 Aug 2020 11:38:26 +0200 (CEST)
Date:   Sat, 22 Aug 2020 11:38:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: Re: [PATCH v2 0/5] PCIe aardvark controller improvements
Message-ID: <20200822093826.7fzchbwpmvdgpqbf@pali>
References: <20200804115747.7078-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804115747.7078-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 04 August 2020 13:57:42 Pali Rohár wrote:
> Hi,
> 
> we have some more improvements for PCIe aardvark controller (Armada 3720
> SOC - EspressoBIN and Turris MOX).
> 
> The main improvement is that with these patches the driver can be compiled
> as a module, and can be reloaded at runtime.
> 
> This series applies on top of Linus' master branch.
> 
> Marek & Pali
> 

Hello! I would like to remind this patch series.

Lorenzo, could you please look at it?

> Changes in V2 for patch 4/5:
> * Protect pci_stop_root_bus() and pci_remove_root_bus() function calls by
>   pci_lock_rescan_remove() and pci_unlock_rescan_remove()
> 
> 
> Pali Rohár (5):
>   PCI: aardvark: Fix compilation on s390
>   PCI: aardvark: Check for errors from pci_bridge_emul_init() call
>   PCI: pci-bridge-emul: Export API functions
>   PCI: aardvark: Implement driver 'remove' function and allow to build
>     it as module
>   PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()
> 
>  drivers/pci/controller/Kconfig        |   2 +-
>  drivers/pci/controller/pci-aardvark.c | 104 ++++++++++++++++----------
>  drivers/pci/pci-bridge-emul.c         |   4 +
>  3 files changed, 71 insertions(+), 39 deletions(-)
> 
> -- 
> 2.20.1
> 
