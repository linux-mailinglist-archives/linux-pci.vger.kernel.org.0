Return-Path: <linux-pci+bounces-42985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED7CB7CC5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 04:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79DB23005515
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 03:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6E2AD3D;
	Fri, 12 Dec 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB+P7Xpk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C7D27E;
	Fri, 12 Dec 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765511567; cv=none; b=CJcakAJcOV/8FAG6b8eljPb5FnoYylXU2N4vW9xkCZ61MrE3maElJmJ2+06bpQkEK8U8Od2MsFv2tOFS4pwHTKecwCPlpL0/xjBwtNYD5cQlSCI8lHa8uYhfqDRrzLV67CgjVw7pgwfxxFsJypEylsc+dQWosu71bbmjpqkOJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765511567; c=relaxed/simple;
	bh=4aNjpdLHQX5WPy6vwTgIkcZd5b8rix/rORP2xiTO8Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJTv88PLclXuAGy0r8KRVlz08RUHxW0Q5TMf7jEIfPmAJm43H8rZ9+/cVMsIZctRWlfGYO0Bc5S4hUNi60tmDoACVocsHJc4LUXLrP0MeDd0syc3jxaswRXzQ0Anq9zQA9l+XMs+vQeecqDGOtjxV185vR1oc21DdHdKRyA9c5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB+P7Xpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E70FC4CEF1;
	Fri, 12 Dec 2025 03:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765511567;
	bh=4aNjpdLHQX5WPy6vwTgIkcZd5b8rix/rORP2xiTO8Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sB+P7XpkJ1Dp/PpeK2FJ2O+T82CuOhDGaBXmo7cR0B8RkuP36VrBm4Uyip/QaW3nl
	 Nz8BbXrZzSOv2bJ2nZF/plsvKTfrPge0t49z0FlNLioys59JM9vRci5O3RXq9zE+O8
	 yz9siG0TBbYh3amgXggAN5QqXyxwe24HBeYCJxy1iALO2RgC8itcWQy7GWzVs/e+AV
	 sbCDJv4CSM8AGQB40OnlutDHJYA5NzA0yjQ6xPL96KNZUE8JHnLHTfIoELzgDlHAkK
	 dmaOwrweQcn2rTWhQQGpb2a8HbGD7iyovS39KVSX3NimvFxoWz4RtGBk4N9JdDEeuK
	 Ssab2LJW4WeFw==
Date: Fri, 12 Dec 2025 12:52:35 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	FUKAUMI Naoki <naoki@radxa.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <pjn2gs43rqbe3odh6zvh4qaftxxl6qvdzpm6pgpadxeeid42ko@4a2qradscaqd>
References: <20251201063634.4115762-2-cassel@kernel.org>
 <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>
 <aTev28wihes6iJqs@dhcp-10-89-81-223>
 <dad4957c-ca13-4742-b46d-03f0478911d5@oss.qualcomm.com>
 <aTe1bA7lcVzFD5L7@dhcp-10-89-81-223>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTe1bA7lcVzFD5L7@dhcp-10-89-81-223>

On Tue, Dec 09, 2025 at 02:36:44PM +0900, Niklas Cassel wrote:
> On Tue, Dec 09, 2025 at 10:57:18AM +0530, Krishna Chaitanya Chundru wrote:
> > On 12/9/2025 10:42 AM, Niklas Cassel wrote:
> > > 
> > > So I don't really understand your concern with this series, at least not if
> > > it goes on top of your series:
> > > https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com/
> > Hi Niklas,
> > 
> > If this series goes on top of the our series i.e pwrctrl rework series, I
> > don't have any concerns.
> > My only concern is link up IRQ never fires if this patch goes before series.
> > 
> > - Krishna Chaitanya.
> 
> This patch missed the v6.19 merge window (and so did the pwrctrl rework
> series), so as long as Mani queues up both for v6.20 (with the pwrctrl
> rework series getting applied first), I think we are good.
> 

The plan is to merge pwrctrl series to v6.20 (unless we get strong objections),
but once that happens, Qcom doesn't need this patch.

So it'd be good if you can just limit this patch to just Rockchip. Then once the
Rockchip also moves to pwrctrl, we can revert this patch (also the whole IRQ
based link up since the Root Port is not hotplug capable).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

