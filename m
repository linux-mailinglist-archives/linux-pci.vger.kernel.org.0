Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13C118167F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 12:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgCKLEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 07:04:47 -0400
Received: from foss.arm.com ([217.140.110.172]:48152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgCKLEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 07:04:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8D051FB;
        Wed, 11 Mar 2020 04:04:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2D73F6CF;
        Wed, 11 Mar 2020 04:04:45 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:04:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: functions/pci-epf-test: Add DMA data transfer
Message-ID: <20200311110443.GB30083@e121166-lin.cambridge.arm.com>
References: <20200303103752.13076-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303103752.13076-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 04:07:47PM +0530, Kishon Vijay Abraham I wrote:
> Patch series uses dma engine APIs in pci-epf-test to transfer data using
> DMA. It also adds an option "-d" in pcitest for the user to indicate
> whether DMA has to be used for data transfer. This also prints
> throughput information for data transfer.
> 
> Changes from v1:
> *) Fixed some of the function names from pci_epf_* to pci_epf_test_*
> since the DMA support is now been moved to pci-epf-test.c
> 
> Kishon Vijay Abraham I (5):
>   PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer
>     data
>   PCI: endpoint: functions/pci-epf-test: Print throughput information
>   misc: pci_endpoint_test: Use streaming DMA APIs for buffer allocation
>   tools: PCI: Add 'd' command line option to support DMA
>   misc: pci_endpoint_test: Add support to get DMA option from userspace
> 
>  drivers/misc/pci_endpoint_test.c              | 165 ++++++++++--
>  drivers/pci/endpoint/functions/pci-epf-test.c | 253 +++++++++++++++++-
>  include/uapi/linux/pcitest.h                  |   5 +
>  tools/pci/pcitest.c                           |  20 +-
>  4 files changed, 412 insertions(+), 31 deletions(-)

Applied to pci/endpoint for v5.7, thanks.

Lorenzo
