Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41434356F07
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353131AbhDGOmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 10:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353045AbhDGOl7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 10:41:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D365600D4;
        Wed,  7 Apr 2021 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617806509;
        bh=sQHFh64TVuIInYNwwXKFf/wPZwrI2OO0eX/1rT7dwnA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GOtpP6wwRLpJVwjsoZfX6TxMubaD+/GmZcZ1wsS8fNWHfVLbWGEWar03rGKKG1gKE
         ldwR3LUo1JqEMWdbGANLySWVvADYDctLexmbPXXtotNhTLRq0GfKr18rxWT1XQkOX6
         RG+v02o7AO/U0OW7wG2+3zn/wD8aBvIP48mf5F9Hvw7EACucKAXul7eZOBbO+JEdT4
         8dLz+TZ6FS16infnIzYTsMJueOCT/SozQx+9cvDPPNLRyiVhqiolQ9SnJ1+GO1VtqP
         XDdTJft5apdppoR4BSM5tmcIkWIIEFVtwrxPx2LaUZXOS7bMWR4fIjbaI6kJV9WQ7X
         OqQQx04VyMGVA==
Received: by pali.im (Postfix)
        id 84435521; Wed,  7 Apr 2021 16:41:46 +0200 (CEST)
Date:   Wed, 7 Apr 2021 16:41:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20210407144146.rl7x2h5l2cc3escy@pali>
References: <20200716110423.xtfyb3n6tn5ixedh@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200716110423.xtfyb3n6tn5ixedh@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 16 July 2020 13:04:23 Pali Rohár wrote:
> Hello Bjorn!
> 
> I see following error message in dmesg which looks like a race condition:
> 
> sysfs: cannot create duplicate filename '/devices/platform/soc/d0070000.pcie/pci0000:00/0000:00:00.0/config'
> 
> I looked at it deeper and found out that in PCI subsystem code is race
> condition between pci_bus_add_device() and pci_sysfs_init() calls. Both
> of these functions calls pci_create_sysfs_dev_files() and calling this
> function more times for same pci device throws above error message.
> 
> There can be two different race conditions:
> 
> 1. pci_bus_add_device() called pcibios_bus_add_device() or
> pci_fixup_device() but have not called pci_create_sysfs_dev_files() yet.
> Meanwhile pci_sysfs_init() is running and pci_create_sysfs_dev_files()
> was called for newly registered device. In this case function
> pci_create_sysfs_dev_files() is called two times, ones from
> pci_bus_add_device() and once from pci_sysfs_init().
> 
> 2. pci_sysfs_init() is called. It first sets sysfs_initialized to 1
> which unblock calling pci_create_sysfs_dev_files(). Then another bus
> registers new PCI device and calls pci_bus_add_device() which calls
> pci_create_sysfs_dev_files() and registers sysfs files. Function
> pci_sysfs_init() continues execution and calls function
> pci_create_sysfs_dev_files() also for this newly registered device. So
> pci_create_sysfs_dev_files() is again called two times.
> 
> 
> I workaround both race conditions I created following hack patch. After
> applying it I'm not getting that 'sysfs: cannot create duplicate filename'
> error message anymore.

Scratch this hack patch, it contains another new race condition.

The only way how to get rid of this race condition is either to protect
whole "sysfs_initialized" variable by mutex or by completely removing
"sysfs_initialized" variable and therefore also removing function
pci_create_sysfs_dev_files(). I'm for second variant.
