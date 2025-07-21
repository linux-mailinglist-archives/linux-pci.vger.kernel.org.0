Return-Path: <linux-pci+bounces-32679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398F8B0CB66
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 22:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640363A7461
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960852376EC;
	Mon, 21 Jul 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C45cHwa9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB472236E3;
	Mon, 21 Jul 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128833; cv=none; b=bbdCHUPhoSZubj4Mku321XmYMQJhQYOhjTMuJqV4DweObPlBamDBwTZ3CgSDGVcjKkMRx6+4cWHm5kkxQD1Y/oks64NNHu8FNhWb7NDDtMHV9E6gLNF+uGgejbgnWuz39F/6GK7tXcN3CGOkIH1tmM+Z2PEbe23/ysiCL5Dfs9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128833; c=relaxed/simple;
	bh=wVhEt8/KpJttUi3OKb7I/0WqnKJ5C2uSgR1uwaVY+84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qgPbUK/KDy0ENhVGsxkb9YldADUmqwa23KyD4LGV5fOCOH5XcfYUMyev02A6hfJYIae6WbmizjWN5NXgSrvly5cuh8rtrpQsm4QscuHrQfBC39BFaj4VZKAWr+jmihcc9Epu18WXnlDxzfLbnenrs/PIWK+KKNpmiPKqfdzKGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C45cHwa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DB2C4CEED;
	Mon, 21 Jul 2025 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753128832;
	bh=wVhEt8/KpJttUi3OKb7I/0WqnKJ5C2uSgR1uwaVY+84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C45cHwa9t9DOc35mw1dV3cSVYrW773PCAwDUH3x9CYyT6y0nmQ4fF66Xl+evfQsZT
	 SD3kulZlQ8sPpG4Lkc3Zpeq3Erv6NEB0aEjk9GumqOgxaM3F4ysHbC/t/OcGmdi3N7
	 Z+p8wQ32EQuAAy7ZOD6IETSNGb/+dOH85gwOI+TMyeSK5Me8lqyHKLpySYd0GgG2en
	 /Hwgj0kG7b7WCt4vgDyFUfXsClUqHhDCey+qd7ukcTMq0NXweV/1q3lCGsWenYm/rG
	 M+A+yWfQ+B4nRbz4ZuiSU3eFbVgSs617q+duySe3x6iUmxTXJdJhKX0RLGdASyHvVh
	 iV2bEghL8o5kw==
Date: Mon, 21 Jul 2025 15:13:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Raghu Halharvi <raghu.halharvi@broadcom.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: Does linux kernel support PCIe System Firmware Intermediary(SFI)
Message-ID: <20250721201351.GA2751222@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEDZ0BRrt1TBu+Bwc0yK4x9OiK63zXa8ORg4SSdCLu-OLKcXOQ@mail.gmail.com>

On Mon, Jul 21, 2025 at 04:46:07PM +0530, Raghu Halharvi wrote:
> Hello,
> 
> Not sure if this is the right forum but wanted to know if the Linux kernel
> supports SFI/eSFI?

No.  Patches are welcome.

Bjorn

