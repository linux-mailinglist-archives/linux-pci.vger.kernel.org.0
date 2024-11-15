Return-Path: <linux-pci+bounces-16848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B819CDB15
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DBE1F21B1E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424518A959;
	Fri, 15 Nov 2024 09:07:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530918A921;
	Fri, 15 Nov 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661624; cv=none; b=aSWLPwXR5hhHtajYZ+4chG5wB4oE3WzVa0be0AcVqoyc5EvwCI2wpJVLIwwfZiX3WzXXd5pdy4Lf3dFB1xQQyzD0o4/RvWONqiJ6BFWceq18oVYZbNI+BHKCj6DUmrBkXW2xrWfOmMOMmykrSfx+7YGV16hxqMKQTrw4KnesiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661624; c=relaxed/simple;
	bh=Stjtz6qDnjiC1mkqCjFO1YM17Ev0itGJ8CXdx1KVwAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGR9UylEqS5UdPBMYlzTHZMOV+QZ0CrsO8a/PdCqT2yZP1s2C3bNSfsCBzuivJDCl991f9RzaxYHQ537+2nqF8as23tXXY8hQyusfPQ5vs2LD9rlu7XMv1ySl+6DBx+hDd8VNhPHo0wHUyBFFwKOWG5L+yUFR02MX9CS1XkNXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1EF162800C917;
	Fri, 15 Nov 2024 10:06:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0844E3641AA; Fri, 15 Nov 2024 10:06:59 +0100 (CET)
Date: Fri, 15 Nov 2024 10:06:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 2/2] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <ZzcPMxWqtvDWh3cq@wunner.de>
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <20241112135419.59491-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112135419.59491-3-xueshuai@linux.alibaba.com>

On Tue, Nov 12, 2024 at 09:54:19PM +0800, Shuai Xue wrote:
> The AER driver has historically avoided reading the configuration space of
> an endpoint or RCiEP that reported a fatal error, considering the link to
> that device unreliable.

It would be good if you could mention the relevant commit here:

9d938ea53b26 ("PCI/AER: Don't read upstream ports below fatal errors")

Thanks,

Lukas

