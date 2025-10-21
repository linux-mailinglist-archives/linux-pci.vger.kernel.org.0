Return-Path: <linux-pci+bounces-38863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2EBBF53B5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 10:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7F0E350E6E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754191E1DF0;
	Tue, 21 Oct 2025 08:30:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CA26E71C
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035438; cv=none; b=fznd1ej/rXnd/+dYGmuJvOmWgEORFhaRzFCHd1sc0cJcgrwu/k24SJNq51v/JVbVUqW//BiYJ03FcEvLzWD9smfb5GcaDq+qltLWbFDjG9RenBVbfcx8fkC6CjrIJrl1vRnGQq74qkJqlTw8Qqam2Qn6gsiDsgb4ysiKNi3+Dgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035438; c=relaxed/simple;
	bh=cd/cf0vZnJ/8dBeL5n/0/0ovqa317aomJvJfCdJ6Sk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N13wzaV/3e2RYoKSPQfwH2gYGqG2HuT5sC5YpGWRj/FYFIpbYfPRp6IaHj75PcRX2Izi4t7rzm51gsdqy0sNpl1Igz+aICI/Mj69YaZfhsIxRSYAsZQW3CXN1TvGvbBYffcn0grvw0KzBQUidkV3oCmhb+2YLaf1rgafQEdPPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 12F8B2C02B9A;
	Tue, 21 Oct 2025 10:30:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E03054A12; Tue, 21 Oct 2025 10:30:33 +0200 (CEST)
Date: Tue, 21 Oct 2025 10:30:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	=?iso-8859-1?Q?Adri=E0_Vilanova_Mart=EDnez?= <me@avm99963.com>,
	Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <aPdEqcRnp09dwSO5@wunner.de>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
 <aPc4JpVyhCY1Oqd-@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPc4JpVyhCY1Oqd-@wunner.de>

On Tue, Oct 21, 2025 at 09:37:10AM +0200, Lukas Wunner wrote:
> Does this flap of the Presence Detect State bit also happen with
> 4d4c10f763d7?

Sorry I meant to say "*without* 4d4c10f763d7".

