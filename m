Return-Path: <linux-pci+bounces-4536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661258728CB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 21:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C181C21E7E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 20:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC7712AACC;
	Tue,  5 Mar 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPa79dmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFC12AAC2;
	Tue,  5 Mar 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670753; cv=none; b=hc45IE4qo9syNw7vrs2K+IRXrfwqbPRTIe4LD0EYadHHiDR3SOUWnpamJCtMxblAwQpoSbm+W1BnmEjcbKwrGXptGusBHjciMeQj/VbNP/Ml8mysKs8/S3wDYHaCg6+k8or8vVocm35ppfnKMX5++C/a6UH+W2ieIsOCCl296jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670753; c=relaxed/simple;
	bh=MtMKOqwG00apk+sEFFLwEO8144oftOKJAps+lmbST94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WDLJ4k4/MFJqQKTb37NVD7dCTCyyNmNaZHbHfw2bH2Zhsblpn3Xs3oGN1lF5E5HdrGv9I6qLgF6i5j5x2lCLcCsHxETOJVQSolDjFJuFDFKF9mNZEPPQrRVE4vQZfwsCj7m2yvHHEqVZGRQP3rdz6R/AwlTvdCL1oRsjDXeuEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPa79dmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C51AC433C7;
	Tue,  5 Mar 2024 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709670753;
	bh=MtMKOqwG00apk+sEFFLwEO8144oftOKJAps+lmbST94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lPa79dmSeSGz9NrHn+AkQ4D9fSAHbeD4h96BpfObWgwtj8yKswpMz7USGsc44n8T9
	 QqV9xv/HE93NWFjH2MTFhk3ghIlLRAsGKOAooScbcSqC6CLHeimKHGZhv2osjN8crq
	 xCUQHlg9iPE+MOJjd9bmc1E3IDUx4h/rXwqPaeomewx1ac0+F9GAzUsN5B97vdRu94
	 6V2/jFLV2nPE3PCV9u60eQd/4aNpjudeQP+R75vNhfQxjAc7pcW7ANfTcVYtxo16qc
	 Og4ubIwal1J5AfCbm9xxhO/8Xm9qqj620LzLUDEAtQreu/a+8x/CCOO1xPDdAt3o4P
	 9xxbxt2IjfQ1w==
Date: Tue, 5 Mar 2024 14:32:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH kernel v2] pci/doe: Support discovery version
Message-ID: <20240305203231.GA538524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089cddf1-3686-4403-a480-07fddd66ab4b@amd.com>

On Tue, Mar 05, 2024 at 05:02:27PM +1100, Alexey Kardashevskiy wrote:
> On 28/2/24 07:41, Lukas Wunner wrote:
> > On Mon, Feb 26, 2024 at 02:31:14PM +1100, Alexey Kardashevskiy wrote:
> > > Does PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER need to be in pci-regs.h?
> > 
> > Yes that's fine.
> > 
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -1144,6 +1144,7 @@
> > >   #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
> > >   #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> > > +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER	0x0000ff00
> > >   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> > >   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> > >   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> > 
> > "DISCOVER" duplicates the preceding "DISC", maybe just
> > "PCI_DOE_DATA_OBJECT_DISC_REQ_3_VERSION" for simplicity?
> 
> Well, mostly because the PCIe spec specifically says "discovery" in the
> field description, not just "version", but ok, I'll drop it.
> 
> btw "DISC" is just confusing, it has nothing to do with discs. _PROTOCOL is
> not even correct anymore, now, in PCIe r6.1 it is called "type", lovely :)
> s/PCI_DOE_DATA_OBJECT_DISC_/PCI_DOE_DISCOVERY_/ (because DO==DATA_OBJECT)
> imho would do better but may be some other day.

Agreed, and there are only a couple uses so not hard to change,
although it is already in uapi/.  Maybe nobody really uses it yet
though?

> Less ugly since we want to keep it 80 chars long (do we, still?). Like this
> looks meh:
> 
>         u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>                                     *index) |
> FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
>                                     (capver >= 2) ? 2 : 0);
> 
>         __le32 request_pl_le = cpu_to_le32(request_pl);
> 
> If we did 100 chars, I could do:
> 
>         u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> *index) |
>                          FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER,
> (capver >= 2) ? 2 : 0);
>         __le32 request_pl_le = cpu_to_le32(request_pl);

Personally I prefer 80 columns because all the rest of drivers/pci is
that, and it's a hassle when browsing to have to resize the window to
either accommodate wider lines or avoid wasting screen space when all
the lines are shorter.

But there are exceptions.  Strings don't need to be broken because
grepping for error messages works better when they're continued.  This
situation might be an exception, too.  We don't need to slavishly
adhere to 80 if the result looks terrible.

Bjorn

