Return-Path: <linux-pci+bounces-44317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1931D07036
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 04:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DE273036C51
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 03:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6329323BF91;
	Fri,  9 Jan 2026 03:42:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949F23EA87;
	Fri,  9 Jan 2026 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930173; cv=none; b=bVpDUdHkrXZp4f3e9m7EGDn+MsKjrrI8m0OC1NsIoNd06G4+r4DRGff9plmdnt3EIHWHe4kritJn1nQ0AfrsDYqfgtLn4W8gkd2ZEXOLdcwhKMsv3VC6Iev4Ktd/N3J3zJpQ3wUMngnKr7ulVpzWY4q3bYu1uC4YVqIo33jiqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930173; c=relaxed/simple;
	bh=4fBZa53/AN1hTKBs44t7KsGQ67w2j3iipZhGC44TkCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afAMpHxs5OgqQffSWy0Ev7wxRPv7e+3RRcZNgsOXOGZJsRh3DImH9OH4lWcIYGiqGte53m2J3dsrvQ5wd2jPRsfo9fXf0bPFSMUn9gfvhzse5JY/LhrdpfduzJePdGkGzaS388aYgmMyQHEEwqVf0A7rIU/np2/qlIcXglhpL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 21759B86AB;
	Fri,  9 Jan 2026 03:42:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 1CAB32000E;
	Fri,  9 Jan 2026 03:42:48 +0000 (UTC)
Date: Thu, 8 Jan 2026 22:42:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 1/3] PCI: trace: Add PCI controller LTSSM transition
 tracepoint
Message-ID: <20260108224246.316e3ee0@fedora>
In-Reply-To: <1767929389-143957-2-git-send-email-shawn.lin@rock-chips.com>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
	<1767929389-143957-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1CAB32000E
X-Stat-Signature: ixen3nko6phz4ok8ow8qaq99cnwj1w9q
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+VwLkx5rS4QfHZ8DMusTQAIQzr8G333kA=
X-HE-Tag: 1767930168-399124
X-HE-Meta: U2FsdGVkX18Ltj9i1968eJbmgEAL+747dfB1oVBPxwLb1uXRsYerWn2Rr18GkjXPeyB0dgstmGgCc5Ftp8WbtdC9PisjKj5OIVhhd0ExdcvXyChlc7ORzNPXvrSbuKIWGxQzATADF/bkugHttN//qYQCLYVCBwA5GqUob9gXvwqzhBAUXq0DrGcWiKwY+Vxv4fXw59c7G8bAXph65pmOihRBL+3o4vjRTFWa5FKPiAa6jTyYC2lD2lA6w8CElCc4vkoFfZE4H0Knu0SriyYhugrdLDlpw0sRuzOlnGcf+XNmnzuQyrlELYrZXQwRAF7XbWx3GN85gf6BQfvLTDxj3BLjU0WP+whaVs1MGmMLXKqiuYF4WwHKiaenl3/5mVt7

On Fri,  9 Jan 2026 11:29:47 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:

> +	TP_printk("dev: %s state: %s rate: %s",
> +		__get_str(dev_name), __get_str(state),
> +		__print_symbolic(__entry->rate,
> +			{ PCIE_SPEED_2_5GT,  "2.5 GT/s" },
> +			{ PCIE_SPEED_5_0GT,  "5.0 GT/s" },
> +			{ PCIE_SPEED_8_0GT,  "8.0 GT/s" },
> +			{ PCIE_SPEED_16_0GT, "16.0 GT/s" },
> +			{ PCIE_SPEED_32_0GT, "32.0 GT/s" },
> +			{ PCIE_SPEED_64_0GT, "64.0 GT/s" },
> +			{ PCI_SPEED_UNKNOWN, "Unknown" }

As these values are all enums, you may want to add in this file:

TRACE_DEFINE_ENUM(PCIE_SPEED_2_5GT);
TRACE_DEFINE_ENUM(PCIE_SPEED_5_0GT);
[..]
TRACE_DEFINE_ENUM(PCIE_SPEED_UNKNOWN);

So that this can be parsed by user space tooling such as trace-cmd and
perf.

-- Steve


> +		)
> +	)
> +);
> +

