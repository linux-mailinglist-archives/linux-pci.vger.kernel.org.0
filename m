Return-Path: <linux-pci+bounces-27788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F9AB866A
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2964C0EB1
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8922980B7;
	Thu, 15 May 2025 12:33:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F60205AA8;
	Thu, 15 May 2025 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312393; cv=none; b=DLBY9arBRHNG2pdqB8OTSGeDMT15gZtrhaGh47GBX3kowoI+q9irqF0xh+/j5nmNCJZR4sJGyp265iSIFoB9Na6dYwU9oya8IEVgMz+ob1IAy9BoldsRLcU6jgW5sS8iGS5l+WQdTZ1PpE9HPnN9gr97fkOD/uQLeLXXvpN9SAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312393; c=relaxed/simple;
	bh=sqn3TjNu0rqeVDckBpHQKmt76v9N8Z5F9oXbP6OA3IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvGsRO1LaRFd+H4VmLexKeSxfB0b9DfQRomM3zQzOdgxtoywQ0SBjhWg67Jd4b+b3ug2TjuwBIuAzJpMQxsMwFBfYyJ575gRSeirlisn/ZJVnM987H+32vLwqBxc63RWqAGltlzJl7o3sVcXLrb5kOmqxaxxkk1GF+UVUzstEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6205A2C051C8;
	Thu, 15 May 2025 14:32:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 36B082D3E7; Thu, 15 May 2025 14:33:01 +0200 (CEST)
Date: Thu, 15 May 2025 14:33:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <aCXe_SMq6vsAIAin@wunner.de>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
 <aCTyFtJJcgorjzDv@wunner.de>
 <20250515084346.GA51912@rocinante>
 <aCXZdfOA8bme-qra@wunner.de>
 <98fa31e7-db86-35f0-a71c-a1ebf27f93f0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98fa31e7-db86-35f0-a71c-a1ebf27f93f0@linux.intel.com>

On Thu, May 15, 2025 at 03:21:39PM +0300, Ilpo Järvinen wrote:
> I'm a bit hesitant to mark "Accepted" state though, I did it this time 
> but in general I feel I might be overstepping my authority even if I know 
> some patches have been accepted.

Bjorn has encouraged submitters to mark their own patches as "Superseded":

   "If you're really gung-ho, you can go to Patchwork [2] and mark
    your superseded patches as "Superseded" so I don't have to do that
    myself."

    https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

... and I was assuming that also applies to marking one's own patches
as "Accepted", but I might be jumping to the wrong conclusion.

Thanks,

Lukas

