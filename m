Return-Path: <linux-pci+bounces-40474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B167BC39BF8
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67B024F5F9A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD8030ACF6;
	Thu,  6 Nov 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9aQVLpk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56A42C11C9;
	Thu,  6 Nov 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420038; cv=none; b=ZHcqkgYHltbQmMOHzZ9jZQng/mKHhS2oK17n8qAYhf+gIh0DBSZVPcYbqO6mBcNhgTuPqERfRdW3BJ6kOuVhRCguwv3CU+9feO20i1pJGP/nnJ/wnRVKtD77gDl0L4BiGXx5Usgi4n4ax8khXMt4eeYN7JU73aoC71nmlZCOmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420038; c=relaxed/simple;
	bh=MieKUKDPbSY+HzttPLXginlv3OHh6q6f7G1egoTKNI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq5ZoRf+vv1YIytQZ5BmEB/kHa6TEnE6m5e5UL7IQTj6lt7l1TSJssL+moEFaWPjr4NzLsBR0mlU5DY8YxY0qclGTulQCBSOTloofuwoxr8MIwW0iwOt7nmdsrd4FDs7k9eE6c1cb/UqEWRv7p9GfZ4kFMbuL4/MypHq3q6n9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9aQVLpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20083C4CEF7;
	Thu,  6 Nov 2025 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762420037;
	bh=MieKUKDPbSY+HzttPLXginlv3OHh6q6f7G1egoTKNI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9aQVLpkFlu/1ll+IAGrhZ6ghN3FIqK2wGYl2AF0vkYenPel/E8im3tlXc9H0DjS2
	 CXhoRbDPyJ/NXx08KR8rQtgc5M8gCDOJ/Tlp85TbVuvLnIBQyr3L6qyWWlvBaePJPb
	 cBqiX6e3NLgavy0KbMwuyqTmq4iDyvTvu6hrcPSZq5HrmPMmBSARZGQXYp0UU3B6ww
	 L1z6CZ3urqnNgrQWpPg+Kt4FDn5Nagf1auEfyL/QM9KklhwTEi/sCbjbAL3PHLL3At
	 HIHrPPr3NAD122CcEYD3nbt1Ds6b5anvs0ScnP69r7N2qtYimDeTHUYNSJIvA9iD/+
	 5rFTPfSyqWWAw==
Date: Thu, 6 Nov 2025 14:36:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>, 
	Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Andrew Murray <amurray@thegoodpenguin.co.uk>, Jingoo Han <jingoohan1@gmail.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
Message-ID: <lsue7hlgybqpru3qfetlpee2mswnycvhxjffwyxtplmpqved2u@aohtwjtxesr4>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
 <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>
 <rguwscxck7vel3hjdd2hlkypzdbwdvafdryxtz5benweduh4eg@sny4rr2nx5aq>
 <20251106-positive-attractive-tiger-ec9c1c@kuoka>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106-positive-attractive-tiger-ec9c1c@kuoka>

On Thu, Nov 06, 2025 at 09:30:15AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 03, 2025 at 03:42:58PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Nov 03, 2025 at 10:47:36AM +0100, Neil Armstrong wrote:
> > > Hi Mani,
> > > 
> > > On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> > > > Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
> > > > have region for DWC controllers as it has the Root Port and controller
> > > > specific registers, while ELBI has optional registers.
> > > > 
> > > > Hence, fix the binding. Though this is an ABI break, this change is needed
> > > > to accurately describe the PCI memory map.
> > > 
> > > Not fan of this ABI break, the current bindings should be marked as deprecated instead.
> > > 
> > 
> > Fair enough. Will make it as deprecated.
> 
> The true question is what value was being passed as that item (ELBI)?
> Because if this was always DBI - device has DBI there - then what
> deprecation would change?

Nothing, except not breaking old DTs with the binding check. That's why I
decided to remove it in the first place.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

