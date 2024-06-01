Return-Path: <linux-pci+bounces-8154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572B8D6EAC
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08F81C21749
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4984175A5;
	Sat,  1 Jun 2024 07:28:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4F1FA1
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717226891; cv=none; b=jbrOGzB90LtbpAnhYH1JkfGQQs9385sMqvpbiHQKec3ufaMOrgwnR3//roJhEIBRfkbVTyke1RuzhUOCLxXqvNvPqG/9Iqbhv/tTNtIzS0JTNWckPy+ZrqQRJXCYSUaHWHPkZ3wIENAfAqpW1F+0xy1MQc1WkOJUDMKNPi2VReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717226891; c=relaxed/simple;
	bh=d9mbdW8TbVNFyraHdNdpYcvb44Nh82nZjKPJEpMy9g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYwHUUDaxw8oT1YEPO9RV4WiOWV5BpBhoo8Q36MSlB/cNXRH3bxS4Ef2qYAdbQeeY9HKOc2yyIFSa+z09KVDeNiCcCq91vSqEi4q2GiwvYpbmU1vayXi/kkY3BhgxQjF+MQyBPs2TNVKrTA7PbrGjmRosYG5+e471z3Ny3mvHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 15CDA2800BDB3;
	Sat,  1 Jun 2024 09:27:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EAA3A357A76; Sat,  1 Jun 2024 09:27:58 +0200 (CEST)
Date: Sat, 1 Jun 2024 09:27:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: alan.adamson@oracle.com
Cc: linux-pci@vger.kernel.org, jonathan.derrick@linux.dev
Subject: Re: Spurious DLLSC on a x4x4 NVMe
Message-ID: <ZlrNfu_PvKkD_4jS@wunner.de>
References: <c14b0b67-e766-4464-9acb-dc4f6dea0b7e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14b0b67-e766-4464-9acb-dc4f6dea0b7e@oracle.com>

On Fri, May 31, 2024 at 02:11:56PM -0700, alan.adamson@oracle.com wrote:
> Back in 2021/2022 there where discussions about issues when hot removing a
> bifurcated x4x4 device from a x8 slot. I could not find any resolution or
> applied fix for this.
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20210830155628.130054-1-jonathan.derrick@linux.dev/
> 
> Was there ever a resolution?

No, there wasn't.

I proposed a patch in this e-mail:

https://lore.kernel.org/linux-pci/20220924073208.GA26243@wunner.de/

...but it seems nobody actually tested it for the bifurcation use case.

Thanks,

Lukas

