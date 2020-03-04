Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CFE178909
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 04:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgCDDUs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 22:20:48 -0500
Received: from yyz.mikelr.com ([170.75.163.43]:57158 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbgCDDUs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 22:20:48 -0500
Received: from glidewell.localnet (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 6DF123CFC8;
        Tue,  3 Mar 2020 22:20:46 -0500 (EST)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH 2/4] PCI: Use ioremap, not phys_to_virt for platform rom
Date:   Tue, 03 Mar 2020 22:20:45 -0500
Message-ID: <2616060.jBR9Tdob1i@glidewell>
In-Reply-To: <20200303143827.GA78253@google.com>
References: <20200303143827.GA78253@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, March 3, 2020 9:38:27 AM EST Bjorn Helgaas wrote:
> Cosmetics:
> 
> s/ioremap/ioremap()/ (also in commit log)
> s/phys_to_virt/phys_to_virt()/ (also in commit log)
> s/pci_platform_rom/pci_platform_rom()/ (commit log)
> s/rom/ROM/

> This changes the interface of pci_platform_rom() (the caller is now
> responsible for doing an iounmap()).  That should be mentioned in the
> function comment, and I think the subsequent patches should be
> squashed into this one so the interface change and the caller changes
> are done simultaneously.
> 
> Also, it looks like nvbios_platform.init() (platform_init()) needs a
> similar change?

Hi Bjorn,

Thank you for your comments. I'll make the suggested changes, add an iounmap() 
in the nouveau usage, and provide a new two-patch series.
