Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B370739282
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFUW3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 18:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFUW3D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 18:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751AA1738;
        Wed, 21 Jun 2023 15:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8297616FB;
        Wed, 21 Jun 2023 22:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B21C433C0;
        Wed, 21 Jun 2023 22:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687386540;
        bh=HGjabCeT43jLvc1k3yVHAmOljzcopoeRcmpwRfbnVmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gJLTlRDtj9s/skU9rpEj2Hdw1EPLNnsTxBYia/bNMAAZ6s6S+n16Qc246vASgYX08
         yKDa9cs0ApTNkMd2Dp/88gGGJwCasQyr4Wm3wf6yAlbyk7VcDA2eECFvY4Ige5Tbys
         Da1N7b3cTCf/PDG7vDM0hIv5GouuG+Ccpr9BqaChHjfi+wkAVegRT8wPmLnDpp/b6m
         D/aGeS3//YuOK4DQbZ4xOaszL7csnYBVxldYawk6953dzVnM4d72gVwUSSGVbUKur6
         R+2DfQoDZ9HfUliqOwqlZjq6VtCWxHqJ/mUxmS2kuYWA6V5MO0e9S8O8y2MxqFhs7g
         A9Bv8NDyp0D1w==
Date:   Wed, 21 Jun 2023 17:28:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
Message-ID: <20230621222857.GA122930@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620140451.21007-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 09:04:51AM -0500, Mario Limonciello wrote:
> Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to access
> an OperationRegion unless `_REG` has been called.
> 
> "The OS runs _REG control methods to inform AML code of a change in the
> availability of an operation region. When an operation region handler
> is unavailable, AML cannot access data fields in that region.
> (Operation region writes will be ignored and reads will return
> indeterminate data.)"
> 
> The PCI core does not call `_REG` at anytime, leading to the undefined
> behavior mentioned in the spec.

I got lost in the maze of users of ACPI_ADR_SPACE_PCI_CONFIG, but is
it really true that we never call _REG for PCI config space at all
today?

If so, I guess AML that uses ACPI_ADR_SPACE_PCI_CONFIG won't work
until after we set the relevant device to D0?

Do we explicitly set devices to D0 during enumeration, e.g., somewhere
in the pci_scan_device() path?  If not, should we?

If we don't set things to D0 during enumeration, it seems like this
AML won't work until we suspend and resume the device.

Separately, I propose a minor restructuring to avoid the need for
mentioning PCI_POWER_ERROR and PCI_UNKNOWN.  Checking for those means
we need to look at the definitions to be sure we cover all cases, and
it also doesn't solve the problem that a caller can pass undefined
pci_power_t values that would index outside the state_conv[].

Possible rework attached below.  I also like the fact that it makes
the _REG patch very simple and specific to _REG.

> The spec explains that _REG should be executed to indicate whether a
> given region can be accessed.
> 
> "Once _REG has been executed for a particular operation region, indicating
> that the operation region handler is ready, a control method can
> access fields in the operation region. Conversely, control methods
> must not access fields in operation regions when _REG method execution
> has not indicated that the operation region handler is ready."
> 
> An example included in the spec demonstrates calling _REG when devices are
> turned off: "when the host controller or bridge controller is turned off
> or disabled, PCI Config Space Operation Regions for child devices are
> no longer available. As such, ETH0’s _REG method will be run when it
> is turned off and will again be run when PCI1 is turned off.".
> 
> It is reported that ASMedia PCIe GPIO controllers fail functional tests
> after the system has returning from suspend (S3 or s2idle). This is
> because the BIOS checks whether the OSPM has called the `_REG` method
> to determine whether it can interact with the OperationRegion assigned
> to the device as part of the other AML called for the device.
> 
> To fix this issue, call acpi_evaluate_reg() when devices are
> transitioning to D3cold or D0.
> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 052a611081ec..182cac535250 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	return false;
>  }
>  
> +static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
> +{
> +	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> +	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> +				    ACPI_ADR_SPACE_PCI_CONFIG, val);
> +	if (ret)
> +		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
> +			enable ? "connect" : "disconnect", ret);
> +}
> +
>  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> @@ -1053,32 +1063,36 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  		[PCI_D3hot] = ACPI_STATE_D3_HOT,
>  		[PCI_D3cold] = ACPI_STATE_D3_COLD,
>  	};
> -	int error = -EINVAL;
> +	int ret;
>  
>  	/* If the ACPI device has _EJ0, ignore the device */
>  	if (!adev || acpi_has_method(adev->handle, "_EJ0"))
>  		return -ENODEV;
>  
>  	switch (state) {
> +	case PCI_POWER_ERROR:
> +	case PCI_UNKNOWN:
> +		return -EINVAL;
>  	case PCI_D3cold:
>  		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
> -				PM_QOS_FLAGS_ALL) {
> -			error = -EBUSY;
> -			break;
> -		}
> -		fallthrough;
> -	case PCI_D0:
> -	case PCI_D1:
> -	case PCI_D2:
> -	case PCI_D3hot:
> -		error = acpi_device_set_power(adev, state_conv[state]);
> +				     PM_QOS_FLAGS_ALL)
> +			return -EBUSY;
> +		/* Notify AML lack of PCI config space availability */
> +		acpi_pci_config_space_access(dev, false);
> +		break;
>  	}
>  
> -	if (!error)
> -		pci_dbg(dev, "power state changed by ACPI to %s\n",
> -		        acpi_power_state_string(adev->power.state));
> +	ret = acpi_device_set_power(adev, state_conv[state]);
> +	if (ret)
> +		return ret;
> +	pci_dbg(dev, "power state changed by ACPI to %s\n",
> +		acpi_power_state_string(adev->power.state));
>  
> -	return error;
> +	/* Notify AML of PCI config space availability */
> +	if (state == PCI_D0)
> +		acpi_pci_config_space_access(dev, true);
> +
> +	return 0;
>  }
>  
>  pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)


