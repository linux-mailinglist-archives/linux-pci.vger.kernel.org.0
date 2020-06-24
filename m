Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6808A207C6B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406253AbgFXTvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 15:51:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:50809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406243AbgFXTvm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 15:51:42 -0400
IronPort-SDR: CJov8q8Y7s0zfuWbDwXb0Wpx8Le+qyaY1dL99SzkQqRhPcnOJXnJi6vK4uIZkI3CZqdTiyGlDx
 MSorHsLbi63w==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142097929"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="142097929"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 12:51:41 -0700
IronPort-SDR: 0HXStLgzbNaPqVGEZcN5pG+ymSki/qNqdVZRFuDBzuYsIYyFOTipKMQJ1s4kIvoJVp+hez2Ucx
 Lt4SSke28oeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="263728515"
Received: from arpeshla-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley) ([10.254.43.136])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2020 12:51:41 -0700
Message-ID: <c56b537ad4f13829d52ccfae73b5286090b01ad3.camel@linux.intel.com>
Subject: Re: [PATCH v2] pciutils: Add decode support for RCECs
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
Reply-To: sean.v.kelley@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mj@ucw.cz, bhelgaas@google.com, linux-pci@vger.kernel.org
Date:   Wed, 24 Jun 2020 12:51:41 -0700
In-Reply-To: <6672f7959e9737fbccfd3d12ef566c473dd127ea.camel@linux.intel.com>
References: <20200624155727.GA2554730@bjorn-Precision-5520>
         <6672f7959e9737fbccfd3d12ef566c473dd127ea.camel@linux.intel.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-06-24 at 12:44 -0700, Sean V Kelley wrote:
> That works well, I can also add the hyphen if it is adjacent with
> this,
> I think:
> 
> for (int dev=0; dev < 32; dev++)
>    {
>      if (BITS(bmap, dev, 1))
>        {
>          if (!adjcount)
>            printf("%s %u", (prevmatched) ? "," : "", dev);
>          prevmatched=1;
>          adjcount++;
>          prevdev=dev;
>        }
>      else
>        {
>          if (adjcount > 1)
>            printf("-%u", prevdev);
>          adjacent=0;

Rather, I meant:
adjcount=0; 

>        }
>    }
> 
> 

