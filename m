Return-Path: <linux-pci+bounces-30638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552BDAE8BC6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B934A304A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B129E111;
	Wed, 25 Jun 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ZHKFfM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2F1AF0BB;
	Wed, 25 Jun 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874083; cv=none; b=tWIqZ7NjhUV8XclPsCW9FWoiotc4dJtobBNM7f6KJz9j56S6r6txDW0sMDMdWfcsvbnOkerAfPnr9TS3yU6XC9BG579CU1MdH+8hXvoyk0J46ostyWbjg5co6vk+vz9Nm7wrMg2g7cmPE2qC/DPRGib0ja8Vh8viqcGC+/nvywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874083; c=relaxed/simple;
	bh=V/776moD0WP3JA8kmJKpRFhViMjXtiD1Hu+QZ1gN3ik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JSZhppCoVGpYxsx2g1mYhb04M6ccBVqUqDMlP8i4fSXJ2KQcOhgglgtmM8rWYR6oBmB6qGZoHLulzl5Qc84Xy9vlu2iYUpOCi4cDiSHr2znaFKy9+DIJ9wApeffQR4dKqEbG5WfRgN5wuCIHxP3f2CCgSKnHM+HsVcgZv8gsYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4ZHKFfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC41C4CEEA;
	Wed, 25 Jun 2025 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750874082;
	bh=V/776moD0WP3JA8kmJKpRFhViMjXtiD1Hu+QZ1gN3ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a4ZHKFfM/MUH7wdncYY6XrWlP2fPRfVmsLpbFF+gwUxm9ucIgZFB5A819+w4EfYM+
	 IdC82XoKAqDp92w5NLOvTPSjp6gE9SGH/sFTWE19zj/0YrsqrXGwFNq3E42xElDtgr
	 +Vp1dOHyeR1G+XEKcajNklagWy1jzEF3m/d2xpD/qV5vAnGJu67u/CBOTARe5trz2U
	 Y4jwsjCjh6vxmW0H39DZ3XIgA7wPcKPkqQ+UWs86uUAYiQUYHDf2wzl/Ifvq1QjIht
	 VessRp4F48UN8weEyp0gvCFYX+TbdV7N1EP/Q8Z5efJP+q7PCS4JRYefgayvBidAIG
	 kuBHiMzqzBMPA==
Date: Wed, 25 Jun 2025 12:54:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 4/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
Message-ID: <20250625175441.GA1579685@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed851fd-6cdc-48f6-ae39-67c95e6ad6d0@tuxon.dev>

On Wed, Jun 25, 2025 at 04:07:58PM +0300, Claudiu Beznea wrote:
> On 18.06.2025 20:42, Manivannan Sadhasivam wrote:
> > On Fri, May 30, 2025 at 02:19:13PM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >> only as a root complex, with a single-lane (x1) configuration. The
> >> controller includes Type 1 configuration registers, as well as IP
> >> specific registers (called AXI registers) required for various adjustments.

> This is how HW manual suggest to do it. The manual is open, it can be
> downloaded from [1]. Chapter that describes the steps implemented here is
> 34.4.2.4 Issuing Special Requests.
> 
> Steps to reach the HW manual:
> 1/ click "RZ/G3S Group User's Manual: Hardware" button
> 2/ click confirm
> 3/ open the archive
> 4/ go to r01uh1014ej0110-rzg3s-users-manual-hardware -> Deliverables
> 5/ open r01uh1014ej0110-rzg3s.pdf

Nice that the manual is public!  URLs are a great invention; it's too
bad when we need directions for where to click, etc, in addition to
the URL.  Maybe one or both of these URLs could be included in the
commit log.

> [1]
> https://www.renesas.com/en/products/microcontrollers-microprocessors/rz-mpus/rzg3s-general-purpose-microprocessors-single-core-arm-cortex-a55-11ghz-cpu-and-dual-core-cortex-m33-250mhz?queryID=695cc067c2d89e3f271d43656ede4d12

https://www.renesas.com/en/document/mah/rzg3s-group-users-manual-hardware?r=25458591

