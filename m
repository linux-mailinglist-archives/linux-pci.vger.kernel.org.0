Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C83241CBE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgHKOuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Aug 2020 10:50:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:61161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgHKOuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Aug 2020 10:50:16 -0400
IronPort-SDR: PLDrom9O7eW0yYAw8U7AzYOTkNRkwUxVUp0TUYGRBF6Jz4y2N1YVy33rdKBZoL6USsGUNbj1gz
 RzgSbcFUnj8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="171786762"
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="171786762"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 07:50:15 -0700
IronPort-SDR: lim6dOyM7M6ZjxPMl1KN6NPpY/oExwYlaK43P+XCsOgQRcza64TZDr2+3+xuFH2SGxqgGG0sKo
 YQj3ql6dmddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,300,1592895600"; 
   d="scan'208";a="308421631"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2020 07:50:15 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 6E906580785;
        Tue, 11 Aug 2020 07:50:15 -0700 (PDT)
Message-ID: <4989e6bdfcd787e01c8459f4b5b9517a2ae73b24.camel@linux.intel.com>
Subject: Re: [PATCH V5 0/3] Intel Platform Monitoring Technology
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Tue, 11 Aug 2020 07:50:15 -0700
In-Reply-To: <20200811080433.GI4411@dell>
References: <20200717190620.29821-1-david.e.box@linux.intel.com>
         <20200729213719.17795-1-david.e.box@linux.intel.com>
         <74c03fe9fea12f4b056bf694a0d03d5200244231.camel@linux.intel.com>
         <20200811080433.GI4411@dell>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-08-11 at 09:04 +0100, Lee Jones wrote:
> On Mon, 10 Aug 2020, David E. Box wrote:
> 
> > Friendly ping.
> 
> Don't do that.  Sending contentless pings is seldom helpful.
> 
> If you think your set has been dropped please just send a [RESEND].
> 
> This is probably worth doing anyway, since you've sent v2, v3, v4 and
> now v5 has reply-tos of one another.  The thread has become quite
> messy as a result.
> 
> Also please take the time to identify where we are with respect to
> the
> current release cycle.  The merge-window is open presently.  Meaning
> that most maintainers are busy, either sending out pull-requests or
> ramping up for the next cycle (or just taking a quick breather).
> 

No problem. I'll resend v5 in a new thread when rc1 is tagged. Thanks.

