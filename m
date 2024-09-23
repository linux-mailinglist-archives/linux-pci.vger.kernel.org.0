Return-Path: <linux-pci+bounces-13363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C767997EA8E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870502822E5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37A195985;
	Mon, 23 Sep 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1HexIV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0626EADA
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090258; cv=none; b=tmzg+4TS8CkkIEuk9Q4XbWye3jCXmV1EY1vneLb4VxmHrOaFZ2GTaBgfyuc6fRglT0cmYy9k2gtrWYb4XB21nZt92LQFZfsEBupuEkFCS86d0WIC76s6v2GwMMCtTLoRtTFiDPL9zcWR9DWsqrVTVJFTV4zJDNiR7D35F0zl3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090258; c=relaxed/simple;
	bh=oT0J+exSbcMUtXhbjyc0NjUqkCpBvPLs+cYPwOzULoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jupmTOFQavDAbpSOzUPmfoU+UfccW0g99f19pz9MrIbbH6P6PkDMCqdvyqr4PXI1CxkkLohIKsX47wptGuasMQcFZYjlHmlEvFmAIonRYYPsglB10vVCYURYde9DgwBAaB70JxuPmhvRbwjpbP2BB9x7mPvDry/75d7czjCoe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1HexIV/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727090257; x=1758626257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oT0J+exSbcMUtXhbjyc0NjUqkCpBvPLs+cYPwOzULoQ=;
  b=l1HexIV/fYiJIla5HWAX/RwmlZAYpJY4eatILUwQnw+k32ktyhqeCs/S
   nz+B2/18JwRpKTAtCmrhFwwlVCQkmeb4A5Idph+s3/yyi/UZ5Ij1FdBtO
   LPMQf8GtCafCXum4Y9phtkvQvqs/qW7ctCW5hqoYPlY2TDz37Wq8gkrZq
   LbXKQTP3ER8FzX3m0N2fvqUIbAAk+75sjzFDKDJsVdpoTwak2lqRMBHQo
   fj+46QPSKFCWikZhREwNwa+OPN65JmqT9BJd+DqE6xy7k9tAyE6eLOO1S
   GfuAPpBaQL6g+qIrRLg5kjBmuzPOyUB5yHSaGwBK6rIk0NNOM+GdTooir
   A==;
X-CSE-ConnectionGUID: mGxiorJ8SACJ+5lzlQsatw==
X-CSE-MsgGUID: 25NB4EiZRsavzpGBViregg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="43551458"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="43551458"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:17:36 -0700
X-CSE-ConnectionGUID: m0pcvJkeRvWYpiWDUqLGxw==
X-CSE-MsgGUID: Y1/4cQqtTPer4EqcWKJ/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="70934133"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 23 Sep 2024 04:17:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 682DD2E1; Mon, 23 Sep 2024 14:17:33 +0300 (EEST)
Date: Mon, 23 Sep 2024 14:17:33 +0300
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
Cc: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <20240923111733.GV275077@black.fi.intel.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
 <20240923044123.GT275077@black.fi.intel.com>
 <99a2aa0d9f3768f250510db0abe6b32079f6a047.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99a2aa0d9f3768f250510db0abe6b32079f6a047.camel@secunet.com>

On Mon, Sep 23, 2024 at 08:43:19AM +0000, Wassenberg, Dennis wrote:
> Hi Mika,
> 
> the logs I shared with Ilpo a few minutes ago will already contain activated thunderbolt logging.

Thanks for the logs!

I wonder if you can share your kernel .config with me too? I have here
MTL based system and similar dock so can try to reproduce. At least with
my kernel config I do not see the issue even if I set the command line
matching yours:

  slab_debug dyndbg="file drivers/pci/* +p"

I built the Thunderbolt driver into the kernel as it looks like this is
what you are doing but still I don't see the crash due the poisoned
memory so I suspect I'm still missing something.

