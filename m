Return-Path: <linux-pci+bounces-3619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EDC8584C3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3085C1C21535
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746521350DC;
	Fri, 16 Feb 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh4O+qZp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513BB1350DA
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106594; cv=none; b=Wa3uWQ7XAhSWSCeOBOLH74AFHF2yIkI4ciF4P6M/SV0YaSuuK72xhxISNUek+OR4whtS5Q95Rpja9qSEE7bNimFDoiECw88o1JEvpMopo/Tk07aN0wXf37jq09P/rLxIXr2mbPzXhmzhKXEf7tjyAjLXUg484qyp6WoosyaBU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106594; c=relaxed/simple;
	bh=IuZ98DlPQRzx9BSITRz0hhMOAE19U4ajkwd2FamQ3Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YoW9Nzz9s1pZ59ISCKUK9w+hOpPvcMAhwyDqJgRD6Jx+NjXAUrEyzt0AvndtT1UuX3/y+0VSJm0PG3oKmTrkjNfJfx21rF7oxzIwltkf4VHao66FNwgm/MizfdeDJIHOeUHscrHoXLdr+QphbfaNaxfFYoFjidz1s5JIykUruw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh4O+qZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAB1C43394;
	Fri, 16 Feb 2024 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106593;
	bh=IuZ98DlPQRzx9BSITRz0hhMOAE19U4ajkwd2FamQ3Z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bh4O+qZpy4n4AFEqQs1WimXbUZbZgclTJJS8XtFmfTXjkHDEZWKdxzuu3cJHKJC7+
	 dBo4ErlV1wNsnrQVAG63r1im/e4474BxLc2172vz8KE5eKN+ItHIvqw6HNKHLTnntU
	 LpsA85NIqN0YW8w6KmEPePjbU5GkISkvUN731W/37PbsdmwLg1WKH7FLOBlGB7TxNc
	 uIVsfI62Ra1z5qNJp4Fr6D5h6ViRFBjXxJktEpKuq4H4aPZN7KRrp9Hucmv+NSBaV3
	 Ucm2GcgZeW9dZnUIlxPK6KDiR8J0I79EbBGYqV3+92I7UdLyH7ul7OaHcSL1fFvlnf
	 ylKHS8mHz4kiA==
Date: Fri, 16 Feb 2024 12:03:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: =?utf-8?B?SsO2cmc=?= Wedekind <joerg@wedekind.de>,
	linux-pci@vger.kernel.org, aradford@gmail.com, linux@3ware.com
Subject: Re: [PATCH] drivers/pci: disable extension-tags on 3w-9xxx controller
Message-ID: <20240216180312.GA1346616@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a22210a6-f9ea-d495-907d-1729dabc17fd@linux.intel.com>

On Fri, Feb 16, 2024 at 04:59:57PM +0200, Ilpo Järvinen wrote:
> On Fri, 16 Feb 2024, Jörg Wedekind wrote:
> You need to provide a description here too, the shortlog in subject is not 
> enough.

Yes, we would like a little background, e.g., a URL for a bug report
if it exists, a description of how a user might recognize this
problem, etc.  See https://git.kernel.org/linus/1b30dfd376e2 ("PCI:
Mark Broadcom HT1100 and HT2000 Root Port Extended Tags as broken")
for a sample.

Also update the subject line to use the same pattern as 1b30dfd376e2.

> > Signed-off-by: Jörg Wedekind <joerg@wedekind.de>
> > ---
> >  drivers/pci/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index d797df6e5f3e..2ebbe51a7efe 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5527,6 +5527,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
> >  
> >  	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
> >  }
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
> > 


