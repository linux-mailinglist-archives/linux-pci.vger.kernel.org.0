Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C59177840A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 01:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjHJXRX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjHJXRW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 19:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF592694;
        Thu, 10 Aug 2023 16:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D3B63F6A;
        Thu, 10 Aug 2023 23:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05667C433C8;
        Thu, 10 Aug 2023 23:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691709441;
        bh=qPsFwAx57nmNmTH+gfAIk/AJ5OPfBVdOZsSrENFXzIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Brh2InwBRZ2PU8X4rPr7NVOjKO27ikzR6XL4NXBKIQA4X0kYcFx1XWbNXmhqCtCEC
         JQe5PDtZACf2j/D49hBAOHxA6OrsKkWjp8RNxi3vVGx4jo3CHrz4ydFunw62SLgGWQ
         iqYqZ0aOly/ZD5u/weZ3wTZjb2ijKjE7WBDTrX4+uvIGNcUuaJu4WTi9x7RBIvHD05
         uvW+VhEIfnWxkGRaYNlGrio577ImogHoJAqhqc2FY7kmx+VZ6itS9wC+q5MnO9g+Tl
         c+jEDBP9vZ0hARK+vshUBLKqft0wp4JsKhzOUmW6Yw1tyIlbGDG6h+AddXFNMoVcJt
         XyisDmtpVDKTg==
Date:   Thu, 10 Aug 2023 18:17:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH v3 2/5] ACPI/APEI: Remove static from apei_hest_parse()
Message-ID: <20230810231718.GA49532@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704120517.1322195-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 04, 2023 at 08:05:17PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Each dev with AER capability needs to call the apei_hest_parse function to
> match and extract register values from HEST PCIe AER structures.
> Therefore, remove static from apei_hest_parse() so that it can be called
> in another file.

Can you reword the subject line and commit log in the positive?
"Removing static" is a negative thing and it's semantically a bit too
low level -- it's clearly what the *code* does, but we can see that
from the patch, and what we want to know here is *why* it's important.
What this really does is expose apei_hest_parse() for use by other
subsystems.

Browsing the drivers/acpi commit log history, I see that Rafael adds
"()" after function names, so please do the same here (you did do that
once above, but not in the first line).

> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/acpi/apei/hest.c | 2 +-
>  include/acpi/apei.h      | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index fb839a5c480ee..fd40c035c9b2e 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -132,7 +132,7 @@ static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
>  	return false;
>  }
>  
> -static int apei_hest_parse(apei_hest_func_t func, void *data)
> +int apei_hest_parse(apei_hest_func_t func, void *data)

If this is going to exported to the PCI subsystem, I think it needs
some kernel-doc.  For example, it's important to know that it stops
parsing the HEST if func returns anything non-zero.  This is how
pci_acpi_program_hest_aer_params() knows that it got good data that
matches the device it wants.

Given the fact that apei_hest_parse_aer() fills in the struct
acpi_hest_parse_aer_info with pointers into the HEST table data, it's
also important to know that this HEST table data is persistent.

>  {
>  	struct acpi_hest_header *hest_hdr;
>  	int i, rc, len;
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index 8a0b2b9edbafe..f975e4fe78fcb 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -37,9 +37,14 @@ typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> +int apei_hest_parse(apei_hest_func_t func, void *data);
>  int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
>  #else
>  static inline void acpi_hest_init(void) { }
> +static inline int apei_hest_parse(apei_hest_func_t func, void *data)
> +{
> +	return -EINVAL;
> +}
>  static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
>  {
>  	return -EINVAL;
> -- 
> 2.34.1
> 
