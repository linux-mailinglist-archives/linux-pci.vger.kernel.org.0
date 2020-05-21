Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E31DD8D9
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEUUuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 16:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgEUUuR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 16:50:17 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05BE22078B;
        Thu, 21 May 2020 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590094216;
        bh=pF78alMt3ZAvQ+IYKFegT1DqeGVCpoUhm4a+yo43GrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kYgpipI5wSOI78saKcfSyLfTrCzqEU/r61Eqvchvk88jlLPteICh+Kn5vFRxVSwfI
         +HvZkTLOk6Asy+sZql0jbaEgLhGi/UgFHCCJ9epUeHrc5BZ+SbfxcdVhjW1dZjLO0k
         qRAJ1lUjBA1W5HK8Yt/0NxdcDTcmL7Zfr/+JdLLg=
Date:   Thu, 21 May 2020 15:50:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] PCI/PTM: Fix PTM switch capability evaluation
Message-ID: <20200521205013.GA1181279@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b974380436d46ab3d8b7f4988f17e6f822079ac.1590068178.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 03:37:30PM +0200, Gustavo Pimentel wrote:
> In order to enable PTM feature in a PCIe Endpoint, it is required to
> enable this feature as well in all devices capable (if present) in the
> datapath between the Root complex and the referred Endpoint e.g. PCIe
> switches.
> 
> RC <--> Switch (USP) <-> Switch (DSP) <-> EP
> 
> According to PCIe specification Rev5 (6.22.3.2) and (7.9.16), in order
> to enable this feature on a PTM capable switch, it's required to write a
> enable bit in the switch upstream port (USP) control register, which after
> that must respond to all PTM request messages received at any of its
> downstream ports (DSP).
> 
> The previous implementation verifies if the PCIe switch has the PTM
> feature enabled on both streams ports (USP and DSP). Since the DSP
> doesn't support PTM capability, the previous implementation doesn't
> allow the PTM feature to be enabled in the Endpoint, the current patch
> fixes this.
> 
> Fixes: eec097d43100 ("PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints")
> Signed-off-by: Aditya Paluri <venkata.adityapaluri@synopsys.com>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Joao Pinto <jpinto@synopsys.com>

The existing code is definitely broken.  I would prefer to fix this on
the enumeration side, as opposed to walking the tree at enable-time.
Can you try the alternate patch below?

Bjorn

> ---
>  drivers/pci/pcie/ptm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 9361f3a..cd85d44 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -111,6 +111,14 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  	 */
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
>  		ups = pci_upstream_bridge(dev);
> +		/*
> +		 * Per PCIe r5.0, sec 7.9.16, the PTM capability is not
> +		 * permitted in Switch Downstream Ports
> +		 */
> +		if (ups && ups->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
> +		    pci_pcie_type(ups) == PCI_EXP_TYPE_DOWNSTREAM)
> +			ups = pci_upstream_bridge(ups);
> +
>  		if (!ups || !ups->ptm_enabled)
>  			return -EINVAL;
>  

commit b9e92258d486 ("PCI/PTM: Inherit Switch Downstream Port PTM settings from Upstream Port")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu May 21 15:40:07 2020 -0500

    PCI/PTM: Inherit Switch Downstream Port PTM settings from Upstream Port
    
    Except for Endpoints, we enable PTM at enumeration-time.  Previously we did
    not account for the fact that Switch Downstream Ports may not have a PTM
    capability; their PTM behavior is controlled by the Upstream Port (PCIe
    r5.0, sec 7.9.16).  Since Downstream Ports don't have a PTM capability, we
    did not mark them as "ptm_enabled", which meant that pci_enable_ptm() on an
    Endpoint failed because there was no PTM path to it.
    
    Mark Downstream Ports as "ptm_enabled" if their Upstream Port has PTM
    enabled.
    
    Fixes: eec097d43100 ("PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints")
    Reported-by: Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 9361f3aa26ab..0c42573a66d8 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -39,10 +39,6 @@ void pci_ptm_init(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
-	if (!pos)
-		return;
-
 	/*
 	 * Enable PTM only on interior devices (root ports, switch ports,
 	 * etc.) on the assumption that it causes no link traffic until an
@@ -52,6 +48,23 @@ void pci_ptm_init(struct pci_dev *dev)
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
 		return;
 
+	/*
+	 * Switch Downstream Ports may not have a PTM capability; their PTM
+	 * behavior is controlled by the Upstream Port (PCIe r5.0, sec
+	 * 7.9.16).
+	 */
+	ups = pci_upstream_bridge(dev);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM &&
+	    ups && ups->ptm_enabled) {
+		dev->ptm_granularity = ups->ptm_granularity;
+		dev->ptm_enabled = 1;
+		return;
+	}
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return;
+
 	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
 	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
 
@@ -61,7 +74,6 @@ void pci_ptm_init(struct pci_dev *dev)
 	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
 	 * furthest upstream Time Source as the PTM Root.
 	 */
-	ups = pci_upstream_bridge(dev);
 	if (ups && ups->ptm_enabled) {
 		ctrl = PCI_PTM_CTRL_ENABLE;
 		if (ups->ptm_granularity == 0)
