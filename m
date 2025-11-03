Return-Path: <linux-pci+bounces-40123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234FC2CF9A
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 17:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F367A4E4345
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82573314B66;
	Mon,  3 Nov 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnW2zgIM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570063148C8;
	Mon,  3 Nov 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185742; cv=none; b=RIzFmhtGdfwhFxkNuozXi6Q1MFqChQW1rZd8exXBxJ3A0ZLBlIUjT7K3giRxmkdF93cBfNklkAo8qyjEXsn5y0u8XWDq8D+LP1uB0i/xA+YXPyr2UZN+7qWzIeQILqfF87HK0jgZdbjuxboOJJj38XAyL7NaIkvGKuR32VBg4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185742; c=relaxed/simple;
	bh=dWiE+QloP4U5xWzLAg4cQn58TLdwOultML9Hm3/8Lr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sbK4JNhrPGdxtnbt2YqWgAyqq0IfkFi8ZRZk59jLERVv+EpqJiYiKPcLSI6mFG+4jpmbWnSiQqwn4huO8O7hFO9kUR953ii9aZRBKBB+HDP5pDejBgOFTyUk2M7d7os0hhN3vGNoPjPZRySbPFOP4q1r5NpoQoIkVaVlS0h99fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnW2zgIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF422C4CEE7;
	Mon,  3 Nov 2025 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762185740;
	bh=dWiE+QloP4U5xWzLAg4cQn58TLdwOultML9Hm3/8Lr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fnW2zgIMRMnd9MvIaz9WPvawhQDPIkHep+35+KiXx0dB1O4E4q3ZcTd/R2MS3v838
	 ag1ndWg8XMDBbqE3zLdsQEqxGxqszT0iLKbewcT5dTx7Z6p/AebeHsLVvJdj/mDx3K
	 gAH28TdqHQnQNwFwSoa0DSgqxPoxjRPYOZaeLbf0QqeMJ33GXhAPRWw/Hj77j3reC7
	 I2RqNsxC+hcYlaaM4jXpLOMYklgZ96QdxNTnEQ3vYmOpzrM1IRdInyr7/B7zu1E9yp
	 0DHgwW2AuQOpru+WPYnZM3csNDswOfZbZ3HC+qLsAPwzY8U2As6BLOtUX3RtTTwH/V
	 njgN5SoePuHKw==
Date: Mon, 3 Nov 2025 10:02:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH 1/7] PCI: Add Intel Nova Lake S audio Device ID
Message-ID: <20251103160219.GA1806872@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e34fe42-a031-4ab6-b986-c09a36040b66@linux.intel.com>

On Mon, Nov 03, 2025 at 02:43:57PM +0200, Péter Ujfalusi wrote:
> On 02/10/2025 11:42, Peter Ujfalusi wrote:
> > Add Nova Lake S (NVL-S) audio Device ID
> 
> Can you check this patch so Takashi-san can pick the series up?

We have a long history of adding these Intel audio device IDs that are
only used once, which is not our usual practice per the comment at the
top of the file:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

Generally speaking, if an ID is used by only a single driver, we
either use the plain hex ID or add the #define to the driver that uses
it.

Have we been operating under some special exception for the Intel
audio IDs?  I see that I acked some of these additions in the past,
but I don't remember why.

> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > ---
> >  include/linux/pci_ids.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 92ffc4373f6d..a9a089566b7c 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -3075,6 +3075,7 @@
> >  #define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
> >  #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
> >  #define PCI_DEVICE_ID_INTEL_HDA_FCL	0x67a8
> > +#define PCI_DEVICE_ID_INTEL_HDA_NVL_S	0x6e50
> >  #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
> >  #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
> >  #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
> 
> 

