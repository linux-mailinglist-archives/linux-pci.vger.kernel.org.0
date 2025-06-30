Return-Path: <linux-pci+bounces-31109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5939AEE88E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08B57A95DB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069C221DB5;
	Mon, 30 Jun 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLaYmDt6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AD1F3B97;
	Mon, 30 Jun 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316720; cv=none; b=N2EbHpkkGB+W5r7ep3XRDkPKYwWb5eWgY3fnR7caROsWxsMlp0QFRcxjdCWxasrf6ZVvBEj5W4IK194jL9+pnODzIbkIRotGzKTNY6zxXRn5+hHVn3dk9mdu7vgXksVWj9Lw46/nL6F+5jjButEQo71yfjgcV+6YIUfpxPCDXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316720; c=relaxed/simple;
	bh=JdyRZH5BJ88ivihFwPavGB92a6PBslWIdcXsPwgE0Co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kK/pWY1p1QuCgXVlICh/T/6SEcxGTIB1zfvXahmiDUXK8wM5cbW+1+5ZU9Tt0ceAWbDRgC6QuS9lMuzOvejfj1mVfRmIK8F1AlolohjBb6hlpjy/CJnY2cDarhN3/Vx8n6ugn3kTuq8lCIDlQmEBXsTIzDSXS/h1mKHVRDPOATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLaYmDt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E1EC4CEE3;
	Mon, 30 Jun 2025 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751316719;
	bh=JdyRZH5BJ88ivihFwPavGB92a6PBslWIdcXsPwgE0Co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JLaYmDt6JBDSL87SWQR3ICatIHSv6P910ve69LvzvnESHSxqxgVfyZhEV9ooFokrW
	 llr/FBDJHwx5wVCWDMYnafVIgukHF35ysYE4nyK5ys3CaTEABjj7Xp7i0jIMPy2pMb
	 pEVdSjEs9vjjm2g0gkM3ZitbxmrQcYR2M6nwj2SfTWiangHO4mLrk3TxUEdsoJajbC
	 SI4PsVDUzhS3sERZEuXaGsMVk56uItv0eraxqXP1GG5Zy3h+Dx2gUy+5lPY96RxG9t
	 cLVTHG1xyWSYcXnKwD0CHgxS+wuENOojdkXHBG1f+Rhp62XXyg+K8Qz1bm5wdmLkBC
	 2bgECWzOd41uQ==
Date: Mon, 30 Jun 2025 15:51:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] PCI: dwc: Add debugfs support for PTM context
Message-ID: <20250630205158.GA1809065@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617231210.GA1172093@bhelgaas>

On Tue, Jun 17, 2025 at 06:12:10PM -0500, Bjorn Helgaas wrote:
> On Mon, May 05, 2025 at 07:54:41PM +0530, Manivannan Sadhasivam wrote:
> > Synopsys Designware PCIe IPs support PTM capability as defined in the PCIe
> > spec r6.0, sec 6.21. The PTM context information is exposed through Vendor
> > Specific Extended Capability (VSEC) registers on supported controller
> > implementation.
> 
> > +const struct pcie_ptm_ops dw_pcie_ptm_ops = {
> 
> Sparse complains:
> 
>   CHECK   drivers/pci/controller/dwc/pcie-designware-debugfs.c
> drivers/pci/controller/dwc/pcie-designware-debugfs.c:868:27: warning: symbol 'dw_pcie_ptm_ops' was not declared. Should it be static?
> 
> I should have noticed this earlier, sorry.  As of v6.16-rc1, this is
> now 852a1fdd34a8 ("PCI: dwc: Add debugfs support for PTM context")
> upstream.

Keeping this warm so we remember to fix it eventually.

