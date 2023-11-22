Return-Path: <linux-pci+bounces-75-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4F7F3AC1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 01:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC99281AEA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B463A;
	Wed, 22 Nov 2023 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqQXpdgu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0876D3F
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 00:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3309C433C8;
	Wed, 22 Nov 2023 00:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700613432;
	bh=T+X8dv5dqj6tH86PIC+f7CdRwS99S20uzaY4HsowPbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UqQXpdguQjHRk82VND9am2C4SMCLMKuWszu5zbs9GDwq4hrJiyLFPph8oPcPOFeL5
	 ywDCiyhqc0gu7lIVWrxTapmeqVhR9kVJh0rh3VkLp7C3L6iE+C9itDefg3WErv7qgG
	 yzC0pbvGNhqfdtDEXRj+S8lHE2o0gY744vNmXw9IO7I6dCsHnZbcQDwnaB+4i0YQrN
	 y8kn9m7gzfssHEJ7aRV4PTgOBGGcZhqbY6LqJRQdMLu7VDp9U+rQI+Jk9eZb1L9Tdp
	 PMix90E0ZrmAKDidn3TR+0QwdWk3x+ostYSaMpM3psYMSuQ2al+GbYU7io7D2fpq6e
	 85kLbRIB/X94w==
Date: Tue, 21 Nov 2023 18:37:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Daniel Stodden <dns@arista.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Message-ID: <20231122003711.GA265235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb27909b-931e-406e-a77d-b77f7305b532@arista.com>

On Wed, Nov 22, 2023 at 12:25:48AM +0000, Dmitry Safonov wrote:
> On 11/22/23 00:19, Bjorn Helgaas wrote:
> > On Tue, Nov 21, 2023 at 03:58:22PM -0800, Daniel Stodden wrote:
> >>> On Nov 21, 2023, at 10:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Tue, Nov 21, 2023 at 10:23:51AM -0800, Daniel Stodden wrote:
> >>>>> On Nov 20, 2023, at 1:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>> On Mon, Nov 13, 2023 at 01:21:50PM -0800, Daniel Stodden wrote:
> >>>>>> A pci device hot removal may occur while stdev->cdev is held open. The
> >>>>>> call to stdev_release is then delivered during close or exit, at a
> >>>>>> point way past switchtec_pci_remove. Otherwise the last ref would
> >>>>>> vanish with the trailing put_device, just before return.
 
> It's fine to drop my SoB. With the fixup above,
> 
> Reviewed-by: Dmitry Safonov <dima@arista.com>

Done, thanks!

