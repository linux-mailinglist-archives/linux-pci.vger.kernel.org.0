Return-Path: <linux-pci+bounces-2197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA882EAE3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 09:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31071C225EB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623311720;
	Tue, 16 Jan 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkB2yt3V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E011C83
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705393940; x=1736929940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MRcnmyiQ7N8RKTxdqOtzsPA4jYhktVaScXcZRKWO/PM=;
  b=WkB2yt3Vv1HdoMVWtYfcz28QJKLjsLgg/tU/88MW34GM3I3xVfo8q7eH
   NQG9unQzqdFYvCm0rlxHdfsMHcmRo78WQLaebAtahOXYNYk+RB+p8utuH
   TYqwHD0aQ7xR9vLn2goQIVQuaScXzrFVQ7EpEpw6wUy8GAsHoSJIjDGlx
   7blkiYOVMDxXt5u1ZaL85Unz5wk65JslM6Tsi4OVAmBiok0hFUAtkMQ55
   JzjZ1PuRMkgsv6PK9cXrLoGgh/SiWS08EtsTwdinK+drNiR7WGYrTrjlY
   qfni00K/3e2FUnhI7/5xA24W3hKZLK1Z7lxyFCkNsH/LQI2g5DY8oxD97
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="403545057"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="403545057"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:32:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="1030908160"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="1030908160"
Received: from mindai-mobl2.ccr.corp.intel.com (HELO localhost) ([10.255.31.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:32:17 -0800
Date: Tue, 16 Jan 2024 16:32:06 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com
Subject: Re: [PATCH 0/4] pci/aer: Handle Advisory Non-Fatal properly
Message-ID: <hewpjsczelodrjojdxul36jwfbx4ccsajac624nl3ej6dvwvvr@xt24qgrmqhjf>
References: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
 <20240112164107.GA2271345@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112164107.GA2271345@bhelgaas>

On Fri, Jan 12, 2024 at 10:41:07AM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 11, 2024 at 03:32:15PM +0800, Wang, Qingshun wrote:
> > According to PCIe specification 4.0 sections 6.2.3.2.4 and 6.2.4.3,
> > certain uncorrectable errors will signal ERR_COR instead of
> > ERR_NONFATAL, logged as Advisory Non-Fatal Error, and set bits in
> > both Correctable Error Status register and Uncorrectable Error Status
> > register. Currently, when handling AER event the kernel will only look
> > at CE status or UE status, but never both. In the Advisory
> > Non-Fatal Error case, bits set in UE status register will not be
> > reported and cleared until the next Fatal/Non-Fatal error arrives.
> > 
> > For instance, before this patch series, once kernel receives an ANFE
> > with Poisoned TLP in OS native AER mode, only status of CE will be
> > reported and cleared:
> > 
> > [  148.459816] pcieport 0000:b7:02.0: AER: Corrected error received: 0000:b7:02.0
> > [  148.459858] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> > [  148.459863] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00002000/00000000
> > [  148.459868] pcieport 0000:b7:02.0:    [13] NonFatalErr           
> > 
> > If the kernel receives a Malformed TLP after that, two UE will be
> > reported, which is unexpected. Malformed TLP Header was lost since
> > the previous ANF gated the TLP header logs:
> > 
> > [  170.540192] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> > [  170.552420] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00041000/00180020
> > [  170.561904] pcieport 0000:b7:02.0:    [12] TLP                    (First)
> > [  170.569656] pcieport 0000:b7:02.0:    [18] MalfTLP       
> > 
> > To handle this case properly, this patch set adds additional fields
> > in aer_err_info to track both CE and UE status/mask and UE severity.
> > This information will later be used to determine the register bits
> > that need to be cleared. Additionally, adds more data to aer_event
> > tracepoint, which would help to better understand ANFE and other errors
> > for external observation.
> > 
> > In the previous scenario, after this patch series, both CE status and
> > related UE status will be reported and cleared after ANFE:
> > 
> > [  148.459816] pcieport 0000:b7:02.0: AER: Corrected error received: 0000:b7:02.0
> > [  148.459858] pcieport 0000:b7:02.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> > [  148.459863] pcieport 0000:b7:02.0:   device [8086:0db0] error status/mask=00002000/00000000
> > [  148.459868] pcieport 0000:b7:02.0:    [13] NonFatalErr           
> > [  148.459868] pcieport 0000:b7:02.0:   Uncorrectable errors that may cause Advisory Non-Fatal:
> > [  148.459868] pcieport 0000:b7:02.0:    [18] TLP
> 
> Thanks for the overview here.  It would be good to put some of these
> details in the commit logs of the patches that implement this, because
> this cover letter is not preserved when the series is merged.
Thanks for your advice, will put some of these details in commit logs, 
mainly in PATCH 2. 
> 
> If/when you do, remove the timestamps because they're not relevant and
> are merely distracting.  Indent quoted material a couple spaces.
Agreed. Thanks.
> 
> Update the citations to a current spec revision (PCIe r6.0, or maybe
> PCIe r6.1).  The section numbers are probably the same, but there's no
> point in citing a revision that's 6.5 years old when newer ones are
> available.
Makes sense, thanks!
> 
> Bjorn

