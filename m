Return-Path: <linux-pci+bounces-28103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD9ABD809
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDB3178E64
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3E8280004;
	Tue, 20 May 2025 12:09:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DA21C9EA;
	Tue, 20 May 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742985; cv=none; b=ONRAoUmEA6CFoSsDEc85k9K8ZcLneKvF3hBiADi1ecKD0XTlHmsX0ddIa1MRlq63cgFmZHvWugnafo/brSM1zsPxFwYmWK5zq28lU7k42XOal1d3J1EFUp0sRD+tthnPP2V0kINFOglx+XRMoPZwrTO9PGV5eZt1Zqx+kemhx7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742985; c=relaxed/simple;
	bh=Ria7aw6NfTWp+nvL2GRgcVqJKUNYVVnsbJqHcEPrdW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZd7TmCukqXlam+oAp5pXZpfV1fSDTa42FryXaUmafrD51wBwCjhqu0APPYY11XfIBkN3YSAnyQTUN62xPQfHFgGewL7PAMKjXVFmgYJ5J6MJLD9SSCYBWTDgN9yb5D1gOa990zQaWxiVRa9SIAqPcaE1doZSSHNAweYJZ/tods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id ADAAC2C01636;
	Tue, 20 May 2025 14:09:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 89FFE1B8296; Tue, 20 May 2025 14:09:39 +0200 (CEST)
Date: Tue, 20 May 2025 14:09:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com,
	bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <aCxxA-4HEnZ-O2W0@wunner.de>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
 <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
 <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
 <aCxdFm_BpgOTFFUv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCxdFm_BpgOTFFUv@wunner.de>

On Tue, May 20, 2025 at 12:44:38PM +0200, Lukas Wunner wrote:
> Link speed changes and device plug/unplug events are orthogonal,
> I don't think they should be mixed together in the same event.
> 
> A link speed event can be signaled simultaneously to a plug event
> and then user space can decide in which type of event it's
> interested in.
> 
> That also avoids the awkwardness of having N/A values for the
> link speed on unplug.

After thinking about this some more:

A link speed event could contain a "reason" field
which indicates why the link speed changed,
e.g. "hotplug", "autonomous", "thermal", "retrain", etc.

In other words, instead of mixing the infomation for hotplug
and link speed events together in one event, a separate link
speed event could point to hotplug as one possible reason for
the new speed.

Thanks,

Lukas

