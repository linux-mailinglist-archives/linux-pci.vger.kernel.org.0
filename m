Return-Path: <linux-pci+bounces-3364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12127851DE3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 20:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D9CB21229
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB546549;
	Mon, 12 Feb 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT+pi2X4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A945C18;
	Mon, 12 Feb 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766172; cv=none; b=A3gb9IIBbG5ThBLYbe1HP/9ZHCDuwqhMcTffXG3hiwZxR++KL/BRe1N5h2h6v8X7Y3TUo+yZh0qTn4mgM/Ja4mgUTwXS3GN/W8xiuoQFVfcq+JKZSqHvfUe9dK48YtDZJeAWCQT13a8NTEkcZIp4vjgmuhPIKipeo6ZOeG39Kdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766172; c=relaxed/simple;
	bh=18wK+0VtdXVC4XJ9lIoIgt7iOg+dvn23InbMDvODp8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j9HWkvSDu5HSeJt2fvHiyHUXzeEOfgsVTuxU9IFf8/PoVAFiEOxg15/2EMh+onMJc9zfFejBSjvbCmyYBvhBpa0crAqU5Pb36ZGL+HNXM4uqq4Xv5OwOqokolQYiXsMHEoL3ZWa5KnmWVOJEtzzfNitpmCKlcxribpfJn63HHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT+pi2X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33B9C433C7;
	Mon, 12 Feb 2024 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707766172;
	bh=18wK+0VtdXVC4XJ9lIoIgt7iOg+dvn23InbMDvODp8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sT+pi2X4iiXXktpOysvlDMnwfPiU80BsmIuXWBDXUVmKnYcg5/bY2qqjMPxAypMRW
	 ttSn/EavUmKe0fViajfnCU4PKsmI1Ci6UnPf+1UetdcRH2szbUORGgt0Bs3xbyd7Sx
	 VLAZcNmuKePRFlOcgzqV7j7f7m7h2EMq/IhdBebeXHl0/XD95ZyUCJzqIRkjHd6j32
	 VDm1ZVPJ+Q9fGwQ6sEQ1UopMMefwT7i9F2dSmLcga+SRbhBfuqCXWpOiFo5Glvwxr7
	 OtvMkz530ToPqI0+etOAdOIRf30jDmb6OvzrwAxf3D7hi/2np3MQuWUI09NvSq8n0r
	 dufOGhTyMfaxA==
Date: Mon, 12 Feb 2024 13:29:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Onkarnarth <onkarnath.1@samsung.com>
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ACPI: use %pe for better readability of errors
 while printing
Message-ID: <20240212192930.GA1141919@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212102404.1900708-1-onkarnath.1@samsung.com>

On Mon, Feb 12, 2024 at 03:54:03PM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
> 
> As %pe is already introduced, it's better to use it in place of (%ld) for
> printing errors in logs. It would enhance readability of logs.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>

This tag is wrong.  I provided some feedback, but that's not the same
as providing a "Reviewed-by" tag.  "Reviewed-by" has a very specific
meaning and the reviewer must provide it explicitly; details here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.7#n544

Bjorn

