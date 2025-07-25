Return-Path: <linux-pci+bounces-32910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2058B11662
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 04:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984F3AC3106
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F422F16C;
	Fri, 25 Jul 2025 02:25:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39254673;
	Fri, 25 Jul 2025 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410322; cv=none; b=q1e6gYAyL5c5iiIgsRo79C7cP36M/5prNBjOswLzcwR9GJ73fPsc7RQxmfONm5+VBoHekHxZXSwMWNipoaTjdB14jyxOMRb795E/r2b1cHBn2ECJSa7BywaTMC7sXC5CMHPaoaz/3/Is3efNxMBGcQgw44OsDP+x/khZ3U2XLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410322; c=relaxed/simple;
	bh=L2idtvIt/1uihIpQ8b9OtDmVC7OmE4x9WnLbp3Mdl9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvUVEOXR+ZkikOBfVKRIIT7RkXciRp64qru/LOacrFqk/Qkc5w+q6eOfTjKaU8VYCeu4F5+viv8HyXCEkLr5nuXdXXJxEvna/tBg9bMwWY0/1nZXFj9zqwBNMt0yqs5vxWSvxC/M7adAFpIAX2dzjLJi8bABxgn35pzDXgSCL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1AC151605AF;
	Fri, 25 Jul 2025 02:25:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 377261B;
	Fri, 25 Jul 2025 02:25:07 +0000 (UTC)
Date: Thu, 24 Jul 2025 22:25:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <20250724222510.7b00ea79@gandalf.local.home>
In-Reply-To: <0611d06d-e198-4617-a0ba-3050ca6191c6@linux.alibaba.com>
References: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
	<20250723033108.61587-3-xueshuai@linux.alibaba.com>
	<20250723100559.7f0adb3c@batman.local.home>
	<0611d06d-e198-4617-a0ba-3050ca6191c6@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 377261B
X-Stat-Signature: 5hi1kbyyqh1ikfey7kfjuxq3egm7nu3s
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/MoJxA/jhPTrRIoH2xbHAuuPBlBDFxjpY=
X-HE-Tag: 1753410307-806746
X-HE-Meta: U2FsdGVkX18vpnF45ei3qcCwLbzlr91TQHIearcao6J5ZztGfnRfW19kN5BvnxAN/U22+6o1JXO8g3V2HBQKK/Dh4hHfsv1VJR0+k0uVanM39RAosoIdgIU/qE7fPZb2nG6C2dYesS/FRb6up+/DZTzCnQEVLD2C9Hlgylm/A/4TXJAxL8nLi8aBmwzmgHvmhdZKmSFdvb8KF/xa9NrmoMuKc8R3hepW33HbDICTu5D1t88ED9XSvBfdZQP1WseE6GIQkYA+peRAw8otaa1Otx4pVhQbrXd6xZPv+tQXLWTH0acraIorK/VhfO5hlOzAHkQ9B28yTeckomcP3gyggadd6QhP57DnTiadCp0j8wm9ukeD5azKm6MuQ1maJM2o+NA8UVGROpMlqduiFTiCAn/Iqvo3jEVAo2HBb95KpLrELTJ2gHgDiAB3TnhjzicPZrckKZYB4B4=

On Fri, 25 Jul 2025 10:11:10 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> For the libtraceevent implementation, I believe we'd
> need to:
> 
> - Add the PCI speed mapping table to libtraceevent
> - Create a print function similar to other existing parsers
> - Ensure perf, trace-cmd, and rasdaemon can all benefit from it
> 
> Would you like me to investigate the libtraceevent changes, or do you

Yeah, just update libtraceevent. In fact, libtraceevent has plugins for
things like this.

You can use this as an example:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/plugins/plugin_jbd2.c

That adds two functions that are used in print fmt strings. Here's one:

static unsigned long long
process_jbd2_dev_to_name(struct trace_seq *s, unsigned long long *args)
{
	unsigned int dev = args[0];

	trace_seq_printf(s, "%d:%d", MAJOR(dev), MINOR(dev));
	return 0;
}


int TEP_PLUGIN_LOADER(struct tep_handle *tep)
{
	tep_register_print_function(tep,
				    process_jbd2_dev_to_name,
				    TEP_FUNC_ARG_STRING,
				    "jbd2_dev_to_name",
				    TEP_FUNC_ARG_INT,
				    TEP_FUNC_ARG_VOID);
[..]

The above defines:

	char *jbd2_dev_to_name(int arg0);

And when this is found in the parsing, it calls process_jbd2_dev_to_name()
passing it the arguments that was found in the trace.

You would have something like:

	tep_register_print_function(tep,
				    process_pci_speed_string,
				    TEP_FUNC_ARG_STRING,
				    "pci_speed_string",
				    TEP_FUNC_ARG_INT,
				    TEP_FUNC_ARG_VOID);

Which will return a string and take an integer as an argument. Then you
would just implement the process_pci_speed_string() function to do the same
thing as the pci_speed_string() does in the kernel.

Oh, and here's the man page for you on tep_register_print_function()

  https://trace-cmd.org/Documentation/libtraceevent/libtraceevent-reg_print_func.html

-- Steve

