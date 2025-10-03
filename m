Return-Path: <linux-pci+bounces-37497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43368BB5CA7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 04:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B9D480B8C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 02:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3182C235E;
	Fri,  3 Oct 2025 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNWSkcRM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C82C2353;
	Fri,  3 Oct 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759457542; cv=none; b=t6HC0IJecLSmYARhYWKMqK1W9VShX05zXBJsZ/w+rKpi96cDMdXx6oKtk6wYuEauNKNIsct1jAVXOApw/qfYUEwRIpz+6fBw4X9mAO9u8UEnztmRY2geA6I1A7obl5fQAFnbS0Q3/qYvE0+I2XPJQK15eDLnptqJQaP3/oqYpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759457542; c=relaxed/simple;
	bh=qtzjrZBBxKN/6Xha1W2kGG4xjEIlLB9Uc8Ik5gn2z2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHZjL5hRQg1sUL7uqj7Tqrh1hqmU47aBTBdNZyClJcd0TzXmUusWZBBe8lv0F9IcRDWphNF1lkXuccdWdD4MPCcHCn7RLtJedsvhlvcxNNE9sruFi6/ar/QlprvC2xQyNKbvFHdR+qfRGLojnLejRXfYz5BLyDhxe01AW8QxNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNWSkcRM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759457536; x=1790993536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qtzjrZBBxKN/6Xha1W2kGG4xjEIlLB9Uc8Ik5gn2z2M=;
  b=hNWSkcRMYVT+wJwS2NRUgAAn04nLKLT1/J1NTApY0lw5RoI7NwcpGZVl
   T3E6A3+G/cSrbdq665DbS0oAZeMVL5jzdjeMzeEKXz1u8Nc5nWOYJNeR3
   BhQ4MvTfMH//0Yit2CfaPkTfM67vMcurpO2dSNC73TzmUhYVg5YbrJoQc
   eJc35iM9jVnuk+Yo2wpT3FosRFotPf5UQoVDiKKWDkvG8o1bLmSp3aYbg
   AA2KH4s4OMPbIVyoYhyc/puJQcE6iuqUPLRfsnWTxy8X19XPB4q1ij33d
   reyh0K5OO+RXjB/OsCtugW1UosT8OkSr+dn9/mMU/43THGWC8L+tZcDXc
   Q==;
X-CSE-ConnectionGUID: sZb0cg6VTR+w4+xvhGYZPw==
X-CSE-MsgGUID: GVV97dEJTw613u+VfGy6Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="64361708"
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="64361708"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 19:12:16 -0700
X-CSE-ConnectionGUID: pCeIzc+NR8ORVedj+sh/Ig==
X-CSE-MsgGUID: WNmjOiUcSsyju4Y91t++ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="179601731"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 02 Oct 2025 19:12:14 -0700
Date: Fri, 3 Oct 2025 09:59:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, aneesh.kumar@kernel.org,
	bhelgaas@google.com, aik@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/IDE: Add/export mini helpers for platform TSM
 drivers
Message-ID: <aN8uEHZzd2cCOYoK@yilunxu-OptiPlex-7050>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-2-yilun.xu@linux.intel.com>
 <68dc74a6b7348_1fa210058@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dc74a6b7348_1fa210058@dwillia2-mobl4.notmuch>

On Tue, Sep 30, 2025 at 05:24:06PM -0700, dan.j.williams@intel.com wrote:
> Xu Yilun wrote:
> > These mini helpers are mainly for platform TSM drivers to setup root
> > port side configuration. Root port side IDE settings may require
> > platform specific firmware calls (e.g. TDX Connect [1]) so could not use
> > pci_ide_stream_setup(), but may still share these mini helpers cause
> > they also refer to definitions in IDE specification.
> > 
> > [1]: https://lore.kernel.org/linux-coco/20250919142237.418648-28-dan.j.williams@intel.com/
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >  include/linux/pci-ide.h | 6 ++++++
> >  drivers/pci/ide.c       | 8 +++-----
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > index a30f9460b04a..5adbd8b81f65 100644
> > --- a/include/linux/pci-ide.h
> > +++ b/include/linux/pci-ide.h
> > @@ -6,6 +6,11 @@
> >  #ifndef __PCI_IDE_H__
> >  #define __PCI_IDE_H__
> >  
> > +#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> > +	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> > +	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> > +	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, (domain)))
> > +
> >  enum pci_ide_partner_select {
> >  	PCI_IDE_EP,
> >  	PCI_IDE_RP,
> > @@ -61,6 +66,7 @@ struct pci_ide {
> >  	struct tsm_dev *tsm_dev;
> >  };
> >  
> > +int pci_ide_domain(struct pci_dev *pdev);
> >  struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
> >  struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
> >  void pci_ide_stream_free(struct pci_ide *ide);
> 
> So I do not think we need to export these as much as let TSM drivers
> reuse more of the common register setup logic.

Do you mean PCI IDE should provide the collapsed raw RID/Address
Association Register values for platform TSM drivers? TDX needs these
raw values for SEAMCALLs.

> 
> I will flesh out more of the proposal on the next patch.

