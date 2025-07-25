Return-Path: <linux-pci+bounces-32914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C3FB116D8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 05:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1481CC59E2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 03:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5ED1D5AD4;
	Fri, 25 Jul 2025 03:06:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B90EEAB;
	Fri, 25 Jul 2025 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412819; cv=none; b=Ntelz++Rz5n5JGZLlOtlUflO9TjBNzZj+vyUSu9xXn1qyvvbeD5NVriC/uoSmU9MRFU7AnNYRMJjMwwmEmgFKPBrKWXSbhuIE/OdFwdc2IlwPgTEKKTOsHO00WDAzIhGUlA56czx/XqS/bmW//tuD5nNIZDqF8egJMDMAQgC5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412819; c=relaxed/simple;
	bh=dJqlW2RblcHAJp6X/GdaHOKsCm+CMLAEE3v8Md4Vae0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsZJCCoxZHMr1Lb/vPF1m7TCphZoLhle+RxvKxJa4CobipkxzL4hakwu3BqZf2qrGnJ2NliBJkComUaTWpNpGgHsg5/dO7hh46rv/7pnMzoodHbiBbZyf7j1GfwKVyLShypZkVcscuBq0dtZkxjfhgD0Tj+eND2NLBeb9Fc2oPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 46C57C05C6;
	Fri, 25 Jul 2025 03:06:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id CF1B76000A;
	Fri, 25 Jul 2025 03:06:43 +0000 (UTC)
Date: Thu, 24 Jul 2025 23:06:47 -0400
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
Message-ID: <20250724230647.1875702f@gandalf.local.home>
In-Reply-To: <d87b1029-b572-4995-82a9-c7d83551900e@linux.alibaba.com>
References: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
	<20250723033108.61587-3-xueshuai@linux.alibaba.com>
	<20250723100559.7f0adb3c@batman.local.home>
	<0611d06d-e198-4617-a0ba-3050ca6191c6@linux.alibaba.com>
	<20250724222510.7b00ea79@gandalf.local.home>
	<d87b1029-b572-4995-82a9-c7d83551900e@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9wsxr8bkoh8qt36twrwbwtmeywo835ty
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: CF1B76000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+7fcpPccKnDaXIHE4xe9rNJz+2XjvTHgI=
X-HE-Tag: 1753412803-107182
X-HE-Meta: U2FsdGVkX1/k+D8mWXYcapC/KHUri1LpPc4jinE9J80v71xEGkwFev3acuvX8/KVrGHSjxq5w5ag4KuUxiKefW+rghkE7pZwydLUcqnGMonxSK+u9tHmr/sTUrXdxPR/vxTUOXx91ZK1UT9kXq60zB2mMCmZTHPB5XK4Rr1nQ6KE8WBSMIkMrT79Sxv8R/VAP0YKNqHpOKaCHksGyeuqpOF/BUPHmTBovjpVH3S8Lj+JwjCx7NGOY2FhEMZkf9VcO1Lz1tcsHSay1QJIJ9MBurI2wsDdf3zUS3ZhzYyY4cE2lbraUDaEPlFWRpCo2Mu+pKy1syyLOnWYsjWuqSdPguFQ64O3Px9YC+ATtZPMUl1NwiHE9WRjVA==

On Fri, 25 Jul 2025 10:59:16 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Thank you so much for the detailed guidance and the excellent example!
> This makes it much clearer how to implement the libtraceevent support.
> 
> Should I include the libtraceevent plugin patch in the same kernel patch
> series, or submit it separately? I'm not sure about the best practice
> here.

No, libtraceevent lives outside the kernel tree.

> 
> > 
> > -- Steve  
> 
> I'll work on the libtraceevent patch and submit it according to your
> guidance. Thanks again for the clear direction and the documentation
> link!

Make a patch against: git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git

Follow the same procedure as you would for submitting to the linux kernel,
but instead of sending it to LKML, send it to: linux-trace-devel@vger.kernel.org

You don't even need to Cc me. I'll get it from that mailing list.

Patchwork is here: https://patchwork.kernel.org/project/linux-trace-devel/list/

-- Steve

