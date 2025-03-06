Return-Path: <linux-pci+bounces-23066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B58A551CB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 17:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C03F1765EC
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA12571C8;
	Thu,  6 Mar 2025 16:48:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275413635B;
	Thu,  6 Mar 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279699; cv=none; b=u6lVzXtEhuW672ORl0XZEcP423+Tj5pKwgJhWYicyqteXQEsGdc70QsgvkaiBxXpO1ys6O9Ws9JJf+vSTorRMqMhrrhPJ9i4NjfLiLPdLBAaORqZEI0Cy/a3/uFcXXJl1Qrb+oFPsnJSZ6l81doZ+83jYuODGBCmOsHcfiq3i9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279699; c=relaxed/simple;
	bh=cRxH/eNjPom3M8pp6oEsvNCyvMgaeq+dOvETtm3u/qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMVtyZAYuxvE76UWoES0N9dGLu37dB0GCucZ+0Cq3xLcD2X7SQlVPSXEN6OwQCQsOBR1xt6sUCI0ZC6WtvA21Lkyl/9s5pKJhO7Clg0cKJISyTmIBt31x6pkbETJAxbIR2ZCQeRQ1Iac+l/6UMBCAqtPUTTSPWg26rt+6qAAl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 500AD300115FB;
	Thu,  6 Mar 2025 17:48:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 35FC21F5C3; Thu,  6 Mar 2025 17:48:13 +0100 (CET)
Date: Thu, 6 Mar 2025 17:48:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Fix system hang during resume with
 daisy-chained hotplug controllers
Message-ID: <Z8nRzYOgTz86xRwN@wunner.de>
References: <20241022130243.263737-1-acelan.kao@canonical.com>
 <20250305230959.GA318387@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305230959.GA318387@bhelgaas>

On Wed, Mar 05, 2025 at 05:09:59PM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 22, 2024 at 09:02:43PM +0800, Chia-Lin Kao (AceLan) wrote:
> > A system hang occurs when multiple PCIe hotplug controllers in a daisy-chained
> > setup (like a Thunderbolt dock with NVMe storage) resume from system sleep.

Thanks Bjorn for reminding me of AceLan's report.

This appears to be the same issue Mika and Kenneth reported,
a fix is currently being worked on in this thread:

https://lore.kernel.org/all/Z8nRI6xjGl3frMe5@wunner.de/

