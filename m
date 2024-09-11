Return-Path: <linux-pci+bounces-13026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF83974A2F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 08:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E4C2878DD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936939FD7;
	Wed, 11 Sep 2024 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3N7AesZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086742AF18;
	Wed, 11 Sep 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035194; cv=none; b=r77Spbksm0ZJ2tyD0NagQout3aZ0aMP5yvmfFUZS4pyz9EUt0d7d2JMOTzmHOS+LsII0I/6oZmzWKpGZk+gxSkQeFZFcxPovGqzi/wE+eaoQxWw7wQ2UestO7A7v6swkLFTG4QQAhmM91C1lcruQqMyn2jjWPqVZbTn33OjZCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035194; c=relaxed/simple;
	bh=9jbMG3ru9EXg+xJ84H5vV5M8Oih5pehmomkdNLtVlyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lusF/e6CkIolBQH6B3nK423TOD4ELQHqumnPMy/3vJg3g0L/sUS9xpZAtIneaYPvHhc/eeTUwU4H4JlofKxPO6tRjnja5RtdDiy1Ce4QXi67QCNhlfyc05tRFf/b6uh7kjxew/CTpX4lP7YjbWabbruhQWQ4kPZjaAXibgCSFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3N7AesZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96550C4CEC5;
	Wed, 11 Sep 2024 06:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726035193;
	bh=9jbMG3ru9EXg+xJ84H5vV5M8Oih5pehmomkdNLtVlyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3N7AesZzBtc82YWzG6wUAVPXzCH22R3lO3lDSujsog1tQ0vZm9qXapMh7uJxCTqo
	 C8IOENbAMrhPYlyzeSX+amSshIHIHEgaC7R+CCpB3j8/E/pG18e5/K5yo+/R6durGs
	 l9EGfyj3c3x1b6rKr8U8Pzgnx0kOOmXSTIuRWkMBwBvXMJS8kGEaa5u7avtgeF9DJ2
	 0/PZ1wDgcW2PgviKroYQsmz+1pDZ18WF9PzG+0ODefdNg8pgW3Lou5XSrE/78JhsCY
	 BS9b1mmHxR+caxDvHlWrYsqvz7Q4iKLGqVgegRnQzJ76SSGeY1BMj715HocQ3B9Qc5
	 BJ2O9Cm0CMScw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1soGbb-000000005eO-1SCE;
	Wed, 11 Sep 2024 08:13:31 +0200
Date: Wed, 11 Sep 2024 08:13:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <ZuE1CzTmx2Jd4TCP@hovoldconsulting.com>
References: <20240723151328.684-1-johan+linaro@kernel.org>
 <Zsb_1YDo96J_AGkI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsb_1YDo96J_AGkI@hovoldconsulting.com>

On Thu, Aug 22, 2024 at 11:07:33AM +0200, Johan Hovold wrote:
> On Tue, Jul 23, 2024 at 05:13:28PM +0200, Johan Hovold wrote:
> > Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
> > dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
> > bindings, which results in DT checker warnings like:
> > 
> > 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> > 
> > Note that this property has been part of the Qualcomm PCIe bindings
> > since 2018 and would need to be deprecated rather than simply removed if
> > there is a desire to replace it with 'vpcie3v3' which is used for some
> > non-Qualcomm controllers.
> > 
> > Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Can someone pick this one up for 6.11?

Another three weeks have passed and the merge window is now around the
corner.

Can someone please pick this one up for 6.12.

Note that this patch has been acked by the driver maintainer as well as
a DT maintainer.

Johan

