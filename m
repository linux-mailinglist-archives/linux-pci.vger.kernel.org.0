Return-Path: <linux-pci+bounces-39132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B398C007EF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71D8A501875
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB7E30C345;
	Thu, 23 Oct 2025 10:29:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8630AD15;
	Thu, 23 Oct 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215345; cv=none; b=TIqtwFxNqgKlEqPSkn5gW+F7k0fgdmB4vyt2gbrbg6twGKLf1VqwH5bIUDq8X2+KB6INGjPllknaj1lRWzNUW6z6S7l9aDp1zXVH4RlSLTqqZPgfJ/fo4Jb7AQL//FUrYVOVcJ2Wjo28EnEe6L4u5VmLT2H6Ul/yUjTBGKSotow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215345; c=relaxed/simple;
	bh=pGPo9/UqrRNsd8AKSl1YMoYQnLW+87Ri18eV4hTmovY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMLKtDTx3EP+wuzSr88Wf/XJ66H4LvrUkSeYjuR9M68eHa3C0yrMmyYv4OjCMi9oyktd2YGxsI7L8Zjdzy43tDl52wiCJ9PEKzI2LKkDk5OxDtzn4sO1DpFB2fKSGvQh+vlnnNcIqkqv1jLc+NXYMVHsiI/W1MqCvQL886LGuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E9931200C2CB;
	Thu, 23 Oct 2025 12:29:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D4EA64A12; Thu, 23 Oct 2025 12:29:00 +0200 (CEST)
Date: Thu, 23 Oct 2025 12:29:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
Message-ID: <aPoDbKebJD30NjKG@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
 <aPZAAPEGBNk_ec36@wunner.de>
 <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>

On Mon, Oct 20, 2025 at 10:45:31PM +0800, Shuai Xue wrote:
> 	if (host->native_aer || pcie_ports_native) {
> 		pcie_clear_device_status(bridge);
> 		pci_aer_clear_nonfatal_status(bridge);
> 	}
> 
> This code clears both the PCIe Device Status register and AER status
> registers when in native AER mode.
> 
> pcie_clear_device_status() is renamed from
> pci_aer_clear_device_status(). Does it intends to clear only AER error
> status?
> 
> - BIT 0: Correctable Error Detected
> - BIT 1: Non-Fatal Error Detected
> - BIT 2: Fatal Error Detected
> - BIT 3: Unsupported Request Detected
> 
> From PCIe spec, BIT 0-2 are logged for functions supporting Advanced
> Error Handling.
> 
> I am not sure if we should clear BIT 3, and also BIT 6 (Emergency Power
> Reduction Detected) and in case a AER error.

AFAIUI, bits 0 to 3 are what the PCIe r7.0 sec 6.2.1 calls
"baseline capability" error reporting.  They're supported
even if AER is not supported.

Bit 6 has nothing to do with this AFAICS.

Thanks,

Lukas

