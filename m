Return-Path: <linux-pci+bounces-34459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D8B2FD24
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D006261E9
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3351DED47;
	Thu, 21 Aug 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6iu2OSG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8515990C;
	Thu, 21 Aug 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787002; cv=none; b=asAlG0foKIH0tuF1k0ze1PdmTXTXSB6AD7aBZ1gV+RvhclcGRd2BhLOeaTXOUehPcO5nwjmU30ntBS2+UPxic7z9BVNqjqgUc6PtLrrUhFvUiMTmlIdtOQmgVkaWquj9Kpv8cPxIZonMB7I4nt7q33wVCUGtwnuh9BYpopdz7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787002; c=relaxed/simple;
	bh=mslOxpgPXJUH1lPNo77g9hu/LctQ1v616V6U+vFUEuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=os3HuXvjXyUQEVR4Svf1Cr5tzZuCelb6Utu6xdG7oZaWnpbF7Na7NXzUW6Q5sg1WqunMj9uuKbVnlwx6YdGX4sDV9K/1BboVBOVGr+2PYRRheECG2WzWhj6nKJkhFaRkZJjooF6r1nsoKGoaKVGPp8GY8OfAMP8pBdF3HaSIKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6iu2OSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555F0C4CEF4;
	Thu, 21 Aug 2025 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755787002;
	bh=mslOxpgPXJUH1lPNo77g9hu/LctQ1v616V6U+vFUEuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A6iu2OSGmM5F1jb5AqsqgYWlPZCfFqiYce5lrehvWxbBEyzLtTugwCQ4UGIpAtGeH
	 mtXyP9+eEm+EFKT4gEUFyaIoCIDv5XNhwDCOa3jvLtDuDZYg33VdJX7b7Yl8kmLZ9u
	 iLbs+755oUD1UrtOUrRlDUwrVxTj8IkR69l7289qRT5MJA0eBuREIH/L6CVrmsdp0T
	 mLLjoVacNl46v5K1/5ChCpVyJucsu7GcEhhimHvKynGX/OCfZQkyq28l5Du8EYubRz
	 p4BICIvF1YIdMPBefiXzoc/4IDuhp9H9xTmQUHegAg23odDaBn5/W1j5TSv2jquBSt
	 et6DDYaC4EjkA==
Date: Thu, 21 Aug 2025 09:36:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Message-ID: <20250821143641.GA672933@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB88334A22726CF287D41775DC8C32A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Thu, Aug 21, 2025 at 05:44:00AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2025年8月20日 3:07
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; jingoohan1@gmail.com;
> > l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > mani@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [RESEND v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is
> > no endpoint connected
> >
> > On Mon, Aug 18, 2025 at 03:32:04PM +0800, Richard Zhu wrote:
> > > Skip PME_Turn_Off message if there is no endpoint connected.
> >
> > What's the value of doing this?  Is this to make something faster?  If so,
> > what and by how much?
> >
> > Or does it fix something that's currently broken?
> >
> > Seems like the discussion at
> > https://lore.kern/
> > el.org%2Flinux-pci%2F20241107084455.3623576-1-hongxing.zhu%40nxp.com%
> > 2Ft%2F%23u&data=05%7C02%7Chongxing.zhu%40nxp.com%7Ced46fe10aeb74
> > 21c88a508dddf53a24f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > C638912272493755203%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn
> > RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%
> > 3D%3D%7C0%7C%7C%7C&sdata=lIE7%2FlS5jiGxGPGVm5Hr5efpMbT19CLqrwu
> > YNvAEdLY%3D&reserved=0
> > might be relevant.
> >
> > This commit log only restates what the code does.  In my opinion we need
> > actual justification for making this change.
> Hi Bjorn:
> Thanks for your comments.
> This commit is mainly used to fix suspend/resume broken on i.MX7D PCIe.
> A chip freeze is observed on i.MX7D when PCIe RC kicks off the PM_PME message
> and no any devices are connected on the port.
> 
> Because i.MX7D is a very old design, and out of IP design technical support.
>  I don't know what's going on inside the PCIe IP design when kick off the
>  PM_PME message.
> 
> From SW perspective view, what I can do is to find out a quirk method to
>  workaround this broken. Hope this can clear up your confusions.

OK, will look for some of this background in the commit log of the
next version.

