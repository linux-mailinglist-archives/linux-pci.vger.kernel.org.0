Return-Path: <linux-pci+bounces-12851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D3D96E01B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 18:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9149F28A84B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA819C579;
	Thu,  5 Sep 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRtP7uNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D091428F3;
	Thu,  5 Sep 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554689; cv=none; b=EbI6jwn7OwAg9TqYtYgq74qHecjuLyCSpW0DfZEK2TXHljP20Q1GcE5XqITEZfkHbbhjEG0qpTDNwhAnW9DYp8KEKS6eY7txfM+rRpwpRbSL1bUaaKVXGlmQc2QPYTwOO/IxuzYRnxYbnxT/+Uy1QYQ4btkO50RRFJq6JGsDfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554689; c=relaxed/simple;
	bh=f1B6hzv/N33wS2vfox0OnxEoRfvPhb5MO9IpFoGSJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KSUlOmd/0t0YJ2Utd97l8xcswPc80/5y7vuBc+Z/RENffMojJVxnMPgKhRzMVz/Cbn4wvTo9HblvZRzMoDLxAMs3ChLLt10xx7Pfq7AVeRJx8DS3GgRwmev0+T2FfXA6BM/gdlVhbS3O+Ad7uXsghg/+L1KHUDZhJS6/TmbaJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRtP7uNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856D6C4CEC5;
	Thu,  5 Sep 2024 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725554688;
	bh=f1B6hzv/N33wS2vfox0OnxEoRfvPhb5MO9IpFoGSJwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KRtP7uNU+wA+5IfTixJzHj2LR7A2+TgmiHjflW9v121YPUKuGHuU5cETEXdqtE0fW
	 n6rDi8SDiQFU9rwsQ7bAiY4kOBjGJD1dI7mBWsclpH5JC8NJ5ZoP02APgYtW9g9bPz
	 gpjT5P92SbZmmPeCFlhdiMIc9XfcjjEe26gFWS0L8vU1eoolo32UVqtACPM38u8Onf
	 TpRFeYn45CskZOY3GGYU3ascmdbF+UqUCjn6ybjlosf9ZWKzD6RNfT5xrS1DbMOnI/
	 V3ZxZDSeEhRxnUVEFVz7uwp24BGELwWXrJqrUOd6MO6EZnrQCLCZ3zMMmExcXqNcDf
	 NOaCIyDMDujtw==
Date: Thu, 5 Sep 2024 11:44:47 -0500
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
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 00/12] PCIe TPH and cache direct injection support
Message-ID: <20240905164447.GA391162@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d9b0e83-9f54-4471-bdef-5bbe84cc7aec@amd.com>

On Thu, Sep 05, 2024 at 10:45:57AM -0500, Wei Huang wrote:
> On 9/4/24 15:20, Bjorn Helgaas wrote:
> > To me, this series would make more sense if we squashed these
> > together:
> > 
> >   PCI: Introduce PCIe TPH support framework
> >   PCI: Add TPH related register definition
> >   PCI/TPH: Add pcie_enable_tph() to enable TPH
> >   PCI/TPH: Add pcie_disable_tph() to disable TPH
> >   PCI/TPH: Add save/restore support for TPH
> > 
> > These would add the "minimum viable functionality", e.g., enable TPH
> > just for Processing Hints, with no Steering Tag support at all.  Would
> > also include "pci=notph".
> 
> >   PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
> >   PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
> > 
> > And squash these also to add Steering Tag support in a single commit,
> > including enhancing the save/restore.
> 
> Can you elaborate on save/restore enhancement? Assuming that the first
> combined patch will have save/restore support as suggested. Are you
> talking about the ST entries save/restore as the enhancements (see
> below), because the second combined patch deals with ST?
> 
>         st_entry = (u16 *)cap;
>         offset = PCI_TPH_BASE_SIZEOF;
> 	num_entries = get_st_table_size(pdev);
>         for (i = 0; i < num_entries; i++) {
>                 pci_write_config_word(pdev, pdev->tph_cap + offset,
>  	                              *st_entry++);
>                 offset += sizeof(u16);
> 	}

I meant that since the first patch knows nothing about ST, it would
save/restore TPH control but not the ST entries.

The second patch would add ST support and also add save/restore of the
ST entries.

