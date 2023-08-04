Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07C1770157
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 15:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjHDNUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjHDNU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 09:20:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BAD59C7;
        Fri,  4 Aug 2023 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691155095; x=1722691095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ot9Ooygu6Xo8v9fyWTf7US/LLF4qBCnv8SIgzf+9s2Y=;
  b=GJE5NFvvHVNUWtmpdurbbnt/w3mbIX5aaraK6i1forXfkOBHPkqEe0sb
   NfrcZFrAqw1pW38Y7UpUL9VpV5hMObHDYQKp0CfYfB5n9jvzOVM+U4rPy
   M08mLtiVaN4upTROWiqzjwnCLvvxomKkQPkgXMHCJ3C6hEU2U4Hno1Kky
   f8E128G4fpv/NGUgvnmFCWqQb3oqsRGZPNlD+Z0P15gJ3q2qT2OdwFd//
   YeFNqHgsrUM2+CJ5iLFWxL9rD48zHIJera1T9jCUNV+v686iMS2sMf2G7
   xS3ICFqsUxA4vB5g+RH9KbnlV3SVGjdBluOYU+ToR5i4fnxe1+MNBCq0R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370137010"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="370137010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 06:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873384919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2023 06:16:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D6376BAB; Fri,  4 Aug 2023 16:17:03 +0300 (EEST)
Date:   Fri, 4 Aug 2023 16:17:03 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v9 3/3] PCI/ACPI: Use device constraints to decide PCI
 target state fallback policy
Message-ID: <20230804131703.GB14638@black.fi.intel.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
 <20230804010229.3664-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804010229.3664-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 08:02:29PM -0500, Mario Limonciello wrote:
> +/**
> + * acpi_pci_device_constraint - determine if the platform has a contraint for the device
> + * @dev: PCI device to check
> + * @result (out): the constraint specified by the platform
> + *
> + * If the platform has specified a constraint for a device, this function will
> + * return 0 and set @result to the constraint.
> + * Otherwise, it will return an error code.
> + */
> +int acpi_pci_device_constraint(struct pci_dev *dev, int *result)
> +{
> +	int constraint;
> +
> +	constraint = acpi_get_lps0_constraint(&dev->dev);
> +	pci_dbg(dev, "ACPI device constraint: %d\n", constraint);
> +	if (constraint < 0)
> +		return constraint;
> +	*result = constraint;

Is there something preventing to return the constraint directly instead
of storing it into "result"?

> +
> +	return 0;
> +}
> +
>  static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>  {
>  	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0c..6c70f921467c6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	return acpi_pci_bridge_d3(dev);
>  }
>  
> +static inline int platform_get_constraint(struct pci_dev *dev, int *result)

Ditto here.

> +{
> +	if (pci_use_mid_pm())
> +		return -ENODEV;
> +
> +	return acpi_pci_device_constraint(dev, result);
> +}
> +
