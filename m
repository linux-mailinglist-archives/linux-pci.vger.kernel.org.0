Return-Path: <linux-pci+bounces-22468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3CA46E48
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 23:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6FE16DA70
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F626F47B;
	Wed, 26 Feb 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZcLE6rH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AC26F465;
	Wed, 26 Feb 2025 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607979; cv=none; b=jJg7b7VnOnoyIpuWEuWztFLgN7zV+s/zlmH0gtkM8rbZHqVxiYic6vZuUS/r/XZpypktuARIG+FFWBwkXw6ooAALWq6kDoyNN2bGddpESXeDkX/yW6PGS0ddPYd+QyPW3gpjrsCCeL0eErKD+xlpZ4zn5JgHgSMPJYiZTnoXPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607979; c=relaxed/simple;
	bh=AyITmA8rf9pMLh099tYprgLtyEciAbbLGdntk9qGI60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h8QEmOvaAmbLEzQygHjkw1aHKdYZPQfEX7tHAcnZXpJdDK39gpIUPZwSEDqftmLXra95L+b+OkfatCu+BgKOJ8H0Cs17BF3j9uN1d3CxiCk6UuDlAczWJUDhzIQozHpI5fkaqYLXPKDyBZXf1ZpxklRLIad1vnf4QyOcx1cE+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZcLE6rH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE78C4CEE9;
	Wed, 26 Feb 2025 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607978;
	bh=AyITmA8rf9pMLh099tYprgLtyEciAbbLGdntk9qGI60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XZcLE6rH24Lom8DmUNZKENo7PwJQ/pixzYhyTfDgEUaSLt+KSpFefYJseuhnvDYCy
	 Aa5pU4gq4QnOm/axD6ArmqMt2q7Z0QX0q8hHNL33dwPYjd7lwjEIRa6YEuxYfyA3Fn
	 2B6TJZCkme4O/PvBFj/dqtnBT1/DnNWu+W+4JF/0bP7n9dgAnx75ahOCohlyPSN3GE
	 tRSmZgqr2ck6WEIjWdeGaK7DuM0UpbvZPBhr+eGWqma//YwgDCVwN+H6ZRMzO4QwAu
	 cBsdfD2VVtBLRAl1gZVhkAmyj2Q8dbH5xQCIsRRFGo1EKoPF8WCwmxfSKH/6ONomr5
	 Eak0Yc1WgWIYg==
Date: Wed, 26 Feb 2025 16:12:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v7 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Message-ID: <20250226221254.GA561689@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-preset_v6-v7-2-a593f3ef3951@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 05:15:05PM +0530, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
> 
> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> configure lane equalization presets for each lane to enhance the PCIe
> link reliability. Each preset value represents a different combination
> of pre-shoot and de-emphasis values. For each data rate, different
> registers are defined: for 8.0 GT/s, registers are defined in section
> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> an extra receiver preset hint, requiring 16 bits per lane, while the
> remaining data rates use 8 bits per lane.
> 
> Based on the number of lanes and the supported data rate, this function
> reads the device tree property and stores in the presets structure.

Can you mention the function name here somewhere so we don't have to
dig it out of the patch?  If you put it in the subject, the function
name is descriptive enough that you hardly need anything more, e.g.,

  PCI: of: Add of_pci_get_equalization_presets() API

> + * of_pci_get_equalization_presets - Parses the "eq-presets-Ngts" property.
> + *
> + * @dev: Device containing the properties.
> + * @presets: Pointer to store the parsed data.
> + * @num_lanes: Maximum number of lanes supported.
> + *
> + * If the property is present read and store the data in the preset structure
> + * else assign default value 0xff to indicate property is not present.
> + *
> + * Return: 0 if the property is not available or successfully parsed; errno otherwise.

Wrap to fit in 80 columns like the rest of the file.

> + */
> +int of_pci_get_equalization_presets(struct device *dev,
> +				    struct pci_eq_presets *presets,
> +				    int num_lanes)
> +{

