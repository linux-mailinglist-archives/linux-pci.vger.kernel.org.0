Return-Path: <linux-pci+bounces-20656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28AAA25D60
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91556188BDE2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604102080F4;
	Mon,  3 Feb 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEyAGXAa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389B205E23;
	Mon,  3 Feb 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593770; cv=none; b=LmQTIDgxTeG6IebfGLgBlpJ3ScFUs96BkdlERpH2bEEWQJbTtF7TjXn03S5YctPQM0A6Js091gIOOCpIuclowhu/tZ1UWHG9aNxcub0qt4hWQtNXCf1KzGTf4BPfmTtOONDTl6GhkqIG3rrP9L6B3LKmbJdAQNV6mHLk3em7Aes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593770; c=relaxed/simple;
	bh=7qTSLx4AmEwiBlAKop9IxRVdPnJArLy31VhVkFM+m1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5Vr/mRkJJuWoL8GEdRXuuz5Bk+cn9ICx4wgqEok9BPMBWpmZe4JRTp222y+5CR2Omex7E8i68AtIdLcGYTMOFwLknPVuoldxH44aJkz0zHGI7sm1BTTCxDsG9iCxjvpjcxXU4gTcVZAPbgOx/fc05wRGISO2L9W5qrqW/iwloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEyAGXAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BDEC4CED2;
	Mon,  3 Feb 2025 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738593769;
	bh=7qTSLx4AmEwiBlAKop9IxRVdPnJArLy31VhVkFM+m1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nEyAGXAa5ZLM2+sCJia0Ss2/FjxWtzQTqw/gf5q4vNJJ7vxGUkS2vXe+kSDCkIZfS
	 wBPnnTzi8oa7isrD4CP/caDFB7G6/VWOLSmx9SomPeSQygxdlfcu3SAWbD9GhTXPHQ
	 Kjq//bfj3u1+iz/e47elZ5h483nTWO9C6WTxDbs2c5pWfdMstlKiM9bsZzngHmx+72
	 3Az3htAPsNvXH2edDe1rCW82AiEL9YfOzJIgSKTk1GbnAIHpTsx+Umz44UqylZZqwT
	 dNsNcwJXjs/Pi7r+aoO7h0E7Q9GmgVoTtC5svbGdMEfPNNybCwMSKSFKkV8rjzZxbj
	 Aw1wTov8EIpeg==
Message-ID: <aa93715c-6659-4cb2-b353-450054df04d9@kernel.org>
Date: Mon, 3 Feb 2025 15:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] PCI: altera: Add Agilex support
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	matthew.gerlach@altera.com, peter.colberg@altera.com,
	"D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>,
	D@thinkpad.smtp.subspace.kernel.org,
	M@thinkpad.smtp.subspace.kernel.org
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
 <20250127173550.1222427-6-matthew.gerlach@linux.intel.com>
 <20250203141819.tqjymcp5p47ti5b2@thinkpad>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250203141819.tqjymcp5p47ti5b2@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2025 15:18, Manivannan Sadhasivam wrote:
> On Mon, Jan 27, 2025 at 11:35:50AM -0600, Matthew Gerlach wrote:
>> From: "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
>>
>> Add PCIe root port controller support for the Agilex family of chips.
>> The Agilex PCIe IP has three variants that are mostly sw compatible,
>> except for a couple register offsets. The P-Tile variant supports
>> Gen3/Gen4 1x16. The F-Tile variant supports Gen3/Gen4 4x4, 4x8, and 4x16.
>> The R-Tile variant improves on the F-Tile variant by adding Gen5 support.
>>
>> To simplify the implementation of pci_ops read/write functions,
>> ep_{read/write}_cfg() callbacks were added to struct altera_pci_ops
>> to easily distinguish between hardware variants.
>>
>> Signed-off-by: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Driver changes LGTM! You just need to fix the checkpatch warnings as reported
> by krzk. With that,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I expected warnings, because of missing bindings, but there actually are
bindings, just some unusual order of patches, so maybe nothing to fix.

Anywy just in case: never mix DTS into the middle of patchset because it
just raises the question about dependency and you cannot have one. These
are different subsystems - DTS *always* goes to SoC.

Best regards,
Krzysztof

