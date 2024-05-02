Return-Path: <linux-pci+bounces-7027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9B28BA2F4
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F45D1F21BA3
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 22:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636D57C96;
	Thu,  2 May 2024 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJGW4XTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B557C94;
	Thu,  2 May 2024 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687450; cv=none; b=LYpVkGMdsnrrWt00xE5quZN/AbX3JukEW99vbpe9448PZlbhzP5uVRsioP0eThRJkYqGq4FHzel3x5xWE+rDBrX0iHaf/Vq3bjcRufc/hY++S0jMSzFT9ZuDIFD897wPpQ8rWi1XCUg/VRHKCDvw0jWcAZ0tn+127FtijGPWH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687450; c=relaxed/simple;
	bh=oHvGfGYBKi9expgIezTfEAK+vl5W/y1ZMPNDJv9bhyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RNPjxSUpNKpXoxL8/qGEyfNbvypGjoPnT4vSJvavwOg5I2rqHyJokKJBK8mWF1Zlfk29idlKenSzny3zZzp+jF0l/i0J0aZ/BiMDm9AP89grUBeHsXPD20337qzzFoJR/IWQ+t0Ft5X3jjN/G5S8vJliNUsoGcfOROKlroDyTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJGW4XTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02645C113CC;
	Thu,  2 May 2024 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714687450;
	bh=oHvGfGYBKi9expgIezTfEAK+vl5W/y1ZMPNDJv9bhyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MJGW4XToVN7/89xYTYpGk4IA1uz6UNAlPZJHM5aHXlkTIsmn1rRTPEjsSUOGFL3qh
	 b0YpO2QYkZVF9tkBTfNUAV3yZj5nlidSfLqaeRCCSd8LgH39gDtflV4F4SZMJrSyx8
	 jSp59aGPgc1e1pm5SXGERBHMsSVnnLEDIooGIHeHh96DvKCHBeWPbBWCZlM4pcSfYQ
	 IymendFlOClF7PkFGca9YuwtLQJCStzoeGX+BmuQ0/erjbK/WJTuGVoc5OHpS/mML0
	 K/35wxjpcWTdwR2zWIHd2zQywotmeYi0H7Waisj6MtiCWcH9oX0JJqTgiCi/HwZ2c4
	 yZH+ybgN2w5fg==
Date: Thu, 2 May 2024 17:04:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/ASPM: Define consolidation
Message-ID: <20240502220408.GA1550497@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322123952.6384-1-ilpo.jarvinen@linux.intel.com>

On Fri, Mar 22, 2024 at 02:39:50PM +0200, Ilpo Järvinen wrote:
> This series consolidates ASPM related defines into the ones in
> linux/pci.h and eliminates the almost duplicate ones from aspm.c. This
> allows using the input without mapping between the defines so the state
> mapping code to focus on the special cases.
> 
> Ilpo Järvinen (2):
>   PCI/ASPM: Consolidate link state defines
>   PCI/ASPM: Cleanup ASPM disable/enable mask calculation
> 
>  drivers/pci/pcie/aspm.c | 180 ++++++++++++++++++++--------------------
>  include/linux/pci.h     |  22 ++---
>  2 files changed, 100 insertions(+), 102 deletions(-)

Applied to pci/aspm for v6.10, thanks!

