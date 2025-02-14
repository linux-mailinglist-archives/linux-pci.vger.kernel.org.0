Return-Path: <linux-pci+bounces-21488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7417A363E4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C231887106
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC0267706;
	Fri, 14 Feb 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNL9Irn3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859713C67E;
	Fri, 14 Feb 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552759; cv=none; b=umpI2oGe6L2Baw52NSSICLDU5VIT0TvTo8J4zF2mJC6BnYjIv3ShXMn4+ICXxuNFG8QGhyKyKfNMqdmj7BuX4XZ/LgV5Fj5xmKytTbeK60MUlTvkemF15j9LJgV2xtybG2a94+Dr+vYTAJDXRe7bPvUcuKFgSOqJVs3x2cVMTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552759; c=relaxed/simple;
	bh=Ey1zlVhXIpxWgj73agPh9w38FDz9HQtrvzNhm54LvV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tdYnIociv9ISRZQ03u7zSuzs+aSmh0dwY3Jq9nuj7Z065E4bxSsTgqWkhloq14UP7/aiA9oR3r/ojxdfOLEfhEW0fJvjprHQ6FhzbJcZ9XttH2bbMWbHdyJjNpyhxDn3nBAHdTW9usBAP7OZxMBASThf+/PPbgUrne8t7lBKeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNL9Irn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1DBC4CED1;
	Fri, 14 Feb 2025 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739552759;
	bh=Ey1zlVhXIpxWgj73agPh9w38FDz9HQtrvzNhm54LvV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JNL9Irn3k4q7/FRNPRa9Uk3v9czBGGX2ghYuz3qau+52HS9u+Ns71pUFgYjA5d8Sf
	 CcJnf8hmnj1iI2ODegX6FDh/ni6M3s1eoSstXNSH8JxepufI6mYwp9Dgx2zT2TNRjA
	 +0cGSIRrZg6J8ARMnNN6OKSMM+V77g/ojLw/tprlgSQsPtXtfAR7Up0EMhMLpKDSvs
	 RE+e6/Xh4Jla6nVj64sqaq6BartvgS/QvJIfNvKiNeCY65wWWTwKZQLBt1DNdbOHUe
	 MRCjztTttWKqFf49frdqc4h2pYloAPkpS3XOR7dKzR7tkRu4Tuxgi6gE0ZO62UX0bg
	 fPDLrdjLnBdKg==
Date: Fri, 14 Feb 2025 11:05:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Niklas Cassel <cassel@kernel.org>, jingoohan1@gmail.com,
	shradha.t@samsung.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250214170556.GA156582@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33191017-b12c-44a2-92dc-44a7d0e79bd0@163.com>

On Fri, Feb 14, 2025 at 04:34:29PM +0800, Hans Zhang wrote:
> I will git pull the latest code and fix it.

The general rule is to base on -rc1 (a.k.a. the pci/main branch), or
on top of a topic branch if the patch depends on something already
queued on that branch (and mention the branch if this is the case).

Bjorn

