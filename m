Return-Path: <linux-pci+bounces-41454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C4FC6622D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AFF135983C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 20:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337D1302170;
	Mon, 17 Nov 2025 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re3U4Mqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46F2FE56B;
	Mon, 17 Nov 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412232; cv=none; b=T8zUiC/nb3gZiJZB0ps7VUxd8Cbxx/s08VJq1g8wLVoNqOpIYz00T9eSWrHkNceGxhcs1M4MOZHwIPhG2bwhclJaicWaa4b9XPPLaxI+7Qk4eVaq6UpOdTNawwR9RM/RA11gVvhNnTomnEDIqKcomkRBSYuHv+Jt5+UJVb/LJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412232; c=relaxed/simple;
	bh=8ed1/LqTDi9J6Cd/l8V0MNcIqQta3AJ4Jk23LfPDRwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TFm7epQhY/FiXLE3JRJri2QJk6/xlaAGhDJ2d1M2vCBOBZU91jkH5iHetF5Mv4Gjy4bHIKWFzylUTGO5kMLJCvBbdFst9qFz4930foIdMnF2DD0F7hEcDfUzFodQyEw+dTy1ibLCYEWP7U2ricM230MuraDtWA76cA/wqkCJl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re3U4Mqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE5C113D0;
	Mon, 17 Nov 2025 20:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763412231;
	bh=8ed1/LqTDi9J6Cd/l8V0MNcIqQta3AJ4Jk23LfPDRwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=re3U4Mqpb5UfMPsEjbI9h8j/NOQXU9xKb6om6xXZDQ4bzV+8YGee5+2u5y/XEDuF5
	 dv0HHmUJ0QA8vHoT8R1QME1qkU21Va8lXH0yhNNJS0vePBBCa/rDLWcm9KTSytZXRQ
	 OcGw2qZ1bBnkdV6SV0fbxBjL2TAz6ftP6GRRAH1V6LZPq93OE7e7In6K9ILm69+9O5
	 +rs5VtSfgtKGNWMkW5b5w61EemVmnAd/tpPhdiWLM3Hi0eOwXyKv0huX/75IuFaXXm
	 j1b8zD8/d439dekML6TfSfyZfVuq5lEH+l8IZAMSNakKnGwXSTEHQ1rZsD2YGGV6MY
	 Up/PD1sWvTQrg==
Date: Mon, 17 Nov 2025 14:43:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 1/1] PCI: stm32: Don't use "proxy" headers
Message-ID: <20251117204348.GA2522408@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114185534.3287497-1-andriy.shevchenko@linux.intel.com>

On Fri, Nov 14, 2025 at 07:52:01PM +0100, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> In particular, replace of_gpio.h, which is subject to remove by the GPIOLIB
> subsystem, with the respective headers that are being used by the driver.

Thanks, Andy!  It looks like a lot of work to figure this out by hand.
Is there a tool to figure this out?  Maybe something I could run when
reviewing patches?

IWYU seems like a nice principle but I couldn't find any mention in
Documentation/.  Should it be covered there somehow?

Bjorn

