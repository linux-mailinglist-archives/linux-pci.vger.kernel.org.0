Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AE722C6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfGWXHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 19:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfGWXHD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 19:07:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0CD2238C;
        Tue, 23 Jul 2019 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563923223;
        bh=pp3VeEKDhtsJD2D+h2rq5js+joCttLYr+igNbqENd4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7W+2qpIRb1joAjtfWlNBJt/KSOtXyWnBvuA8+0Q7F1Oq+WLZRZP8dK4gGOVmPlYj
         abs7IEOWcH4Z/ohf4Ne+Wi6o8APJuPEs+F/ubqOSUpXTVC8MvfW6gCqj7NztM9C57u
         aoJqKu6PGegI5vf3zrlMe5SIJYnJEOa1dL68TZJw=
Date:   Tue, 23 Jul 2019 18:07:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 00/11] PCI: Move symbols to drivers/pci/pci.h
Message-ID: <20190723230701.GA47047@google.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 04:23:30PM -0600, Kelsey Skunberg wrote:
> Move symbols defined in include/linux/pci.h that are only used in
> drivers/pci/ to drivers/pci/pci.h.
> 
> Symbols only used in drivers/pci/ do not need to be visible to the rest of
> the kernel.
> 
> Kelsey Skunberg (11):
>   PCI: Move #define PCI_PM_* lines to drivers/pci/pci.h
>   PCI: Move PME declarations to drivers/pci/pci.h
>   PCI: Move *_host_bridge_device() declarations to drivers/pci.pci.h
>   PCI: Move PCI Virtual Channel declarations to drivers/pci/pci.h
>   PCI: Move pci_hotplug_*_size declarations to drivers/pci/pci.h
>   PCI: Move pci_bus_* declarations to drivers/pci/pci.h
>   PCI: Move pcie_update_link_speed() to drivers/pci/pci.h
>   PCI: Move pci_ats_init() to drivers/pci/pci.h
>   PCI: Move ECRC declarations to drivers/pci/pci.h
>   PCI: Move PTM declaration to drivers/pci/pci.h
>   PCI: Move pci_*_node() declarations to drivers/pci/pci.h
> 
>  drivers/pci/pci.h   | 48 ++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/pci.h | 47 --------------------------------------------
>  2 files changed, 45 insertions(+), 50 deletions(-)

Hi Kelsey,

I didn't get these applied before v5.3-rc1, so now they don't apply
cleanly.  Would you mind refreshing them and posting a v2 that does
apply to my "master" branch (v5.3-rc1)?

Bjorn
