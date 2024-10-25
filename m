Return-Path: <linux-pci+bounces-15368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE529B11A6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C71282FA3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AD1D270A;
	Fri, 25 Oct 2024 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyf/v0GP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40061D1E75;
	Fri, 25 Oct 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892189; cv=none; b=KgjzEVw/4w4ZycajHmBj0lm4w75cVJFfLDxj3UQgYzkIgGUO4zlANpq1Dn5WnBL4ngsmalg5Tn9P35p8BrO96NIWZTfS39enjn3jnYa5dBQn4q2pX76LUxbzzG+Hnxv1lXkwNN/6dIyl+J/+A73w/BfVpdlZ8nOHj+OGBOdlW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892189; c=relaxed/simple;
	bh=0VXLkxh/2Ecsv6rIIKWkGlW2EIFOBXyj7cfyt2r+xLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=etGObcW1sK9rL6v9aBeOVShVHjDTCFg4t2ZbQxKTIhvYeeJyyTV+R3BUZIH0D3v206hXvzB7AYrg/Ho5of2xjOaBA782pKAD4ufnpWYXRzeqz779wuReMm3yAGYJllhPVlmb9hYIwSdWWSei9EtiWI9kQ8Yl8eSwQjd/k/ciIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyf/v0GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AF3C4CECC;
	Fri, 25 Oct 2024 21:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729892188;
	bh=0VXLkxh/2Ecsv6rIIKWkGlW2EIFOBXyj7cfyt2r+xLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Lyf/v0GP/E2zd0MG4qbYJMsm3GH3QEQ2KMOyNh3zfnsWD+lCIlZyurAiQTgGyODMq
	 gpjNp9BULeC1T38Gc+WKexKxJWC0h3XMps1GjZp6U7BJ3JQOqfruzmZ/mtWrEsRJaA
	 /rGTwHlhfo6Div0SvSBfMLULLsudg0gEZf//trY6n13+0FAkwwT2oIWxZNoyE/S5HS
	 imKkGLdyMSS+KgpkS2UuHJNPNzUKE0hrQ/wJGAmHUP8AbFcJBHI1s+LArEiUOQNpxz
	 ZEHXNYhKRCTZVXiAv5XmZzehJkVwV2ZjJj3OlvX4saCmtTiR26pWiPXTaPSOghHnxV
	 BeSsAkGJsW/8w==
Date: Fri, 25 Oct 2024 16:36:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] PCI: ep: dwc/imx6: Add bus address support for
 PCI endpoint devices
Message-ID: <20241025213626.GA1030542@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxwH//clayRL2emF@lizhi-Precision-Tower-5810>

On Fri, Oct 25, 2024 at 05:05:03PM -0400, Frank Li wrote:
> On Fri, Oct 25, 2024 at 03:48:18PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 24, 2024 at 04:41:42PM -0400, Frank Li wrote:
> > > Endpoint          Root complex
> > >                              ┌───────┐        ┌─────────┐
> > >                ┌─────┐       │ EP    │        │         │      ┌─────┐
> > >                │     │       │ Ctrl  │        │         │      │ CPU │
> > >                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
> > >                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
> > >                │     │       │       │        │ └────┘  │ Outbound Transfer
> > >                └─────┘       │       │        │         │
> > >                              │       │        │         │
> > >                              │       │        │         │
> > >                              │       │        │         │ Inbound Transfer
> > >                              │       │        │         │      ┌──▼──┐
> > >               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
> > >               │       │ outbound Transfer*    │ │       │      └─────┘
> > >    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
> > >    │     │    │ Fabric│Bus   │       │ PCI Addr         │
> > >    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
> > >    │     │CPU │       │0x8000_0000   │        │         │
> > >    └─────┘Addr└───────┘      │       │        │         │
> > >           0x7000_0000        └───────┘        └─────────┘
> > >
> > > Add `bus_addr_base` to configure the outbound window address for CPU write.
> > > The BUS fabric generally passes the same address to the PCIe EP controller,
> > > but some BUS fabrics convert the address before sending it to the PCIe EP
> > > controller.
> > >
> > > Above diagram, CPU write data to outbound windows address 0x7000_0000,
> > > Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> > > 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
> >
> > The above doesn't match what's in patch 1/4, and I think the version
> > in 1/4 is better, so I'll comment there.
> >
> > To avoid confusion, it might be better not to duplicate it in 0/4 and
> > 1/4.
> 
> Yes, cover letter don't come into git tree. This part is common and
> important, It is not good just said ref to patch1 commit message.
> 
> Add do you have addition comment about this and
> https://lore.kernel.org/imx/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com/T/#t
> 
> The both are the pave the road to clean up pci_fixup_addr().

I think it would be helpful to combine the "PCI: dwc: optimize RC host
pci_fixup_addr()" series and the "bus_addr_base" parts of this series
together into a single series because they are doing very similar
things, and it's easier to review them together.

And split the dt-bindings, PHY sub mode, and new endpoint support
parts to their own series because they're not related to the address
translation changes.

Bjorn

