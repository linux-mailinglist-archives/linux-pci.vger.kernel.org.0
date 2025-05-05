Return-Path: <linux-pci+bounces-27190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C87EAA9AF6
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DE417D8EC
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD8129A78;
	Mon,  5 May 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUPtZhLn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B9C8F0;
	Mon,  5 May 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467120; cv=none; b=lEzcusIjqMEhigbS9Cy5Pg5PUWiJhWIi8eJibIMn1Rz3ocJGYqew0A7nBw7KwDALALXR/44N52YAJZHHc7hRChi8OGpfKY0UaVKbjNsbWFRkO+uKHbcbFjqAILL8k1ixsFJqQThymLUSfVqvKIAmGE7QGLRi7pTRHd7XSKf+JzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467120; c=relaxed/simple;
	bh=h9tYezBFZHw9e31Ck9rDgTtC1IAiM/oIrgkf5RUxoIo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VmxO4p27sgpZua5JkPukjIkejKgTef/REATKbGE3uqq7iBVrQ+0ESe9berCvGdZgN3gZx3ECCsisVH5Xds4Bk+y65w270iOYYTAY5GiiVoGLijKURUGwh8biw6GHVtCUW6Ra/PQx6nV5mgOTKmth0qp8zgvV86cXKljnQfhy9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUPtZhLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B551C4CEE4;
	Mon,  5 May 2025 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746467120;
	bh=h9tYezBFZHw9e31Ck9rDgTtC1IAiM/oIrgkf5RUxoIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HUPtZhLn0raRZiEmANupF6ssPuFV5xOkouZG0qOyC3Shoz0WCqCHvg0ozckyFcwa/
	 Hr9qug47YXQz/pQhe0XP0gTXSxj/e0g6hdnGsLfOdUWSajg47VdAgEisNRPxETZQua
	 T+Kz/zoRcKU5+HStzvAJa+syg6lbQ8+1rsq+ihH7s7vcZFM67Vetsr66V4boOA33kR
	 nUwQVZsJUQn0+DjZNcHfN8Vu5GLYnJJ/CIIkkdBH8OtnqSBCiti/i6A6tlkIPMQOSs
	 jjIIZ8D4BkE0r86cXYdjgFSShXcE8hKJCmrzN9ihBaSXA04nHiCnnlHj92hhL2bbzW
	 V4eNhbO4vel/w==
Date: Mon, 5 May 2025 12:45:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Shen, Yijun" <Yijun.Shen@dell.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jon Pan-Doh <pandoh@google.com>,
	Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Liu Xinpeng <liuxp11@chinatelecom.cn>,
	Darren Hart <darren@os.amperecomputing.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
Message-ID: <20250505174518.GA986261@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb6b57b-4317-404d-8361-19e1c3bd499c@oracle.com>

On Mon, May 05, 2025 at 11:58:25AM +0200, Karolina Stolarek wrote:
> On 29/04/2025 17:54, Jonathan Cameron wrote:
> > On Fri, 25 Apr 2025 16:12:26 +0200
> > Karolina Stolarek <karolina.stolarek@oracle.com> wrote:
> ...

> Bjorn, is this patch blocking the ratelimiting series? Would it be
> acceptable to use public logs in the commit message? I'm asking because it
> looks like there's no easy way to trigger the GHES path, or it would take
> some time, further delaying the ratelimiting work.

Nope, I think ratelimiting is more urgent, so I'm going to push harder
on that.  If we can do both this cycle, so much the better.

