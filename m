Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABFA419958
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 18:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhI0Qlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 12:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235678AbhI0Qlb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 12:41:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD72E6108E;
        Mon, 27 Sep 2021 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632760793;
        bh=qhd2opmqQR1JXSq/kmZFfX/7R9p2kQSzkv4HY2mjKJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sTE2w4NvSeYdbjhqo9RIAFOqGXLhUoFCuor+mtKEECfeOYMgK/GI/GLfb8SIQfwGt
         LntffaHhVq40GK6IJMafuHn1KFpiRRNbHLIRF0soVsukusLLqHsRb2q7q4VA8xjjU6
         QqxZJ5QcODPt6LpR90HmWQ+o0X0QaaV9aPsJw83LVFoCDzPBNgu2KV6tYaQfj/owSQ
         gMU5kXdmGl3iINQjGvZ5pSJ43mprz16p4jctADPaIpNyC+QlXfYhIiBI/vYh/OMQZE
         7vTbMZ/0n7xmii/68HBT+HJcEZESFnXk4jYTBdgRHdytP9nY0KQFGVeR4sMiDtBJnV
         /eEgrXtV2vZyg==
Date:   Mon, 27 Sep 2021 11:39:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH 0/5] Switchtec Fixes and Improvements
Message-ID: <20210927163951.GA655671@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924110842.6323-1-kelvin.cao@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:08:37AM +0000, kelvin.cao@microchip.com wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Hi,
> 
> Please find a bunch of patches for the switchtec driver collected over the
> last few months.
> 
> The first 2 patches fix two minor bugs. Patch 3 updates the method of
> getting management VEP instance ID based on a new firmware change. Patch
> 4 replaces ENOTSUPP with EOPNOTSUPP to follow the preference of kernel.
> And the last patch adds check of event support to align with new firmware
> implementation.
> 
> This patchset is based on v5.15-rc2.
> 
> Thanks,
> Kelvin
> 
> Kelvin Cao (4):
>   PCI/switchtec: Error out MRPC execution when no GAS access
>   PCI/switchtec: Fix a MRPC error status handling issue
>   PCI/switchtec: Update the way of getting management VEP instance ID
>   PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP
> 
> Logan Gunthorpe (1):
>   PCI/switchtec: Add check of event support
> 
>  drivers/pci/switch/switchtec.c | 87 +++++++++++++++++++++++++++-------
>  include/linux/switchtec.h      |  1 +
>  2 files changed, 71 insertions(+), 17 deletions(-)

Applied with Logan's reviewed-by to pci/switchtec for v5.16, thanks!

I tweaked the comment spacing in "PCI/switchtec: Error out MRPC
execution when no GAS access" so it matches the existing similar
comments.
