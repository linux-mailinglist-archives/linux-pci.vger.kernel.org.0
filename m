Return-Path: <linux-pci+bounces-7211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B338BF485
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 04:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23181C23320
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BD1A2C25;
	Wed,  8 May 2024 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4Pdv4wP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAA2563
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135248; cv=none; b=koHjEbQvfoliK27Tc/P1gLHlhitR8WILufNutmvbyfYcpDoHhkNkb/ZNyMkwfXLuEWCiClePstm5dsQYIku9uZ1tAdLm87uRZK0L1vScn6vPnRyN8QAN9EfvT8rq6hZpPWQk/bZjhCWfPc4zGFGFRKuiTg4MtKQkl45Ki81CzGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135248; c=relaxed/simple;
	bh=xU6MM4wpMg/XrlyHvzUgme/0wiRaoqcQzd07zoGlfpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hno9QfPigfa7hvCTa6Xm3/v4X2Dx3NoFSUxF6iaU1+OD/b+aC9BSwVEW6rqOR4WlL8w/k0vWQjbjS/vAbLUwsgOrAQLRPHOCTXMBd+q5ijU8li0TtSMc1e4UfEflfqusLnIzsjU1LV+zL2r7cvT3IzIn+yWZ4SOZP9GeQH8B76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4Pdv4wP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715135246; x=1746671246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xU6MM4wpMg/XrlyHvzUgme/0wiRaoqcQzd07zoGlfpU=;
  b=J4Pdv4wPFjdfvGlbuNxhQ3xi9W7yVnlxhDq5yxZjReAfGiS0HpgNt1S+
   Q7ebWNQABL5eTMm0AHWauVQ/fdPaoga+9zD9QErLyGg5TUVq9ISz0iHm9
   CQb1QbkXw1cZvR+H0z+egdmvvx9OTuca+bsR1B+kiex+GGVxXvrXerDsH
   +F7Ztp/jq6waEDwH+CcB/5ZHHua0SOojYV3ZL+6pmHXlg1gjmc7FZ241T
   xpeDTC2t6qNV4qKeaQFuLOEiarmly4ozGQssInWLY3U0PNFGTUdsrR5AW
   7RHWDtB9xtphEuuRnRCOOhpINUb3Gfrz9y3WfWbkiYAmPEf8LYZzyjYcX
   Q==;
X-CSE-ConnectionGUID: uGZST/RrS9eUFA7405SdPw==
X-CSE-MsgGUID: 70Qx7VFrRp+dBVFKJrbewA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10838035"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10838035"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 19:27:25 -0700
X-CSE-ConnectionGUID: Jc9JefSKSm2LHM8AeRvDFQ==
X-CSE-MsgGUID: ciV07w9IQSCYEZZhG2s1bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28701986"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2024 19:27:22 -0700
Date: Wed, 8 May 2024 10:21:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, kevin.tian@intel.com,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Zjrhtun8IXtqOFR1@yilunxu-OptiPlex-7050>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
 <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
 <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
 <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zjjz60XvF97c+Hea@yilunxu-OptiPlex-7050>
 <663a7131d47b3_354c429489@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663a7131d47b3_354c429489@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, May 07, 2024 at 11:21:37AM -0700, Dan Williams wrote:
> Xu Yilun wrote:
> > > > If (!ide_cap && tee_cap), we get here but doing the below does not make 
> > > > sense for TEE (which are likely to be VFs).
> > > 
> > > The "!ide_cap && tee_cap" case may also be the "TSM wants to setup IDE
> > > without TDISP flow".
> > 
> > IIUC, should be "TSM wants to setup TDISP without IDE flow"?
> 
> Both are possible. The TSM may need to be involved in IDE key
> establishment even if the PF or its VFs are ever assigned as TDIs. Also,
> as you say, it is possible for a TSM to trust that a device does not
> need IDE established because it is has knowledge that the device is
> integrated into the SOC without physical exposure of its links.
> 
> > But I think aik is talking about VFs (which fit "!ide_cap && tee_cap"),
> > VFs should not be rejected by the following:
> > 
> >       pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> >                                              PCI_DOE_PROTO_CMA);
> >       if (!pci_tsm->doe_mb)
> >               return;
> > 
> > VF should check its PF's doe/ide/tee cap and then be added to
> > pci_tsm_devs, is it?
> 
> This path should probably skip VFs because the 'connect' operation is a
> PF-only semantic. I will fix that up.

Agreed. I drafted some simple changes for the idea, that we keep
pci_dev::tsm for every TEE capable device (PF & VF) to execute tsm_ops,
but only adds PFs to pci_tsm_devs for "connect".


diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 9c5fb2c46662..31707f0351c6 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -241,9 +241,14 @@ void pci_tsm_init(struct pci_dev *pdev)
        if (!pci_tsm)
                return;

-       pci_tsm->ide_cap = ide_cap;
        mutex_init(&pci_tsm->exec_lock);

+       if (pdev->is_virtfn) {
+               pdev->tsm = no_free_ptr(pci_tsm);
+               return;
+       }
+
+       pci_tsm->ide_cap = ide_cap;
        pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
                                               PCI_DOE_PROTO_CMA);
        if (!pci_tsm->doe_mb)
@@ -262,9 +267,14 @@ void pci_tsm_init(struct pci_dev *pdev)

 void pci_tsm_destroy(struct pci_dev *pdev)
 {
+       if (!pdev->tsm)
+               return;
+
        guard(rwsem_write)(&pci_tsm_rwsem);
-       pci_tsm_del(pdev);
-       xa_erase(&pci_tsm_devs, pci_tsm_devid(pdev));
+       if (!pdev->is_virtfn) {
+               pci_tsm_del(pdev);
+               xa_erase(&pci_tsm_devs, pci_tsm_devid(pdev));
+       }
        kfree(pdev->tsm);
        pdev->tsm = NULL;
 }

Thanks,
Yilun

> 
> I still think the PF needs to go through an ->add() callback because I
> do not think we have a cross-vendor unified concept of when IDE without
> TDISP, or TDISP without IDE is supported.

