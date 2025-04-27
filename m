Return-Path: <linux-pci+bounces-26853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC7A9E226
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0F17A64F8
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557E61F3BAC;
	Sun, 27 Apr 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4dPAyD2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDC1AA1E0;
	Sun, 27 Apr 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745746446; cv=none; b=oPQ2/aJ6dBoXuYVRkBUzUqXhRss/3dXkQDNqlHHEZVqsopZKwYJVhq2xXU6HErAdx94JwgAfPRIMP2j48Ddg+1nZfU5YfYynoeoIJvZbvs3/WCtiuXToze7C6nfjgAxi5FJPshRKaPfZxceve4XrU70SIfuf6h5I2m5E7CPnNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745746446; c=relaxed/simple;
	bh=4xWg8JKZlyPAMpxIVuL/WG3hri+yK8ECmKy+6YaZucg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O6O1LIaV3rW7+g3dvV4+4YB0nVOn/lPn+/pIxo/NT+j8II5dDoQh5pPjmuN2n//K8DStMysouEbaRxB03GttzyspAJTC330SYfubdHvAtx5kiedcQqnRsSpxpdCWB/uIhcRLpgz292kJv9gIr8u1DuE9Y1VDhA89a/FP/NazJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4dPAyD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC6FC4CEE3;
	Sun, 27 Apr 2025 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745746445;
	bh=4xWg8JKZlyPAMpxIVuL/WG3hri+yK8ECmKy+6YaZucg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z4dPAyD2Hqp7i3j7MLcPzZZhp5qDOu4lX34OCG7JVxAVXzrUVM8QPwVy97UOjhSul
	 fvjfm/VBSVRAv3+szffWRV/8pV9R+0heRRh3zMZAi+FUAHo3QJ5nSS/m/bvWJKipup
	 xMg/eoIpNyRKIcs91LdXO4U6xUFZ7KaYbpd7tolSL9iKQwVgENqDvukQfYpUb1m645
	 1F7FvUL6IVP57s4Gt9Ad4C+G/Z9iK2EeLDvytF6eYf8nIUJ6rWn9movzVq6Oa/c075
	 0gWB9yK6JtkaC/uIkYNQnriVQ+mryeBHXwPASM1YIBkIYIPQvwGKeVGSy3zeEu9+oE
	 ZJcNwhvpbyN4w==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <680c1b50443bf_1d5229484@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
 <yq5a7c3edot5.fsf@kernel.org>
 <680c1b50443bf_1d5229484@dwillia2-xfh.jf.intel.com.notmuch>
Date: Sun, 27 Apr 2025 15:03:59 +0530
Message-ID: <yq5a1ptedk3c.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Aneesh Kumar K.V wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> 
>> > There are two components to establishing an encrypted link, provisioning
>> > the stream in Partner Port config-space, and programming the keys into
>> > the link layer via IDE_KM (IDE Key Management). This new library,
>> > drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
>> > driver, is saved for later.
>> >
>> ....
>> 
>> > +/**
>> > + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
>> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
>> > + * @ide: registered IDE settings descriptor
>> > + *
>> > + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
>> > + * settings are written to @pdev's Selective IDE Stream register block,
>> > + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
>> > + * are selected.
>> > + */
>> > +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>> > +{
>> > +	struct pci_ide_partner *settings = to_settings(pdev, ide);
>> > +	int pos;
>> > +	u32 val;
>> > +
>> > +	if (!settings)
>> > +		return;
>> > +
>> > +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
>> > +			     pdev->nr_ide_mem);
>> >
>> 
>> This and the similar offset caclulation below needs the EXT_CAP_ID_IDE offset 
>
> *facepalm*
>
> So it seems no one is trying to build on top of this framework yet.
>

You can find my POC work with this framework at
https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-1.1/da/proto/rmm-1.1-alp12/v1
. I'm still reworking the patches, so I haven't posted them to the
mailing list yet.

-aneesh

