Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A029E2022BE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jun 2020 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgFTJJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Jun 2020 05:09:38 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:40465 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgFTJJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Jun 2020 05:09:38 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5FCE728032723;
        Sat, 20 Jun 2020 11:09:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 38F0B10CB8; Sat, 20 Jun 2020 11:09:36 +0200 (CEST)
Date:   Sat, 20 Jun 2020 11:09:36 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     refactormyself@gmail.com
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Fix wrong failure check on
 pcie_capability_read_*()
Message-ID: <20200620090936.3khh3gj46pnojnrw@wunner.de>
References: <20200619201219.32126-1-refactormyself@gmail.com>
 <20200619201219.32126-3-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619201219.32126-3-refactormyself@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 10:12:19PM +0200, refactormyself@gmail.com wrote:
> On failure, pcie_capabiility_read_*() will set the status value,
> its last parameter to 0 and not ~0.
> This bug fix checks for the proper value.

If a config space read times out, the PCIe controller fabricates
an "all ones" response.  The code is checking for such a timeout,
not for an error.  Hence the code is fine.

Thanks,

Lukas

> 
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 53433b37e181..c1a67054948a 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  
>  	do {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -		if (slot_status == (u16) ~0) {
> +		if (slot_status == (u16)0) {
>  			ctrl_info(ctrl, "%s: no response from device\n",
>  				  __func__);
>  			return 0;
> @@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
>  	pcie_wait_cmd(ctrl);
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> -	if (slot_ctrl == (u16) ~0) {
> +	if (slot_ctrl == (u16)0) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		goto out;
>  	}
> @@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
>  	int ret;
>  
>  	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)0)
>  		return -ENODEV;
>  
>  	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> @@ -440,7 +440,7 @@ int pciehp_card_present(struct controller *ctrl)
>  	int ret;
>  
>  	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)0)
>  		return -ENODEV;
>  
>  	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
> @@ -592,7 +592,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  
>  read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> -	if (status == (u16) ~0) {
> +	if (status == (u16)0) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		if (parent)
>  			pm_runtime_put(parent);
> -- 
> 2.18.2
