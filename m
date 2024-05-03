Return-Path: <linux-pci+bounces-7063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5BA8BB700
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C872817CF
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A45BAFC;
	Fri,  3 May 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzfgsK0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1365BAF0;
	Fri,  3 May 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774623; cv=none; b=BlfirACerwLxyHd2dnVH7ttxB9e5R7M7F8SAk7M9iBueHVyjOjSB7UidE4n3XJY9WSCEQkOJLslwLrTYUvRt4OnYxyKqxw/P88duJjQd3iGCwbRfsECs0wZguYhHlw5uWINcSLv7hJ5NlBGzDYRzwTGxmBfpZZbJMzHPFP6h2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774623; c=relaxed/simple;
	bh=NN+CPZ6b4zKVlSwv0Gl0g3ssQNO+Ma2/acLu1b/klbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OXkJoi29wMQsTBGUiwHOdWBM4DTrf0bIo05StUd0J0mV0XG3c+0ody3EBlKvXG5NZRF9dpCho8gSIeV5FYLA5kwC2VC7ZZpfv8GOjijZ8F8dSajXLpJ+skec/i4Xrn80+q4D2sgPn+zNT4Dh61fVx9tHuKVNGM4JFMojmipgoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzfgsK0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22669C116B1;
	Fri,  3 May 2024 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714774623;
	bh=NN+CPZ6b4zKVlSwv0Gl0g3ssQNO+Ma2/acLu1b/klbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QzfgsK0+3yaNMoeJIWnkMCsYFICKkEtnQb9+36M7QyJfJbtkVhNYODmtK+9u61g7V
	 qidD+2wng8yGGRF1l234lgY9LQKmYE7LpbEqk4VhIdwu2tF4qSWLsbF5L9A4gdWYIQ
	 yMc1L39vHK8J6M1km1AGZnXIYmRxI/P0S/tJ10pdJuF7d7APa2xuGy6sWSmZnbOC8a
	 EfTygQC1ke9dsqdOwEtGlx1XSsx4w0kD+5QWQ8IAvovRWfGhfCdm5q46ti1T7vLdMt
	 QFx7V3eUrAqD192IUHuZtnPBsiHLd+7/aDmYw2/3wJqMfnfJb+H+cE+zUGBrmzfQKp
	 nr6tIaWP5F4dA==
Date: Fri, 3 May 2024 17:17:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] PCI: vmd: Enable PCI PM's L1 substates of
 remapped PCIe Root Port and NVMe
Message-ID: <20240503221700.GA1607942@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424105814.21690-2-jhp@endlessos.org>

On Wed, Apr 24, 2024 at 06:58:15PM +0800, Jian-Hong Pan wrote:
> Re-send for the version information.
> 
> Notice the VMD remapped PCIe Root Port and NVMe have PCI PM L1 substates
> capability, but they are disabled originally.

When you post the next version, can you post the patches as responses
to the cover letter?  Patchwork and b4 don't know how to deal with
a series posted as disconnected messages.

Bjorn

