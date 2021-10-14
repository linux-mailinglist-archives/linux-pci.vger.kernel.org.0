Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5542DC01
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 16:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhJNOtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 10:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhJNOtr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Oct 2021 10:49:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DE0C606A5;
        Thu, 14 Oct 2021 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634222862;
        bh=XMZbQV/iPebYZWbTLtoV6N8/GG1cwsFjaxP+vvD0084=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NkThT+g5jXMQfER110hQPYDcJidXygydpEHYj4YEpVCMQxOB1Dicl9JanI/pIs7gS
         K4uRZTG7I8QKuPbgnhRJy1EMcSuApU5QacMoiQ+A5+/Vy0CTp0wxNDEEuMN9YBCR/i
         cC7bo/P301Lqt2tOGXZoeYgkDuJNPIQP3PHX8Z1wb/5O16HKrzI03l/WnPNYmCZIYI
         uwr1ntCWjiDPgohljmuoD0RhXrRqgZf/eLBvlk99UewtyPMvVT+yR/P1RoXmq2T6ju
         igBUxajAQ2SG0GSs4fILYgoMRkXvg4kdDOBEwxFV0oqNQfLaV6NhaSE1/L1Al0mZnt
         m1Sr25EKwXhHA==
Date:   Thu, 14 Oct 2021 09:47:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH v2 0/5] Switchtec Fixes and Improvements
Message-ID: <20211014144740.GA2028709@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014141859.11444-1-kelvin.cao@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 14, 2021 at 02:18:54PM +0000, kelvin.cao@microchip.com wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Hi,
> 
> This patchset is mainly for improving the commit message of [PATCH 1/5]
> in v1[1] to elaborate the root cause, together with a function renaming
> and some other tweaks.
> 
> This patchset is based on v5.15-rc5.

Applied, replacing the previous set, thanks!

> [1] https://lore.kernel.org/lkml/20210924110842.6323-1-kelvin.cao@microchip.com/
> 
> Changes since v1:
> - Rebase on 5.15-rc5
> - Tweak some comment spacing (as suggested by Bjorn)
> - Update commit message to elaborate the root cause of MRPC execution
>   hanging (as suggested by Bjorn)
> - Rename function check_access() to is_firmware_running()
>   (as suggested by Logan) so the function name suggests the meaning of
>   the return values (as suggested by Bjorn)
> - Add comment to function is_firmware_running() (as suggested by Logan)
> 
> 
> Kelvin Cao (4):
>   PCI/switchtec: Error out MRPC execution when MMIO reads fail
>   PCI/switchtec: Fix a MRPC error status handling issue
>   PCI/switchtec: Update the way of getting management VEP instance ID
>   PCI/switchtec: Replace ENOTSUPP with EOPNOTSUPP
> 
> Logan Gunthorpe (1):
>   PCI/switchtec: Add check of event support
> 
>  drivers/pci/switch/switchtec.c | 95 ++++++++++++++++++++++++++++------
>  include/linux/switchtec.h      |  1 +
>  2 files changed, 79 insertions(+), 17 deletions(-)
> 
> -- 
> 2.25.1
> 
