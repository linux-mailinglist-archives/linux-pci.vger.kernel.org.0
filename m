Return-Path: <linux-pci+bounces-4669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE7876793
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD261C21798
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD321104;
	Fri,  8 Mar 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7FSbwUG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDC24B21;
	Fri,  8 Mar 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912826; cv=none; b=HV+TUhPIbJ9F+8ikYoSWtKMGqyQIEfUYR4UM/Ql6B1sKgf9qECofyk7EWnxIMT2hmpzD8BSp3bmNBc10nvHDJKrCU0JUJR4seSexqw99rgYEhnigNIPhobZZnodcyjnX45sPalR8h63ML6P5w664itaQaqK3Ssutgxerfwwtv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912826; c=relaxed/simple;
	bh=l2K9wiOr2tNH/BYguc0CqSDjwSjakfCUr6j37VreWNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpjOtJajWLA8nEGhiTumNQ5dosMlt4C32lPPB5Cq89XkJT1iOeYKIGKnndz+i38D0YrgYbRQ56N43Gt8Ycg0QJEViyv3ugjav+7wOzytDDIUawNJZfQj42caOYHAxaMl+CtEsmH0roVrgTP/OtSBPjB41gITiiQa7t3+K4SS/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7FSbwUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4EFC433C7;
	Fri,  8 Mar 2024 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709912825;
	bh=l2K9wiOr2tNH/BYguc0CqSDjwSjakfCUr6j37VreWNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7FSbwUGBtZ4Juut7DNOO3CBIzWhL+/PLRWLQ6rk+P++2zZP7zthPzZ6RLT74bPxe
	 qYZeCzLguL88XTxQhE0rafX8WtIc8MxItQf4AOHynj11lZIy3hch1k7dFefhLYuMxW
	 DYltJYLfi1nPWBulpbw5fWeSq4eHdjd6e9+mYZIhnsSOwS1CIb3mia7948yqXYaee7
	 MLTSRUMdigKpxxh6BLWrr9sBfV1fxTzx5g9YjxTBYfj+IRh9pUEb7VPn9azzb0jt31
	 bXQqWx694LGMT4ltZ7bTKhC5Nv/0IvqYbnaibA7ZZzFXEYfnNnE3JkGldxxsVBHjk4
	 yl/YjKbN+s9Rw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ricRF-000000004GK-1JII;
	Fri, 08 Mar 2024 16:47:13 +0100
Date: Fri, 8 Mar 2024 16:47:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3
 ITS enable
Message-ID: <ZeszAWpz8KtuPI2a@hovoldconsulting.com>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306095651.4551-1-johan+linaro@kernel.org>

On Wed, Mar 06, 2024 at 10:56:46AM +0100, Johan Hovold wrote:
> This series addresses a few problems with the sc8280xp PCIe
> implementation.

> Qualcomm has now confirmed that this is an issue on sc8280xp and its
> derivate platforms. Specifically, the PHY configuration used on these
> platforms is not correctly tuned for L0s and there is currently no
> updated configuration available.
> 
> As we are now at 6.8-rc7, I've rebased this series on the Qualcomm PCIe
> binding rework in linux-next so that the whole series can be merged for
> 6.9 (the patch to disable l0s and the devicetree fix are both marked for
> stable backport anyway).
> 
> The DT bindings and PCI patch are expected to go through the PCI tree,
> while Bjorn A takes the devicetree updates through the Qualcomm tree.

> Johan Hovold (5):
>   dt-bindings: PCI: qcom: Allow 'required-opps'
>   dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
>   PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p

Bjorn H, could you pick up these three for 6.9-rc1?

>   arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
>   arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe

That way there's a small chance that Bjorn A can be able to squeeze in
the patch to enable ITS in 6.9 too (e.g. if there's an rc8).

Johan

