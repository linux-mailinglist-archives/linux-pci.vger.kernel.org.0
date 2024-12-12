Return-Path: <linux-pci+bounces-18330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEF9EFB96
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2361890FBE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22888191F88;
	Thu, 12 Dec 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udxg9BO+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6D1917E8
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029412; cv=none; b=hEUC2eKV76UJueBa/Xdq34Q+fMfE3FdUumKCLMiGz57AUaiG7Ez63fxPUNOCbh9xJBCIK2FmmcCPm/ycZMwXCi/CHtyvOAc/JbIWlGCkZLmyhZ+1PtkFYdadVcmVK6Er/f+27lBDzNPmWehbZGzJMil1CKlHIMD+N4hbPWTnlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029412; c=relaxed/simple;
	bh=1RHviLb0TyngV+uOSctErtPSXxCUi9IoilqzjkB84vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TSd8aV4qhCk8utUI5rmlMWNBtRQMhmABvmGotoQp4Ljb/zkiYydnENWlEw5i1vUAaqtCPQt69/v5stJWqp3PNsIqgB9zBmeAO50cYp8hCJv+qlSzfELK64YZBDt5AIgS3VsLVsgQpF8Oa1w6L0xKFO/ZoYoGTxdq4liH/N1F55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udxg9BO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6C1C4CECE;
	Thu, 12 Dec 2024 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029410;
	bh=1RHviLb0TyngV+uOSctErtPSXxCUi9IoilqzjkB84vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Udxg9BO+SAlP/ucCKixftOK8VaQEbRdzIZ/B0kV3SHhsCGzSIa+uWGN1YU/KmBPc4
	 YjFlCIg6x1fHVzPFGiO329cSGhzETaE3zbnb4TQaKBjEuK9VudLqM64GNgOJHTUY78
	 n5Yz4FL92QOpbkGw5aJQmDo0qVBZniMAqjRsNYhqXEmjD31/n9ORsUtMgYrkOz/rrz
	 lrNhwZSTtFQUniYPSQF/mxHsWT/UA/rRAbdRXt7EkDQt1TbP2hOKt3Qfxr0Zc2E/Pf
	 q5XLLsvnJrAtxb/Vyz5LSWCQmVdk+EglGZaQ4gXCOq4zkDjMdyzMXlEa6tX59wbEcv
	 x5/R8dZ39+rPQ==
Date: Thu, 12 Dec 2024 12:50:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 13/18] nvmet: Implement host identifier set feature
 support
Message-ID: <20241212185009.GA3355992@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-14-dlemoal@kernel.org>

On Thu, Dec 12, 2024 at 08:34:35PM +0900, Damien Le Moal wrote:
> The NVMe specifications mandate support for the host identifier
> set_features for controllers that also supports reservations. Satisfy
> this requirement by implementing handling of the NVME_FEAT_HOST_ID
> feature for the nvme_set_features command. This implementation is for
> now effective only for PCI target controllers. For other controller
> types, the set features command is failed with a NVME_SC_CMD_SEQ_ERROR
> status as before.
> 
> As noted in the code, 128 bits host identifiers are supported since the
> NVMe bass specifications version 2.1 indicate in section 5.1.25.1.28.1
> that "The controller may support a 64-bit Host Identifier...".

s/bass/base/

