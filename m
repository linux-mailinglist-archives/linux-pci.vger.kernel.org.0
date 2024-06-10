Return-Path: <linux-pci+bounces-8548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190990276A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 19:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB26A28984A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5813C819;
	Mon, 10 Jun 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="n/SSVeLg"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EA1E4B0;
	Mon, 10 Jun 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718039131; cv=none; b=ktCflxdYtPgzzi+V4EQxlunZq5y/UjIzUxjTp3RvycEKhUCEvoyRPjnGVZ/4HffIU4Y011euMOhn27Gnl+rK/kSbUZCcNfaglp5eE4196KHshWKXeBq5WQMm2p/Vk971S8fbjGiRXdPDj445czCkNKWrGG6hXjDdsWWO3btucwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718039131; c=relaxed/simple;
	bh=jKS3MuwjOqVi1LYTcaBD5kWbzqgcc2y8GtTs8r6U+BU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=qyD2rY/pMxPJW0gpIZLU1MyAcCabfMk1t3o6wnkO1DmCCy7G/CZRHoFPWhKScZVOmHZSfZIcfsBcInkthKQhMD5sqvJe0irXXA+5RGNOBC/OTVRNXV91SBSaje6uhyjAcplYBDcUbjY06HWm+cKetFsgEE5KN1SNOCVmp0rZevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=n/SSVeLg; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Qrv7Sttr41le5/dZwT/NWoIdvUouzD0OZoeprPF9tk8=; b=n/SSVeLgMBvbqR6V7an7yf5zJY
	X4KSBiqmSr87uDZxv+8vP3nzFiPRFs5x1Pdmmt2v474p5GQ/DWeNr24p+qaQnt7Pr4Tk88DqiVVMo
	bhVGvxz6EzHWdUIFT7WDc6SXoZDZmfMWBX+OmDB8hX6q67TLX1IS8a91JXzw2qiYI6qKa0m2JWpl2
	4C8ywS8oVto3So5178sfgXHkEixAk8UbiIBUmjng52tEvkLubA5lmd9hK3Ijwf/1gWhy5NBFWfs79
	SZxLy6kiIqbbF9I+NkdYI136qa+lUzCnOh8N2k250MOMyKAT/ddUJ2P5dTV+1c7WHhUTBsnDcl4Jo
	hXsi2IgA==;
Received: from [172.16.1.162]
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1sGiSQ-0055ry-0M;
	Mon, 10 Jun 2024 11:05:22 -0600
Message-ID: <c0e0f7bf-845d-4d7d-857a-ca09acdb92af@deltatee.com>
Date: Mon, 10 Jun 2024 11:05:12 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev
References: <2024061053-online-unwound-b173@gregkh>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <2024061053-online-unwound-b173@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kurt.schwemmer@microsemi.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, bhelgaas@google.com, ntb@lists.linux.dev
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI: switchtec: make switchtec_class constant
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-06-10 02:20, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: ntb@lists.linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Looks good to me, thanks!

Reviewed-By: Logan Gunthorpe <logang@deltatee.com>

