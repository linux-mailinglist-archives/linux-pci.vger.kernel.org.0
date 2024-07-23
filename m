Return-Path: <linux-pci+bounces-10628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB89939848
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135B31F22703
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FB1E868;
	Tue, 23 Jul 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8PbG/++"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141D3D6A;
	Tue, 23 Jul 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701964; cv=none; b=L92C+8QJYxcTtBB7ngd331niClUhu3fOoby2DflGZzhiUeBsnE+ZyJJQBrAVSrUsuYFt7/3OTbG+31odUsIR3bLtgeZS+BCIjeVKN6X6Pj++4F1Ti7OWvNRfYrhTlajlnYMVMNQIoDeTaAZ8IOVeUKHWNJb55kXDIrwsmBem/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701964; c=relaxed/simple;
	bh=4MjUjUt3+OExmiMhXeg3eaZMQ9NujtpsbSoluxp06HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuJZ19F63vWAoErehNAK36+6j/2n5ztPon42HkwqwpHINLS86+6n0u3wT5/QAl8GZfFCZ6BpnhDND9tucqiCWQfyqU4Ew6oSwwyhMVU+AxNfotQZlNHN0DoBlVA4qluISXN0ZI4dLdEMQgFh/vaQ3blBzH3Bx7C9cvKBBAlPvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8PbG/++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D505C116B1;
	Tue, 23 Jul 2024 02:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721701963;
	bh=4MjUjUt3+OExmiMhXeg3eaZMQ9NujtpsbSoluxp06HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8PbG/++481YtFJpvcbDhOkergvpVspSpxe9UNu/GoVd4PmC2fW9Z0J+EyB3zla5c
	 rEVmDFTaN7VZQvgOBxXdXjPXKQOueYljYHFPozC4T6XeLCWzgKYcjW5+t9aaOYt957
	 Eu9d4qYPHNhAWf6Sw9y5cXEHek/Pepr9x0R/mOvQF0dK8k030DU16DEhKgQ1M5Tu7/
	 srdMxhfyyMdlaZ4wzCmz8VX+Sy7rpDZm/2SXvXnpiXDe8EuNfUXTQalACReCXYO3G9
	 FArOwS3Oc1PpPT0xNVDPlpJ2WmNeUYUPg5Pb3DMZOqP8YpV/F9VRQJnNEI1G7z32aH
	 Fp3TjqCnW2AHA==
Date: Mon, 22 Jul 2024 20:32:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/13] dt-bindings: PCI: pci-ep: Update Maintainers
Message-ID: <172170195962.180906.10627145523008955004.robh@kernel.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-3-71d304b817f8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-pci-qcom-hotplug-v2-3-71d304b817f8@linaro.org>


On Wed, 17 Jul 2024 22:33:08 +0530, Manivannan Sadhasivam wrote:
> Kishon's TI email ID is not active anymore, so use his korg ID. Also, since
> I've been maintaining the PCI endpoint framework, I'm willing to maintain
> the DT binding as well. So add myself as the Co-maintainer.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


