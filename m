Return-Path: <linux-pci+bounces-2576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF983D826
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2248D1C2B97F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD0B1C296;
	Fri, 26 Jan 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZddASvdK"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2571429A
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264118; cv=none; b=TF+fFTDuW056AHOWG+pJABpW5gklATeWw06hQN3dJ50ukBv1DQK3DiEQo+kAIXIk1KKkCC4S+RJpgfZU9nE8O+DZ6OKM2XMd9Xi0D1HEyXnDnLo2E8sPphuAcvFeT6Qn0ltceZ8Au+shdWhXtW94IyrH7aLg05rhxnY+9qxg7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264118; c=relaxed/simple;
	bh=K7ZbKmkkyko8CzeqBuFVpmpZDR/lt/hLWQ9Ysz94KJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAdzUlZIaNRPvwhJmR5NFCP3A5W12HgbYsNkNOD/LF78QIqOW+ZqrNihED+nVeKsRsjGq7665IHCP/oT8Le+A5FAJaGjXh6Pyq/kXJQI5yOaQ0fAlm9GUuw3KxC/2GiSd9mphDjjgYEQMXuEErkImwyef6QoUL0uar7wdt91wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZddASvdK; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 7571D283C43; Fri, 26 Jan 2024 11:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706264107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbZQc2sPveBEy3QFxilZnqRGH9yGq98U2a5NtGUSFs8=;
	b=ZddASvdKfksjqEZwe6D3y0Ka/J/CTbEgyVLtn82NSA3QZeFDAkV5PMoGnRjuna+fbIwXt0
	DFJGtv0qPv9et6TfocZq8kKU+I5Lr9nLHedSWdLVg54H71Jmq/JQgsTTja2DWzQjAhofN5
	lnAHXgdnmAgPUfMoeG5+fvFPo0fVB28=
Date: Fri, 26 Jan 2024 11:15:07 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH pciutils 2/2] pciutils: Add decode support for IDE
 Extended Capability
Message-ID: <mj+md-20240126.101409.24642.nikam@ucw.cz>
References: <20231230124239.310927-3-aik@amd.com>
 <20240112211959.GA2282480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112211959.GA2282480@bhelgaas>

Hello!

> > Capabilities: [830 v1] IDE
> 
> Possibly expand "IDE"? [...]

Yes, please.

Also, could you please provide some test data (a dump of config space
which contains this capability)? See also the dumps in the "tests"
directory.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

