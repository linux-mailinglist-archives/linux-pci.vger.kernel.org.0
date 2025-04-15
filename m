Return-Path: <linux-pci+bounces-25932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA3A8A4CF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 19:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8CB3BC9A6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3208F7D;
	Tue, 15 Apr 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="P3RtSJ+k"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142710E9;
	Tue, 15 Apr 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736422; cv=none; b=nb4WXazMsOE11ehQ8VxYp5Zjg5jP5JQt0iBaO+50jGSoWicgcapJl1Ieql98VqThhgL4eubve2HsWFD0TfJIE6t623XBkfNYXriw4dZRVxMBhLkTeB3CiUt5axf6s0LS+YD5cvWXrjqElgKsL39BhXTq6GWIKjxLm69p/mHiBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736422; c=relaxed/simple;
	bh=KsPCEMVc2LMLTS4j1lUJZrful794O99DydUdMIngm8A=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=OO/1HlEoJ9rViMKa+Dw/nDZeQF2us4nK8BajhBkWKWVsyHK8zMDVgKrNFcRqUNhxmMXK1z9FGfgIS2LDaFWweBMcYwo2mx6x29ROJm6g0EsDmlX6oRXo7yB2ENT2dVHb5GBR5HiRwnyziE3pRpaLa3RL79Cy1dakUa0Wwo0D17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=P3RtSJ+k; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
	MIME-Version:Date:Message-ID:cc:content-disposition;
	bh=KsPCEMVc2LMLTS4j1lUJZrful794O99DydUdMIngm8A=; b=P3RtSJ+kk9OJ5LuMQzZga8rlKU
	lwj6oFYa7EtD7N+rEKwDyzNt8XfjFLRuIHwZOchBOA71z9i2CZjmKmW4t06/+LKOdaewTrVnxhHCs
	AxaOXIxquT/r/b6Y3ZjsIXNtsYBw+U/LtVWR5eOldEBRU03n1F6I0nq8u8nNPWf0CAT1ijVsgocPX
	zUS8oYl1s82QpX9yylOxZWHhHg2qySHGgBU9uIX5eU1tdc8WXq3FN54a/U2EcpzPS+tlgDg9wnEQq
	hH0T4z2w1KjwkswMhwFoYDLEakw3amD0T/Cl5m86x7nWSDLp7obeEh+qyC0Hz9hu19JJNm4RanAnQ
	UnsLJESg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1u4jdt-000rei-0Q;
	Tue, 15 Apr 2025 11:00:12 -0600
Message-ID: <dbb07d97-433b-4792-bbd7-74033c838d29@deltatee.com>
Date: Tue, 15 Apr 2025 11:00:11 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stephen Bates <sbates@raithlin.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z_2nIRgPqp2JlT9m@MKMSTEBATES01.amd.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Z_2nIRgPqp2JlT9m@MKMSTEBATES01.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] p2pdma: Whitelist the QEMU host bridge for x86_64
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Stephen,

On 2025-04-14 18:24, Stephen Bates wrote:
> It is useful to be able to develop and test p2pdma applications in
> virtualized environments. Whitelist the QEMU PCI host bridge emulated
> by the default QEMU system for x86_64.

The host bridge is also in real hardware. 82G33 motherboards from c.
2007. Given it's age the real hardware probably doesn't support P2P
transactions, but at the same time it's probably pretty rare and I
wouldn't expect there to be much risk of someone trying and failing a
P2P transaction on such a machine. These things are probably worth
noting in the commit message.

Other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

