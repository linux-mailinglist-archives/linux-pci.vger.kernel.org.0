Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380181B6400
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgDWSrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 14:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbgDWSre (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 14:47:34 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E44320704;
        Thu, 23 Apr 2020 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587667654;
        bh=ysT67fj+CwFIi/cQSwft5njqONSjwtIgNbDHLbf1qGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R83GfzjO86+V+apIEHHSQnTMOg+yiEY/nSZigenvnPJeiBXNOE4+/4IGGaZST4PbE
         zX+c6WfoScBt2okvQJ4kpX4cPH5TMjMPNBx6VlcvpUcBcRMVePsqTOxbjgrQ6e3Khd
         gvIhtp17qUCidr1hVXWsasIlMXoyMSMnaTmNRmbk=
Date:   Thu, 23 Apr 2020 13:47:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Cleanup unused EMI() and HP_SUPR_RM() macros
Message-ID: <20200423184732.GA203039@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587439673-39652-1-git-send-email-ani@anisinha.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 21, 2020 at 08:57:50AM +0530, Ani Sinha wrote:
> We do not use PCIE hotplug surprise (PCI_EXP_SLTCAP_HPS) bit anymore.
> Consequently HP_SUPR_RM() macro is no longer used. Let's clean it up.
> EMI() macro also seems to be unused. So removing it as well. Thanks
> Mika Westerberg <mika.westerberg@linux.intel.com> for
> pointing it out.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to pci/hotplug for v5.8, thanks!

> ---
>  drivers/pci/hotplug/pciehp.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index ae44f46..4fd200d 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -148,8 +148,6 @@ struct controller {
>  #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
>  #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>  #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> -#define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
> -#define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
>  #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>  #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
>  
> -- 
> 2.7.4
> 
