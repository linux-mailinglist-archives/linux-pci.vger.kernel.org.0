Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4496968C912
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 23:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBFWAu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 17:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBFWAt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 17:00:49 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCF2ED51;
        Mon,  6 Feb 2023 14:00:47 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 49A0628010889;
        Mon,  6 Feb 2023 23:00:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 238A82E9C99; Mon,  6 Feb 2023 23:00:44 +0100 (CET)
Date:   Mon, 6 Feb 2023 23:00:44 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
Subject: Re: [PATCH 05/18] ACPICA: Fix 'struct acpi_cdat_dsmas' spelling
 mistake
Message-ID: <20230206220044.GA21823@wunner.de>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571660543.587790.9945516736671124794.stgit@djiang5-mobl3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167571660543.587790.9945516736671124794.stgit@djiang5-mobl3.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 01:50:06PM -0700, Dave Jiang wrote:
> 'struct acpi_cadt_dsmas' => 'struct acpi_cdat_dsmas'
> 
> Fixes: 51aad1a6723b ("ACPICA: Finish support for the CDAT table")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

ACPICA changes need to go into upstream first (via a pull request on
GitHub).  Once it's merged, you can submit the same patch downstream
for the kernel and reference the ACPICA commit with a Link: tag.

I've already submitted a pull request for the exact same change more
than a week ago:

https://github.com/acpica/acpica/pull/830

The pull request has been approved but not merged.  Hopefully that'll
happen soon.

Thanks,

Lukas

> ---
>  include/acpi/actbl1.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 4175dce3967c..e8297cefde09 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -344,7 +344,7 @@ enum acpi_cdat_type {
>  
>  /* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
>  
> -struct acpi_cadt_dsmas {
> +struct acpi_cdat_dsmas {
>  	u8 dsmad_handle;
>  	u8 flags;
>  	u16 reserved;
> 
> 
