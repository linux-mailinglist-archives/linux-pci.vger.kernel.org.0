Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148857E633
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiGVSEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiGVSEe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 14:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A313F93;
        Fri, 22 Jul 2022 11:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A00BB829DF;
        Fri, 22 Jul 2022 18:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CE9C341C6;
        Fri, 22 Jul 2022 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658513071;
        bh=I9rg0pdukwVqyXqT3G9fo2Fk6rs00uJZapALvEXvvUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=efRjADUYK9tMFhM0sQ2zyEnj0Wv2RHw1a9WGR/P21akil/jdzX/qvnxdb89CqSamc
         7akDU1o+uHAqp1R6T5GEgWoW9jpwoGRjPjn2+hg2ylID9coEe1gqIJaSd6wBAxdutw
         E10T7aP3cvoFfGS6C+Uuq7xJwZCBRYhkT2aTyMlYhE9VnvLCPeQackL4sp1kLbXU2D
         EeIscwLzZ6p62bO7omiyW0LXuQ58Y1OTpDajBuXa94AkkvYFORwVqWfM0qo0d398T+
         N7F364/vESkDtgFGJtZRktH4lyeqripghabxff25R2EC+plz54URMhxje6s+1iGri3
         wLmYpI3KPJu9g==
Date:   Fri, 22 Jul 2022 13:04:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Update link to PCI firmware specification
Message-ID: <20220722180429.GA1915025@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722174754.27921-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 22, 2022 at 12:47:54PM -0500, Mario Limonciello wrote:
> The previous link to the PCI firmware specification in the comments
> for drivers/pci/pci-acpi.c no longer works.  Update the comment
> to a current link to this specification.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to pci/misc for v5.20, thanks, Mario!

> ---
>  drivers/pci/pci-acpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 3760d85c10d2..a46fec776ad7 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -21,8 +21,9 @@
>  #include "pci.h"
>  
>  /*
> - * The GUID is defined in the PCI Firmware Specification available here:
> - * https://www.pcisig.com/members/downloads/pcifw_r3_1_13Dec10.pdf
> + * The GUID is defined in the PCI Firmware Specification available
> + * here to PCI-SIG members:
> + * https://members.pcisig.com/wg/PCI-SIG/document/15350
>   */
>  const guid_t pci_acpi_dsm_guid =
>  	GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
> -- 
> 2.34.1
> 
