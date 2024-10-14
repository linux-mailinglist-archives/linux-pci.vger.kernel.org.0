Return-Path: <linux-pci+bounces-14499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A3B99D597
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0221F240F1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0B1C2327;
	Mon, 14 Oct 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXk9bav3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FE1B85C2;
	Mon, 14 Oct 2024 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926973; cv=none; b=AZup8qe9gRhV3JrvQLPteVGFMam9RkJWEpSJhDlO27kVZzg8nxPd2H+ksYYfzHUC6UrR6wg6NUTYP70Tr9rUAyo1wqr+Ja7/8xQ5HXLtVpv87pSdiHZfDgqHjRvArFMb6/k+BpZQCLGlBg5CUxvCWKvbt3DgWDs+JzyADfOshao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926973; c=relaxed/simple;
	bh=UYsXEf6G0HnwwBXdadcjdUX9XZ4CIA8TewE2uVy2MiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SwQkiaalDg9+fhyNj865gPGF7w42t7tvuSdELJHJ2crtopNcAHlH6k3Pgi3gtJomisqa5N5xOVx5dTPfyaGSHN3SQ0I1YpqI3Z0n7ZkEVoVllmSthGUWqE4FftsKvrQ1owmqEFLsyDGYzJjcJeD9DgGxZeTzlwOWC5PCSwoqm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXk9bav3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E2C4CEC3;
	Mon, 14 Oct 2024 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728926972;
	bh=UYsXEf6G0HnwwBXdadcjdUX9XZ4CIA8TewE2uVy2MiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BXk9bav3KMeceQzMIW0JiD1qjXZa+9KEQ/jWc+X4FgSdbKaDgzxPdXyKvoTXpcwLZ
	 rY1/SJYE6URPC+NhMGmjL9uWmtX1SWTSiyFZ987hv7IaOXS0raS/TbklFyWo9+if2y
	 4Nezs8HfdgNua2YPsE9cFvmM5fhCsPXesoHy2X/M89WlHK2rpCocdKQ6di+JN+INxs
	 n47n1D9+ltQDl3pceruS9QVGroWBp6Cm2e8Hi2nZCk3W1NozdxcMme1gbL8tJ+OBYF
	 oYCquTREPByC13zxmuMPmHvgZmCa9+QkTG6R1HW5tt+m+9r5TeNxXB4S1Rm6QSR5Yg
	 Nw7l9Zo2W1msw==
Date: Mon, 14 Oct 2024 12:29:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <Terry.Bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Message-ID: <20241014172930.GA612951@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17857590-4fca-4c55-b1d7-85a0b22519b6@amd.com>

On Mon, Oct 14, 2024 at 12:22:08PM -0500, Terry Bowman wrote:
> On 10/10/24 14:07, Bjorn Helgaas wrote:
> > On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
> >> This is a continuation of the CXL port error handling RFC from earlier.[1]
> >> The RFC resulted in the decision to add CXL PCIe port error handling to
> >> the existing RCH downstream port handling. This patchset adds the CXL PCIe
> >> port handling and logging.
> ...

> >>     Downstream switch port CE:
> >>     root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
> >>     [  177.114442] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
> >>     [  177.115602] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
> >>     [  177.116973] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
> >>     [  177.117985] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
> >>     [  177.118809] pcieport 0000:0e:00.0:    [14] CorrIntErr
> >>     [  177.119521] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
> >>     [  177.119521]
> >>     [  177.122037] cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'
> > 
> > Thanks for the hints about how to test this; it's helpful to have
> > those in the email archives.  Remove the timestamps and non-relevant
> > call trace entries unless they add useful information.  AFAICT they're
> > just distractions in this case.
> 
> I'll remove the test logging and details from the cover sheet. I'm
> unable to find how to attach using git tools. Instead of an
> atatachment, I can locate the log files and details on a public
> github. Let me know if this is not acceptable.

It's fine to keep this in the cover sheet, and I'd rather have it
there, where lore will archive it reliably forever, than to have a
pointer to some other github that may eventually disappear even though
it's public today.

I just meant to remove irrelevant information like the timestamps.

Bjorn

