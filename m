Return-Path: <linux-pci+bounces-19336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F75BA026F1
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 14:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86C63A4FC6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2BB1DAC8E;
	Mon,  6 Jan 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ISl0fbKu"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66A1DE2BD;
	Mon,  6 Jan 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171077; cv=none; b=krZIvGFysdpN21Wg0jl5iYVA0BgqWo2Dt2suLUhgr/XxWHIpxppzjtsupngvYVcCp5Z50B8RuVT5PG4Bpv/FIuMTINuWdrTnHvG13MKWg6wP2f0HO7sMwlb/9tI3TVNWjHxkKF5EzFdlktefBCoMH5WNtZ9X8+o1kT8WkGfxwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171077; c=relaxed/simple;
	bh=PaRy/Qp4G2GUwWfivD85MpnF/GRAoQIsxAYn3Wppbwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1+UpKyeQHnls5SCiyk0K9Ez15wXQ8wHlGBBKxk6olG8WDltH9HaOTQXM6V8ndMajNcRzBmtI4HFnfgBPJW+Pd3amUQpYWvVGIdKwstmZU2PtRQS7punWj+Vn7aXNFlCPmQa+H8BUPy1CLhVFALzuHGbwBkKwn/yHzP34RC9/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ISl0fbKu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jPkB+WGq3E7u+EGSM2PcJI+Gi33CoRnyjGq/ftg1apk=; b=ISl0fbKuUQ8lMiwligsmbR+plC
	JjC342g3xpVPQWI2K9aXk9wSCnkVVCcHqv4jR+KivMdjhNVDnaSVQHAQO1dvn1ef+/Z90Y4pdjgMK
	OhmdIb9F/npjbPB+1TPiV+G+w2jlQ79mJkVU4qPaenwOBrkvohtj5iLtUO/IEi8yiQGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUnP1-001tBo-T9; Mon, 06 Jan 2025 14:44:19 +0100
Date: Mon, 6 Jan 2025 14:44:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Niklas Cassel <cassel@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <b49e6147-32c6-4239-bdba-72f25ef04a9f@lunn.ch>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch>
 <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>
 <c94570db-c0af-4d92-935c-5cc242356818@lunn.ch>
 <CANAwSgQ_gojVxvi_OyHTyTSdzRrno=Yymn0AdEXyTHTgDTyFcA@mail.gmail.com>
 <Z3vGXrUIII4ixNnF@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3vGXrUIII4ixNnF@ryzen>

> As both me an Manivannan said earlier in this thread,
> PCIe endpoint devices should not be described in device tree
> (the exception is an FPGA, and when you need to describe devices
> within the FPGA).
> 
> So I think that adding a "ethernet-phy" device tree node in this case is
> wrong (as the Ethernet PHY in this case is integrated in the PCIe connected
> NIC, and not a discrete component on the SoC).

There are other cases when PCIe devices need a DT node. One is when
you have an onboard ethernet switch connected to the Ethernet
device. The switch has to be described in DT, and it needs a phandle
to the ethernet interface. Hence you need a DT node the phandle points
to.

You are also making the assumption that the PCIe ethernet interface
has firmware driving all its subsystems. Which results in every PCIe
ethernet device manufacture re-inventing what Linux can already do for
SoC style Ethernet interfaces which do not have firmware, linux drives
it all. I personally would prefer Linux to drive the hardware, via a
DT node, since i then don't have to deal with firmware bugs i cannot
fix, its just Linux all the way down.

	Andrew

