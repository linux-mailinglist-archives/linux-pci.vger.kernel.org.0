Return-Path: <linux-pci+bounces-28979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E1ACE04D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082BB189A2AB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640D28FABD;
	Wed,  4 Jun 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3VoA2AT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58528ECED;
	Wed,  4 Jun 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047530; cv=none; b=CXACZVTAW3DnK9a4YY0TFOCaaPG58C2QfZnC0aoW2mxtZNMDYjsCPmESL4xDtdo9DgaaS4eRUBhTxj4dFmQzjwTFtqI+iutStBX+BBXhY0uo7McMOlHEBu1n+VE0dLbAUyKWTJEIic77xYP2cKP0DAxv/LOQ+J0GPejlvgzBJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047530; c=relaxed/simple;
	bh=PNnRD6gL8fWk7hdZqeCrnED11vXVXXttbbydPicR/PM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lZfXEThTx93Rm5hpkE1tLgH+0F/I/ghVziaQYFVWYa3GfWFpz9Gc4eA6CNFIOs/RrJZvm4/EyjZ5zWn5CU5iE46PNOs/W9y5nZGctY/YGBmZN9JTMH1QNa32rfpVB1AY3Tulgh8ixRyCMXdGyxjFgKvWRvvXh6KMzJdWeP4NZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3VoA2AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3395CC4CEE4;
	Wed,  4 Jun 2025 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047529;
	bh=PNnRD6gL8fWk7hdZqeCrnED11vXVXXttbbydPicR/PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o3VoA2ATNbG2J0YJpoV5J5NM4BpCueexbKJIWoR8KiEJM7aVioU3wmaXYivuILtR4
	 dgEE+EKTwE6RMCP5EDTOQM7Q4qy+i/p2C7NYhwfhPm3JaCnGxjQIWefxrApJb/OT5Z
	 jdx9pbtbzUPObeHTQbu9QJwDwQb9bo1w1zokVw1kik00JWwi34Uhc7Qy59QNfCCURf
	 WPRsPKMoPvVrbW7lXn6WJ0lZrd3e9yvuNRBDxPRCs2oLwTf/UolMEzpsepEQ2Ou4Le
	 Cgd7G2y0J9SH09R/85YQ+FHlKFpEmMfm7bw4q3ije6KETz5jirXZDT6TrmLtdU3s+O
	 6MmHKHS51+/rQ==
Date: Wed, 4 Jun 2025 09:32:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] Update my e-mail address
Message-ID: <20250604143207.GA516466@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>

On Wed, Jun 04, 2025 at 05:38:29PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> My Linaro e-mail is going to bounce soon. So update the MAINTAINERS file to use
> my kernel.org alias and also add a mailmap entry to map the Linaro email to the
> same.
> 
> @Bjorn H: Could you please merge this series via PCI tree?
> 
> - Mani
> 
> Manivannan Sadhasivam (2):
>   MAINTAINERS: Update the e-mail address of Manivannan Sadhasivam
>   mailmap: Add a new entry for Manivannan Sadhasivam
> 
>  .mailmap    |  1 +
>  MAINTAINERS | 38 +++++++++++++++++++-------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)

Squashed these together and applied to pci/misc for v6.16, thanks!

