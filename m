Return-Path: <linux-pci+bounces-18216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4B9EDF39
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 07:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE888282BE0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD23C17E900;
	Thu, 12 Dec 2024 06:06:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28F5684
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733983613; cv=none; b=o6YICMouGQANBNMyTChlU5Ugc5P5zcY2yGkRluDWfCeAtoKVyGw2MN3FdjPcGl18N+R2k+fYKLzjkNTgmZNXtti3uFxcYbM7SAphlmKt6G4ZfgStfi9+t9r6de+7+Xs37ehvIX2sL5qYs8Kz3GfuTVHQFAjvOeP09JvJ4LyPKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733983613; c=relaxed/simple;
	bh=ZXkL/jwe1KJpb9z6G+ovBDENovucjrZmoP+08ql8GF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgeJKAOhtLPTENoDhfb/dnUlUkWPb1VssPNScBdzGf9CvJ3ZeLgQeGwOf16j46m84fWOQomQ5ND6jLUXJgPXGvB78pm80xEgjQNRe22yhBwUX+4WVZTNZJ23RMvpolM7ATCtnmpn3BOCAT1jUJhvn38GoDDGSxpEQSbB3q/Fx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9219E68D07; Thu, 12 Dec 2024 07:06:48 +0100 (CET)
Date: Thu, 12 Dec 2024 07:06:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
Message-ID: <20241212060648.GB5266@lst.de>
References: <20241210093408.105867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

FYI, this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I've closely worked with Damaien on this, so a look from someone
who is not too close to the work would be useful as well.


