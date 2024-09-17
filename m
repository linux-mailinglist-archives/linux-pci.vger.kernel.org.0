Return-Path: <linux-pci+bounces-13253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7697AC32
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 09:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39B7B2988D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A11649CC;
	Tue, 17 Sep 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS6EJ24y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33A16193C;
	Tue, 17 Sep 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558343; cv=none; b=SgZluajj2APtTop52b7qo3DSuSLkiA3jUMYI78/TKCDIKbupYiu6TLGKBH1Q+Z2p7EWwdz0mVRpdhS29nWIpNoza5nYLZyItGErZcCXteCj6TXtawDnh+CDDdEcKwpGIjEkbO381Fut5r10etBMWUddiwXwD8TDega+fqpDLwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558343; c=relaxed/simple;
	bh=7Hwfh6nn+H/Twj0M/m3ZP/p1nsY1WaGzgv9vCVQ8AIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5TL49fk3f+9eiFuj+tTSVvsccQ3Dd14P70IXFfjQoMDMPkFjdA+UcEiaHRBjiG1bd10NxWeI7PLNhebHrfKuk0t60qigB0TRy1i8/qI1p9ow9GoU0HY/l3QlaW8B0QXLK1lEp2jcoDHByAuQde4HVNh1uDA3p1qJc0JEJ1pzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS6EJ24y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3611C4CEC7;
	Tue, 17 Sep 2024 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726558342;
	bh=7Hwfh6nn+H/Twj0M/m3ZP/p1nsY1WaGzgv9vCVQ8AIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MS6EJ24yFiZUzotIPLx2ItHcWVuE6SmgpHu5EHKBoZvZvmH97MgabzDFD4vhlOrVh
	 oUtjNODTpOUma8LbNsu1ThwciMEyjwW8tRLuu8HsYhIg+s/qKAPuf47iPC5j46efAG
	 7JXCU8FO8USMPYmwqGUBGKY76TnIpPcJ5/rEKqCvDaj2tBxDFc3gWEzzynRv28oRjN
	 DQihrB5caChEERV5git0IROmNZ/2ryT+JT9NQEXnn5u5uHnw4nRcwBjjqU606Q8ECU
	 bcihVHkRbYlt3kVR5Eo9jaX9GgQBcsOqSNrdfFhmQFXjF4eWdNqfxh00jNJKSGTQxY
	 fYl1THonV9hUw==
Date: Tue, 17 Sep 2024 08:32:15 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V5 2/5] PCI/TPH: Add Steering Tag support
Message-ID: <20240917073215.GH167971@kernel.org>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-3-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916205103.3882081-3-wei.huang2@amd.com>

On Mon, Sep 16, 2024 at 03:51:00PM -0500, Wei Huang wrote:
> pcie_tph_get_cpu_st() is added to allow a caller to retrieve Steering Tags
> for a target memory that is associated with a specific CPU. The ST tag is
> retrieved by invoking ACPI _DSM of the device's Root Port device.
> 
> pcie_tph_set_st_entry() is added to support updating the device's Steering
> Tags. The tags will be written into the device's MSI-X table or the ST
> table located in the TPH Extended Capability space.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>

...

> @@ -45,6 +201,163 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
>  	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
>  }
>  
> +/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
> +static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
> +{
> +	struct msi_desc *msi_desc = NULL;
> +	void __iomem *vec_ctrl;
> +	u32 val, mask;
> +	int err = 0;
> +
> +	msi_lock_descs(&pdev->dev);
> +
> +	/* Find the msi_desc entry with matching msix_idx */
> +	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
> +		if (msi_desc->msi_index == msix_idx)
> +			break;
> +	}
> +
> +	if (!msi_desc) {
> +		err = -ENXIO;
> +		goto err_out;
> +	}
> +
> +	/* Get the vector control register (offset 0xc) pointed by msix_idx */
> +	vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
> +	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
> +
> +	val = readl(vec_ctrl);
> +	mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
> +	val &= ~mask;
> +	val |= FIELD_PREP(mask, (u32)tag);

Hi Wei Huang,

Unfortunately clang-18 (x86_64, allmodconfig, W=1, when applied to net-next)
complains about this.  I think it is because it expects FIELD_PREP to be
used with a mask that is a built-in constant.

drivers/pci/pcie/tph.c:232:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
  232 |         val |= FIELD_PREP(mask, (u32)tag);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
  115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
   72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   74 |                                  _pfx "type of reg too small for mask"); \
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
././include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
  510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
  498 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
  490 |                 if (!(condition))                                       \
      |                       ^~~~~~~~~
1 warning generated.

> +	writel(val, vec_ctrl);
> +
> +	/* Read back to flush the update */
> +	val = readl(vec_ctrl);
> +
> +err_out:
> +	msi_unlock_descs(&pdev->dev);
> +	return err;
> +}

...

