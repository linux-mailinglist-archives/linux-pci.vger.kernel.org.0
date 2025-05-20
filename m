Return-Path: <linux-pci+bounces-28090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C578ABD579
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE323A437C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E627D270544;
	Tue, 20 May 2025 10:44:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA71A3177;
	Tue, 20 May 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737890; cv=none; b=nP6iyeJTzwITwAvYS3PGlHLUJFESlPZPFqbDBLAoAvN8Ro9E/MyWB+QWd7s8AAOXAGZGuzFf4r63ovEvUt1/SKL66H3Jg6PTYgVzM9gjtV/RluNAIJtW/Rs3FBi2dRIamztBd8bP+Lm/opo5+aHY2RVs2fC7idja8jILbN7boIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737890; c=relaxed/simple;
	bh=dTHAEP/VM9QFDcvAVhrlLjg+6G233HJXFhDRHzhX1II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7RJGhTZgo/DJ1i/JC2GvVYnEUVC+B37GFuLZXQOURvTfmZVngbCo6InYZ/0+Uek7/MtrFlJueWNeZI9XpSCz/56Qc4HhNHzyCkxRO2Ui9TVeJlEwIf1kOWlNUpyec24/6Rp9EC3GjvWvNetkkdcJRHy7y2LLQPTCO4UhXiVANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 708702C00092;
	Tue, 20 May 2025 12:44:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3D1F41B826B; Tue, 20 May 2025 12:44:38 +0200 (CEST)
Date: Tue, 20 May 2025 12:44:38 +0200
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
Message-ID: <aCxdFm_BpgOTFFUv@wunner.de>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
 <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
 <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>

On Tue, May 20, 2025 at 01:07:28PM +0300, Ilpo Järvinen wrote:
> On Tue, 20 May 2025, Shuai Xue wrote:
> > , and the format of "Link Speed changed" is a bit different from 
> > "pci_hp_event".
> 
> The difference is only because when the Link is down, there's no Link
> Speed (obviously). Whenever a new device is hotplugged and it comes up, 
> there's also Link Speed for it which can be included into the trace event. 
> 
> I think the trace event should have some special value for the fields that 
> are N/A due to Link being off. While it would be possible to create 
> separate events for speed changes and hotplug, I don't see any pros in 
> that approach over just having the N/A fields marked as such when the Link 
> is Down.

Link speed changes and device plug/unplug events are orthogonal,
I don't think they should be mixed together in the same event.

A link speed event can be signaled simultaneously to a plug event
and then user space can decide in which type of event it's
interested in.

That also avoids the awkwardness of having N/A values for the
link speed on unplug.

Thanks,

Lukas

