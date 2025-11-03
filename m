Return-Path: <linux-pci+bounces-40131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964AAC2D7DF
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 18:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4372E3AFA53
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6431960B;
	Mon,  3 Nov 2025 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2QMDBEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699326AA88;
	Mon,  3 Nov 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191194; cv=none; b=PxLCMJejy2cJ1DLEH35EwWQETs9idfs9bpiCVmthX2QPx5nf4SqH4aC/C4DZiKwIkOiR2oAu1wIuFYcIVbmr9Ca5ynK6HY9z+QXr0dJJTPFyEqe8fx/efej131D2kvA4Cs9y1boPxi3U37AaVwj41lNexizl5T0lKLNHGeTK+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191194; c=relaxed/simple;
	bh=ImfEpuEvGJzHfdHEbBZTkOKQ3ljJuF84xb7AnSHfJw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hdtBeFGwNGT7YDBvyPQXsFKgDlHQTj7gibgCTlXtkGIewO7ZG5C5Yz+unPBUUJnl7NcMqE+dpPBvrnNK+K/Ib8Atmue1Za9M+EHArdibOts4WfoBoBQ09jEtEczz2pj5ZrjUreEwJlvPi0DcYIFEjSXoWhhaE6YbrC4gyskhRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2QMDBEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DA6C4CEE7;
	Mon,  3 Nov 2025 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762191193;
	bh=ImfEpuEvGJzHfdHEbBZTkOKQ3ljJuF84xb7AnSHfJw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J2QMDBEnApSK6PZOoQQd55IADOsIBlUF1lqh49U7/S8kw+ZxJ7glSoiE2wuHus2gv
	 Tr8bzP5T1jy9RX7+t9zn/oeq3n3DO8VymhKPgFgSfOXWTdnIavStEaNG21bXp45rzA
	 ADoT26ePv/KV4u14iu1cwQ6G1oeebjWqplvXYx2CAcIkSJzN5FI5JbIOXND0h6Hym7
	 87J7bBZ7jAModgZD6m+QWcd+Xug2LeIvuopUqkJuwRjLzPf2fMTQccsBo1LQEn9YuW
	 4rqoaaOEmHF2BJySQjZ80+QjeV6pcaM+iEoISlAhgMfYR2CsKzvIvvib6SzfnK4gVD
	 HLI3HbOa/P4xQ==
Date: Mon, 3 Nov 2025 11:33:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH 1/7] PCI: Add Intel Nova Lake S audio Device ID
Message-ID: <20251103173312.GA1811842@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef97aef3-e837-4c88-84e7-33afbc8ac150@linux.intel.com>

On Mon, Nov 03, 2025 at 06:27:16PM +0200, Péter Ujfalusi wrote:
> On 03/11/2025 18:02, Bjorn Helgaas wrote:
> > On Mon, Nov 03, 2025 at 02:43:57PM +0200, Péter Ujfalusi wrote:
> >> On 02/10/2025 11:42, Peter Ujfalusi wrote:
> >>> Add Nova Lake S (NVL-S) audio Device ID
> >>
> >> Can you check this patch so Takashi-san can pick the series up?
> > 
> > We have a long history of adding these Intel audio device IDs that are
> > only used once, which is not our usual practice per the comment at the
> > top of the file:
> > 
> >  *      Do not add new entries to this file unless the definitions
> >  *      are shared between multiple drivers.
> > 
> > Generally speaking, if an ID is used by only a single driver, we
> > either use the plain hex ID or add the #define to the driver that uses
> > it.
> 
> In this case the ID is used by two different driver stack, the
> legacy HDA and SOF.

Sigh.  I looked through the patch series, searching for
PCI_DEVICE_ID_INTEL_HDA_NVL_S, but of course there's only one instance
of *that*, but two others constructed via PCI_DEVICE_DATA() where only
"HDA_NVL_S" is mentioned.

Can you include some hint about that in the commit log so I don't have
to go through this whole exercise every time?  I want pci_ids.h
changes to mention the multiple places a new ID is used so I know that
the "multiple uses" rule has been observed.

With that:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> > Have we been operating under some special exception for the Intel
> > audio IDs?  I see that I acked some of these additions in the past,
> > but I don't remember why.
> 
> The HDA audio entries were moved here by v4 of this series:
> https://www.spinics.net/lists/alsa-devel/msg161995.html
> 
> (I cannot find link to v4, only this:
> https://patchwork.ozlabs.org/project/linux-pci/list/?series=364212)
> >>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> >>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> >>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> >>> ---
> >>>  include/linux/pci_ids.h | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> >>> index 92ffc4373f6d..a9a089566b7c 100644
> >>> --- a/include/linux/pci_ids.h
> >>> +++ b/include/linux/pci_ids.h
> >>> @@ -3075,6 +3075,7 @@
> >>>  #define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
> >>>  #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
> >>>  #define PCI_DEVICE_ID_INTEL_HDA_FCL	0x67a8
> >>> +#define PCI_DEVICE_ID_INTEL_HDA_NVL_S	0x6e50
> >>>  #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
> >>>  #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
> >>>  #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
> >>
> >>
> 
> -- 
> Péter
> 

