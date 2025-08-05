Return-Path: <linux-pci+bounces-33421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159CB1B227
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 12:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5433A3FF6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A521771A;
	Tue,  5 Aug 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZIA6rl4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877A2566;
	Tue,  5 Aug 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390567; cv=none; b=tfG2ufpe0Dn6kxBtlqRcPd8ChMXTFB5lqD1q0SUESvyu+8gar4w52OPB9CpefrvAjnLGre/h+LQejkRNwjqiKDA5WyGHNbcGrC8ekyX5o2yI9nxhTtuycMcZB5n31cfX2iePph9kYNWyJ15fZfe5m3o8rLN4f0FaGJXWbzM5MAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390567; c=relaxed/simple;
	bh=rK71U250BK27CMyHf1FowcrdOTFDq8gjL7pfGebYpEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKaJaDwvTL4einJWDrU6g6mnxQXMrBPhKCxg1iC/vk6noeNdx+In8JLfpuH8czZpZtgUpMieBSfBHun7U+aMbnUbtDYg+TGoXobNc9StotBmfToxTnJr6Fp0nWZn7LgZosI6AMGqKBKbaNo7vNm8zhi0F4fbDkEcvKZBXbB3ZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZIA6rl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A99BC4CEF4;
	Tue,  5 Aug 2025 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754390567;
	bh=rK71U250BK27CMyHf1FowcrdOTFDq8gjL7pfGebYpEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZIA6rl4omdzTy8g7gTN1gA/6k2Y0gFk+ifudok3drvkaP49riohOADH+jtfNKnAT
	 u6WDQGSYmK8eXF4Ef7Q9A+uMSXLzGxHiNb9AyKRRYW25DH5Xf52N5TPUGodsjeL0pL
	 aKEbvxrB6l4efVsPYfr35c+iiu6DF/g29kzmFtmIJvhTkS8evr11bq9uQ75gCAssH4
	 stYvm0zcpqRKIq5LCaPS6RJvKm8iAXgxsV/OikzqcsQjT1GHtn1lswhB+v1/I+ikQG
	 aLvd1GQMejjsRpOUbn8Ydz2WL188ZCoqKheOo1C18IFzaS3XkCF+YmmaV4hMcM9WdM
	 Zx7BKG3AX83UA==
Date: Tue, 5 Aug 2025 16:12:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>, 
	Brian Norris <briannorris@chromium.org>, Minghuan Lian <minghuan.Lian@nxp.com>, 
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] pci: nwl: Unhandled AER correctable error
Message-ID: <g4w5tcasa4ka24rqhgmbrmrua5a23dytgcbsqkuoyzekgmv43f@2wjltdepyizc>
References: <20250804205702.GA3640524@bhelgaas>
 <23d9f128-af95-41b1-a5b9-3c69d2df8ab8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23d9f128-af95-41b1-a5b9-3c69d2df8ab8@linux.dev>

On Mon, Aug 04, 2025 at 06:10:48PM GMT, Sean Anderson wrote:
> On 8/4/25 16:57, Bjorn Helgaas wrote:
> > [+cc more folks who might be interested in AER with non-standard
> > interrupts]
> > 
> > On Fri, Aug 01, 2025 at 01:43:19PM -0400, Sean Anderson wrote:
> >> Hi,
> >> 
> >> AER correctable errors are pretty rare. I only saw one once before and
> >> came up with commit 78457cae24cb ("PCI: xilinx-nwl: Rate-limit misc
> >> interrupt messages") in response. I saw another today and,
> >> unfortunately, clearing the correctable AER bit in MSGF_MISC_STATUS is
> >> not sufficient to handle the IRQ. It gets immediately re-raised,
> >> preventing the system from making any other progress. I suspect that it
> >> needs to be cleared in PCI_ERR_ROOT_STATUS. But since the AER IRQ never
> >> gets delivered to aer_irq, those registers never get tickled.
> >> 
> >> The underlying problem is that pcieport thinks that the IRQ is going to
> >> be one of the MSIs or a legacy interrupt, but it's actually a native
> >> interrupt:
> >> 
> >>            CPU0       CPU1       CPU2       CPU3       
> >>  42:          0          0          0          0     GICv2 150 Level     nwl_pcie:misc
> >>  45:          0          0          0          0  nwl_pcie:legacy   0 Level     PCIe PME, aerdrv
> >>  46:         25          0          0          0  nwl_pcie:msi 524288 Edge      nvme0q0
> >>  47:          0          0          0          0  nwl_pcie:msi 524289 Edge      nvme0q1
> >>  48:          0          0          0          0  nwl_pcie:msi 524290 Edge      nvme0q2
> >>  49:         46          0          0          0  nwl_pcie:msi 524291 Edge      nvme0q3
> >>  50:          0          0          0          0  nwl_pcie:msi 524292 Edge      nvme0q4
> >> 
> >> In the above example, AER errors will trigger interrupt 42, not 45.
> >> Actually, there are a bunch of different interrupts in MSGF_MISC_STATUS,
> >> so maybe nwl_pcie_misc_handler should be an interrupt controller
> >> instead? But even then pcie_port_enable_irq_vec() won't figure out the
> >> correct IRQ. Any ideas on how to fix this?
> >> 
> >> Additionally, any tips on actually triggering AER/PME stuff in a
> >> consistent way? Are there any off-the-shelf cards for sending weird PCIe
> >> stuff over a link for testing? Right now all I have 
> > 
> > This is definitely a problem.  We have had some discussion about this
> > in the past, but haven't quite achieved critical mass to solve this in
> > a generic way.  Here are some links:
> > 
> >   https://lore.kernel.org/linux-pci/20250702223841.GA1905230@bhelgaas/t/#u
> >   https://lore.kernel.org/linux-pci/1464242406-20203-1-git-send-email-po.liu@nxp.com/
> 
> Thanks for the links. Toggling PERST does seem to reliably cause
> correctable errors (however "correctable" they may actually be in
> practice). With the patch I posted on the other branch of this chain I
> now get
> 
> [   43.041610] pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
> [   43.050693] pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [   43.061477] pcieport 0000:00:00.0:   device [10ee:d011] error status/mask=00000001/0000e000
> [   43.069842] pcieport 0000:00:00.0:    [ 0] RxErr                 
> 
> Whether or not that's the right fix, at least I can test things :)

Could you please check if INTX is working for AER? You can just pass the cmdline
parameter, "pcie_pme=nomsi" and observe if the IRQ is getting triggered.

We have a desire to add platform IRQs for AER, but before doing that we need to
make sure that the platform doesn't support both MSI and INTx.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

