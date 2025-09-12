Return-Path: <linux-pci+bounces-36064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D2B5589F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D79AA7B65
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DC26F289;
	Fri, 12 Sep 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPkiIYGN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906E4C81;
	Fri, 12 Sep 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713855; cv=none; b=jZVXjYjgNKFXd8+CyJNxMq1qGWihoR5EvAmaj9RoQKVFz/muM8rVkHuK4hqBkN8gyfvELy+Cowlh5jNI3W+zdUSOu3Mk14VxPE46MIncX6fC9FtcBNXp1nqKZWls1rkLbL5sXq4WJJaj5UqKgeG2APIph0OuND8duUxrwLFAEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713855; c=relaxed/simple;
	bh=I32UvaadbaJ72Eaidbhmruy+XECfJJW6sIgil2cnjeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GfWJ0pGm5u9Fv5faIowM+5ZBVP+9fUakGnr2SvYIAZc4V7SSbx3+zibANYA8OGmtjeZXPXWISJotToiE0CiKsGP2iKgLtKoBnhnQDjCBmv7VJRsBHFsmf4ceM7CY66tx/mymh0MOZS1ETSlxPWQ7aBgGR6RYCJETWvt5EfiiOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPkiIYGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD397C4CEF1;
	Fri, 12 Sep 2025 21:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757713855;
	bh=I32UvaadbaJ72Eaidbhmruy+XECfJJW6sIgil2cnjeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gPkiIYGNsVnzkGKHbxxmFqBsyIMcycgphKoCmbj8GCCYzxsWhQT3JRMOfmPyMqODQ
	 uzGBxRZL3dghbATykaG2tSVEML0iOTtx1CmufOncToMeAUNzYK2GbPG/9ADADC+F/q
	 TKmW6+PwUvNMEyFhDRectkEsWwFj/rqtvzT1GiBIYYRZCkQb4m7EIcd0r84ohOvsyX
	 kjCilPYUg+ek55S/3MfjHoUcR1urIuTIDrF77z1T80tQRtaDG24SkwPg3MJqH6AB70
	 j+3h6uxILGb51saPCUzDZhSfNo5dZOf3HZM7qqTPv4f62lHTAklzyMKeHXrb1gsQKW
	 XbM9D3n5jJQ/w==
Date: Fri, 12 Sep 2025 16:50:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v9 3/4] PCI: qcom: Prepare for the DWC ECAM enablement
Message-ID: <20250912215053.GA1643809@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-controller-dwc-ecam-v9-3-7d5b651840dd@kernel.org>

On Tue, Sep 09, 2025 at 12:37:52PM +0530, Manivannan Sadhasivam wrote:
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> To support the DWC ECAM mechanism, prepare the driver by performing below
> configurations:
> 
>   1. Since the ELBI region will be covered by the ECAM 'config' space,
>      override the 'elbi_base' with the address derived from 'dbi_base' and
>      the offset from PARF_SLV_DBI_ELBI register.
> 
>   2. Block the transactions from the host bridge to devices other than Root
>      Port on the root bus to return all F's. This is required when the 'CFG
>      Shift Feature' of iATU is enabled.

FWIW, before I noticed your v9, I had updated the comments here to fix
a few inconsistencies.  Here's the diff:

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7c2b2c8c61c2..962f0311a23a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -343,15 +343,15 @@ static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
 	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
 
 	/*
-	 * The only device on root bus is a single Root Port. So if PCI core
-	 * tries to access any devices other than Device/Function (0.0) in Bus
-	 * 0, the TLP will go outside of the controller to the PCI bus. But with
-	 * CFG Shift Feature (ECAM) enabled in iATU, there is no guarantee that
-	 * the response is going to be all F's. Hence, to make sure that the
+	 * The only device on the root bus is a single Root Port. If we try to
+	 * access any devices other than Device/Function 00.0 on Bus 0, the TLP
+	 * will go outside of the controller to the PCI bus. But with CFG Shift
+	 * Feature (ECAM) enabled in iATU, there is no guarantee that the
+	 * response is going to be all F's. Hence, to make sure that the
 	 * requester gets all F's response for accesses other than the Root
-	 * Port, configure iATU to block the transactions starting from function
-	 * 1 of the root bus to the end of the root bus (i.e from dbi_base + 4kb
-	 * to dbi_base + 1MB).
+	 * Port, configure iATU to block the transactions starting from
+	 * function 1 of the root bus to the end of the root bus (i.e., from
+	 * dbi_base + 4KB to dbi_base + 1MB).
 	 */
 	addr = pci->dbi_phys_addr + SZ_4K;
 	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
@@ -1385,7 +1385,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ecam_enabled) {
 		/*
 		 * Override ELBI when ECAM is enabled, as when ECAM
-		 * is enabled ELBI moves along with the dbi config space.
+		 * is enabled ELBI moves along with the DBI config space.
 		 */
 		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
 		pci->elbi_base = pci->dbi_base + offset;

