Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A526F823F
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 13:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjEELpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjEELpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 07:45:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFB1887E
        for <linux-pci@vger.kernel.org>; Fri,  5 May 2023 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683287140; x=1714823140;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cMNP3eMv7Sft+L0oJqLYCy2TrwjrNQEX5APegvEMH3Y=;
  b=TqZBZ4+3BAoIC/rgosnM/8WfEnHYsumDELJ6Iyp/ItDJPxS9l0pkeinf
   79SKYpVaxKZIDt2Vt4fj9jTENNgKx1tL7psqLNFTsBz2GXY3isiQHS221
   vrSPZfE7rZCQcrRhJS2lAcnmOtt5aDI1JKdzeKGJAWQg3ydQwjli/Cdfh
   P8flXUFahDGch3VVUD5ewZgB6T+x5biCuz2zAF0of55YIUU3YUCftuaCw
   0rLqPTRz6ksmbQJ5v6KYzDHpIxhtfUljazppsv/mYcYi3uKSc/xFxet2H
   7KXAwXfGGjT1WuUGSAyv3v0qxSnCTqtNHmKzb9Tyqro0n7eKC9LlHibxp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="348012658"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="348012658"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 04:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="700390862"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="700390862"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.139.56])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 04:45:39 -0700
Date:   Fri, 5 May 2023 13:45:34 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 2/3] misc: enclosure, ses: simplify some get callbacks
Message-ID: <20230505134534.000066b9@linux.intel.com>
In-Reply-To: <645446ab23922_2ec5d2945c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
        <20221117163407.28472-3-mariusz.tkaczyk@linux.intel.com>
        <645446ab23922_2ec5d2945c@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 4 May 2023 16:58:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Mariusz Tkaczyk wrote:
> > Remove active, status, fault and locate variables from
> > enclosure_component struct. Return then directly.
> > No functional changes intended.  
> 
> This looks ok although it's not a clear win on the diffstat. Does this
> make the NPEM implementation easier to remove the indirection through
> "struct enclosure_component" for reading fresh values? That would help
> make the case.

I did that to familiarize better with this API. I determined that those values
can be just returned. They are refreshed every time on read in get_*led*(). I
believed that it makes implementation simpler for reader.

It could save me from some questions, "why not to reuse existing active,
fault, status variables" but it is no clear benefit.
It saves some memory because those variable probably won't be used in
NPEM/_DSM implementation (at least draft I left doesn't not use them).

If you don't see this valuable let me know, I can drop it.

Thanks,
Mariusz
