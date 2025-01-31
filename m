Return-Path: <linux-pci+bounces-20587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DACA23D94
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85383A45A2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5C61BD018;
	Fri, 31 Jan 2025 12:10:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDD16D9AF;
	Fri, 31 Jan 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738325404; cv=none; b=KEY1GqzvYm392Qj9qH7GjU3+O+aeYBv0+4qV63MTMOXH9e3UFFe5qj3VKRG9Zh18vhGSqdwN5j6ZoOsp0C3kNLSt1cCdnN4jmTfzFzawagpwaGCQgD/dcK+mapUofhCESFRhjdohTeEug9iaFqqbyAeQ/lSnnztpiIquPCBozPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738325404; c=relaxed/simple;
	bh=jZGcq+yg1AZLUIKLtsjmrWCl4GzT6CMuM7zP/fm4DVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6DWJZFCPR6Yr/SFnSlEXll14qCvEspW5F3pN6LTWCJvVsdCNpFNI659H5afzMKVjLM6GgLy9t7fyFP9ETEil/Byga2ZowuS1ThgqjgpdhVhtHUbpKmQIZrgv8mkuBS7JK2qSIx+szLjHSBkg2I6gX1fn4REzSOVkG+DwRV1eUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C388B3000C9A0;
	Fri, 31 Jan 2025 13:09:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BD70AAAAB43; Fri, 31 Jan 2025 13:09:51 +0100 (CET)
Date: Fri, 31 Jan 2025 13:09:51 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Assistance Needed: PCIe Device BAR Reset Issue
Message-ID: <Z5y9j0eOQTIrcD7E@wunner.de>
References: <CAMciSVUzFL+myQTTRD-OZRf+o9UUPDE87SzUxQ2cYdjrfd7iHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMciSVUzFL+myQTTRD-OZRf+o9UUPDE87SzUxQ2cYdjrfd7iHQ@mail.gmail.com>

On Fri, Jan 31, 2025 at 03:37:26PM +0530, Naveen Kumar P wrote:
> PCIe Device: PLDA Device 5555
[...]
> Initially, the BAR value is 0xb0400000. However, after some time, reading
> from the PCIe device's BAR memory fails and returns 0xffff

If you're reading "all ones" from config space, it means the device is
inaccessible and the host bridge is returning this fabricated value after
a timeout.

>         Kernel modules: m1801_pci

That's not a driver in the upstream kernel.

Maybe that driver allows the device to runtime suspend to D3hot,
which in turn allows its upstream bridge to also runtime suspend
to D3hot.  Then the device would be inaccessible.

> Verified power management settings:
> 
> cat /sys/module/pcie_aspm/parameters/policy
> Output: [default] performance powersave powersupersave

/sys/bus/pci/devices/0000:01:00.0/power/runtime_status
would tell you whether the device is runtime suspended.

Thanks,

Lukas

