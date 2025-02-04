Return-Path: <linux-pci+bounces-20710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF337A279E8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 19:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A24162010
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F8217711;
	Tue,  4 Feb 2025 18:33:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68A20DD4B;
	Tue,  4 Feb 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694010; cv=none; b=oMrB8wk+dCx7IMLjxusREzK1ZLfnuv6ASrdj0j5V0GPp9Moswqtyn9U4WKry1FLhSGqYggPxEJX1Sa3xBQpNYzjpoc8H4uM4+dLkqoS+P7SDb23XRdqOQfvoBSRkgmCc1Vvx83Ra5chyuFNfCqQAbhKUOoVvYymC1QfAireOtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694010; c=relaxed/simple;
	bh=9tCl/OAJveyPGvp2Qy6lKZ2tmZJINBFUAGiCJIMj5IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmpFC7OFADaI10/iFleScJho2Igo4g6KmMFPnzbVyBv3RlCRif11o0PUOH45LLwzJ0GQsvXt+nNEc6fxYUaQQQ9HWjE5nTIBP1UOEsLBEq6turCiCALszjqLvsG9DEQ/pVI16j0AZhB6iPDOaqrT4ZNK7bSva+B6sXBqZ86nOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B80611FB;
	Tue,  4 Feb 2025 10:33:51 -0800 (PST)
Received: from [10.57.35.4] (unknown [10.57.35.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4D73F58B;
	Tue,  4 Feb 2025 10:33:22 -0800 (PST)
Message-ID: <a373416b-bf00-4cf7-9b46-bd95599d114c@arm.com>
Date: Tue, 4 Feb 2025 18:33:19 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/5] PCI/TPH: Add Steering Tag support
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20241002165954.128085-1-wei.huang2@amd.com>
 <20241002165954.128085-3-wei.huang2@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241002165954.128085-3-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 5:59 pm, Wei Huang wrote:
[...]
> +/**
> + * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
> + * @pdev: PCI device
> + * @index: ST table entry index
> + * @tag: Steering Tag to be written
> + *
> + * This function will figure out the proper location of ST table, either in the
> + * MSI-X table or in the TPH Extended Capability space, and write the Steering
> + * Tag into the ST entry pointed by index.
> + *
> + * Returns: 0 if success, otherwise negative value (-errno)
> + */
> +int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
> +{
> +	u32 loc;
> +	int err = 0;
> +
> +	if (!pdev->tph_cap)
> +		return -EINVAL;
> +
> +	if (!pdev->tph_enabled)
> +		return -EINVAL;
> +
> +	/* No need to write tag if device is in "No ST Mode" */
> +	if (pdev->tph_mode == PCI_TPH_ST_NS_MODE)
> +		return 0;
> +
> +	/* Disable TPH before updating ST to avoid potential instability as
> +	 * cautioned in PCIe r6.2, sec 6.17.3, "ST Modes of Operation"
> +	 */
> +	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
> +
> +	loc = get_st_table_loc(pdev);
> +	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
> +	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
> +
> +	switch (loc) {
> +	case PCI_TPH_LOC_MSIX:
> +		err = write_tag_to_msix(pdev, index, tag);
> +		break;
> +	case PCI_TPH_LOC_CAP:
> +		err = write_tag_to_st_table(pdev, index, tag);
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	if (err) {
> +		pcie_disable_tph(pdev);
> +		return err;
> +	}
> +
> +	set_ctrl_reg_req_en(pdev, pdev->tph_mode);

Just looking at this code in mainline, and I don't trust my 
understanding quite enough to send a patch myself, but doesn't this want 
to be pdev->tph_req_type, rather than tph_mode?

Thanks,
Robin.

> +
> +	pci_dbg(pdev, "set steering tag: %s table, index=%d, tag=%#04x\n",
> +		(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST", index, tag);
> +
> +	return 0;
> +}

