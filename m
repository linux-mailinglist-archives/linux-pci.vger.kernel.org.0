Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A6614A28
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 12:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKAL7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKAL7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 07:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483221A2;
        Tue,  1 Nov 2022 04:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF85D60F12;
        Tue,  1 Nov 2022 11:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6ECC433C1;
        Tue,  1 Nov 2022 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667303970;
        bh=jE2un0Sz/ysAPdWfNQruk9QmhmYI1Sr+/LKCWpOOlWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kk/lfsrrExZHeqKWIiVyavCryh2/yVKVq+BhUY+NEXfY7TIgxd6/5KuCdc7X8OlVK
         ae8LeA/RAaqT9fhUAZX0CWMewDcr1StcO3eTefVjMZm3XyBQbfJaQeu0B+xawYuSDt
         uzlMKXkFm7irV5ijcRZk7sJxRpQslUAw1FGJUh/bNLnnOu0E/UmCuDOLd0rVaMx6mO
         sgyIgo9WWHrg2o7XJJnHZ2TExJLM7AcNDLPsOkqFeSgzgdKG6VAz1x6dMYoI+CPObh
         P6iOztgIoQIEg9x5fwbYJgqrEZpWoYhb8nxMTkeV+2EufAxiIOfFAqiaDT935/fBsA
         lGRoTIHiwHnFw==
Date:   Tue, 1 Nov 2022 17:28:48 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-epf-vntb: remove unused field
 epf_db_phy
Message-ID: <20221101115848.GH54667@thinkpad>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
 <20221028155703.318928-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028155703.318928-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 11:57:00AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> None use epf_db_phy and remove it.

"epf_db_phy is not used, so remove it"

> 
> Signed-off-by: Frank Li <frank.li@nxp.com>

With that,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 191924a83454..ee66101cb5c4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -136,7 +136,6 @@ struct epf_ntb {
>  
>  	struct epf_ntb_ctrl *reg;
>  
> -	phys_addr_t epf_db_phy;
>  	void __iomem *epf_db;
>  
>  	phys_addr_t vpci_mw_phy[MAX_MW];
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