commit 79d4fdf58711 ("PCI/PM: Validate acpi_pci_set_power_state() parameter")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Jun 21 16:36:12 2023 -0500

    PCI/PM: Validate acpi_pci_set_power_state() parameter
    
    Previously acpi_pci_set_power_state() assumed the requested power state was
    valid (PCI_D0 ... PCI_D3cold).  If a caller supplied something else, we
    could index outside the state_conv[] array and pass junk to
    acpi_device_set_power().
    
    Validate the pci_power_t parameter and return -EINVAL if it's invalid.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 052a611081ec..bf545f719182 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1053,32 +1053,37 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		[PCI_D3hot] = ACPI_STATE_D3_HOT,
 		[PCI_D3cold] = ACPI_STATE_D3_COLD,
 	};
-	int error = -EINVAL;
+	int error;
 
 	/* If the ACPI device has _EJ0, ignore the device */
 	if (!adev || acpi_has_method(adev->handle, "_EJ0"))
 		return -ENODEV;
 
 	switch (state) {
-	case PCI_D3cold:
-		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
-				PM_QOS_FLAGS_ALL) {
-			error = -EBUSY;
-			break;
-		}
-		fallthrough;
 	case PCI_D0:
 	case PCI_D1:
 	case PCI_D2:
 	case PCI_D3hot:
-		error = acpi_device_set_power(adev, state_conv[state]);
+	case PCI_D3cold:
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	if (!error)
-		pci_dbg(dev, "power state changed by ACPI to %s\n",
-		        acpi_power_state_string(adev->power.state));
+	if (state == PCI_D3cold) {
+		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
+				PM_QOS_FLAGS_ALL)
+			return -EBUSY;
+	}
 
-	return error;
+	error = acpi_device_set_power(adev, state_conv[state]);
+	if (error)
+		return error;
+
+	pci_dbg(dev, "power state changed by ACPI to %s\n",
+	        acpi_power_state_string(adev->power.state));
+
+	return 0;
 }
 
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
commit 746652bd0376 ("PCI/PM: Call _REG when transitioning D-states")
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Tue Jun 20 09:04:51 2023 -0500

    PCI/PM: Call _REG when transitioning D-states
    
    ACPI r6.5, sec 6.5.4, describes how AML is unable to access an
    OperationRegion unless _REG has been called to connect a handler:
    
      The OS runs _REG control methods to inform AML code of a change in the
      availability of an operation region. When an operation region handler is
      unavailable, AML cannot access data fields in that region.  (Operation
      region writes will be ignored and reads will return indeterminate data.)
    
    The PCI core does not call _REG at any time, leading to the undefined
    behavior mentioned in the spec.
    
    The spec explains that _REG should be executed to indicate whether a
    given region can be accessed:
    
      Once _REG has been executed for a particular operation region, indicating
      that the operation region handler is ready, a control method can access
      fields in the operation region. Conversely, control methods must not
      access fields in operation regions when _REG method execution has not
      indicated that the operation region handler is ready.
    
    An example included in the spec demonstrates calling _REG when devices are
    turned off: "when the host controller or bridge controller is turned off
    or disabled, PCI Config Space Operation Regions for child devices are
    no longer available. As such, ETH0’s _REG method will be run when it
    is turned off and will again be run when PCI1 is turned off."
    
    It is reported that ASMedia PCIe GPIO controllers fail functional tests
    after the system has returning from suspend (S3 or s2idle). This is because
    the BIOS checks whether the OSPM has called the _REG method to determine
    whether it can interact with the OperationRegion assigned to the device as
    part of the other AML called for the device.
    
    To fix this issue, call acpi_evaluate_reg() when devices are transitioning
    to D3cold or D0.
    
    Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
    Link: https://lore.kernel.org/r/20230620140451.21007-1-mario.limonciello@amd.com
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>


diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index bf545f719182..a05350a4e49c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return false;
 }
 
+static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
+{
+	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
+	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
+				    ACPI_ADR_SPACE_PCI_CONFIG, val);
+	if (ret)
+		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
+			enable ? "connect" : "disconnect", ret);
+}
+
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -1074,6 +1084,9 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
 				PM_QOS_FLAGS_ALL)
 			return -EBUSY;
+
+		/* Notify AML lack of PCI config space availability */
+		acpi_pci_config_space_access(dev, false);
 	}
 
 	error = acpi_device_set_power(adev, state_conv[state]);
@@ -1083,6 +1096,15 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	pci_dbg(dev, "power state changed by ACPI to %s\n",
 	        acpi_power_state_string(adev->power.state));
 
+	/*
+	 * Notify AML of PCI config space availability.  Config space is
+	 * accessible in all states except D3cold; the only transitions
+	 * that change availability are transitions to D3cold and from
+	 * D3cold to D0.
+	 */
+	if (state == PCI_D0)
+		acpi_pci_config_space_access(dev, true);
+
 	return 0;
 }
 
