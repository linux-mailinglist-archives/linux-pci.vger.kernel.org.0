Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9D463E92
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 20:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbhK3TZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 14:25:12 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57912 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbhK3TZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 14:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=Dlyz49EtKbJqaNzZfY1tx0m9Yx6JL073qjZfik+uWwE=; b=VEornqptojdVzaRUFG+WqR1CYD
        GF5KRyNgtfYRTD6G10G4SN4gIAkwQ2CzgN4UUfuM0nazIEfV6ByTXoLsuRLJWIZcC1zrTuAZXLxdb
        GVND9pkSL5czg6JUyIpVKoyl2mMHN+ZUkB7QML2Ozuabyn5UTrmPnZvmVu2g2zVrlm5zphOgc51X5
        kziw93b1XB+yHPG1ChiV6lUR4/dTF+cr+AtJ9dN8s5UWqHSFMQpV7n1TNzuc54YPDQqZ3KuKhEs3K
        DG4mm5pm8xhOKLxvC1gesniPE++b0EoASHbZnuyBPB+f7q1Li4IiO5e+D62zngvT0fqbnyPMZNWwi
        l1uIvong==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ms8gy-00BCOF-Ov; Tue, 30 Nov 2021 12:21:29 -0700
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
Date:   Tue, 30 Nov 2021 12:21:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87ilwacwp8.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: x86@kernel.org, borntraeger@de.ibm.com, hca@linux.ibm.com, linux-s390@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, ashok.raj@intel.com, megha.dey@intel.com, jgg@nvidia.com, kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org, helgaas@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
> At the conceptual level these interrupts are in separate irq domains:
> 
>      |   _______________________
>      |   |                      |
>      |   | NTB                  |
>      |   |                      |
>      |   | PCI config space     |
>      |   |     MSI-X space      | <- #1 Global or per IOMMU zone PCI/MSI domain
>      |   |_____________________ |
>      |---|                      |
>          | Memory window A      |
>          | Memory window ..     | <- #2 Per device NTB domain
>          | Memory window N      |
>          |______________________|
> 
> You surely can see the disctinction between #1 and #2, right?

I wouldn't say that's entirely obvious or even irrefutable. However, I'm
certainly open to this approach if it improves the code.

> I'm way too tired to come up with a proper solution for that, but that
> PCI_IRQ_VIRTUAL has to die ASAP.

I'm willing to volunteer a bit of my time to clean this up, but I'd need
a bit more direction on what a proper solution would look like. The MSI
domain code is far from well documented nor is it easy to understand.

Logan
