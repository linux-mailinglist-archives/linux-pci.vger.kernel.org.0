Return-Path: <linux-pci+bounces-4395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651CF86FC47
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA931F21606
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD633D0B6;
	Mon,  4 Mar 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXE51NYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F11DA5B;
	Mon,  4 Mar 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541857; cv=none; b=Z/YOcVD7FlkLgfutSGPiyQaUfkf3BI5BkPihzBd/L/BELEmT0ASHDIjjDYbsKUX+qAxRMaMe+/sIcq3Gbs1/vMe8Q1ytbTbQdAqQZCShz4SoQgEdKhLrzCulX2jzgo/0x1NGbOYCm7EYqrsYhrHofOmVCOi0RuZ9+bSE5t+FQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541857; c=relaxed/simple;
	bh=m3btwuB1XUM+0/1Srhrmy8oBrwYrCSMk8C4cHIhZwpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8//Pn/8aHczXdhdITMkbuoWyNbn3fJiFBrsNln9Ub4R1wkPgydhVBH0yQidmnROAm7SV3Boq0tDsLbjsr9Azd9mpMBVZIqBeHbORynRXi8OeMH7brpc5hc5VC4qz4Qlipdoh8Zevnr0kPc1wopNIoRkYoWgohR5ARRV+jdM668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXE51NYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0C3C43399;
	Mon,  4 Mar 2024 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709541857;
	bh=m3btwuB1XUM+0/1Srhrmy8oBrwYrCSMk8C4cHIhZwpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXE51NYDqpQ6Rpt9NCI+I0KTgTxx8Ob9USgAHcXYvtmVdkGqv9AJOiPikODi/j8+J
	 7JMubxXRMWEnVhoLTktK0+ZSoBnHvSbaG7TShTXMSmNd9wdyeXvcVBKx5E859ICTT4
	 HBoz1rjslk7YRW72BGTovEg/P++8uW9LfQTYy3vhl5wn0yn/ioLGvJ/fW707WhVa78
	 m216Hm24/eDT/aA9PiVuIvA2ukGsRri5g7nghmfQOMZv6wHhIPtASbOLZCoWVsjGHV
	 N/uK6O2Dkz6XaukXb+Ik9dnu49PD3loVvBZsOhM/NIJ7CUuAonay1v5ra93D6LBqYR
	 PKHtKW3BB9x3g==
Date: Mon, 4 Mar 2024 09:44:09 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v10 03/14] PCI: imx6: Simplify reset handling by using by
 using *_FLAG_HAS_*_RESET
Message-ID: <ZeWJ2Z5kKoqbeWYn@lpieralisi>
References: <20240205173335.1120469-4-Frank.Li@nxp.com>
 <20240301190931.GA403500@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301190931.GA403500@bhelgaas>

On Fri, Mar 01, 2024 at 01:09:31PM -0600, Bjorn Helgaas wrote:
> [+cc Nathan]
> 
> On Mon, Feb 05, 2024 at 12:33:24PM -0500, Frank Li wrote:
> > Refactors the reset handling logic in the imx6 PCI driver by adding
> > IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.
> > 
> > The drvdata::flags and a bitmask ensures a cleaner and more scalable
> > switch-case structure for handling reset.
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Lorenzo, would you mind squashing in Nathan's fix from
> https://lore.kernel.org/r/20240301-pci-imx6-fix-clang-implicit-fallthrough-v1-1-db78c7cbb384@kernel.org?
> 
> Also, the subject line has a repeated "by using by using".

I will fix it up.

Thanks,
Lorenzo

