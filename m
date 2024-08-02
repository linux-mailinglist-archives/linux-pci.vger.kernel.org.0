Return-Path: <linux-pci+bounces-11182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18D945BD9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 12:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A911C20D46
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8561DB43A;
	Fri,  2 Aug 2024 10:13:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496E134B6;
	Fri,  2 Aug 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593617; cv=none; b=dBz9WBcQd4CBe7e5e+mnKVUoC5f3UnN+5ZusjQqFOg8TyDgxYtTRocost2QRetjIYkf7w+ssA9h05BAmCFLIU6hHHT4PeU80Ezdc9Z5B4WnY3vWGdRLA0hRjA/qGDj2EPI+hBwX7h5h+58tWnDvHheSFCh8SFtWcj5Fovz2ZXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593617; c=relaxed/simple;
	bh=CGgO4c4usttTcvDWQPDRc8NVgRBTwg+m6dDsG/vP5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry26MRBS60IPZChxXSUXved8ZNCthqsho8MO0c8Z9tFJmpmDNfZneEk6ginwoEx134BabL+G17fF/nGv9joan1BNDPE/E0VyDaw63ltEraBhBDwa7v42pajbA8stMzEJwJ4rrfj7llFDJCPuFB109XOOjuLQBn2/NZsIm3m8NJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D8088100DA1B8;
	Fri,  2 Aug 2024 12:13:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AD1C81135EE; Fri,  2 Aug 2024 12:13:31 +0200 (CEST)
Date: Fri, 2 Aug 2024 12:13:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <ZqyxS8spZ-ohsP3R@wunner.de>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>

On Fri, Aug 02, 2024 at 11:25:03AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Unlike ACPI based platforms, there are no known issues with D3Hot for the
> PCI bridges in the Devicetree based platforms. So let's allow the PCI
> bridges to go to D3Hot during runtime. It should be noted that the bridges
> need to be defined in Devicetree for this to work.
[...]
> +		if (state == PCI_D3hot && dev_of_node(&bridge->dev))
> +			return true;

For such a simple change which several parties are interested in,
I think it would be better to move it to the front of the series.

Patch [1/4] looks like an optimization (using a cached value)
which this patch doesn't depend on.  Patch [2/4] looks like a
change of bikeshed color which isn't strictly necessary for
this fourth patch either.  If you want to propose those changes,
fine, but by making this fourth patch depend on them, you risk
delaying its acceptance.  As an upstreaming strategy it's usually
smarter to move potentially controversial or unnecessary material
to the back of the series, or submit it separately if it can be
applied standalone.


> Currently, D3Cold is not allowed since Vcc supply which is required for
> transitioning the device to D3Cold is not exposed on all Devicetree based
> platforms.

The PCI core cannot put devices into D3cold without help from the
platform.  Checking whether D3cold is possible (or allowed or
whatever) thus requires asking platform support code via
platform_pci_power_manageable(), platform_pci_choose_state() etc.

I think patch [3/4] is a little confusing because it creates
infrastructure to decide whether D3cold is supported (allowed?)
but we already have that in the platform_pci_*() functions.
So I'm not sure if patch [3/4] adds value.  I think generally
speaking if D3hot isn't possible (allowed?), D3cold is assumed
to not be possible either.

Thanks,

Lukas

