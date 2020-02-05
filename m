Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A530A153750
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 19:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBESLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 13:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgBESLe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 13:11:34 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D952720674;
        Wed,  5 Feb 2020 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926293;
        bh=WB1JyKrS75c2AvvUswc+cIqLLh1dfJg7gVlsy6wC/kA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CPtgGAUtn1Atx/7LmpFSw9Q/tc/VPVL/YIdNdZ3vgj4MBw7Xo5O9EQPsY4hWmQrBc
         xAdPbXEhrqZpX2jPWprIhMfprD8mZpO6iFbUyand9qwCCQJoZa4KRXMZTH8DDbls0X
         l7098IKAmz+V+hONMt5kgU/1dHAh7kXuakpXw5hY=
Date:   Wed, 5 Feb 2020 12:11:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v1 1/1] PCI/ATS: For VF PCIe device use PF PASID
 Capability
Message-ID: <20200205181131.GA226021@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe891f9755cb18349389609e7fed9940fc5b081a.1580325170.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 11:14:00AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Per PCIe r5.0, sec 9.3.7.14, if a PF implements the PASID Capability,
> the PF PASID configuration is shared by its VFs. VFs must not implement
> their own PASID Capability. But, commit 751035b8dc06 ("PCI/ATS: Cache
> PASID Capability offset") when adding support for PASID Capability
> offset caching, modified the pci_max_pasids() and pci_pasid_features()
> APIs to use PASID Capability offset of VF device instead of using
> PASID Capability offset of associated PF device. This change leads to
> IOMMU bind failures when pci_max_pasids() and pci_pasid_features()
> functions are invoked by PCIe VF devices.
> 
> So modify pci_max_pasids() and pci_pasid_features() functions to use
> correct PASID Capability offset.
> 
> Fixes: 751035b8dc06 ("PCI/ATS: Cache PASID Capability offset")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Applied to for-linus for v5.6, thanks!  I also added a stable tag
since 751035b8dc06 appeared in v5.5.

> ---
>  drivers/pci/ats.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 982b46f0a54d..b6f064c885c3 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -424,11 +424,12 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
>  int pci_pasid_features(struct pci_dev *pdev)
>  {
>  	u16 supported;
> -	int pasid = pdev->pasid_cap;
> +	int pasid;
>  
>  	if (pdev->is_virtfn)
>  		pdev = pci_physfn(pdev);
>  
> +	pasid = pdev->pasid_cap;
>  	if (!pasid)
>  		return -EINVAL;
>  
> @@ -451,11 +452,12 @@ int pci_pasid_features(struct pci_dev *pdev)
>  int pci_max_pasids(struct pci_dev *pdev)
>  {
>  	u16 supported;
> -	int pasid = pdev->pasid_cap;
> +	int pasid;
>  
>  	if (pdev->is_virtfn)
>  		pdev = pci_physfn(pdev);
>  
> +	pasid = pdev->pasid_cap;
>  	if (!pasid)
>  		return -EINVAL;
>  
> -- 
> 2.21.0
> 
