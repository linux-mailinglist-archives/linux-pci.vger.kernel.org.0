Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A981B13B1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgDTR5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 13:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgDTR5h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 13:57:37 -0400
Received: from localhost (mobile-166-175-186-98.mycingular.net [166.175.186.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8E520B1F;
        Mon, 20 Apr 2020 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587405456;
        bh=1QfeIdYAdaoPYZPVIY/AQvVUA98AZnRFonLWpP+zWZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=isVsuct1teVVrXGWhe+smoFYkCAXLHWLHhmKq/KoBg4bf+k2drAK+0l5uReYejijn
         nvYkJdhR17R072goe6KIZH1F/jL2+a6tlZnk3piC/Xbq8JCFRwn09DWzJeQi2lyN9E
         UotslwHOshcxVcY+mmLz9luaeplq+d51jUDdJKOo=
Date:   Mon, 20 Apr 2020 12:57:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     linux-kernel@vger.kernel.org, ani@anirban.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: remove unused EMI() macro
Message-ID: <20200420175734.GA53587@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587387114-38475-1-git-send-email-ani@anisinha.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ani,

On Mon, Apr 20, 2020 at 06:21:41PM +0530, Ani Sinha wrote:
> EMI() macro seems to be unused. So removing it. Thanks
> Mika Westerberg <mika.westerberg@linux.intel.com> for
> pointing it out.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  drivers/pci/hotplug/pciehp.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 5747967..4fd200d 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -148,7 +148,6 @@ struct controller {
>  #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
>  #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>  #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> -#define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)

Thanks for the patch!  Can you squash it together with the HP_SUPR_RM
removal (and also check for any other unused ones at the same time)?
For trivial things like this, I'd rather merge one patch that removes
several unused things at once instead of several patches.

I like the subject of this one ("Removed unused ..."), but please
capitalize it as you did for the HP_SUPR_RM one so it matches previous
history.

Bjorn

>  #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>  #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
>  
> -- 
> 2.7.4
> 
