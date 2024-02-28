Return-Path: <linux-pci+bounces-4212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC386BA8A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 23:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2179C1C22F3F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715281361B5;
	Wed, 28 Feb 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX3RE+mK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E001361A4;
	Wed, 28 Feb 2024 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158127; cv=none; b=cDZfvCUumjVJnNCsv+jRWGpH4JGdZPIbIO8MbQ2Zjtr6FwSXhUU/mE2bPu0i9P6kd0zRhGTbZs1tv0JTos8s5K8/X74O7JcK0EaUeS1SnmX3VqkgpDcDQyzj6WuYzwBuhhZnDPhGbG9Z89UFmu4CZFxuWEx8Sm+PaDvNyYFjHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158127; c=relaxed/simple;
	bh=cDIB7eI+qfgraTst6qw8uLCsKY/61Gvo/qIhEP5EUZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qv8Xq/kzhA1JflSfCBreCfTN+niV6vzgOrP2pGk2SyiYumbMbxaIHRLamofa4j6eWnus7fAMtS6x+YQI5TgKKHQJ2perLZlkv3SAk2sLNLOZaoxkZUzcGqEV1lMNic/NTViogk8uWmZoVQmXFGvtum9uPjXskXgcW8HoPgaMX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX3RE+mK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD49C433C7;
	Wed, 28 Feb 2024 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709158125;
	bh=cDIB7eI+qfgraTst6qw8uLCsKY/61Gvo/qIhEP5EUZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JX3RE+mKdKR3cvs2/r6iCFu+RJTvicZ9D4D1E2qwq5kEnO0q5ozRlFgi6RPZbSD+n
	 Kz4JTeGOFFE+8Ox6q084bxDjKJW4oPxfZ8wulEKEe8AV70+XjzAGUUasrk7PMcGkMz
	 /aa9ExC4RfKqEYouEuTIsCvdNLApe6NIUDhWwzfMHYy0o6RLioqLF2/n3FYxluK5dy
	 1oEStdLGgcp4lNjFeAeiP7RL8w0FHuHX30YRNgOMCN7VenEGcbN5yDv3/A1oBIlv8T
	 bpgfItgqgi/zRR0UTHiu3c5RVlCErz9/KijTaVaAkX8bLkRMs9iBLd431PSMnA/GZO
	 /gWj+V8w2a8hQ==
Date: Wed, 28 Feb 2024 16:08:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <20240228220843.GA309344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>

[+to Mani]

On Fri, Feb 23, 2024 at 04:21:12PM +0100, Johan Hovold wrote:
> This series addresses a few problems with the sc8280xp PCIe
> implementation.
> ...

> A recent commit enabling ASPM on certain Qualcomm platforms introduced
> further errors when using the Wi-Fi on the X13s as well as when
> accessing the NVMe on the CRD. The exact reason for this has not yet
> been identified, but disabling ASPM L0s makes the errors go away. This
> could suggest that either the current ASPM implementation is incomplete
> or that L0s is not supported with these devices.
> ...

> As this series fixes a regression in 6.7 (which enabled ASPM) and fixes
> a user-reported problem with the Wi-Fi often not starting at boot, I
> think we should merge this series for the 6.8 cycle. The final patch
> enabling the GIC ITS should wait for 6.9.
> 
> The DT bindings and PCI patch are expected to go through the PCI tree,
> while Bjorn A takes the devicetree updates through the Qualcomm tree.
> ...

> Johan Hovold (12):
>   dt-bindings: PCI: qcom: Allow 'required-opps'
>   dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
>   dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
>   PCI: qcom: Add support for disabling ASPM L0s in devicetree

The ASPM patches fix a v6.7 regression, so it would be good to fix
that in v6.8.

Mani, if you are OK with them, I can add them to for-linus for v6.8.  

What about the 'required-opps' and 'msi-map-mask' patches?  If they're
important, I can merge them for v6.8, too, but it's late in the cycle
and it's not clear from the commit logs why they shouldn't wait for
v6.9.

Bjorn

