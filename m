Return-Path: <linux-pci+bounces-2113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B903382C397
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5B1F23646
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD374E29;
	Fri, 12 Jan 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdqJ3AGC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED96E2CF
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 16:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A2DC43394;
	Fri, 12 Jan 2024 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705077173;
	bh=krKegrfXbKhLJdttsWgNEShyybOUBjdHglDYm+obGLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UdqJ3AGCKB4mOJAxqn+UvugXF1CiJnjGpXsPW3DjmHRliS8qYbuQ9648WjQ21HeVX
	 BWoRS89nX8qknXIgjma0RBKcRLdKRv6sRS0fDa1DypHCMPEXLIurWTSCdUBLnhxrxT
	 gjryEPffZ88EaPIraBTutOpZDOICzuO7sp2FU5JfXm/PgA7u0EF4+bryBqh0PglF5B
	 Cn0xFzzq/0qMeLbZjCXr9VYIETd2FR/Q8iCWuEzveJYPCSxozZ1sAuvc8uAmeRlilr
	 WBwNik1oQQBXALIHEwsNLhwa+Zdu+5WHp0jCSirfvt0H6juSlDH3EpUfCQ45UgUkDw
	 K3BoO2azuzdxQ==
Date: Fri, 12 Jan 2024 10:32:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com, erwin.tsaur@intel.com,
	feiting.wanyan@intel.com, qingshun.wang@intel.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/4] pci/aer: Store more information in aer_err_info
Message-ID: <20240112163251.GA2271088@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073227.31488-2-qingshun.wang@linux.intel.com>

Please update subject lines of all these patches to match the
capitalization of drivers/pci/ history.

On Thu, Jan 11, 2024 at 03:32:16PM +0800, Wang, Qingshun wrote:
> Store status and mask of both correctable and uncorrectable errors in
> aer_err_info. Severity of uncorrectable errors and the values of Device
> Status register is also recorded in order to filter out errors that
> cannot cause Advisory Non-Fatal error.
> 
> Refactor rest of the code to use cor/uncor_status and cor/uncor_mask
> fields instead of status and mask fields.

Can you say something here about the benefit of doing this?  This text
essentially describes the code in English, but we can read the code.
What we need here in the commit log is the *reason* for making this
change.

Bjorn

