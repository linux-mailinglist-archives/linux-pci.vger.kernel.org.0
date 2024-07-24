Return-Path: <linux-pci+bounces-10727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9234C93B3D7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 17:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524A328198B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FD815B54F;
	Wed, 24 Jul 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA/e9ota"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D515B0FE;
	Wed, 24 Jul 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835389; cv=none; b=PsIjjwWeF2hOVJlVEQwUDJk6P/ljVmeF+mNpAsPTTRwh2dnmGZN9uJOc8rIti3blLmhWD/wlkkCjSQ78b0a9GpiMa8GIO1YOvZuddBbbXIrlOEA4HimI5zxIAxHbrKQsLBerMN0ylSJUERqWbvitdenAtPdhjeZWLJ9d4hLbnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835389; c=relaxed/simple;
	bh=dy+PiHf/gs6ghVGg6izoOkhmxgnHq4Gzf3BWbR5h3yg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LKy+PrXRg2Qv5puM7ishlrk3/d4o37tnOUV048CrW2VuPdVlh+sW8gTJgdcAUIpUq6A/cHn7qiESRDbDU7j86JLFZL0yfH61/jVTmJ/yQ3ZszQYNHB7YLcrK2LE1QLCUa7misUBaVVCmTnKxwGjBdO+pdejFTucXXRXH7qVLx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA/e9ota; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E885BC32782;
	Wed, 24 Jul 2024 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721835389;
	bh=dy+PiHf/gs6ghVGg6izoOkhmxgnHq4Gzf3BWbR5h3yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iA/e9otaw6Mwui8yoHfDbxojScfPoSU1evarFxgtCOhu9saIA1/odP+gPRWkX+k1B
	 QBHV2K1fdZz0UuMEdEhdGKmT+XKJE90VWxjhCP8cUrHAGlt/EnLqMt8kjZV975WVIQ
	 CkMYGVdIZ8Jnf4OXTnFv3K7dFscf1cFRq4vHVuV/qr+8r05Z+QYNYkgXclnYyrTnKL
	 p0VPRuZZweuocuemEnZ/S+3sGVLjdjl47C002ObSWsK2Y4pNPhQJqweFai3ku9t6b4
	 dfovRNHm+/YvvUVL2CsphUEZMUhzHG8/NVvWCcjnbKbhQC3hQxO9UZrkOMKOucC1qC
	 uybwCfubFRwnQ==
Date: Wed, 24 Jul 2024 10:36:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, Jonathan.Cameron@huawei.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
Message-ID: <20240724153627.GA800043@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc94330f-1ef0-8b84-ebb8-44fd74c4a3c9@amd.com>

On Wed, Jul 24, 2024 at 03:45:34PM +0100, Alejandro Lucero Palau wrote:
> On 7/17/24 21:55, Wei Huang wrote:
> > TLP headers with incorrect steering tags (e.g. caused by buggy driver)
> > can potentially cause issues when the system hardware consumes the tags.
> > Provide a kernel option, with related helper functions, to completely
> > prevent TPH from being enabled.
> 
> Maybe rephrase it for including a potential buggy device, including the cpu.
> 
> Also, what about handling this with a no-tph-allow device list instead of a
> generic binary option for the whole system?
> 
> Foreseeing some buggy or poor-performance implementations, or specific use
> cases where it could be counterproductive, maybe supporting both options.

Makes sense if/when we need it.  IMO no point in adding an empty list
of known-broken devices.

