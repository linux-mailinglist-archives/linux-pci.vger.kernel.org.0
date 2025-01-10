Return-Path: <linux-pci+bounces-19624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E00A091D9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 14:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5103A7577
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6720E002;
	Fri, 10 Jan 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux87nqez"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591E20DD68;
	Fri, 10 Jan 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515536; cv=none; b=MKXSx9hLbGcoTnMyCSLExLZRwVDlM/N/j5ZY09+yDoB2CX3FbKgexsqzGpNJx5iIc8p7nfAgEw+7Ha62ybRAbCvVTTQbn4cq8QWw9Yi7UAWmKgx5O1weXHQjAGZ+ZnkYuvsaGFI9s5WIfzOzXKDLLDzU+pMi9bH0oB5AR/UcUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515536; c=relaxed/simple;
	bh=sMtcZsY0SZYMt1hGhUZLsdz7uwQzU4ojyFbYBXSdqHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p7ju5jnWCGb7qPMidkneCeaPzUpXJ8T6MijzsFi4+gR6QE2QjVlO6LY/yDDH5xZ9OiMcIge+uvjuqCDd5rtaKQ0OCXrcB1tQsR7VLsT+bX23IeAUq43RwhRiWOxR4yHG443isZu+N+thgSQxweDhzPT6GBcuXEb0BWivie+s5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux87nqez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A17C4CED6;
	Fri, 10 Jan 2025 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736515535;
	bh=sMtcZsY0SZYMt1hGhUZLsdz7uwQzU4ojyFbYBXSdqHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ux87nqezhclH1L67RzAEyK7azsLRr9kifb0yatBEQ/J8dMrrKEGx4DELdou38B7kz
	 +GL2Xm/HBgF9jaE4hYVQ+4NDqCPEQZmygo6gx/EClxgXuEW2+tUQz5R5gVQlTNPrHV
	 e5K+Y3CqSsoyUJOoNUNMWGere6+UhaWizTX6A5AvjHb+LjjhKwQxhjeyD/KBuNSXDW
	 UxGNCoy5gA6puAlHL7fAj7Buz8XQRS1LDBv67hNdPabvnxg4rBetZe152vdiOZN5xu
	 Dnwi2V9F5z6YdYRnc4x8vfutCk+cwXulphlbM1Umne+5L/v5T0mgU6bMECo+BP/ihw
	 O7wxrq+o9bLlA==
X-Mailer: emacs 31.0.50 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <Z32MUFBIyp0IKyzC@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org> <Z32MUFBIyp0IKyzC@yilunxu-OptiPlex-7050>
Date: Fri, 10 Jan 2025 18:55:29 +0530
Message-ID: <yq5aplkuu7g6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Tue, Dec 10, 2024 at 08:49:40AM +0530, Aneesh Kumar K.V wrote:
>> 
>> Hi Dan,
>> 
>> Dan Williams <dan.j.williams@intel.com> writes:
>> > +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>> > +			 enum pci_ide_flags flags)
>> > +{
>> > +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>> > +	struct pci_dev *rp = pcie_find_root_port(pdev);
>> > +	int mem = 0, rc;
>> > +
>> > +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>> > +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
>> > +		return -ENXIO;
>> > +	}
>> > +
>> > +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>> > +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
>> > +			ide->stream_id);
>> > +		return -EBUSY;
>> > +	}
>> > +
>> 
>> Considering we are using the hostbridge ide_stream_ids bitmap, why is
>> the stream_id allocation not generic? ie, any reason why a stream id alloc
>> like below will not work?
>
> Should be illustrating in commit log.
>
> "The other design detail for TSM-coordinated IDE establishment is that
> the TSM manages allocation of stream-ids, this is why the stream_id is
> passed in to pci_ide_stream_setup()."
>
> This is true for Intel TDX.
>

IIUC ide->stream_id is going to be set by SVE or TDX backend. But then
we also expect the below.

	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
		pci_err(pdev, "Setup fail: Busy stream id: %d\n",


Hence the confusion why the stream-id cannot be allocated by the generic
TSM module as below

>> 
>> static int pcie_ide_sel_streamid_alloc(struct pci_dev *pdev)
>> {
>> 	int stream_id;
>> 	struct pci_host_bridge *hb;
>> 
>> 	hb = pci_find_host_bridge(pdev->bus);
>> 
>> 	stream_id = find_first_zero_bit(hb->ide_stream_ids, hb->nr_ide_streams);
>> 	if (stream_id >= hb->nr_ide_streams)
>> 		return -EBUSY;
>> 
>> 	return stream_id;
>> }
>

-aneesh

