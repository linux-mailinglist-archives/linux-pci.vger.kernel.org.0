Return-Path: <linux-pci+bounces-9208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05C91576E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 21:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47774B230FF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983991A01C8;
	Mon, 24 Jun 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mdn+WCiP"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8319FA7C;
	Mon, 24 Jun 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258883; cv=none; b=KdPhk9yTK57rKzq3LoMBfgDAtZMPuNh2Wy7Z98rYeR//Q29AL7OQ9WVsBv4BBqznwvuH5KeSyS+7eNSHNesf03fRRfD17y8HjeXzT3ZdXDfJoYVjFF9K9MTcxOaCA8Hi5dR9OdgfRtloAu1PfgKMv+CXy8ouTKodfVsUgjxJCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258883; c=relaxed/simple;
	bh=YjeIZMTsd0omzx/GT5djMmpkMHF0TUzcmkFbGvfVmVI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=YN7C9H8tqeV7cKjhlniGzJZHpc2+RcPWq+izeA7XrTw9FAjWvQjtbcHBvuxR53k9OZReJ76k7t+f53LphWAMsxvAwwVSzSH0OV5yFcQMBq8ljSIQlTi9fJlbgOcsby2EysREUlQoHC6MEZGWIA6N2H5SDJ5p83XbT1FiIAYRKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mdn+WCiP; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=YjeIZMTsd0omzx/GT5djMmpkMHF0TUzcmkFbGvfVmVI=; b=mdn+WCiPlUD/e/xuATkjETArAY
	n6Eb+FlQbES0RDhy/Z7P/A2jM/xplHg2O+Coq12Rk8c09YT5qCkYewIvscGHj+QqLfriHkOuQTyQT
	NE8+GzCVW/3cI/736SyYclnQR0kAxcXlBJWqgjwPuEoKXScJbcB31ObM4mWrhnDLgQbtyjMVR16MI
	zqgzC1wMo3c4u+Tt2A/reaeYdcSCc7yvg/c8WvBqnMwC3JnIUxXaxuMgZj+8cXhVFSFOvm2SyGBAj
	m3SIrNieBIMrBgitaOEoD1q91yZGsivZ3xyRfXaaBLl9tUTUwWMa2f3+csMT9rhpNyp9XjjiTrCr8
	YSHocFnA==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1sLpP5-00AMSm-0E;
	Mon, 24 Jun 2024 13:31:11 -0600
Message-ID: <6e2dc59a-445d-435e-9066-4a00119acf02@deltatee.com>
Date: Mon, 24 Jun 2024 13:31:01 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bjorn Helgaas <helgaas@kernel.org>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com,
 sathya.prakash@broadcom.com
References: <20240621205327.GA1374772@bhelgaas>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20240621205327.GA1374772@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: helgaas@kernel.org, shivasharan.srikanteshwara@broadcom.com, linux-pci@vger.kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com, sathya.prakash@broadcom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/2] switch_discovery: Add new module to discover inter
 switch links between PCI-to-PCI bridges
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-06-21 14:53, Bjorn Helgaas wrote:
> [+cc Logan]

My apologies. I'm dealing with some health issues at the moment and I'm
not able to review this in a timely fashion.

I'll try to review this when I'm able but that may not be for a few weeks.

Thanks,

Logan

