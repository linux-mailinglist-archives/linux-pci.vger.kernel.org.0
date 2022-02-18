Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22004BC21B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 22:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbiBRVbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 16:31:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbiBRVbc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 16:31:32 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85C3703C;
        Fri, 18 Feb 2022 13:31:14 -0800 (PST)
Message-ID: <1a163e75-f620-dfe7-01b1-5356fe767b2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645219872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GlQGXJ9cc6b2kyBud06IlPhdvljYz0PT9D3x32cSxO8=;
        b=tERcmtAwI/OVlxABHG/SzjJMHMrHHH9ULV3i6RqUJYYXU3QLnbBvfAEva+aVdzUA+cOhdm
        tyDg/+tTMjwCbBi74FQL+DGs4HrmxsBJjbOCFQWWIo0zZImeKzG+OamIRv3ly72YnD98Nw
        fxehdNLOXOU1R+kysdxOeGhhuxqidOM=
Date:   Fri, 18 Feb 2022 14:30:48 -0700
MIME-Version: 1.0
Subject: Re: [PATCH V5 3/3] PCI: vmd: Configure PCIe ASPM and LTR
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220218045056.333799-1-david.e.box@linux.intel.com>
 <20220218045056.333799-4-david.e.box@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220218045056.333799-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/17/2022 9:50 PM, David E. Box wrote:
> Currently, PCIe ports reserved for VMD use are not visible to BIOS and
> therefore not configured to enable PCIE ASPM. Additionally, PCIE LTR
> values may be left unset since BIOS will set a default maximum LTR value
> on endpoints to ensure that misconfigured devices don't block SoC power
> management. Lack of this programming results in high power consumption
> on laptops as reported in bugzilla [1].  For currently affected
> products, use pci_enable_default_link_state to set the allowed link
> states for devices on the root ports. Also set the LTR value to the
> maximum value needed for the SoC. Per the VMD hardware team future
> products using VMD will enable BIOS configuration of these capabilities.
Will the refreshes of the affected CPU be supported in BIOS or this workaround?

> This solution is a workaround for current products that mainly targets
> laptops. Support is not provided if a switch is used nor for hotplug.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=213717
> 
> Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V5
>   - Provide the LTR value as driver data.
>   - Use DWORD for the config space write to avoid PCI WORD access bug.
>   - Set ASPM links firsts, enabling all link states, before setting a
>     default LTR if the capability is present
>   - Add kernel message that VMD is setting the device LTR.
> V4
>   - Refactor vmd_enable_apsm() to exit early, making the lines shorter
>     and more readable. Suggested by Christoph.
> V3
>   - No changes
> V2
>   - Use return status to print pci_info message if ASPM cannot be enabled.
>   - Add missing static declaration, caught by lkp@intel.com
> 
>   drivers/pci/controller/vmd.c | 48 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a582c351b461..eac379c80cd7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -67,10 +67,19 @@ enum vmd_features {
>   	 * interrupt handling.
>   	 */
>   	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
> +
> +	/*
> +	 * Enable ASPM on the PCIE root ports and set the default LTR of the
> +	 * storage devices on platforms where these values are not configured by
> +	 * BIOS. This is needed for laptops, which require these settings for
> +	 * proper power management of the SoC.
> +	 */
> +	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
>   };
>   
>   struct vmd_device_data {
>   	enum vmd_features features;
> +	u16 ltr;
>   };
>   
>   static DEFINE_IDA(vmd_instance_ida);
> @@ -714,6 +723,38 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>   	vmd_bridge->native_dpc = root_bridge->native_dpc;
>   }
>   
> +/*
> + * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> + */
> +static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> +{
> +	struct vmd_device_data *info = userdata;
> +	u32 ltr_reg;
> +	int pos;
> +
> +	if (!(info->features & VMD_FEAT_BIOS_PM_QUIRK))
> +		return 0;
> +
> +	pci_enable_default_link_state(pdev, PCIE_LINK_STATE_ALL);
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> +	if (!pos)
> +		return 0;
> +
> +	/*
> +	 * If the LTR capability is present, set the default values to the
> +	 * maximum required by the platform to allow the deepest power
> +	 * management savings. Write this as a single DWORD where the lower word
> +	 * is the max snoop latency and the upper word is the max non-snoop
> +	 * latency.
> +	 */
> +	pci_info(pdev, "VMD: Setting a default LTR\n");
> +	ltr_reg = (info->ltr << 16) | info->ltr;
> +	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> +
> +	return 0;
> +}
> +
>   static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
>   {
>   	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -867,6 +908,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
>   		pci_reset_bus(child->self);
>   	pci_assign_unassigned_bus_resources(vmd->bus);
>   
> +	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, info);
> +
>   	/*
>   	 * VMD root buses are virtual and don't return true on pci_is_pcie()
>   	 * and will fail pcie_bus_configure_settings() early. It can instead be
> @@ -1012,7 +1055,10 @@ static const struct vmd_device_data vmd_28c0_data = {
>   static const struct vmd_device_data vmd_467f_data = {
>   	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>   		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -		    VMD_FEAT_OFFSET_FIRST_VECTOR,
> +		    VMD_FEAT_OFFSET_FIRST_VECTOR |
> +		    VMD_FEAT_BIOS_PM_QUIRK,
> +	/* 3145728 ns (LatencyScale of 1048576 ns with a LatencyValue of 3) */
> +	.ltr = 0x1003,
>   };
>   
>   static const struct pci_device_id vmd_ids[] = {
