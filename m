Return-Path: <linux-pci+bounces-32601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BCB0B6BD
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E49A179A80
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF012BA2D;
	Sun, 20 Jul 2025 15:34:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6838FA6
	for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025690; cv=none; b=fDjmnxwwpp/1cJ3Ecm+GqeaDLXjgUv4wFq7pjKpd23yT+L+BISMGNNF7qWp3omN8RfC1AOWbb2xiHsYMwzzG89vnw222ABv0HqYrDsPZhfwAVQHfaawnO6A0y2/WnycRFuhQwdpkReV4UcUnzwVPJd93KHc9D2z+bvwLucVMiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025690; c=relaxed/simple;
	bh=TySepg3PGjZlyF5m4kXJT/9CDL58Bw8Lmes8MXjc1Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyFNH8M07/VCkfZuEvq/A0ucNOWMCFcDsrDq4M/3BPbTMJ3dhWXCUEd1dQFD/89rGRb5RaKG7bE8Nv9MmKRqrdR5zbhyVMjz3ntcwcT6QCsw/3rIpnQkYEyl5vkzB9Go+qEz24hgdsO2GSP27UqJ/qe//zkzpmQ0hhfBQscBjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D1D6E200919D;
	Sun, 20 Jul 2025 17:34:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BDDBF19FEF; Sun, 20 Jul 2025 17:34:44 +0200 (CEST)
Date: Sun, 20 Jul 2025 17:34:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Adjust visibility of boot_display attribute
 instead of creation
Message-ID: <aH0MlOshychrsvg9@wunner.de>
References: <20250720151551.735348-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720151551.735348-1-superm1@kernel.org>

On Sun, Jul 20, 2025 at 10:15:08AM -0500, Mario Limonciello wrote:
> There is a desire to avoid creating new sysfs files late, so instead
> of dynamically deciding to create the boot_display attribute, make
> it static and use sysfs_update_group() to adjust visibility on the
> applicable devices.
[...]
> @@ -1698,7 +1690,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  	if (!sysfs_initialized)
>  		return -EACCES;
>  
> -	retval = pci_create_boot_display_file(pdev);
> +	retval = sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_group);
>  	if (retval)
>  		return retval;
>

pci_create_sysfs_dev_files() is called from two places, pci_bus_add_device()
and the late_initcall pci_sysfs_init().

Do you really need to update the group in both or would one of them suffice?
If the latter, please update it only in that single place.  Better yet,
if you know where visibility of the attribute may change (e.g. after certain
function calls in graphics drivers), add the call there instead of in the
PCI core.

We should probably add a code comment to pci_create_sysfs_dev_files() that
it is slated for removal (once the resource files have been converted to
static as well) and that no new attributes are allowed to be added here.

Thanks,

Lukas

