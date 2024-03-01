Return-Path: <linux-pci+bounces-4300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEE86DCB8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 09:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E254A1F26B7A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5669D1D;
	Fri,  1 Mar 2024 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4ZroOJY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E379200C3;
	Fri,  1 Mar 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280576; cv=none; b=t02ASlfVUqN32RFdT5n7ifKxAu9UsFGfJHDBmw8pSejPJhgjRU6TXfV/8fJ9H023hmzPtRTqXOaMh7DHdw5Y0pej9iDmBE5vh/y9sG0n3I6Ffau0/TLtYTDz62sam3hH+eGdh8RpnTwxmaUmemG4Vtn+LfFlTFztdZwP3mdzAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280576; c=relaxed/simple;
	bh=SDOpostQbxSaHQbVT+H3u8LtntR385azXDotbcIDeEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWsoCnIJqu4wbCIXcWgxMV7+cqN2EY357NIYfVM8QAL+K/kDzqsSnz2cn1VTVLhWpg9KtDY58NcRWlD1FfVc3wdJxZPJb8Gqwx5VCmES5E4Ugi1xGR/5VrQrQI/Kukbt3OVieawn3iEp3To/6jmiPpyCfMofTKsIl96eDoSMCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4ZroOJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF45C433C7;
	Fri,  1 Mar 2024 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709280575;
	bh=SDOpostQbxSaHQbVT+H3u8LtntR385azXDotbcIDeEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4ZroOJYkhMhHrVl1Ap4ozy2FeV7TA0/Efnc93tTYUHxflBLZOl8k1ljZ70MuD6HI
	 +KD5jrkApO4SgulrrTz5XoH6+JBz96ZO+j12YNr/jBjAhY1fsZdaZfA7IYMvkqtl0K
	 5772p83G7hOiJXoTVe+CclZocIbEFK7fI4jGNhBW8q9hBK1A01WUDvHoVdsHUClY7i
	 iM9aXaWeD7z8XehuHy0JmAn/Nb8JcBjw9Usv22n+UfguUVaECBXPYVg+9/E09tOAAm
	 qv6YDkjIgVmvSR3cku0DRHQewuOaXxltaz9f7jAYWeeD6xtcgfpmUjeih9lO6Ge2KT
	 uExrktrOerLuA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfxxh-000000006eC-2A9v;
	Fri, 01 Mar 2024 09:09:46 +0100
Date: Fri, 1 Mar 2024 09:09:45 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZeGNSbPjxELBklbx@hovoldconsulting.com>
References: <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
 <20240229205240.GA361626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229205240.GA361626@bhelgaas>

On Thu, Feb 29, 2024 at 02:52:40PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:

> > It also depends on the severity of the issue and to some extent the
> > complexity of the fix. These binding fixes are certainly low risk.
> > :)
> 
> IIUC we're talking about:
> 
>   arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
>   dt-bindings: PCI: qcom: Allow 'required-opps'

Right.

> These don't look like a regression fix (correct me if I'm wrong), and
> I can't tell whether they fix a user-visible problem, since
> sc8280xp.dtsi does already contain 'required-opps' for ufs_mem_hc,
> usb_0, and usb_1, which are mentioned in the commit log as covering up
> the issue.

The issue has been there since PCIe support was added for this platform
and does not cause any issues until the USB and UFS controllers are
runtime suspended.

When that happens nothing is currently making sure that we have enough
power to run PCIe at gen3 speeds, something which can potentially result
in system instability (e.g. resets).

> If these patches wait until v6.9, what badness ensues?

We'd have a few more weeks where users enabling runtime PM for USB on
the X13s could hit this before we can get the fix backported to stable.

I could have put some more details in the commit message for the DT
patch, but I did not think that amending the PCIe binding would be
controversial. (I guess we can also take the DT fix without waiting for
the binding update as it has been acked by a DT maintainer even if that
would result in some DT checker warnings until things are aligned
again.)

Let me know what you decide regarding getting the whole series into 6.8,
and then I can spend some more time on rewording, splitting and rebasing
this series if needed.

Johan

