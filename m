Return-Path: <linux-pci+bounces-8483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E248F900CAB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 21:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ACD1C20C8D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0011D14E2F8;
	Fri,  7 Jun 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpZz0Fk1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509E39FFB;
	Fri,  7 Jun 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790358; cv=none; b=B3kzl9Psu6qoc73EqLoMVTgAx2tHnsytqROVtSYagM1L+k5phy9qMIqXvgVnKxeJ+jOvTjtPm57El6xLlF/kuFwuP03jMfTExAEVQGnu76si+WgF0SZMt/gN6NG/T5n9BKSFtlZdRiRbSZIXbGNvgif8jKc54R2ts8S0NMDRb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790358; c=relaxed/simple;
	bh=CoZ61dwjEkp8sx38CmXzgu042Gq6Y2RZI+poqBTGNRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JaQdw26TyXHYs9Fo/WDYBRupof8wXebjv3g1Ar0ptE6CmWJGMhFLOkwuJN4lxhbfnqQemWOWndrN+5g0QVSKi6cDE0fxBi1P5IAfxnzHDxHqaqK+2mKJ7mPWyCtaFyj1wHyLS2AEAU6Z6z+cqP9UrITkRIOxAmCnflomKcVKOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpZz0Fk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040A9C2BBFC;
	Fri,  7 Jun 2024 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717790358;
	bh=CoZ61dwjEkp8sx38CmXzgu042Gq6Y2RZI+poqBTGNRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PpZz0Fk1qd29Dq/97R1hu02THlUUYJ1NFRfiFtIqZIf+WH3jdCae/0A+Fse0qdb2j
	 eRLYBBDV3j9426bCf0RU+tpU7PffIXNJmkbdpiZV6JxkiHyJ+ZKaNmvEDeu+JHKzCf
	 FvcLfAwdeau4erACKx4GOBy+wH+EElJmTzuqrd/Aw3KqT5+cFC/o7hiActdTMTWrb7
	 IEsTcusAgUicK7B7Q6VDyddEs7BM9mPGXHeH65t68T9MnX4G7hqyNMpy6RkE10ajiF
	 gJoGhVDPUju3jZabZSWNMXt60KLJ4rqsF8EckGHBADnE/SA2UpgUbLItAkkAE73VGl
	 mL3kKpxofY6Cg==
Date: Fri, 7 Jun 2024 14:59:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH V2 3/9] PCI/TPH: Implement a command line option to
 disable TPH
Message-ID: <20240607195915.GA852179@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213841.3246055-4-wei.huang2@amd.com>

On Fri, May 31, 2024 at 04:38:35PM -0500, Wei Huang wrote:
> Provide a kernel option, with related helper functions, to completely
> disable TPH so that no TPH headers are generated.

If we need this option, say what the option is, why we need it, and
include an example of how to use it in the commit log.

Include the option in the subject line, too, e.g., "Add pci=notph
option to disable TPH".  Or maybe "prevent use of TPH"?  "Disable TPH"
hints that BIOS might have enabled it, and this option would turn that
off.  I haven't looked hard enough to know exactly what you intend or
whether there's a difference.

