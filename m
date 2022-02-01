Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFD4A62D1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiBARpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 12:45:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:11808 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241613AbiBARpr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 12:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643737547; x=1675273547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wo0ruSODN2J2aAjmhR6V0progvo1o7OpOk+t943iN4c=;
  b=SmhuD1+oqjqn64CHSXNy5hSoaasvXY0R2B92h1fwpwF38ZiOUgWEzakl
   xSoMxpCDgrKPDAljYhfLk3e3y18JtsZvhP73THBHkaaUUdTol0EYj5ANj
   2RqlykqX1fDDiAyAQCW40k0D17hcu/ukfmGSokVYlog2Yc/Po5AgYVkoF
   CCV+yMNNyxuFicFnquoiYlOmHyYnnyFZpSFFe23S/2Rbd/nJNR7t1dUug
   Gz/fw+JyxZRWXrwW63MyxqT+kMEkCX7uEd78mGQu9Yq+F+Gx2n9tPZs3B
   CLgj44Obof1k7veV5VhIWoXP6QQ18nLEKNwJXianC5o/jPlhsY/mJf7xP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="235143109"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="235143109"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:45:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="534591256"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:45:46 -0800
Date:   Tue, 1 Feb 2022 09:45:45 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 34/40] cxl/core: Move target_list out of base decoder
 attributes
Message-ID: <20220201174545.z45ofgv7cuxcbjze@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298430100.3018233.4715072508880290970.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298430100.3018233.4715072508880290970.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:31:41, Dan Williams wrote:
> In preparation for introducing endpoint decoder objects, move the
> target_list attribute out of the common set since it has no meaning for
> endpoint decoders.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Could add DPA skip at some point to replace it.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]
