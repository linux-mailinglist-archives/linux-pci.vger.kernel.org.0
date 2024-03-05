Return-Path: <linux-pci+bounces-4530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D35872445
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 17:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E921C24F25
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17912AACD;
	Tue,  5 Mar 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVYDa8FG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E9128374;
	Tue,  5 Mar 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655957; cv=none; b=pndr2I4pTy9WGFVGVUjVYBW6xNdIChDlmw+kftcvnRUEcb4YTTpsx4mfY41NR5xelpPTk2+eHvnr5Sy4/UcwA+D4Pa6PBDVB8FTz2eTShtUOya+C9Nl1i+guyg9ifeUNNl1SdFUn+3UHDA2blY+qyXcRO1ln5UqXw2fWSi1RWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655957; c=relaxed/simple;
	bh=KcfagbFPZk9uK9dCHQW3NSZIC+aFdtVoEOmw4UbL9xU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K/+e+sJ2sKF8g/n9O21pi3jV5WkbkHIMiLNQb2TdRs8j/KeaorQGvDGYoMHqy5nwR2N4RBY/EUSY4vMgv7XEiQLe6/mSZFdE1NjQALFRQmrZ+RhwyG5srJp3ZjfpaFQBIO6veQ3Oft5jr2UJZJQ1BshF77WdI/03xKkTMuOp4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVYDa8FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A00C433C7;
	Tue,  5 Mar 2024 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709655956;
	bh=KcfagbFPZk9uK9dCHQW3NSZIC+aFdtVoEOmw4UbL9xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oVYDa8FGQj+DqlTmlsjmFQWwVKDX4F9MpOPHFn8aPrXbvu0g9jdla9A5IY4WCArXa
	 hbB1QxaTR0FJyRVn52jjZi0wY2i+SZCgVe5Puyj/tVGmRlkL7+wIZGtONe+z3pB2yO
	 1zpuxm2+in7WaPy7b4zC1eJZFQWhJX1iwlhWA2TfPxhWmuZ3yLgURFlHJ1PrSk/aKS
	 TSLJ1RgMBsxNe5wT6uIsomKSZjVzZzIyPkBW0u9LGtMNJDl9UQirg0bEPP9VZZ2JzP
	 Uqmjlf6etB1LB8inqmkza2qb5Gsp8EkiZAibxqDcryMbmXqKNDqNlc9/37aTRPBDO8
	 zlknD1FxTI5YA==
Date: Tue, 5 Mar 2024 10:25:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <20240305162554.GA538416@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdda64e3-3454-406d-55a2-cf79f7650b45@linux.intel.com>

On Tue, Mar 05, 2024 at 05:37:49PM +0200, Ilpo Järvinen wrote:
> On Fri, 22 Dec 2023, Ilpo Järvinen wrote:
> 
> > Hi all,
> > 
> > Here's a series that contains two fixes to PCI bridge window sizing
> > algorithm. Together, they should enable remove & rescan cycle to work
> > for a PCI bus that has PCI devices with optional resources and/or
> > disparity in BAR sizes.
> > 
> > For the second fix, I chose to expose find_empty_resource_slot() from
> > kernel/resource.c because it should increase accuracy of the cannot-fit
> > decision (currently that function is called find_resource()). In order
> > to do that sensibly, a few improvements seemed in order to make its
> > interface and name of the function sane before exposing it. Thus, the
> > few extra patches on resource side.
> 
> Hi Bjorn,
> 
> Can you consider applying this series or do you have some comments on it?
> 
> I'm a bit unsure these days if my emails even reach you successfully as I 
> tend to often receive complaints from Gmail that it has blocked the emails 
> I send with git send-email detecting them as "unsolicited mail".

Sorry, I'm pretty sure I receive your emails since I read via lei and
if it appears on lore with linux-pci or me in the to/cc, I should see
it.  Just a little overwhelmed and struggling to prioritize and
respond.  But thanks for the ping; I will take a look.

Bjorn

