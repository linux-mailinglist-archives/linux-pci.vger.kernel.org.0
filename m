Return-Path: <linux-pci+bounces-19412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA2A0408C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E7A3A15B8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639C1A4F09;
	Tue,  7 Jan 2025 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XiTQokde"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841915C13A;
	Tue,  7 Jan 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255630; cv=none; b=EU3Ntt6Pft6+N5xvRJDdMeLGmz8oE39i/EW14/9nJ/jYV/a0rI137usc7PVXaWCX4O0bM1GwPz02x7m7zEz7jPGdM/fBgyBjEPqWWLIWvPhD8JZknTazCoLUAbcJNIzDb3EB9ta4yUMQKGpAVQxK4BiVG8atRrDbKKwt0GK/WKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255630; c=relaxed/simple;
	bh=D1T9n7wqyrlDXjoSSIH6TV2iacB3LaiObYqCneFFVrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Npn0JPx/WpotcOyRedOCXeGUa7q44m5oqchOu5a8DZFkkOp2p1Zamr6hiveFeLh9/eNBKTmSMPybQMcPXlznDzafF8R54WZZCCWQw1Hqe0BVA5qSMDa9c6pDTIC0d5FwSwPjcF2GCuD3W4MtW9rIAzXscvQBOcC48ThOp0dFgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XiTQokde; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TvCtZRn6q2yrOkVr53SYY2q+vLoe2lQ9suphlIdglAc=; b=XiTQokded4/20LkiEtgFMPQTon
	GQMLclhYTJJjBsn3umKCydHoX5+QzGoLJjUxO3385EVQymx8hF6WSsEYMNEevcLAG7ZZXxPydXWB+
	H/6jTdPjcs5GlpnEtqKu1bHnss3O/e0o+lbIliqiqA1JbkIYH+eE9b0t2w4pF/PxRxHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tV9Oo-002EdJ-RP; Tue, 07 Jan 2025 14:13:34 +0100
Date: Tue, 7 Jan 2025 14:13:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <c08f3d69-1f3d-49a6-96ac-0c2f990f9a8d@lunn.ch>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch>
 <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>
 <c94570db-c0af-4d92-935c-5cc242356818@lunn.ch>
 <CANAwSgQ_gojVxvi_OyHTyTSdzRrno=Yymn0AdEXyTHTgDTyFcA@mail.gmail.com>
 <Z3vGXrUIII4ixNnF@ryzen>
 <b49e6147-32c6-4239-bdba-72f25ef04a9f@lunn.ch>
 <CANAwSgQqPREeFQisQZXqB52+w+j54Bwq4RMiHf3qUTXmnTxCAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgQqPREeFQisQZXqB52+w+j54Bwq4RMiHf3qUTXmnTxCAw@mail.gmail.com>

> I was just trying to understand the call trace for mdio bus which got
> me confused.
> 
> [0] https://lore.kernel.org/all/Z3fKkTSFFcU9gQLg@ryzen/

There is nothing particularly unusual in there. We see PCI bus
enumeration has found a device and bound a driver to it. The driver
has instantiated an MDIO bus, which has scanned the MDIO bus and found
a PHY. The phylib core then tried to load the kernel module needed to
drive the PHY.

Just because it is a PCI device does not mean firmware has to control
all the hardware. Linux has no problems controlling all this, and it
saves reinventing the wheel in firmware, avoids firmware bugs, and
allows new features to be added etc.

	Andrew

