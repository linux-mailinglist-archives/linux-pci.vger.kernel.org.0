Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7939E7B6F38
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjJCREn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCREn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 13:04:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E8EB0;
        Tue,  3 Oct 2023 10:04:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DBEC433C7;
        Tue,  3 Oct 2023 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352679;
        bh=ojhTT5gbz7npnJ9U/90ySd8WkHi5+4JKHxAn4AYgke8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PXhoVkKbpNQi/DK3FrmfqY+MwrwilW7pkXKe7+HQap+P4a7QAfZ3eBo+KJNWliyrL
         v3KFw7bu5Y/oVJE6JWR4pH4n1okAU2KBWvJ2tU7YIv96FEbWQdT5LUWWgXLDzrGHiZ
         YBrZ8qP/ZwZd7sSZ25jEvN8hbpnpm1N2woKVY8YHd9Lkuc1d9pa4f/gFmnaVOEf2bT
         45UPBF87Mej4mPiZPIJVW5/QLLICqVhbeBpYZd1QfDLD793FGuRxO2g0WnpSzlV357
         3r2rDBYNM29LdyTR2B9JCpOak+KEbCHxumzCxRpvmf94WNRSGGG0/5/hXvuZg8ZbiL
         xykSOt2a65VAA==
Date:   Tue, 3 Oct 2023 12:04:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] PCI: ACPI: Switch to use acpi_evaluate_dsm_typed()
Message-ID: <20231003170436.GA678206@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002135352.2603096-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 02, 2023 at 04:53:52PM +0300, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied with Rafael's ack to pci/enumeration for v6.7, thanks!

> ---
>  drivers/pci/pci-acpi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a05350a4e49c..cf108259aef6 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1215,12 +1215,12 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>  	if (!pci_is_root_bus(bus))
>  		return;
>  
> -	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
> -				DSM_PCI_POWER_ON_RESET_DELAY, NULL);
> +	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
> +				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
>  	if (!obj)
>  		return;
>  
> -	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1) {
> +	if (obj->integer.value == 1) {
>  		bridge = pci_find_host_bridge(bus);
>  		bridge->ignore_reset_delay = 1;
>  	}
> @@ -1376,12 +1376,13 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	if (bridge->ignore_reset_delay)
>  		pdev->d3cold_delay = 0;
>  
> -	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 3,
> -				DSM_PCI_DEVICE_READINESS_DURATIONS, NULL);
> +	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
> +				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
> +				      ACPI_TYPE_PACKAGE);
>  	if (!obj)
>  		return;
>  
> -	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
> +	if (obj->package.count == 5) {
>  		elements = obj->package.elements;
>  		if (elements[0].type == ACPI_TYPE_INTEGER) {
>  			value = (int)elements[0].integer.value / 1000;
> -- 
> 2.40.0.1.gaa8946217a0b
> 
