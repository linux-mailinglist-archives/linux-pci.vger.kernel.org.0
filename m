Return-Path: <linux-pci+bounces-15225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B849AEF09
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C931C2273A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932401F666B;
	Thu, 24 Oct 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqpkYQZ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7401EF958
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792786; cv=none; b=ic2mW0HOiKZ4BA6t7k1y7GPfScG+ds2lqT5EVVlvWN0BDNybDzuGp+XaGY7FOWqJvbIL1Vh5BDOP7VIZiL34SN5s/Nu0ULfYIc5o9gqXvmsn1lv/d5Zyt/KDjqvID+qpw7p8IuxmoyaztOMBA2Xvf47FR5myM1e7vFUhX9rJLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792786; c=relaxed/simple;
	bh=+D96GA7IQEKRhi/+1zz338XETq5dWJAX3pXc35gnxqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q04Su/Nw0csfe8OfmXbvDoQJCtSEdXHLpErxlpb6XL63qeLM4z87GFKnLvnRYem8XXSilvu3scx4Wj6h34V1ZYeXXh1YsV1f7ENlyl+Bk1PyJmaDenqgGZjFLnQJOusZVAwZqWcb+VngeBZgpA8qT1Xp2/sptPyUfI8AAcxUws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqpkYQZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4498C4CEC7;
	Thu, 24 Oct 2024 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792785;
	bh=+D96GA7IQEKRhi/+1zz338XETq5dWJAX3pXc35gnxqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NqpkYQZ3qhVJZMCjUaPfwYo510mwIg1NxcR2/1artfiI2LPFXBbb7HQSK4i6YCHta
	 C1JOKF/LB79KMyY/FXM36UtNyjy0uNglcpYU3DCl/NN1/gf1TJdzq1lAgF6yBIAwau
	 YQcTZB3d/Espqee4Q0F1o5ThqpneymGOa9bAUwfFVT2X0giE4zO/Fyk9CRlkWjnBoZ
	 et3W8D1IBIMVk4Pdv/OLouiFooJW1B0G669QHIhi6HuMRa1b8FYOS4ez80gHg7xlwb
	 KV0fLt5pPf38XD5r8nUwuESFx0mdheIsBH9uqS0mmr0dpY8Ds8X8DoNBp5t6YlQwdc
	 i+836OQqqp6wQ==
Date: Thu, 24 Oct 2024 12:59:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
Message-ID: <20241024175944.GA965060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR11MB71853199C12F60897CDE80D4F84E2@IA0PR11MB7185.namprd11.prod.outlook.com>

On Thu, Oct 24, 2024 at 05:58:48AM +0000, Kasireddy, Vivek wrote:
> > Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for
> > functions of same device
> > 
> > On Sun, Oct 20, 2024 at 10:21:29PM -0700, Vivek Kasireddy wrote:
> > > Functions of the same PCI device (such as a PF and a VF) share the
> > > same bus and have a common root port and typically, the PF provisions
> > > resources for the VF. Therefore, they can be considered compatible
> > > as far as P2P access is considered.

I don't understand the "therefore they can be considered compatible"
conclusion.  The spec quote below seems like it addresses exactly this
situation: it says ACS can control peer-to-peer requests between VFs.

> ...
> > I'm not sure what you refer to by "PF provisions resources for the
> > VF".  Isn't it *always* the case that the architected PCI
> > resources (BARs) are configured by the PF?  It sounds like you're
> > referring to something Intel GPU-specific beyond that?
>
> What I meant to say is that since PF provisions the resources for
> the VF in a typical scenario,

Are you talking about BARs?  As far as I know, the PF BAR assignments
always (not just in typical scenarios) determine the VF BAR
assignments.  

Or are you referring to some other non-BAR resources?

> they should be automatically P2PDMA compatible particularly when the
> provider is the VF and PF is the client. However, since this cannot
> be guaranteed on all the PCI devices out there for various reasons,
> my objective is to start including the ones that can be tested and
> are known to be compatible (Intel GPUs).

Regardless of BAR or other VF resources, I don't think VFs are
automatically P2PDMA compatible.  For example, PCIe r6.0, sec 6.12.1.2
says:

  For ACS requirements, single-Function devices that are SR-IOV
  capable must be handled as if they were Multi-Function Devices.

  ...

  - ACS P2P Request Redirect: must be implemented by Functions that
    support peer-to-peer traffic with other Functions. This includes
    SR-IOV Virtual Functions (VFs).  ACS P2P Request Redirect is
    subject to interaction with the ACS P2P Egress Control and ACS
    Direct Translated P2P mechanisms (if implemented). Refer to
    Section 6.12.3 for more information.  When ACS P2P Request
    Redirect is enabled in a Multi-Function Device that is not an
    RCiEP, peer-to-peer Requests (between Functions of the device)
    must be redirected Upstream towards the RC.

Or do you mean something else by "P2PDMA compatible"?

Bjorn

