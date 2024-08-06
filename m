Return-Path: <linux-pci+bounces-11348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5694F948994
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 08:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8881E1C22784
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 06:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBB1BB683;
	Tue,  6 Aug 2024 06:46:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D712A94A;
	Tue,  6 Aug 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926815; cv=none; b=nH9KMoROdABak+pP0VaLARyl+e2sNUHbhG0rxH6qBVQpGnuRtHSAWv11+icwGMP7bYL+WRynJUEgwuuhS9p6dPsI9Vc7Qd4lH3ogAGZK8OWNbTL2ODfjsimHLQwBkvTbZTGU04QFKbiYef1u2tX/ULz+Iq3XLSLFhB/rYncxKlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926815; c=relaxed/simple;
	bh=kN7qcnABhS2q2AECR1b9x9XPc876WEwD39LAyyVhTp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHZ4cCmwUZJZjVjwoFV8+OZB/OXUX0eEBo4PVOox0D1cpyEV/HIjxsUQJo+a8e8L3t92xNXCpCuvL9K++8AN+j3UJDoA/3uUCIDHH4QGEsHWkhEHfqdFIdfHDj8fX2CV1/ZONtUR/QfRUFVc4pfH6bhrJnyaMM2bzmQjDl6/ZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2FE5C300002A5;
	Tue,  6 Aug 2024 08:46:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 18F30366AB; Tue,  6 Aug 2024 08:46:48 +0200 (CEST)
Date: Tue, 6 Aug 2024 08:46:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Message-ID: <ZrHG2KnGp9N00mV_@wunner.de>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org>
 <Zqyro5mW-1kpFGQd@wunner.de>
 <CAJZ5v0hw7C2dHC3yXAwya-KAjzYxU+QgavO_MkR9Rscsm_YHvg@mail.gmail.com>
 <Zq08i2i_ETHsJiKW@wunner.de>
 <20240805132442.GA7274@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805132442.GA7274@thinkpad>

On Mon, Aug 05, 2024 at 06:54:42PM +0530, Manivannan Sadhasivam wrote:
> So what is wrong in using pci_dev::bridge_d3?

The bridge_d3 flag may change at runtime, e.g. when writing to the
d3cold_allowed attribute in sysfs.

If e.g. bridge_d3 is set when pcie_portdrv_probe() runs but no longer
set when pcie_portdrv_remove() runs, there would be a runtime PM ref
imbalance.  (Ref would be dropped on probe, but not reacquired on remove.)


> Again, pci_bridge_d3_possible() is not making use of values that could change
> dynamically.

Which is precisely the reason why it (and not the bridge_d3 flag) is
used by pcie_portdrv_{probe,remove,shutdown}().

Thanks,

Lukas

