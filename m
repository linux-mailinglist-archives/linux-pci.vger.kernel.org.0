Return-Path: <linux-pci+bounces-25266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6EA7B691
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 05:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21A13B8FE3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4E13AA2E;
	Fri,  4 Apr 2025 03:08:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584B42A8F;
	Fri,  4 Apr 2025 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743736138; cv=none; b=HtpRRQX2nuwDcuZCQd9TpNgZFHcEsftsYlvnncN9WXmZpxvpbGKDUQecxeOdGMFtwFyEc9phwHtPJAeCDyyWg3OyP+tewFU9Tzj2rLGfd8wgR5C3O4IFrGPWFgjOw2Eeczhp9a3JPiZGBU49ZJhzSMx8fqT8FbX+j9n5ahWVyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743736138; c=relaxed/simple;
	bh=EFv5kyn/a5Ai+gwUVyuC7HIbBRAFDJibgtYJMSxEavU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXLPOoJvqvN3cvqwU3UmSdAUixGNIBypwqNUSrQPJU0H5UxMS7ZzufUB8CWFJATcFut598DZ6Rddo7rXgL9psovJnM05bM0yoNEEcd/bi1shBIdwox3BMw9e2v4VTKHHvIGozDqn2cxXVdxLD5DrzWLtawQ0Slo49kWVBOErcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4C07A2C506B7;
	Fri,  4 Apr 2025 05:08:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 39C12E798; Fri,  4 Apr 2025 05:08:45 +0200 (CEST)
Date: Fri, 4 Apr 2025 05:08:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v1] PCI/AER: Avoid power state transition during system
 suspend
Message-ID: <Z-9NPQUMt2s90CAA@wunner.de>
References: <20250403074425.1181053-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403074425.1181053-1-raag.jadav@intel.com>

On Thu, Apr 03, 2025 at 01:14:25PM +0530, Raag Jadav wrote:
> If an error is triggered while system suspend is in progress, any bus
> level power state transition will result in unpredictable error handling.
> Mark skip_bus_pm flag as true to avoid this.
[...]
> Ideally we'd want to defer recovery until system resume, but this is
> good enough to prevent device suspend.

if (system_state == SYSTEM_SUSPEND)

... tells you whether the system is suspending, so you could catch that
in the error recovery code.

Suspend to ACPI state S3 or S4 shouldn't need error recovery through reset
upon resume because devices are generally reset by BIOS on resume anyway.

Thanks,

Lukas

