Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A7238F5BE
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhEXWnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 18:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEXWns (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 18:43:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDA3661378;
        Mon, 24 May 2021 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621896140;
        bh=RykgrwMEOKoXEcrJsVff10yzaTjy+pjAbuhxu7UAis0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NwYOZ0gEU/E7F6JX2g3NE1JLJm4BJcmUPe+DU/dXH/hhlGlZcNF4KFji7qWJ6QrbB
         hphFDuxM6PbgXdmMG9zQq3Y0pubYrd2j5L7HcFZGDr+6MnhHBKJFBGbabc7OtIosst
         UvlHDoilGHQYFMRyHKKOMHRBgTqH3iU0N45WZz/4BzQS6egiBNL/je+9Ajs0jJi0h8
         IuVBVtxsknSU65oidsTiiIfgmQdPhpmEd50obo17y3TBL0qL8kk/967Mt3MSnUOg5R
         Fh5wwA0brB8h7AicJwYxKU4yuzU7t2T1yT05wC5tDgJcos927xy7S3pkWTXF5jkUEm
         Szb0qHkt0UWTg==
Date:   Mon, 24 May 2021 17:42:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore spurious link inactive change when
 off
Message-ID: <20210524224218.GA1135242@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409205935.41881-1-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 09, 2021 at 02:59:35PM -0600, Jon Derrick wrote:
> When a specific x8 CEM card is bifurcated into x4x4 mode, and the
> upstream ports both support hotplugging on each respective x4 device, a
> slot management system for the CEM card requires both x4 devices to be
> sysfs removed from the OS before it can safely turn-off physical power.
> The implications are that Slot Control will display Powered Off status
> for the device where the device is actually powered until both ports
> have powered off.
> 
> When power is removed from the first half, the link remains active to
> provide clocking while waiting for the second half to have power
> removed. When power is then removed from the second half, the first half
> starts shutdown sequence and will trigger a link status change event.
> This is misinterpreted as an enabling event due to positive presence
> detect and causes the first half to be re-enabled.
> 
> The spurious enable can be resolved by ignoring link status change
> events when no link is active when in the off state.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Applied to pci/hotplug for v5.14, thanks!

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c34808440..a2c5eef03e7d 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -265,6 +265,11 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		cancel_delayed_work(&ctrl->button_work);
>  		fallthrough;
>  	case OFF_STATE:
> +		if ((events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
> +			mutex_unlock(&ctrl->state_lock);
> +			break;
> +		}
> +
>  		ctrl->state = POWERON_STATE;
>  		mutex_unlock(&ctrl->state_lock);
>  		if (present)
> -- 
> 2.26.2
> 
