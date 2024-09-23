Return-Path: <linux-pci+bounces-13351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EA697E6AD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85C81F21918
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 07:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A4841C77;
	Mon, 23 Sep 2024 07:34:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529321D52B;
	Mon, 23 Sep 2024 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076885; cv=none; b=KwvLB04yjRwjEQNGchFt29hscEW2jNQCmpjyUEovAO7L+HetbgluXFxT06ckTN9adMZWl4Szf7LiH8cdqS1gU87Mtr9JQQcZkiWoz4pycK4gDcKfQ4givPEfRLyNRo2bDAhcf2yYnif/+H8rAUsxHhutGj78Hv4SwLuIbVOC6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076885; c=relaxed/simple;
	bh=6YWZh3lKuSZsg4ArMwfFUaHDYaGVI8qR8v2mWZrmlLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqh3VdbtOAMIui72SjfKFRFnj2md6t0oWEc5ME9D6t0IWnOl669f9VotYy2IOx3ZTJlUUlW3WlRoxUG7dsqc7vpcu3HXFJTTx6VGeT4NkqIP1jvNY3klKVbSZuVWrgC1+hhYFTCMtMSMTwuBmJcZtCXvtCCA20vVJLSemkyvZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 18AC6280138C3;
	Mon, 23 Sep 2024 09:25:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0169A25B6; Mon, 23 Sep 2024 09:25:06 +0200 (CEST)
Date: Mon, 23 Sep 2024 09:25:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, paul.e.luse@intel.com, jing2.liu@intel.com
Subject: Re: [PATCH V5 4/5] bnxt_en: Add TPH support in BNXT driver
Message-ID: <ZvEX0vPIpwGPZgGR@wunner.de>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-5-wei.huang2@amd.com>
 <69110d07-4d6a-4b7f-9ee1-65959ebd6de7@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69110d07-4d6a-4b7f-9ee1-65959ebd6de7@amd.com>

On Mon, Sep 16, 2024 at 04:25:03PM -0500, Wei Huang wrote:
> This patch can not be compiled directly on pci.git tree because it uses
> netdev_rx_queue_restart() per Broadcom's suggestion. This function was just
> merged to netdev last week.
> 
> How could we resolve this double depedency issue? Can you take the first
> three TPH patches after review and I will send the rest via netdev?

Just rebase this series on v6.12-rc1 when it is tagged this Sunday
and resubmit.  pci.git is usually based on the latest rc1 release.

Thanks,

Lukas

