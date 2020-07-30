Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4333233801
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgG3Rx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 13:53:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:36972 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Rx4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 13:53:56 -0400
IronPort-SDR: 69vSudRU4FrcwkmxhHxA1hsqh4d1YLBzRLFqI1PVRBdA9M2xFPTfZBbDNzOXsZBhOd3Lorx0Md
 /+YuqDA0n15A==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149489899"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="149489899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 10:53:55 -0700
IronPort-SDR: Fc6Z47lifP2sAA8iN/gjznggKHYN2Ve5qn8/4HVHpCiTtwAARK9r8DQuX2N/VHbhnGHeFZMWEz
 mW/xHz/Bg/sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="321161314"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2020 10:53:55 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 2139858010E;
        Thu, 30 Jul 2020 10:53:55 -0700 (PDT)
Message-ID: <0d4e8a8130e6a78ba3b6fcb3aee9858d22e5c23b.camel@linux.intel.com>
Subject: Re: [PATCH V4 2/3] mfd: Intel Platform Monitoring Technology support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mark D Rustad <mrustad@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jul 2020 10:53:55 -0700
In-Reply-To: <3DCA0A88-0890-49EE-8644-E6311E891C55@gmail.com>
References: <20200714062323.19990-1-david.e.box@linux.intel.com>
         <20200717190620.29821-3-david.e.box@linux.intel.com>
         <20200728075859.GH1850026@dell>
         <3DCA0A88-0890-49EE-8644-E6311E891C55@gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-07-29 at 15:59 -0700, Mark D Rustad wrote:
> at 12:58 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > If you do:
> > 
> > 	do {
> > 		int pos;
> > 
> > 		pos = pci_find_next_ext_capability(pdev, pos,
> > PCI_EXT_CAP_ID_DVSEC);
> > 		if (!pos)
> > 			break;
> > 
> > Then you can invoke pci_find_next_ext_capability() once, no?
> 
> Part of your suggestion here won't work, because pos needs to be  
> initialized to 0 the first time. As such it needs to be declared
> and  
> initialized outside the loop. Other than that it may be ok.

Already done in V5. Thanks.

David

