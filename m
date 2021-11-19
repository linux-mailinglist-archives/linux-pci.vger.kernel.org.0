Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B9F45791C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhKSWyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:54:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231231AbhKSWyT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 17:54:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8D3D61AF0;
        Fri, 19 Nov 2021 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637362277;
        bh=7GznTvTop0lokx6cVFXD5gAa4aQh8V7B6/e5YII3q+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=myHT6n+iTdJAVtBDiVhYqckUNcJ+EDbIYXS0uuIdTsfnvP+szrY5uqph2BBn9e0/2
         TDtJLUsOVQqscqgGVRCWOfChRwRg1XSGlCL9RoSqOq3ZabIFZridCqfyIGLoZ/Ar+r
         MwxRA/kwWuS1Sbt8aw0hHSzbdSFuIdrrBJ7dP6TrFNc1gUDv4+Lyf9rQgLoIrUehS6
         Q4ZRWzOD7Vs3LJGKebNcwS4z0e20Rx8HtKfVhWFkNFTjKDcNM3gtzpGBNgaqHTnk/4
         Q0BXPYwsrUOYJ2C2FYvPseXSBBd/+KWq+6iPtXVRea6naG/Alrx/615p9T+42Rb3mN
         O+Of3dC9PM2Og==
Date:   Fri, 19 Nov 2021 16:51:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, hch@lst.de
Subject: Re: [RFC PATCH v5 0/4] PCI/ASPM: Remove struct aspm_latency
Message-ID: <20211119225115.GA1980058@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211119193732.12343-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 08:37:28PM +0100, Saheed O. Bolarinwa wrote:
> To validate and set link latency capability, `struct aspm_latency` and
> related members defined within `struct pcie_link_state` are used.
> However, since there are not many access to theses values, it is
> possible to directly access and compute these values.
> 
> Doing this will also reduce the dependency on `struct pcie_link_state`.
> 
> The series removes `struct aspm_latency` and related members within
> `struct pcie_link_state`. All latencies are now calculated when needed.
> 
> 
> VERSION CHANGES:
> - v2:
> »       - directly access downstream by calling `pci_function_0()`
> »         instead of using the `struct pcie_link_state`
> - v3:
> »       - rebase on Linux 5.15-rc2
> - v4
> »       - Create a seprate path to move pci_function_0() upward
> - v5
> 	- shorten long lines as noted in the review
> 
> MERGE NOTICE:
> These series are based on
> »       'commit fa55b7dcdc43 ("Linux 5.16-rc1")'
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Bolarinwa O. Saheed (1):
>   PCI/ASPM: Move pci_function_0() upward
> 
> Saheed O. Bolarinwa (3):
>   PCI/ASPM: Do not cache link latencies
>   PCI/ASPM: Remove struct pcie_link_state.acceptable
>   PCI/ASPM: Remove struct aspm_latency
> 
>  drivers/pci/pcie/aspm.c | 95 +++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 51 deletions(-)

Applied to pci/aspm for v5.17, thanks very much!  We're chipping away
at the cruft in aspm.c little by little.

I made the following changes.  Some whitespace; the rest to take
advantage of the fact that Device Capabilities is read-only and Amey
added a cache of it with 691392448065 ("PCI: Cache PCIe Device
Capabilities register")

That commit uses FIELD_GET(), which is kind of slick and might be
useful in aspm.c as well.

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e29611080a90..c6d2e76e0502 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -378,7 +378,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw;
+	u32 latency, encoding, lnkcap_up, lnkcap_dw;
 	u32 l1_switch_latency = 0, latency_up_l0s;
 	u32 latency_up_l1, latency_dw_l0s, latency_dw_l1;
 	u32 acceptable_l0s, acceptable_l1;
@@ -390,24 +390,22 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		return;
 
 	link = endpoint->bus->self->link_state;
-	pcie_capability_read_dword(endpoint, PCI_EXP_DEVCAP, &reg32);
+
 	/* Calculate endpoint L0s acceptable latency */
-	encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
+	encoding = (endpoint->devcap & PCI_EXP_DEVCAP_L0S) >> 6;
 	acceptable_l0s = calc_l0s_acceptable(encoding);
+
 	/* Calculate endpoint L1 acceptable latency */
-	encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
+	encoding = (endpoint->devcap & PCI_EXP_DEVCAP_L1) >> 9;
 	acceptable_l1 = calc_l1_acceptable(encoding);
 
 	while (link) {
-		struct pci_dev *dev = pci_function_0(
-					link->pdev->subordinate);
+		struct pci_dev *dev = pci_function_0(link->pdev->subordinate);
 
 		/* Read direction exit latencies */
-		pcie_capability_read_dword(link->pdev,
-					   PCI_EXP_LNKCAP,
+		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP,
 					   &lnkcap_up);
-		pcie_capability_read_dword(dev,
-					   PCI_EXP_LNKCAP,
+		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
 					   &lnkcap_dw);
 		latency_up_l0s = calc_l0s_latency(lnkcap_up);
 		latency_up_l1 = calc_l1_latency(lnkcap_up);
