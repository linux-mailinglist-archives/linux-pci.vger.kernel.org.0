Return-Path: <linux-pci+bounces-4370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB586EFB1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 09:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062B01F21E9F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25910A1A;
	Sat,  2 Mar 2024 08:57:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBB134A1;
	Sat,  2 Mar 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709369848; cv=none; b=ZIfaqkkU6ogWC/3ckN6QfOyfAxH084S5PqjeZFv5cay4Vz7wkKLRo8Bv0IXmF2SiRz05N8RjLDuvTki/nNTpFYVEcHYmYd46rqnDn8pUkP+wKim7ZKaMWqjUsp3j+8Rjh84NaXBO6ZGsWgwON14Kc/cZjoqJ6c+yr4Lt4oNpPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709369848; c=relaxed/simple;
	bh=KET+C1+pfLWG4caZqUFEt1d4ZyQE5G3G8vMo+wIeGCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiUjDTm36kq13yusSp+7/ZgcR2TGBGTs4Gfb3zYO6Iy1O2crtz0dVRgccx5NicNOP0crwYNa2PCDPszOlnHaUEsyr4DzFh7WDBhBjeQYp27Q+/gl5cajjgSIqshcmTGWdJEFlDwM5MnV287m8m5P1qexlKFBvInYKigPYBMGo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 661B7100D9401;
	Sat,  2 Mar 2024 09:57:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1AFF52DB06; Sat,  2 Mar 2024 09:57:17 +0100 (CET)
Date: Sat, 2 Mar 2024 09:57:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexander.stein@ew.tq-group.com, decui@microsoft.com,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20240302085717.GA8140@wunner.de>
References: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
 <20240206220715.GA884075@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206220715.GA884075@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 06, 2024 at 04:07:15PM -0600, Bjorn Helgaas wrote:
> Krzysztof has done a ton of work to convert these files to static
> attributes, where the device model prevents most of these races:
> 
>   506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes")
>   d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
>   f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
>   527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
>   e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")
> 
> and he even posted a series to do the same for the resource files:
> 
>   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com/
> 
> I can't remember why we didn't apply that at the time, and it no
> longer applies cleanly, but I think that's the direction we should go.

When I brought up resource sysfs files in October, Bjorn said:

    I think the reason pci_sysfs_init() exists in the first place is
    because those resources may be assigned after pci_device_add(), and
    (my memory is hazy here) it seems like changing the size of binary
    attributes is hard, which might fit with the
    pci_remove_resource_files() and pci_create_resource_files() in the
    resource##n##_resize_store() macro

    https://lore.kernel.org/all/20231019200110.GA1410324@bhelgaas/

I'm wondering in how far Krzysztof's above-mentioned patches
address the issue of late-appearing resources?

In the meantime I've learned of the existence of sysfs_update_group().
It would seem to me that if resources such as the ROM appear late,
we should just call sysfs_update_group() to make them show up in sysfs
(or correct the size of their sysfs files).

But that requires that we identify the places where resources
are unhidden.  Do we know where this happens?

Thanks,

Lukas

