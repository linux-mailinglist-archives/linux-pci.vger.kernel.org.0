Return-Path: <linux-pci+bounces-15657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA539B6EB6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 22:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCE21C21930
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69C1C460C;
	Wed, 30 Oct 2024 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Hn4eDVf8"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4B21747B
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323221; cv=none; b=BjwfroVI4JdIlgplOfgXLU4nN6zy4bc3pPjQJ4vZuaFqUOOm8n1+8bqWJxSXiizbbP5tiCJ2PDsDo9wjphwe83ECXMaSe9wLPAxFDHHKvuz25rvetlp68KiLG+kTOHHPbQGNrYmDH7k+a6lcjnJYeRFH6K590Q87/IPexduC/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323221; c=relaxed/simple;
	bh=Teay/SDFVQ3KrSrIP+rOxfqoHOvTS5vn0M/5NXbwQys=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=lDVgOJDa5tiNBb+I1aR6P76SpZQTYY+7zbJEIEyaHgnUOFyKTMRExjqsEKHrAKnUpq+5CGbAOsSH7I4/OBCUE2JP8R8m4VIhFJDN/gspNXfmgxk19Z9inA3q5K/nO02tcEWGbqoSUmb9x9va36Qe64D65n/rK28qNjXUPq09s3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Hn4eDVf8; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Teay/SDFVQ3KrSrIP+rOxfqoHOvTS5vn0M/5NXbwQys=; b=Hn4eDVf8odnXEa3gXEbm04F6LU
	djR9gKjO57ul/d3FtdsFm/fG2y2ekwz4pJcTFtb+motJr/NBt6KmqAcxV1KLt9avHA0NOCJn3ZQSG
	r6jMjNFU9Gl1dPQdEIyeQBvvfO0FzNk+n7yvYYeX6zX4w9+Zk6e9fUyfJZRQDVT0ENZjJq1iyauLk
	4WUBCye/WmytimX1SwUvQ/abqFWff76EZkjWUJfB40m2CiYFAQ4QHHdjNvfd3Shc7WQyJX7Df+rF2
	0LDZaEyjmQt5/wRxxvWuw0CGBAoMcpQPWC0xG8j7oN5MsD4x44FzNPKvN+E9m0/M8lM2lKrzgWvDq
	7MUw87PA==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t6G6q-004Cg7-17;
	Wed, 30 Oct 2024 15:20:09 -0600
Message-ID: <7e146e2f-5d7c-4f28-b801-360795b4cae7@deltatee.com>
Date: Wed, 30 Oct 2024 15:20:02 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20241030184641.GA1210322@bhelgaas>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20241030184641.GA1210322@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: helgaas@kernel.org, vivek.kasireddy@intel.com, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, bhelgaas@google.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-10-30 12:46, Bjorn Helgaas wrote:
> On Fri, Oct 25, 2024 at 06:57:37AM +0000, Kasireddy, Vivek wrote:
> In the PCIe world, I don't think a TLP can "loop back" to another
> function on the same device.

I'm not sure if the spec says anything that specifically denies this.
But it seems to me that it would be possible for a multifunction device
to handle a transfer to a neighbouring function internally and not
actually involve the PCIe fabric. This seems like something we'd want to
support if and when such a device were to be created.

Logan

