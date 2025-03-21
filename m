Return-Path: <linux-pci+bounces-24380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B1A6C0DD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999A5189BB1F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEFD22D78D;
	Fri, 21 Mar 2025 17:06:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001222D780;
	Fri, 21 Mar 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576781; cv=none; b=E5E9/QcDuKxjfVGL8cszo9CNnrpIJ/i0/nfFwTutpHbBQZ9KqjzypdZm5Be8ACAzlrT+xxihy5Y8NTAbLn/NXEHnc0PRQMNsQQ9Bc2A8kOBxZtiJsOM2hqq1lan5Fr+cOsC2Wb8b0uQ+bVci26CeUCxBV+VE+EUPNRILTFjZgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576781; c=relaxed/simple;
	bh=rB8HreJcBYfpiq7zKNH0GqqCKIth7YokrijCc5SGkVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHGBFpoVM91RMsyPCcO311k4a2s1Z7bR1iVkvHF9SiHJiS2d4fHGi9FuBSzjsuxvUF0lzGL2apjAi0zB6CtKmyfR6PECIqlh4CWn5CN7p3gakGnZQDUY6NRHM+7FgdkGV37+9OoT8HLYM0BBqA6ZnjJwfIiaZR5lWPOgEIBpKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B82F33001F867;
	Fri, 21 Mar 2025 18:06:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9E000562E9; Fri, 21 Mar 2025 18:06:09 +0100 (CET)
Date: Fri, 21 Mar 2025 18:06:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 1/4] PCI: Introduce generic capability search functions
Message-ID: <Z92cgXEGwgYD2gau@wunner.de>
References: <20250321163803.391056-1-18255117159@163.com>
 <20250321163803.391056-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321163803.391056-2-18255117159@163.com>

On Sat, Mar 22, 2025 at 12:38:00AM +0800, Hans Zhang wrote:
> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
> duplicate logic for scanning PCI capability lists. This creates
> maintenance burdens and risks inconsistencies.
> 
> To resolve this:
> 
> Add pci_host_bridge_find_*capability() in drivers/pci/pci.c, accepting
> controller-specific read functions and device data as parameters.
[...]
>  drivers/pci/pci.c   | 86 +++++++++++++++++++++++++++++++++++++++++++++

Please put this in a .c file which is only compiled and linked if
one of the controller drivers using those new helpers is enabled
in .config.

If you put the helpers in drivers/pci/pci.c, they unnecessarily
enlarge the kernel's .text section even if it's known already
at compile time that they're never going to be used (e.g. on x86).

You could put them in drivers/pci/controller/pci-host-common.c
and then select PCI_HOST_COMMON for each driver using them.
Or put them in a separate completely new file.


>  include/linux/pci.h | 16 ++++++++-

Helpers that are only used internally in the PCI core should be
declared in drivers/pci/pci.h.  I'd assume this also applies to
helpers used by controller drivers.

Thanks,

Lukas

