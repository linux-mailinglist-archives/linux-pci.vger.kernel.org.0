Return-Path: <linux-pci+bounces-12172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2566D95E39E
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04391F2171C
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DC914A639;
	Sun, 25 Aug 2024 13:47:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0E13F458;
	Sun, 25 Aug 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593645; cv=none; b=NWIr8pfkwQKF0Of7H4XXhRF/GOMvynIcd/GZCmFcvmPvdaurS3nNWT2t/EVsD4WQSZZApSwBf/RiFXSzg0cM1UA/7WeXJaZPn5AA/yHh8AbSwcUGzUgC/6IP3hatr3Cafv/stHzJjhtFiy2y9VIkBUTXuuxl5uwC3dcUC0iiY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593645; c=relaxed/simple;
	bh=GNG7BHifXDRPnG0cDudbbadTux08EVatgwyXmdmVRYQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=KEvCmWjUKHdmdWh6PDPFfZbDiX5iAs5E8UXrE0CYhUQj7KmtA+cZIDTaW9sL7LGWq2XB72/mozUNJ8aoqbkcUtKRerrbghN5x5kzRs0jiZlLEgmIHmPA4SI5ezm1ccCwZpBtmi8H0s6RNvUTl8w7t6EkrVpYsTlgpmZt1/XQNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D35D792009C; Sun, 25 Aug 2024 15:47:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CDAD292009B;
	Sun, 25 Aug 2024 14:47:19 +0100 (BST)
Date: Sun, 25 Aug 2024 14:47:19 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] PCI: Rework error reporting with PCIe failed link
 retraining
Message-ID: <alpine.DEB.2.21.2408251354540.30766@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 This is a minor update to the patch series posted here: 
<https://lore.kernel.org/r/alpine.DEB.2.21.2408091017050.61955@angie.orcam.me.uk> 
which includes a change to 2/4 suggested by Ilpo to wait on LT rather than 
DLLLA with the recovery call to `pcie_retrain_link' in the failure path, 
so as to avoid an excessive delay where we expect training to fail anyway.

 This patch series addresses issues observed by Ilpo as reported here: 
<https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/>, 
one with excessive delays happening when `pcie_failed_link_retrain' is 
called, but link retraining has not been actually attempted, and another 
one with an API misuse caused by a merge mistake.

 It also addresses an issue observed by Matthew as discussed here: 
<https://lore.kernel.org/r/20240806000659.30859-1-mattc@purestorage.com/> 
and here: 
<https://lore.kernel.org/r/20240722193407.23255-1-mattc@purestorage.com/>. 
where a stale LBMS bit state causes `pcie_failed_link_retrain', in the 
absence of a downstream device, to leave the link stuck at the 2.5GT/s 
speed rate, which then negatively impacts devices plugged in in the 
future.

 See individual change descriptions for further details.

 Original submission at:
<https://lore.kernel.org/r/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/>.

  Maciej

