Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3E6F6AE7
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 14:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjEDMK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDMK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 08:10:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B756189
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683202255; x=1714738255;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eH00SYKnoAKolAuCJ60DBqLm+eLoQIlkpHCTVH5gHvA=;
  b=dcJLpCAoqHJ37jU4M/vUH3+KI+jQ8lUFNhfEDXcvnSqicH5m0e9GxQS0
   TxgJskdebT7qBCCNRnZKEg39oMcvtuXVOMFAqo6VuQZxLj5FdMKnW4Iu7
   Fpvgp3glvnMvJIecdIG9FOddbyG+KwWoQ5dK/nhhi4X3VTH7liZMwwAvt
   226WK9wN67zQgJN+qMNg8pIiN9qe7c8r72NZ3Xtl3E/vvWrBDDhjhg391
   4OGk/1rxRVU8f41rDpIm66gkcuhaedIUXptTgO/wFY5qexc1nLOya0OC+
   jsXPl8eZQZOSS28lONHWwwGSQOtHVw3ppKi73LaY+GQumaierjHWrg+Qi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="347733249"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="347733249"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 05:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="786511987"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="786511987"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.148.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 05:10:53 -0700
Date:   Thu, 4 May 2023 14:10:48 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, stuart.w.hayes@gmail.com,
        dan.j.williams@intel.com
Subject: Re: [PATCH 0/3] Enclosure sysfs refactor
Message-ID: <20230504141048.00001ba6@linux.intel.com>
In-Reply-To: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Nov 2022 17:34:04 +0100
Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com> wrote:

> Hi Bjorn,
> I agreed with Stuart to take over the NPEM implementation[1].
> First part I want to share is a small refactor around enclosure interface.
> 
> The one sysfs change introduced is changing active LED to write-only.
> get_active() callback is not implemented for SES which is the
> only one enclosure API consumer now.
> 
> [1]
> https://lore.kernel.org/linux-pci/cover.1643822289.git.stuart.w.hayes@gmail.com/
> 
> Mariusz Tkaczyk (3):
>   misc: enclosure: remove get_active() callback
>   misc: enclosure, ses: simplify some get callbacks
>   misc: enclosure: update sysfs api
> 
>  drivers/misc/enclosure.c  | 96 ++++++++++++++++-----------------------
>  drivers/scsi/ses.c        | 33 ++++++++------
>  include/linux/enclosure.h | 14 ++----
>  3 files changed, 61 insertions(+), 82 deletions(-)
> 

Hi Bjorn,
Could you please take a look? Let me know if you against this cleanup.
I would like to get back to NPEM, I based my patches on top of it.

Thanks,
Mariusz
