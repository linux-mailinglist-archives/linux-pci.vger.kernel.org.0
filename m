Return-Path: <linux-pci+bounces-40098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85491C2AF3C
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 11:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A42B3B22E6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38FD2FD1B1;
	Mon,  3 Nov 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ+MBqKf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAD7261E;
	Mon,  3 Nov 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164910; cv=none; b=M/VimTWNTIHgUHxgj0tgLtaMJZbc9iho4slQnIhXjrrOfGBZBUZirq3M6Ywlew1WhGk18gj1R24yyu4Z28qlaNu/Fc1S5PMk+zSWiaBV+ip53M3B08CRTZFlgFfbGlD9LZCGpcQx41uZBxiU7E2hmdUmC3MCpzeSxfIPUISAIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164910; c=relaxed/simple;
	bh=O4x0jqqxagDU/VftuFhDlptuntE9Kac7vSj33pi2VvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQgmO0ESnB/TwDEgTqeiBpb4r4+9eq5AgL8Ynz84btlod3vW87lYR6fDLksdeCL2NYJR7Gd4sjdpjzGKc0n7HNM7TTV6X/jMPhzYrghwokiyjWx/jq8nKYhNMGsHCvJxGgEZwPW98TaCjivdr9hxYTzECd1oPEQ87qo5G6w5dos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ+MBqKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECE3C4CEE7;
	Mon,  3 Nov 2025 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762164910;
	bh=O4x0jqqxagDU/VftuFhDlptuntE9Kac7vSj33pi2VvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJ+MBqKfKXeU/teJKJ87gBmtT1H1BpXVfHwO16qP63B5LdGVaJSV+ZjQQmJu9RFK1
	 7ImrzDBiLUdYKyv/kEzjpwZWhzcEL+29oAWdzzer2uxPpLr5FWTEK2cHSVutB00P0j
	 aSCJu+fpbOQHw1up1SDyYXhspEpM/WX63O9IfCYozFIpoE1IcIICeg1nYpA24W2/C3
	 UP+l2hYftcqz7VhZfnGW1e+Pl+yoq752ZwpWFpQPfj8HSGTcwUuhCs9mpFd+DIxZbu
	 1JRpmWucJkIC7kZRS2gXoGxuCjhqFqvhT7jw6pFD119wN0z1NnpfqtAv7ec98zqTMW
	 LdKbA99Io3xLw==
Date: Mon, 3 Nov 2025 15:44:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Andrew Murray <amurray@thegoodpenguin.co.uk>, 
	Jingoo Han <jingoohan1@gmail.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, stable+noautosel@kernel.org, 
	stable@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>
Subject: Re: [PATCH RESEND 0/3] PCI: meson: Fix the parsing of DBI region
Message-ID: <mwdy2qe2kp6ygwyw7ohjykzwcsi7udzitizmbzk2rfuf4jesnj@gbjmjfuvzkvw>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <83d07b54-d584-4297-9aae-2a170c0059d4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83d07b54-d584-4297-9aae-2a170c0059d4@linaro.org>

On Mon, Nov 03, 2025 at 10:50:20AM +0100, Neil Armstrong wrote:
> On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This compile tested only series aims to fix the DBI parsing issue repored in
> > [1]. The issue stems from the fact that the DT and binding described 'dbi'
> > region as 'elbi' from the start.
> > 
> > Now, both binding and DTs are fixed and the driver is reworked to work with both
> > old and new DTs.
> > 
> > Note: The driver patch is OK to be backported till 6.2 where the common resource
> > parsing code was introduced. But the DTS patch should not be backported. And I'm
> > not sure about the backporting of the binding.
> > 
> > Please test this series on the Meson board with old and new DTs.
> 
> Let me try this serie, I'm on a business trip this week so don't expect a full test
> report until next monday.
> 

Sure. I may post the next iteration, but will not merge the binding/driver
patches until you confirm.

- Mani

> Neil
> 
> > 
> > - Mani
> > 
> > [1] https://lore.kernel.org/linux-pci/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com/
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> > Resending as the git sendemail config got messed up
> > 
> > ---
> > Manivannan Sadhasivam (3):
> >        dt-bindings: PCI: amlogic: Fix the register name of the DBI region
> >        arm64: dts: amlogic: Fix the register name of the 'DBI' region
> >        PCI: meson: Fix parsing the DBI register region
> > 
> >   .../devicetree/bindings/pci/amlogic,axg-pcie.yaml      |  6 +++---
> >   arch/arm64/boot/dts/amlogic/meson-axg.dtsi             |  4 ++--
> >   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi      |  2 +-
> >   drivers/pci/controller/dwc/pci-meson.c                 | 18 +++++++++++++++---
> >   drivers/pci/controller/dwc/pcie-designware.c           | 12 +++++++-----
> >   5 files changed, 28 insertions(+), 14 deletions(-)
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20251031-pci-meson-fix-c8b651bc6662
> > 
> > Best regards,
> 

-- 
மணிவண்ணன் சதாசிவம்

