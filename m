Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4414F4A51FF
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 23:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiAaWFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 17:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiAaWFW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 17:05:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC6C061714;
        Mon, 31 Jan 2022 14:05:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BE896159A;
        Mon, 31 Jan 2022 22:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B66AC340E8;
        Mon, 31 Jan 2022 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643666720;
        bh=rtMYLz36aZm/StOCmHf/+PfRe3vImM7acI85NsbHfzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IpyvB65SXg8lxmpn7BQGkjJrzU6/cJMc0aRy3XbWM0/5Ga+DyaFPOgn/OnERV6Mcd
         NSBmi5R5nH/1S+u8602wv2tlRia6VHoRtKxMJSQA0rs88jJL4rM0VamxsshryGIjRK
         IkX7s6X5SJIE52YVw9B7ylwEPMRX7B9Sa2X3TTzCA1YyWRaNw8qlQAvun/5nsMfD+f
         L6EvSbUhtjKMDQZsl/SBuE8rKCfQtDKLFq/WCoRM78Qm40GKzyJJPj9Dj5GbVtyI0u
         UdBh00Qisljv+MQB77fnqWdB6QNsnTI+UCSr+MBkfn71N3E3GULOY+6Zaro7YRmSMU
         3KrLUhdl8zVNg==
Date:   Mon, 31 Jan 2022 16:05:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
Message-ID: <20220131220518.GA515079@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131120841.118833-1-christian.gmeiner@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update subject line to match previous conventions ("git log --oneline
drivers/pci/controller/cadence/pcie-cadence-host.c" to see).

On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> This enables the Controller [RP] to automatically respond
> with Response/ResponseD messages.

Update to imperative mood, e.g., "Enable Controller to ...":

  https://chris.beams.io/posts/git-commit/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v5.16#n134

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index fb96d37a135c..940c7dd701d6 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
>  	return ret;
>  }
>  
> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);

I assume this is some device-specific enable bit that is effectively
ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
Capability?

> +}
> +
>  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
> @@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	if (rc->quirk_detect_quiet_flag)
>  		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
>  
> +	cdns_pcie_host_enable_ptm_response(pcie);
> +
>  	ret = cdns_pcie_start_link(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed to start link\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index c8a27b6290ce..9510ea513b8a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -116,6 +116,10 @@
>  #define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
>  					(((aperture) - 2) << ((bar) * 8))
>  
> +/* PTM Control Register */
> +#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0DA8)
> +#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
> +
>  /*
>   * Endpoint Function Registers (PCI configuration space for endpoint functions)
>   */
> -- 
> 2.34.1
> 
