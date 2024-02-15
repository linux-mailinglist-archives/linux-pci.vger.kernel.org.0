Return-Path: <linux-pci+bounces-3561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB474857090
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2961C21803
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FFC1419B5;
	Thu, 15 Feb 2024 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiZux5Sg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF041C61;
	Thu, 15 Feb 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036157; cv=none; b=sEU0uH0P9lfI1vcRqjr1o9Qgcm/4NPgX8zTdOVnnP5KlPcN5BBT+yG9QrRs8LURfl0ZoLP5nC4EhKTniBCBFc8ISJ7+Qxl7p5VKAqx2YTxIfLDAsbxFFVYFn8cVgg0v8NFVj1DiXrG2uQCM9EPazX2D93xCjea5wfuRj0Xc2lEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036157; c=relaxed/simple;
	bh=vtXodylusAl89FXkmICr+KVIJg7nLPXRZ99RpZ/IWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DcoddnexL+T4RBcTCcufoA29IiuHkCKzu51HkurqsiKhEF91GaFBBM3g2XDO0PuNjfV1LrPdbWGJuujXoAFge+qDELoAfYvQ/PtIeIS6NPt+bxg3yJR7qcsggAzM+Mqaa3zqBvwsn0DmUfRNdwsp6mAa0/Md+J/Yv4V+YFjW6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiZux5Sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717B0C433F1;
	Thu, 15 Feb 2024 22:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036156;
	bh=vtXodylusAl89FXkmICr+KVIJg7nLPXRZ99RpZ/IWYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QiZux5SgUnm7BL03Xb0QSt6s+AKMP8fCIdVgFb0sdcGf3eW2f2wFAF5JYKC/l0ysD
	 GTrVesH9YwfLHu9fMY/sy4PPEu8t8iRsoB1u/aISSwtNMIprB6EosbFUO0F9pTl4hz
	 PmvaEC9saPB3NONdwV04eURXdZbRZ3g11JexgoI2JAU+6MRTl868Pg74sD1psaFSSS
	 A5pZ3SMGySkoFAdu7z+/WpmKkgZRt7BI1B09yKXfpwRHtFBXEKV2RnZ8nY2nLJ67fx
	 8cMDShbNOygzu0ppN+2So9AvVfrMWqM4zmw2gANWX1bolv3YLYHnyLEuCtiGVFypiw
	 BFlRv+YCpQmVw==
Date: Thu, 15 Feb 2024 16:29:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com
Subject: Re: [RFC PATCH 3/6] pcie/cxl_timeout: Add CXL.mem timeout range
 programming
Message-ID: <20240215222915.GA1312780@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca61e1cc-5c72-4c56-b5d4-7442f25119a2@amd.com>

On Thu, Feb 15, 2024 at 04:21:48PM -0600, Ben Cheatham wrote:
> On 2/15/24 3:35 PM, Bjorn Helgaas wrote:
> > On Thu, Feb 15, 2024 at 01:40:45PM -0600, Ben Cheatham wrote:

> >> +#define NUM_CXL_TIMEOUT_RANGES 9
> > 
> > I don't think we actually need this constant, do we?
> 
> Not really, just gets rid of a magic number (as well as makes sure
> anyone who changes that array remembers to update the array size).

My point was that I don't think you need to specify the size of the
array at all since it's initialized, and you already use ARRAY_SIZE()
elsewhere.

