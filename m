Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810175A2BA9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 17:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbiHZPuN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344708AbiHZPtn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 11:49:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63F5CC6CDE
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 08:49:40 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DA50236D99C;
        Fri, 26 Aug 2022 08:49:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DA50236D99C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1661528979;
        bh=SgxSubnScgbDSB/BDiI1rdwxJ9Bi+rXMRXF3GFtjEs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHbY0qw8dFGwkibvNR9txb7lfCd9qDwpV7h3QGIvyryAt0dIrx0Dg+R+kVV5ZFrF8
         6EbH9eLBxilVo0tnS4YKWSemR5gBZTvomN0oqQRmH0zxVh6GAZLap7he+GHBvKcOOj
         LazW/8/pSNTwaoz9cGXvg9V5/vPLIX49S1xM0Hxk=
Date:   Fri, 26 Aug 2022 10:49:33 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20220826154933.GB39334@sequoia>
References: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> mode, so that it's more likely that a hot-added device will work in
> a system with an optimized MPS configuration.
> 
> Obviously, the Linux itself optimizes the MPS settings in the
> PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> for these modes.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---

Hi Bjorn - We have some interest in this patch and I am hoping it can be
considered in preparation for v6.1. I took a look at it and it makes
sense to me but I'm not an expert in this area. Thanks!

Tyler

>  drivers/pci/probe.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..2c5a1aefd9cb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2034,7 +2034,9 @@ static void pci_configure_mps(struct pci_dev *dev)
>  	 * Fancier MPS configuration is done later by
>  	 * pcie_bus_configure_settings()
>  	 */
> -	if (pcie_bus_config != PCIE_BUS_DEFAULT)
> +	if (pcie_bus_config != PCIE_BUS_DEFAULT &&
> +	    pcie_bus_config != PCIE_BUS_SAFE &&
> +	    pcie_bus_config != PCIE_BUS_PERFORMANCE)
>  		return;
>  
>  	mpss = 128 << dev->pcie_mpss;
> @@ -2047,7 +2049,7 @@ static void pci_configure_mps(struct pci_dev *dev)
>  
>  	rc = pcie_set_mps(dev, p_mps);
>  	if (rc) {
> -		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
> +		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_peer2peer\" and report a bug\n",
>  			 p_mps);
>  		return;
>  	}
> -- 
> 2.17.1
> 
