Return-Path: <linux-pci+bounces-12203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD095F37D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF0828327B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D60E17839C;
	Mon, 26 Aug 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvCiD4bj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7902FC08;
	Mon, 26 Aug 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681097; cv=none; b=dI0F+ud0ny1CAoEla3+dl7wTTdx2vqbvggMcL9jsU7ooZFCBcGicDT0nzjBu0wEN1+CW6c13kdkid8Q/5YfrBDt2xyahb61LLYAc207Cww0cJrfgOeTDMzXhyjCz0KfMj01NG+e5H/Rj3a1Oq0MTGv1RzJ3Cq6GsstTQpnUS9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681097; c=relaxed/simple;
	bh=RqshmThvQvVFQmKHaMRsvx7fi4Gt/PX+vtUtT3n8hhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9+/LvV7F2dd8gCVoydw2sMrnVyq9KM/D4MiyEWf1mx9yL2+Qo0OQt4FVckVqoGh4277qOfGnstRTSm7JlnWKzD4DlhOCKH0SAaA6iAP0OQgdh2CLp/yAzQn8to7SH7MeV+u0kR8n1ikPJpIHjkNI0Ts5UzhsvIWL9vP4bSj7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvCiD4bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DD6C52FC0;
	Mon, 26 Aug 2024 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724681096;
	bh=RqshmThvQvVFQmKHaMRsvx7fi4Gt/PX+vtUtT3n8hhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvCiD4bjExmwQq/7sVm+i0PbrFCH03O0/69NSbeGxeuOKNtOzgyQ1QvDnfYM5Efo1
	 9UBXTew3j8D+AVWWBQOo30740MLZGyoShdnlTDsy1rxk+9iQ2my0LJB/CEcFwaPSEd
	 7OLvwvbogMnAJgl/3moIBET9kmvXdbDzWEYbSTDrtYpTL9j5x34G9lZtBoxUBrtThD
	 4b8nkq1ZBDI6IJeCat0GVpjZyFa+C9GXZfKCLxWRmz2w7QRwgAjpW6T/gZpP4gCr7n
	 Mb8HJs75ZE9EaN3+3Pda4dWTL2pCmA6L8qMWUQCBVLxw+mVfClQE+rrS6w68rNJfkF
	 BHfgUgpQIl0rQ==
Date: Mon, 26 Aug 2024 09:04:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	imx@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/1] dt-bindings: PCI: layerscape-pci: Add deprecated
 property 'num-viewport'
Message-ID: <172468109227.92699.12972235014145037669.robh@kernel.org>
References: <20240823185855.776904-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823185855.776904-1-Frank.Li@nxp.com>


On Fri, 23 Aug 2024 14:58:54 -0400, Frank Li wrote:
> Copy the 'num-viewport' property from snps,dw-pcie-common.yaml to
> fsl,layerscape-pcie.yaml to address the below warning. This is necessary
> due to historical reasons where fsl,layerscape-pcie.yaml does not
> directly reference snps,dw-pcie-common.yaml.
> 
> /arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


