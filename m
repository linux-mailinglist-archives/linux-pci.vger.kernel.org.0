Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8535A869
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 23:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDIVir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 17:38:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:11145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhDIViq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 17:38:46 -0400
IronPort-SDR: qJI689LOldELAh2+KYz3YI8AfBtmG5OaudRUv9JblTLXMRF54QFeb4BOPyEuFs9KGwV1BUdnmh
 oqEp2X1vTO5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193882333"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="193882333"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 14:38:32 -0700
IronPort-SDR: YODXat/xmzgv//GR+FDkbrd9drwW9Vcm5OJSECTqHTPZtsThOPDRXy36L3FpRPme+J5RamMrLO
 0nC+h4aYf/ow==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="416431312"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 14:38:32 -0700
Date:   Fri, 9 Apr 2021 14:38:26 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore spurious link inactive change when
 off
Message-ID: <20210409213826.GB101733@otc-nc-03>
References: <20210409205935.41881-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409205935.41881-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 09, 2021 at 02:59:35PM -0600, Derrick, Jonathan wrote:
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

Although this seems like it should never happen with normal cards, it seems
harmless otherwise. 


Reviewed by: Ashok Raj <ashok.raj@intel.com>
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

-- 
Cheers,
Ashok

[Forgiveness is the attribute of the STRONG - Gandhi]
