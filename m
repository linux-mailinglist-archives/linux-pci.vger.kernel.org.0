Return-Path: <linux-pci+bounces-30188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB79EAE080A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F861BC494F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57B4231856;
	Thu, 19 Jun 2025 13:55:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960928B4FB
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341342; cv=none; b=bwt2zOctg4jNDK5yefe3/zDUyyKb0yO5EAatkGYjGP9ha0HlyvQRsk8R1b1r8bN2bQhNKvLl6bBUX6WKYpwemmbbSlxWKvVx3oj9JJr7Pc45Hpcz4DmfOy+5cJ7AxxXApuxx4F1C071ln9yv4LaW9/Qzl04A0/Vwgj6SgwQVVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341342; c=relaxed/simple;
	bh=mYLc9HlJ8ITM10P2FTXfPSJsOtJ+LRaCpUaOVdn/5nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdDoy2YSc+RBFPX0ncy7ylG2IASk/KwfqgwSbbsNVYJXdbT9osAwKa5B/ma5FnX40Cwcu/z0yZpYoMQtjqeLnTmc8AqSqHVtFa8HaSSTjOM8UPmf5jenAxsZCD/5cr2ltg0hXWYSTB8a/EpzFpLlYeYVcJZ1nZ40P5ENGBJlEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7535E2C0527F;
	Thu, 19 Jun 2025 15:55:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4BB0A3A0814; Thu, 19 Jun 2025 15:55:37 +0200 (CEST)
Date: Thu, 19 Jun 2025 15:55:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	mahesh <mahesh@linux.ibm.com>, Oliver <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
Message-ID: <aFQW2aDZa9DhxBPG@wunner.de>
References: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com>

[cc += Krishna, Shawn]

On Tue, Jun 17, 2025 at 10:41:58AM -0500, Timothy Pearson wrote:
> Add pcie_link_is_active() function to check if the physical PCIe link is
> active, replacing duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>

I note that there's a Signed-off-by tag for Krishna here,
but Krishna isn't cc'ed.  In future revisions please cc
everyone you're tagging.

Also, if the vast majority of the patch has originally
been authored by Krishna, please give credit to Krishna
by including a From: header at the top of the message body
(as you've done in v9).

Thanks,

Lukas

