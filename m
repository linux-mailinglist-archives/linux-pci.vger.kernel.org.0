Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5AB25CEE9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgIDBBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 21:01:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:29933 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbgIDBBE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 21:01:04 -0400
IronPort-SDR: lgfOgs3zYUBZL4xF9Gd493i/t+ic3S4QInmj9NtvOfJItS32EyRK9Jcqg8YlAdwACc2v5cKuco
 kHdqeP/eeR0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="156941317"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="156941317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 18:01:03 -0700
IronPort-SDR: 7I0YQQStCWRnkIvhcgR368RdbR9nQ/iyJ3418v7i0hSQubi85ZFZLtAW24KjcY1lQwp4qFyJtD
 nSux1qsCzBrg==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="341999594"
Received: from unknown (HELO [10.212.16.172]) ([10.212.16.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 18:01:03 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Martin =?utf-8?q?Mare=C5=A1?=" <mj@ucw.cz>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] pciutils: Add decode support for RCECs
Date:   Thu, 03 Sep 2020 18:01:02 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <EBF7EBBC-DF7C-4A6D-991E-E8782D5C5002@linux.intel.com>
In-Reply-To: <mj+md-20200902.084105.48579.albireo@ucw.cz>
References: <20200624223940.240463-1-sean.v.kelley@linux.intel.com>
 <mj+md-20200902.084105.48579.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2 Sep 2020, at 1:41, Martin Mareš wrote:

> Hello!
>
>> Root Complex Event Collectors provide support for terminating error
>> and PME messages from RCiEPs.  This patch provides basic decoding for
>> the lspci RCEC Endpoint Association Extended Capability. See PCIe 5.0-1,
>> sec 7.9.10 for further details.
>
> Applied.
>
> Thanks and sorry for the delay.
>
> 				Have a nice fortnight

Many thanks Martin.

Cheers,

Sean
> -- 
> Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
> United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
> A Bash poem: time for echo in canyon; do echo $echo $echo; done
