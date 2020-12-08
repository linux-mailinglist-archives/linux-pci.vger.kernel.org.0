Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF62D3502
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 22:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLHVL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 16:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLHVL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 16:11:56 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C78C0613CF
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 13:11:16 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3E93822EE4;
        Tue,  8 Dec 2020 22:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607461873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEFjtBVF86/OHAKEUK7w4OIQbvBmdzPeOud2sztujh8=;
        b=FkpapXYkkYDM2Wa6lDGwZbcxVEW5J57qlVbjxNxZm4kOHYNmmsfnqcpb1xD6/p1EX4eQJ4
        R/96LjaUeq7PPPZZows0e9l9dJ7irfcHr0KCnHE2ePf6tsgDCDnLwy5ChY4wJbhJtAIjR/
        4LO2U5+cRQRXidZgmTLDZVXZRW/RDUE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 08 Dec 2020 22:11:11 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, kw@linux.com, heiko@sntech.de,
        benh@kernel.crashing.org, shawn.lin@rock-chips.com,
        paulus@samba.org, thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de, Qian Cai <qcai@redhat.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
In-Reply-To: <20201208210613.GA2420289@bjorn-Precision-5520>
References: <20201208210613.GA2420289@bjorn-Precision-5520>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <be626f557ebf580babebad5457023617@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2020-12-08 22:06, schrieb Bjorn Helgaas:
> [+cc Qian]
> 
> On Tue, Dec 08, 2020 at 04:41:50PM +0100, Michael Walle wrote:
>> Hi Lorenzo, Krzysztof,
>> 
>> >On Sun, 29 Nov 2020 23:07:38 +0000, Krzysztof Wilczyński wrote:
>> >> Unify ECAM-related constants into a single set of standard constants
>> >> defining memory address shift values for the byte-level address that can
>> >> be used when accessing the PCI Express Configuration Space, and then
>> >> move native PCI Express controller drivers to use newly introduced
>> >> definitions retiring any driver-specific ones.
>> >>
>> >> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
>> >> PCI Express specification (see PCI Express Base Specification, Revision
>> >> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
>> >> implement it the same way.
>> >>
>> >> [...]
>> >
>> >Applied to pci/ecam, thanks!
>> >
>> >[1/5] PCI: Unify ECAM constants in native PCI Express drivers
>> >      https://git.kernel.org/lpieralisi/pci/c/f3c07cf692
>> >[2/5] PCI: thunder-pem: Add constant for custom ".bus_shift" initialiser
>> >      https://git.kernel.org/lpieralisi/pci/c/3c38579263
>> >[3/5] PCI: iproc: Convert to use the new ECAM constants
>> >      https://git.kernel.org/lpieralisi/pci/c/333ec9d3cc
>> >[4/5] PCI: vmd: Update type of the __iomem pointers
>> >      https://git.kernel.org/lpieralisi/pci/c/89094c12ea
>> >[5/5] PCI: xgene: Removed unused ".bus_shift" initialisers from pci-xgene.c
>> >      https://git.kernel.org/lpieralisi/pci/c/3dc62532a5
>> 
>> Patch 1/5 breaks LS1028A boards:
> 
> I temporarily dropped this series while we figure out what went wrong
> here.

Thanks, let me know if I can test something on the board.

-michael
