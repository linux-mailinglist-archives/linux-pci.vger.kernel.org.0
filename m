Return-Path: <linux-pci+bounces-26237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5264A93B3E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 18:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04CD188B82D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9813AD3F;
	Fri, 18 Apr 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ5RyStq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204479EA;
	Fri, 18 Apr 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994818; cv=none; b=IHdkPDjRJufRhooft7hxHOFY3OugU9GyPlDP0pndoRPGVy9NZR6v72VUxxMGSp487XBUsR0UXfQI2FNFYmKrMI1SAJUfY3KFeGAX/J5y4IpJDGz8fCux6FW5XWIEmWvWBPb0Hz4/4vvH+Ne6g+5iVi32ZFRYWfUTY8jWSzShHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994818; c=relaxed/simple;
	bh=mUAib5v+tIBsTfcndM1x9oXxfgi90lMRGMaA0jGkbkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tmpJtuadhfHOHQKO37PjZFDgKUUEABQ85aE4eILxg5bnPQ4bCvS9h2RUiRGmEkge8IWZeCqtf4dyYpbTdamBmGwaC/Um12Du/vM/bgHBVQUjMn6HQ7YMixEIAV7yfIcDe0u64SZOOFdCZkzze/2mjHCpzmuiJvD8zKiOhvgEf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ5RyStq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF83BC4CEE2;
	Fri, 18 Apr 2025 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744994818;
	bh=mUAib5v+tIBsTfcndM1x9oXxfgi90lMRGMaA0jGkbkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XZ5RyStqRMsLGV61qHOGUgASAjy9yuy56LjVqfECqKftWSyN/kiNGl5EKGi4Twmo+
	 kIoQrUFtVxcE2EsnM5jyL6g4tPVXuSOEaQ8+Ige519NMlBKpoOL87x+dFuWOeWSjqM
	 EJxnqnT82oQujZVmuat8rUu0/5gys5vzPlD5hMqIxqNuzOrvHEPLqbV5wBSrY309jv
	 84OOCQsUPGEpYGJPJAqRDErIeo2r3B3Zlt81zWpyLHn20IfFZw8VUtYYRrE7ifzJaC
	 0BO06yren7GOcDZtAqYLazTORsCfnQC2xgM07iPDhrXdgl7TlgBlKFByp06UJNljhi
	 0Ldsa7u82Um5g==
Date: Fri, 18 Apr 2025 11:46:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Joe Doss <joe@solidadmin.com>
Subject: Re: [REGRESSION 6.14] Some PCI device BARs inacessible
Message-ID: <20250418164656.GA160194@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418102926.690ac42c@foxbook>

[+cc Joe (reporter), Ilpo]
[+bcc Steven (another reporter, bcc since email hasn't been used publicly recently]

On Fri, Apr 18, 2025 at 10:29:26AM +0200, Michał Pecio wrote:
> This is a heads up that an apparent PCI regression has been reported
> and mistakenly assigned to USB in the kernel bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220016
> 
> Visible symptom is missing USB devices, but the whole controller fails
> to probe, apparently due to devm_request_mem_region() returning NULL,
> see drivers/usb/core/hcd-pci.c and usb_hcd_pci_probe().
> 
> Same systems also show a similar failure with some AHCI controller.
> It seems specific to particular ASUS AMD motherboards.
> 
> Somebody found that disabling CONFIG_PCI_REALLOC_ENABLE_AUTO helps.
> 
> That's all I know, reporters can be reached via bugzilla.

#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=220016

