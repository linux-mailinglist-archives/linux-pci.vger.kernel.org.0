Return-Path: <linux-pci+bounces-24249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9546A6AD0A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B673AA29F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13F1E5203;
	Thu, 20 Mar 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8zcaL0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D151F5F6
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494987; cv=none; b=aFhV8SZ6zZ8prqtWc+jEsIuiEPn8ImjokKIwgiaZ3ehlnWba6FM/YXv9QLCqOScEX6LK9GXsEueq8NSyKTa5wv3QVh8HHRh6ijxI84+X+68OGRAQT1aDwArgNjPCJosl0zwo+n2TJsO9QqfL0EgblxY/Wh3Dqc6KKAwIIaMPERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494987; c=relaxed/simple;
	bh=SNpfQm0y5ZkGYfLkXuuzuRyTQNA7Q9MGmGDIvegqoiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YnrdWSp1tcA7u+EIzINPgGLGqzx01i63u1353P+1AldH3KVo8uuIJr+ru9YWucWygd2RxUzjfDL2CKy7I5WNFDvGGDS71uNh8vYgI3f5plJ9zeXricrjsVcjzW5hmMG34EvBKjbUZ9aZLC2vIBN56ZuDHYmTcgDNXm9ll1UIdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8zcaL0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A7DC4CEDD;
	Thu, 20 Mar 2025 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742494987;
	bh=SNpfQm0y5ZkGYfLkXuuzuRyTQNA7Q9MGmGDIvegqoiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W8zcaL0RGYtU68eR8FHzQTWfo9WQ8S8D6sYHddZ+Pq22J/sVGBNQX92WZkI8D9V+Y
	 7H/JB1HDRvYT/nCe8RH1Irdc3IyXpevJudG9FaJXIEfQjMGZdyGSOzMbfi54poKqHS
	 A5LWI8vKJcBSq2e5jtuQbnqKcU50wjNDUOkw2kB/lFYeFa5mKm5HH++Lch2Y7owUgq
	 1+y4DJv6D4dn9wQYk6iO1aIHcUOscm5jeC/tHRWLoFlMhuAfHuXhphBrNIDaE6YEJ6
	 6cJZ6YXBhwvQaSG+uTF7lwfvkB6NhPw5CU1WEeIEgpC1mP7V/tI6mxD6u65ml/krss
	 iA8K3H4r5JlQw==
Date: Thu, 20 Mar 2025 13:23:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v3 5/8] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250320182305.GA1093290@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMC_AXXmkGPexqfKdQOND2i9B7bU+7HZ57EP-uh4WwFNM-jOGg@mail.gmail.com>

On Thu, Mar 20, 2025 at 01:27:27AM -0700, Jon Pan-Doh wrote:
> On Wed, Mar 19, 2025 at 11:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> >   - Previously we *always* called trace_aer_event(), but now we don't
> >     in the !info->status case.  Maybe an unintentional change?  I
> >     think we should call trace_aer_event() always, or change that in a
> >     separate patch if we need to.  This would always have been simpler
> >     if trace_aer_event() had been the very first thing in the
> >     function.
> 
> Good catch. That is an unintentional bug. trace_aer_event() should
> always be called. Moved it to the first thing in aer_print_error() in
> v4 (same patch as I wasn't sure what justification to put for a
> separate commit message other than precursor for ratelimit).

I wonder if trace_aer_event() and pci_dev_aer_stats_incr() should be
part of the same function since we always do both.  But I guess the
trace needs a little more information.  Minor thing we can worry about
later.

Bjorn

