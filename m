Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C05493426
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 05:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351572AbiASEzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 23:55:09 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:42608 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiASEzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 23:55:09 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3297292009C; Wed, 19 Jan 2022 05:55:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2F74092009B;
        Wed, 19 Jan 2022 04:55:01 +0000 (GMT)
Date:   Wed, 19 Jan 2022 04:55:01 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: Add "pci=reassign_all_bus" boot parameter
In-Reply-To: <41c0cadc-a623-b013-24f0-410af2a6dc64@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2201190434230.19178@angie.orcam.me.uk>
References: <20220112154310.GA259954@bhelgaas> <41c0cadc-a623-b013-24f0-410af2a6dc64@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 17 Jan 2022, Yao Hongbo wrote:

> > Why can't we make Linux smart enough to fix this by itself, without
> > forcing the user to boot with "pci=reassign_all_bus"?
> 
>    You're right, it's better for us to make pci enumeration more smart.
> 
>    But i think it's better to provide an additional option for users on ACPI systems,
> 
> which can quickly distingguish the issues between the BIOS and the OS.

 Even if so, x86 has had `pci=assign-busses' for decades already (i.e. 
from Linux 2.4.6), so why not reuse it for whatever your ACPI platform is?

  Maciej
