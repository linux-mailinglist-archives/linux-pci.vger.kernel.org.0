Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F2747FED
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfFQKnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 06:43:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64671 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFQKnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 06:43:04 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id d1245691e53fa191; Mon, 17 Jun 2019 12:43:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: Power management improvements
Date:   Mon, 17 Jun 2019 12:43:01 +0200
Message-ID: <24804374.PG13b4niSC@kreacher>
In-Reply-To: <20190612105739.88578-1-mika.westerberg@linux.intel.com>
References: <20190612105739.88578-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, June 12, 2019 12:57:37 PM CEST Mika Westerberg wrote:
> Hi all,
> 
> This series includes a couple of changes to the PCI power management that
> should make Linux follow the PCIe spec better. The issues this series aims
> to solve came up with Intel Ice Lake Thunderbolt enabling where the
> controller is first time integrated into the SoC but I think these issues
> are generic to any platform having similar configuration.
> 
> Changes from v1
> 
>   * I dropped the last patch as it requires bit more work and not dependent
>     on the other two. I will send it out separately.
>   * Re-arranged conditionals in wait_for_downstream_link()
>   * Moved comments to be part of kernel-doc
>   * Added tags from Rafael and Lukas
> 
> Previous version is here:
> 
>   https://www.spinics.net/lists/linux-pci/msg83582.html
> 
> Mika Westerberg (2):
>   PCI: Add missing link delays required by the PCIe spec
>   PCI: Do not poll for PME if the device is in D3cold
> 
>  drivers/pci/pci.c               | 36 +++++++++++++-----
>  drivers/pci/pci.h               |  1 +
>  drivers/pci/pcie/portdrv_core.c | 66 +++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 10 deletions(-)
> 
> 

Both added to my 5.3 queue, thanks!




