Return-Path: <linux-pci+bounces-22881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F70A4E89C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007F219C0316
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53C283C83;
	Tue,  4 Mar 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eey32oB3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92427E1DD
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107511; cv=none; b=BwI39qGiDKZbzSmDTAd8fQiQyeSxSY5xu28542Sv9e54TRJlCYyUptEdjXjDw2scbricW+OmiGGB5PuFdSql9pwanfbwZRbh0rshpBI6wbsDOrb+nXBW5yMuGxAUYJ4NG+hehcJYP7U6dlX0aVDHVDDmHxV7f7CW9MoL99q1rA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107511; c=relaxed/simple;
	bh=fIitCZ23BYNyvPwxFItByMcIEIJHQdxz0xImpZSVwmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sGrmphks3CWqv0J70c6opH+ZI8awsBi/Cs1Csxl3Zx0xCyC0znjxFju2qnen5p4/0u0tNY7lu8dBmRGVteK6RPfMz03vUHitxyHE36BNf5ONiyAJxYKxPqXu0Z64Xsd4fQuSRYY7MpAZPCAamXfLqgbYmC8yeAd1hfUCfM6kNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eey32oB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D65AC4CEE7;
	Tue,  4 Mar 2025 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107511;
	bh=fIitCZ23BYNyvPwxFItByMcIEIJHQdxz0xImpZSVwmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eey32oB3ygFBGreeResuvIAVtQLNVE5hQWGqnD64SPZKEIfwUQWMWpHTcoiMdIj+P
	 Xr2g5b9E3FUqsQ3TZ4UHnD/ZljGMThv2T2tX5kJj++SAbo5QHF1hs6yrqCdEANxK8M
	 PcaF/j2Lu0w1dk3oE2HQ9LLcLZye6/9R3PAiWbbNh3xNaMYXap6c6QfkbDLEHTxcQ8
	 XzRimAUKF5H/SGmjAmHPa+w0EPInpNOKJUv8ijc2jvkFeIu44Q6MWfpf2cTkVVTDBz
	 P8Gqjgtq/B+uaG9jXAizsM2d1IDvLYl8m/s6r6ho/DvyC5epAusYWfNLYGRGtis6Oe
	 vvnForaBWjRMA==
Date: Tue, 4 Mar 2025 10:58:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix typos
Message-ID: <20250304165829.GA232292@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56112b8d-69e3-9938-b238-fc6a0f43b408@linux.intel.com>

On Tue, Mar 04, 2025 at 06:01:10PM +0200, Ilpo Järvinen wrote:
> On Mon, 3 Mar 2025, Bjorn Helgaas wrote:

> > - * disable_ecrc_checking - disables PCIe ECRC checking for a device
> > + * disable_ecrc_checking - disable PCIe ECRC checking for a device
> >   * @dev: the PCI device
> >   *
> > - * Returns 0 on success, or negative on failure.
> > + * Return 0 on success, or negative on failure.
> 
> The proper kerneldoc formatting for return line is with :, so:
> 
> Return: ...

Thanks, fixed this and several others in this file.

There are LOTS more in drivers/pci, but I'm deferring those to a
possible future kernel-doc cleanup.

Bjorn

