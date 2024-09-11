Return-Path: <linux-pci+bounces-13036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9B99754D6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294CB1C2490B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D7319CC0C;
	Wed, 11 Sep 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD+JfgpX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D2193073;
	Wed, 11 Sep 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063046; cv=none; b=jzdwzClHEY+VQSDOXK8XklvbC8j8OVm5ElO66EM5dLUtLuabq4wZJu0BT75syXi0dSsYuOPfX0pM/EzwPHtOoVUVfqRZFBOStsyMzDokiKlVu0DrnprqswgHKWLNitXkvgZ1ZYwT+gbuJjYEWWAxVD8KPOeIQjS5fBzn/auqQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063046; c=relaxed/simple;
	bh=wImPhwLYU/yulcxrj5+8ZyqsYcLtMANEgV3hK2znSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV1kmHuGojcCWBkA7F/PRxZOSEQDqkysVTM1/h5RQmJ+1aL+aZROI6XoV0DPACPVSHcIlMX8HhV64fu2XQCFw4c392CZIwhs884yNYfSbx3DPKX0HSPDDkEImRHnfhZ8to7W1Mc1OzP2O3dVLkAW8N5xmdl2FB3Gd4Saa1G1LIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD+JfgpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB085C4CEC0;
	Wed, 11 Sep 2024 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726063044;
	bh=wImPhwLYU/yulcxrj5+8ZyqsYcLtMANEgV3hK2znSPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UD+JfgpXDztEgCkJASvgkXlKDpBY7O/zUfiXxQjWF5fesIf2oRxejlq0sVkdJ/T2x
	 EOZlP00Mq8EBL+Z9Cnu3ngPOudndqugnFpz/mgcE85GiDC70dQgI4H9z8XzAVQ4wgE
	 cABE/HrI3TgmjGfPfxheihxIteQaeQ8x21j0HtViYYCUV0+1GVwtyX+oKA942zz/0b
	 xO1R/Lo+/AvifHzVLKbqCbT+76tEdh7ZHnXLCkPU07gWkYR0yRJd5XjVLsFaeY0IIf
	 SX8Gc6qCyKxbcJgqQVfubgWQrSbym/ZM/N4n7680FQe31CdVCIAO7odZxkYIU7m9N0
	 zqe6l5vJuVeIw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1soNqo-000000006KZ-2LiB;
	Wed, 11 Sep 2024 15:57:43 +0200
Date: Wed, 11 Sep 2024 15:57:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <ZuGh1pdPVSYZ4gy_@hovoldconsulting.com>
References: <Zsb_1YDo96J_AGkI@hovoldconsulting.com>
 <20240911135106.GA629136@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911135106.GA629136@bhelgaas>

On Wed, Sep 11, 2024 at 08:51:06AM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 22, 2024 at 11:07:33AM +0200, Johan Hovold wrote:
> > On Tue, Jul 23, 2024 at 05:13:28PM +0200, Johan Hovold wrote:
> > > Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
> > > dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
> > > bindings, which results in DT checker warnings like:
> > > 
> > > 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
> > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> > > 
> > > Note that this property has been part of the Qualcomm PCIe bindings
> > > since 2018 and would need to be deprecated rather than simply removed if
> > > there is a desire to replace it with 'vpcie3v3' which is used for some
> > > non-Qualcomm controllers.
> > > 
> > > Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > Can someone pick this one up for 6.11?
> 
> I applied this to pci/dt-bindings for v6.12.
> 
> v6.11 is possible but we'd need a bit of a story to justify it.
> 756485bfbb85 appeared in v6.9, and the commit log says it fixes a DT
> checker warning, which don't make it sound like this is urgent.  Is
> there more to it that would make this v6.11 material?

No, merging for 6.12 is fine (e.g. this late in the cycle). Thanks.

Johan

