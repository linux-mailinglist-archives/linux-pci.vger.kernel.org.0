Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1ED610556
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiJ0WH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 18:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiJ0WHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 18:07:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16CA02DF;
        Thu, 27 Oct 2022 15:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89540B8280C;
        Thu, 27 Oct 2022 22:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E2AC433D6;
        Thu, 27 Oct 2022 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666908468;
        bh=k2RYOuO9/8oDvtMKq2XpY8XMP11wPC4mHof/KaWGSq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j4ndRFlVZZpSzK7r7b6nn+gW2F3zeKyR9btgzIPERFrN1L2beNgpk88Rf6XrCAB9A
         KuHaQG2GV/9jVbB9ktaI+TDKJIw33rbv8oZDIVVozE5OiZGfs6Nc/WKk8E5IEWTbnd
         JP9qrJobgg6CXZsvnGY6dPtZ2rm0FT1DYBr9NCWy7i5YLypmRQwy5mLLJB8HMRFeO0
         7ozX5atIyN4Eh56l4TUPErFtPnIekEsO3qqv2nqKhLysNt0RTV1vvzjijtuv1nnAfK
         xpVz03WtsZeJpY5usoDahWUvINY2EPw+forccz6Y7PwGvhXylo8cEpm78KEjGowgwk
         0uc7fSdDoXxRw==
Date:   Thu, 27 Oct 2022 17:07:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH 1/5] ACPI/APEI: Add apei_hest_parse_aer()
Message-ID: <20221027220746.GA844491@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027031518.2855743-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 11:15:18AM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> apei_hest_parse_aer() is used to parse and record the PCI Express AER
> Structure in the HEST Table.
> 
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/acpi/apei/hest.c | 119 ++++++++++++++++++++++++++++++++++++++-
>  include/acpi/actbl1.h    |  69 +++++++++++++++++++++++
>  include/acpi/apei.h      |   7 +++
>  3 files changed, 194 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..0bfdc18758f5 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> +#include <linux/pci.h>
>  
>  #include "apei-internal.h"
>  
> @@ -86,7 +87,48 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  	return len;
>  };
>  
> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> +static inline bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)

Drop "inline" here and below.  This is not a performance path, so it's
more clutter than it's worth.

> +static inline bool hest_match_pci(struct acpi_hest_header *hest_hdr,
> +		struct acpi_hest_aer_common *p, struct pci_dev *pci)
> +{
> +	if (hest_match_type(hest_hdr, pci))
> +		return(hest_match_pci_devfn(p, pci));

No need for parens around hest_match_pci_devfn().

> +	else

You can drop the else, too.

> +		return false;
> +}

> + * apei_hest_parse_aer - Find the AER structure in the HEST Table and
> + * match it with the PCI device.
> + *
> + * @hest_hdr: To save the acpi aer error source in hest table
> + *
> + * Return 1 if the pci dev matched with the acpi aer error source in
> + * hest table, else return 0.

In comments and commit logs,

  s/pci/PCI/
  s/aer/AER/
  s/acpi/ACPI/
  s/hest/HEST/
  s/HEST Table/HEST/ (since the "T" in "HEST" stands for "Table")

> +/* HEST Sub-structure for PCIE EndPoint Structure (6) */

PCIe Root Port, if I'm following this correctly.

> +/* HEST Sub-structure for PCIE EndPoint Structure (7) */

PCIe Endpoint.

> +/* HEST Sub-structure for PCIE/PCI Bridge Structure (8) */

PCIe/PCI-X Bridge
