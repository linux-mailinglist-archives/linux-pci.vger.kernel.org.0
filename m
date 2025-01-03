Return-Path: <linux-pci+bounces-19233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF3A00B2E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505043A14BC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6511FA140;
	Fri,  3 Jan 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ/ApSph"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBE442C;
	Fri,  3 Jan 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917035; cv=none; b=CpM3uL218J1TZzhc0y6W3npjf0OWRygTCCWxHHIQz558jUlbKgsd88b7e1N84dDU2t8fDVq3elYiDqgQl2fV1GX+uTxfEAEynBC6saz95UdyNhmb24kKSb9SCXCMuqMpCXLe4a+c+8MHQTj0Q8l69EmAFcWry8JCebLKA6G3UpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917035; c=relaxed/simple;
	bh=1BF/6cjFkwRL519wCuap2QXMjEYM9CYI1Dk9qxzXxNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVpmosfhL1yMRnz4bZGaBhq7VQuhYZhJ7tWq4QPeg0n+Scq7jUdj+gqaakYg7MG3UIsBzzV4CgR/T8NSZWQxYVImsG9CKq2geHaz2GjxG/xQp0tmkoU5OyWyO1QglA5zExceWZ5bsLsSXRk98q5wm+AUl8Or7+TWMf1mPBOUZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ/ApSph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE5FC4CECE;
	Fri,  3 Jan 2025 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735917034;
	bh=1BF/6cjFkwRL519wCuap2QXMjEYM9CYI1Dk9qxzXxNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJ/ApSphiN0qvPN/WMJ+exnXwCvG9WFvpjWQRoBQBZcqsyUjnn18nMvnIqLGZ06lY
	 +RkGa0cC+t7uOFJ9JqNsid9tEeuhCrAL4pSp+0I0uo5PX6AdEdoKAoQjDW+BIde+WY
	 tYCOHmN4MlLC1J28eVTXF9UpQl6y3EroHLu0La2eGSpxkG/4HK2kgo3+OYe8vc9AV2
	 4dmKOA9ZuekWiaIfZKGzZkCj5MVDFG4gYtk13UX+CvrBswD5Jm6BnuGdByRhMBBWv9
	 Y+UmfzAfmios8vQXrVYmdKi5yxQAFjh7HnvXID8K7LQ5O7TzO+VGIWNlQSiIzk1aub
	 fLGO436FH22rw==
Date: Fri, 3 Jan 2025 16:10:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <Z3f95RXj7GhZZHEP@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <Z3fzad51PIxccDGX@ryzen>
 <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>
 <Z3f4JQZ6yYV1BJ-b@ryzen>
 <CANAwSgRTcHuDNLvPJAs7ZaV-NnepeOkHj_kVc5OAJtP03hd6pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgRTcHuDNLvPJAs7ZaV-NnepeOkHj_kVc5OAJtP03hd6pQ@mail.gmail.com>

On Fri, Jan 03, 2025 at 08:36:18PM +0530, Anand Moon wrote:
> > >
> > > We need to enable the GMAC PHY and reset it using the proper GPIO pin
> > > (PCIE_PERST_L).
> > > Please refer to the schematic for more details.
> >
> > The PERST# GPIO is already asserted + deasserted from the PCIe Root Complex
> > (host) driver:
> > https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L191-L206
> >
> > which will cause the endpoint device (a RTL8125 NIC in this case)
> > to be reset during bootup.
> >
> Thanks for letting me know. It seems like a workaround.
> I'll try to disable this and test it again.
> 
> My point is that we haven't enabled the GMAC PHY (device nodes)
> and must properly reset the GMAC.
> 
> We're relying on the code above hack to do that job.

I do not think it is a hack.

If you look in most PCIe controller drivers, they toggle PERST before
enumerating the bus:
$ git grep gpiod_set_value drivers/pci/controller/


Kind regards,
Niklas

