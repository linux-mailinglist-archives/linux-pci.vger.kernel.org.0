Return-Path: <linux-pci+bounces-14791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4B9A24E2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFEF28B52C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EEA1DE3DA;
	Thu, 17 Oct 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnIrR9EN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015F1DE3C3;
	Thu, 17 Oct 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174914; cv=none; b=FzmFoz/Xr7ldwq6R5pSfwqIJ/jq6JXc2T/YekenULZPPLIYpt4gMBe4/A0Gzu0MSoKydzrEA1i6nl9cXfSNj/23jB3a7UZGuw2T+UZDiWIwy93NWoy+/B5A9e8EntikEVSuocLFU7Ipty3c2Kg7RSuu9MtNqsEsMtUhEbw/x/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174914; c=relaxed/simple;
	bh=TJxiR5fL2lynj8uABjj7XdbAFsYnPYmJljXDS5EcbhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UCsNraJ1pKyZsILr5Kyugf8b5CIUYuk1vzSslgausxfCzOR4kjBjX22oiW9cgRXAbp9icLC1m2m/59Ljqox2mQG6Wm8D6ct3jmol+V3m+C3m7u2o4isKTbBVTc2XeRvXUl6Rm9uUhGLhgax+2yDFVTo8Mam12DF2KHhGVMnGSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnIrR9EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA887C4CEC7;
	Thu, 17 Oct 2024 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174913;
	bh=TJxiR5fL2lynj8uABjj7XdbAFsYnPYmJljXDS5EcbhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FnIrR9ENRWy8tI+DCS8KAkeWLyg9IxZCpmJRbl1306BQazoEg+Gic67eFCyfA5gzW
	 XvZWZvofSA3HfFUX2AQvmu9SZcq8FlKhpzZU7yU8qbbFnE/hI76F2vkQyR1B1608Vx
	 gRN3UAtalbXxkbYWEE0cNsCXpH5Q929e0oU7kol07PGb8g4Z/gTNvhlYuDWvAYgSmL
	 0aNjUnnLDGT4yoYqSFvfGuTOlNJ34uof55xLyqQl4LawyVwRMSOOgfgl9eRRa1xKaI
	 6H1SOdDD2QmQeHTYywFCr+JxoKyEBlRoKx0fQKHeFX+Y8YcCyslarfFI7sc6gBUEmK
	 ghp2JY6LAQJfA==
Date: Thu, 17 Oct 2024 09:21:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next 1/2] PCI: Add PCI_VDEVICE_SUB helper macro
Message-ID: <20241017142152.GA685610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017131647.4255-1-piotr.kwapulinski@intel.com>

On Thu, Oct 17, 2024 at 03:16:47PM +0200, Piotr Kwapulinski wrote:
> PCI_VDEVICE_SUB generates the pci_device_id struct layout for
> the specific PCI device/subdevice. The subvendor field is set
> to PCI_ANY_ID. Private data may follow the output.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  include/linux/pci.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> This patch is a part of the series from netdev.
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4..2b6b2c8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1050,6 +1050,20 @@ struct pci_driver {
>  	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
>  	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
>  
> +/**
> + * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
> + * @vend: the vendor name
> + * @dev: the 16 bit PCI Device ID
> + * @subdev: the 16 bit PCI Subdevice ID
> + *
> + * Generate the pci_device_id struct layout for the specific PCI
> + * device/subdevice. The subvendor field is set to PCI_ANY_ID. Private data
> + * may follow the output.
> + */
> +#define PCI_VDEVICE_SUB(vend, dev, subdev) \
> +	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
> +	.subvendor = PCI_ANY_ID, .subdevice = subdev, 0, 0

I don't think it's right to specify the subdevice (actually "Subsystem
ID" per spec) without specifying the subvendor ("Subsystem Vendor ID"
in the spec).

Subsystem IDs are assigned by the vendor, so they have to be used in
conjunction with the Subsystem Vendor ID.  See PCIe r6.0, sec
7.5.1.2.3:

  Values for the Subsystem ID are vendor assigned. Subsystem ID
  values, in conjunction with the Subsystem Vendor ID, form a unique
  identifier for the PCI product. Subsystem ID and Device ID values
  are distinct and unrelated to each other, and software should not
  assume any relationship between them.

