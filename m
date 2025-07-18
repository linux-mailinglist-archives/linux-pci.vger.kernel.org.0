Return-Path: <linux-pci+bounces-32542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A73B0A88C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DEA5A5176
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BCC2E716A;
	Fri, 18 Jul 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M292Sus/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5192E6D3F;
	Fri, 18 Jul 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856535; cv=none; b=GIdD7KOWWcTHTz44KJYhzqcupVhDN5uJDnEb0BhQXPs4Wq9hYhTpIHjDELW7DCvWvSjI+fLMq2ZQMK/IdlykXCK5fCnLdI8Qpr2PJOzS8v8JB8t8gdbvxu9Zjvp8esvL3nGfZ2AL2FrnCGIWCqcEbCknMsZBfBE+Xm5zKJXOsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856535; c=relaxed/simple;
	bh=11X9Sef1jq1w/S7oQRlR3n+bOEuUkdDS7reE/5JQmv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b59ae1v8nynItRizvbLM7ateLPrSda7Bic3yeS+Jx5tWZb7VVMMl2GxCpRkm7eHNfmfN7RzgI8rRuhhH0UOAiV9XgruxcgttrAAuJwURVRn45xDHPjonwjIZg0G0JrsQnS/PhR0TFeyAgw+9t9kJ1bNa6Qk8t79i8kp5DBTMgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M292Sus/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C048AC4CEED;
	Fri, 18 Jul 2025 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856535;
	bh=11X9Sef1jq1w/S7oQRlR3n+bOEuUkdDS7reE/5JQmv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M292Sus/VG02eGqA4KLBWSOMFPlC+C1kaajwzs311j55gIiMMIfr+1ahlMd2QFimz
	 41uZzOvhSzU2mQXBDxwlvJIPmKPx5cKYaVfZtbpiFJ4ud6YVFiiQzjgU19cx6Io699
	 5i1FTWcc74I/x6DBCOjl/80yhKwE/CQqoQiIrHZsr6M0wtDva0TH0x7jPyUQqFR22d
	 mUjDVm9C03HqNDVrYHSlb6OiDnb3FuNJGVy8Ub3AJwqLo1/uf/U5BDYp69Ifu6I0wg
	 BnWXS9h2FIJDYGsFAvy5fIB0zqLAFAQtWdbNaV7ZcQGBnd4+ZntxsH5nW2bfAlQniN
	 vu5aue6rWXutA==
Date: Fri, 18 Jul 2025 11:35:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Matthew W Carlis <mattc@purestorage.com>, lukas@wunner.de,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	anil.s.keshavamurthy@intel.com, bhelgaas@google.com, bp@alien8.de,
	davem@davemloft.net, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	naveen@kernel.org, oleg@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, tianruidong@linux.alibaba.com,
	tony.luck@intel.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250718163532.GA2700834@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e92f8d1f-457c-4248-8397-81b0e20ff4af@linux.alibaba.com>

On Fri, Jul 18, 2025 at 01:29:18PM +0800, Shuai Xue wrote:
> 在 2025/7/18 11:46, Matthew W Carlis 写道:
> > On Thu, Jul 17, 2025 Bjorn Helgaas wrote
> > > So I think your idea of adding current link speed/width to the "Link
> > > Up" event is still on the table, and that does sound useful to me.
> > 
> > We're already reading the link status register here to check DLLA so
> > it would be nice. I guess if everything is healthy we're probably already
> > at the maximum speed by this point.
> > 
> > > In the future we might add another tracepoint when we enumerate the
> > > device and know the Vendor/Device ID.
> > 
> > I think we might have someone who would be interested in doing it.
> 
> IIUC, the current hotplug event (or presence event) is enough for Matthew.
> and we would like a new tracepoing for link speed change which reports
> speeds.
> 
> For hotplug event, I plan to send a new version to
> 
> 1. address Bjorn' concerns about event strings by removing its spaces.
> 
> #define PCI_HOTPLUG_EVENT							\
> 	EM(PCI_HOTPLUG_LINK_UP,			"PCI_HOTPLUG_LINK_UP")		\
> 	EM(PCI_HOTPLUG_LINK_DOWN,		"PCI_HOTPLUG_LINK_DOWN")	\
> 	EM(PCI_HOTPLUG_CARD_PRESENT,		"PCI_HOTPLUG_CARD_PRESENT")	\
> 	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"PCI_HOTPLUG_CARD_NOT_PRESENT")
> 
> 2. address Ilpo comments by moving pci_hp_event to a common place
> (include/trace/events/pci.h) so that the new comming can also use it.
> 
> For link speed change event (perhaps named as pci_link_event),
> I plan to send a seperate patch, which provides:
> 
> 	TP_STRUCT__entry(
> 		__string(	port_name,	port_name	)
> 		__field(	unsigned char,	cur_bus_speed	)
> 		__field(	unsigned char,	max_bus_speed	)
>  		__field(	unsigned char,	width		)
>  		__field(	unsigned int,	flit_mode	)
> 		__field(	unsigned char,	reason		)
> 		),
> 
> The reason field is from Lukas ideas which indicates why the link speed
> changed, e.g. "hotplug", "autonomous", "thermal", "retrain", etc.
> 
> Are you happy with above changes?

Seems good to me.

What do you plan for PCI_HOTPLUG_LINK_UP?  It would be nice to have
the link info there since that's sort of a link speed change itself.

Bjorn

