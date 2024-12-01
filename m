Return-Path: <linux-pci+bounces-17501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5079DF54D
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 11:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82251B20C61
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09D70821;
	Sun,  1 Dec 2024 10:54:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D22B9A2;
	Sun,  1 Dec 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733050498; cv=none; b=ODNqaiJcMJzmhV0tqy9gbZC2F9NY4QyS1N26Iv9ggbAG87FHKMqa25x06et45O0rePxEMu4rFHoVrn0Ks6Yu1hM6NH6srHqBp1ASzQqv0DUIe8/s8MUMYwdAB+uAZq5sVxXDXKo5LI1+zhyYe0k/b53pMwEGcWeINbUFgSi4iS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733050498; c=relaxed/simple;
	bh=VMn30XqKRpwic6TlfkWZsleOtK7GHyHvdzPiBmpHlQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEHzYzhrK39DBxkEHYEVtMfi1DOf7tQsWJUXnDwBI19wYXxpnZ0v3R5il1mGEm3HEg0SZdPOVYB53xPkFfLcnOqrBfWNmQ93JMMOHDpYKHkt+hm2Tw5CKBPmHsCskrKUHq6OZHu94rgZRpvBTiGpdc2oFKtfLXB6eEGsCKvbJtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E5AAB101E6C2B;
	Sun,  1 Dec 2024 11:54:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ADF774E9232; Sun,  1 Dec 2024 11:54:45 +0100 (CET)
Date: Sun, 1 Dec 2024 11:54:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
Message-ID: <Z0xAdQ2ozspEnV5g@wunner.de>
References: <20241126210443.4052876-1-briannorris@chromium.org>
 <20241129192811.GA2768738@bhelgaas>
 <20241201082108.qy2reqd56mvrd6ku@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201082108.qy2reqd56mvrd6ku@thinkpad>

On Sun, Dec 01, 2024 at 01:51:08PM +0530, Manivannan Sadhasivam wrote:
> The idea of pci_pwrctrl_unregister() is to remove the pwrctl device when the
> associated PCI device gets removed. When this happens, the pwrctl driver will
> turn off the power to the corresponding PCI device

After pci_pwrctrl_unregister() is called from pci_stop_dev(),
the device may be accessed by one of the calls in pci_destroy_dev().

E.g. pci_doe_destroy() may set the DOE Abort bit in the DOE Control
Register if a DOE exchange is ongoing.  One cannot assume that no
such exchange is ongoing merely because the device was unbound from
its driver.  The PCI core may have legitimate reasons to perform a DOE
exchange or generally access config space even after the device has been
unbound.  And IIUC, those accesses will fail if pwrctrl has powered the
device down.

Another example is pcie_aspm_exit_link_state(), which will adjust ASPM
settings on device removal.

So it seems to me that the call to pci_pwrctrl_unregister() needs to be
moved to pci_doe_destroy().  However I'm worried that will break the
symmetry with pci_pwrctrl_create_devices(), which is only called in the
!pci_dev_is_added() case.

Thanks,

Lukas

