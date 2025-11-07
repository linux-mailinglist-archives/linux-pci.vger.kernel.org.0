Return-Path: <linux-pci+bounces-40543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B57C3DF3F
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 01:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367DC188DC1C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 00:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAEB1FCF41;
	Fri,  7 Nov 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arLi1sXK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004D1F5825;
	Fri,  7 Nov 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474371; cv=none; b=mSY21yWow0ftOy4g3ojKM7HMpBmoh+iB5gTBv3votTeXNgQF6wkrfEdtGBN2k03e8y3EHYTXLCrE9VBTlI5L9HisdGwcCU8iHzFHDgWKGUGueHYDTqdMUggn/PA4uNwyWAVAPet9KEERhtfaqnebknWA0uLj5ceZGj6bC5dSZ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474371; c=relaxed/simple;
	bh=zVxtIiQXF/h3lLGX+vTX4ScikwyurKS7hUPFV5evgT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kEz5npKi0X4Vj/5gsE87ZofBHcH94r9GD+f9J3KQzfPC21+JjnjwJUlb28EfB0Gaqa7Aw0S+cYpygd5rFNd9u7FcO/4NeZm44HT01yAtGqERL8pTC5jd1tXcAVZKTVdBfEdmdUtXksr+GrPvkwjoQaM+1MWJ+U3ZR+vALW+ZXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arLi1sXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F1C4CEFB;
	Fri,  7 Nov 2025 00:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762474371;
	bh=zVxtIiQXF/h3lLGX+vTX4ScikwyurKS7hUPFV5evgT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=arLi1sXKCOwj5bu+tukL49Vo2iKLJWUsqpLupqoRVBsB+qXse1CVN9RDSb3fOdmz0
	 QWq+nqXxO6RDUAYD5duqY3eDg4gHTyBzD/i68NgZ2QkpJ6ydS9Bb2FQzOQpPKWj6vz
	 bXYRTGV9r6zODcS1pIFaOYL4UGDie/fNdCt2WEedrIO50EsyjA+nOsrXtKoZub5BKl
	 jDZCQ8MH3S60cl138FURAdotszxxo8Q2T6iL0D/iOje6ZfuODWgWtANGpLjPjKU9Fp
	 h9YpZQQKVGWFV0rRMe/n3+geqebX703u7a4gtQFv7Zu+9PjvF4cnGRAKvTPfzEwtq+
	 q8rhLXwIRWrPA==
Date: Thu, 6 Nov 2025 18:12:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org, regressions@leemhuis.info
Subject: Re: [PATCH 02/24] sparc/PCI: Remove pcibios_enable_device() as they
 do nothing extra
Message-ID: <20251107001249.GA1977735@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fcc0fd4b74f99d5c4d80d3907e7607a7d4c89da.camel@physik.fu-berlin.de>

On Thu, Nov 06, 2025 at 08:49:50AM +0100, John Paul Adrian Glaubitz wrote:
> On Fri, 2025-08-22 at 17:55 +0300, Ilpo Järvinen wrote:
> > Under arch/sparc/ there are multiple copies of pcibios_enable_device()
> > but none of those seem to do anything extra beyond what
> > pci_enable_resources() is supposed to do. These functions could lead to
> > inconsistencies in behavior, especially now as pci_enable_resources()
> > and the bridge window resource flags behavior are going to be altered
> > by upcoming changes.

> This change actually broke driver initialization on SPARC, see:
> 
> https://github.com/sparclinux/issues/issues/22

#regzbot report: https://github.com/sparclinux/issues/issues/22
#regzbot introduced: 754babaaf333
#regzbot title: v6.18-rc3 fails to initialise mpt3sas on sparc T5-2

754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they do nothing extra")

