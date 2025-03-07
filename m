Return-Path: <linux-pci+bounces-23080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44BA55B5B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 01:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8870177F22
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 00:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8115C0;
	Fri,  7 Mar 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOjaDAJq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8B139B
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 00:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305742; cv=none; b=ogs33rQ2OAJIPIADNrjVpmNCKozrRjYc+ObQZ1PzJL2uQ9vOMJzi8O9IvAd7ZvoEw6/4vxksCEPViBJTGr3AxBnwU5C1ZMVOgg1mleXbkZ9cXbCV14vR4O/2DW1ro93aKOEBO2bLfZ4OXQmLs9HUliU+PTeLrXe5weEW4cJC3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305742; c=relaxed/simple;
	bh=RIS0yYYDt00mkZhphq12d07k2cznF95eRmBx3+wV9ME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jVLKtMhCW7USJzYr1BoPca/dqECErrHxHmla5hr44RvoMXaSFdRZVviUNm/ZPEaKTThJo+yCoi/KfxO5I+oMpMPh6edL9Y1pl5ablU6qybXbDJwnNNEN8EuZKcMBc8HE0DoQ+vFnOyT7mECo10xRIW6pA5LDW3rIAXWjTFBMizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOjaDAJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C166C4CEE0;
	Fri,  7 Mar 2025 00:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741305741;
	bh=RIS0yYYDt00mkZhphq12d07k2cznF95eRmBx3+wV9ME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZOjaDAJq52YaMH+5grIa4e14kOvIqyu9GK2ThhFVhxZ0TjYYXHIHws8fKEyXOPLCr
	 9vOgMsHimKmQEDTTqW0wokf16NN0UhEG6hOkwx/XO6BQSwtiqxOv95L4VmIL3j4+3/
	 b7iCaqxQtdyqKAjt4iEsOcr1yCG1UOVn+ki0Wm+vm8oczyILLT8qoNoTBs1Pk/nErd
	 aOhqt0KAUCrqaFemNZxFf4Mj+GxNHyBny6HNWpUnpPqJb7Z8R3aHcK4+y7y7/ZJzOQ
	 v7sYpzMgC2V58ikxYqUKw2mMVQ1V5sVyxk/7FHA7Zq9R65/8hMJIzB6ezFb7e7GMJ0
	 Xzw6iKpxnNyVw==
Date: Thu, 6 Mar 2025 18:02:20 -0600
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/8] PCI/AER: Remove aer_print_port_info
Message-ID: <20250307000220.GA382422@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMC_AXWVOtKh2r4kX6c7jtJwQaEE4KEQsH=uoB1OhczJ=8K2VA@mail.gmail.com>

On Wed, Mar 05, 2025 at 05:32:45PM -0800, Jon Pan-Doh wrote:
> > On Tue, Mar 04, 2025 at 05:04:21PM -0800, Jon Pan-Doh wrote:
> > > Would a log suffice in that case (i.e. when aer_get_device_error()
> > > returns 0)? Something along the lines of "{device} is not accessible
> > > while processing (un)correctable error"
> 
> What are your thoughts on this? It adds the pcie port log in the
> edge case described (with no loss of info) and doesn't require
> changes to current ratelimit logic. Something like this (with more
> fields filled in of course):
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 21cdf590b25e..bdfc7e8d6f0f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1253,6 +1253,8 @@ static inline void
> aer_process_err_devices(struct aer_err_info *e_info)
>         for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>                 if (aer_get_device_error_info(e_info->dev[i], e_info))
>                         aer_print_error(e_info->dev[i], e_info);
> +               else
> +                       pci_error(e_info->dev[i], "{device} is not
> accessible while processing (un)correctable error");
>         }
>         for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>                 if (aer_get_device_error_info(e_info->dev[i], e_info))

Maybe, although I think consistency is very important, and we'll
always have Root Port info but won't always have Endpoint info.  So
dropping the Root Port message seems possibly the wrong way around
when it's the Endpoint part that's "optional".

One thing I do like about the current messages is that they associate
information with the device that is the source of the information.  I
remember finding this very confusing when I first looked at how AER
works.

E.g., the "pcieport ... Correctable error" message means the Root Port
received an ERR_COR and generated an interrupt, and the error class
and error source came from the Root Port AER Capability.  Similarly,
the "e1000e ... error status" message contains information read from
the Endpoint AER Capability.

I do think the existing messages are WAY too verbose.  I would love to
make them more concise, and I think the important endpoint info could
probably be squeezed into a single line, although obviously TLP header
logs would be too much for that.

Bjorn

