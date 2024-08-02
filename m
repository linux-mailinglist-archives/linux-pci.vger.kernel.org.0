Return-Path: <linux-pci+bounces-11199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B0946229
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DDD1C2125C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFACB13C914;
	Fri,  2 Aug 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/XMUt2V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE2136322;
	Fri,  2 Aug 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617924; cv=none; b=YBGTNCHMd+POOCWjlz3tFpEtbh6jyOda+suxh9z+TTdGxn4yLbH1yS1uZyi4cyhEP8L40LdFNBDCcW77eMyywpSJ35LE4fdVgyNPd/kcVuC2G0C2fmElImOqp2e3SaJTMMYbhTCx8pZ4v3vtAoSWA+mHSjzicndFRfOZRMAUjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617924; c=relaxed/simple;
	bh=YSziizmBJcN8M1iyhytFgFMOpJl5bsHaVXMtrfZdL5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NTmpBC+Pxppaqx1S+TcTGBslHf2+9rnzgOFkaIliAMY21gGGpCD6FFNZ6GwQuQ0uPqjMt8sTEioH7w1Eyz8wGOwv229ML7YKpzg5s8G/6gKA/fsRp12zmZtYjrhTJhArFOwtDFNQuLghtw49Hg7tO9dWmOdk6k/w9FzQYgtIHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/XMUt2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCBAC32782;
	Fri,  2 Aug 2024 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617924;
	bh=YSziizmBJcN8M1iyhytFgFMOpJl5bsHaVXMtrfZdL5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q/XMUt2VilKvRS9qARnxglOB8+f02t9mMJbEawnsIL8l73iD99DknOyVQw+VvwWZL
	 xpNl63wjxLrZQsa+FNMqYrczlxFLwA/NRwJ4WT6yldM61oddlI/TagQpw3os0G6Ex/
	 wqhwWQYDFHOMgV/MwTzRw+fIyZxyAWHBQuQFLwn9wWmSPvI9JT1ztVc7ZbT1SLms14
	 +dVwMUqt3MvzRqNZHZRm0QZcsR5ZcAw0omBzooidB9M+Df8Bse7yCwzSL7eqY9MRTl
	 40R3msXHc0ysKMKI/GrkSdMglB9aREXAVuAlprIHgzqnAIv0szpUk40IZUkyxQxMhJ
	 4gs9h7Tq3fShg==
Date: Fri, 2 Aug 2024 11:58:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 06/10] PCI/TPH: Introduce API to retrieve TPH steering
 tags from ACPI
Message-ID: <20240802165842.GA154146@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc282b0-97e4-448c-a77e-0ed63746d0a1@amd.com>

On Thu, Aug 01, 2024 at 11:58:46PM -0500, Wei Huang wrote:
> On 7/23/24 17:22, Bjorn Helgaas wrote:
> > > + * The st_info struct defines the steering tag returned by the firmware _DSM
> > > + * method defined in PCI Firmware Spec r3.3, sect 4.6.15 "_DSM to Query Cache
> > > + * Locality TPH Features"
> > 
> > I don't know what I'm missing, but my copy of the r3.3 spec, dated Jan
> > 20, 2021, doesn't have sec 4.6.15.
> 
> According to https://members.pcisig.com/wg/PCI-SIG/document/15470,
> the revision has "4.6.15. _DSM to Query Cache Locality TPH
> Features". PCI-SIG approved this ECN, but haven't merged it into PCI
> Firmware Specification 3.3 yet.

Thanks for the pointer.  Please update to refer to this as an approved
ECN to r3.3 and include the URL.  When it is eventually incorporated
into a PCI Firmware spec revision, it will not be r3.3.  It will
likely be r3.4 or r4.0, so r3.3 will never be the correct citation.

> > > + * pcie_tph_get_st_from_acpi() - Retrieve steering tag for a specific CPU
> > > + * using platform ACPI _DSM
> > 
> > 1) TPH and Steering Tags are not ACPI-specific, even though the only
> > current mechanism to learn the tags happens to be an ACPI _DSM, so I
> > think we should omit "acpi" from the name drivers use.
> > 
> > 2) The spec doesn't restrict Steering Tags to be for a CPU; it says
> > "processing resource such as a host processor or system cache
> > hierarchy ..."  But obviously this interface only comprehends an ACPI
> > CPU ID.  Maybe the function name should include "cpu".
> 
> How about pcie_tph_get_st_for_cpu() or pcie_tph_retreive_st_for_cpu()?

Sounds good.  The former is nice because it's shorter.
"pcie_tph_cpu_st()" would even be fine with me.  s/retreive/retrieve/
if you use that.

> > > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > > index 854677651d81..b12a592f3d49 100644
> > > --- a/include/linux/pci-tph.h
> > > +++ b/include/linux/pci-tph.h
> > > @@ -9,15 +9,27 @@
> > >   #ifndef LINUX_PCI_TPH_H
> > >   #define LINUX_PCI_TPH_H
> > > +enum tph_mem_type {
> > > +	TPH_MEM_TYPE_VM,	/* volatile memory type */
> > > +	TPH_MEM_TYPE_PM		/* persistent memory type */
> > 
> > Where does this come from?  I don't see "vram" or "volatile" used in
> > the PCIe spec in this context.  Maybe this is from the PCI Firmware
> > spec?
> 
> Yes, this is defined in the ECN mentioned above. Do you have
> concerns about defining them here? If we want to remove it, then
> pcie_tph_get_st_from_acpi() function can only support one memory
> type (e.g.  vram). Any advice?

No concerns if they're defined in the ECN, but we need a citation so
we know where to look for these values.  Cite the ECN for now, and we
can update to the actual firmware spec citation when it becomes
available.

Bjorn

