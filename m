Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3880518888B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 16:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCQPFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 11:05:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:17995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgCQPFv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 11:05:51 -0400
IronPort-SDR: 6MWYJfiA39TX4EP9OS0UZ8ntF3TYmOtfBWLIyUonFqXx6vFdsN8BCEQ7416HhgC5YLvfNUu60h
 YTnXfokI4vDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 08:05:50 -0700
IronPort-SDR: 0F5yhZVfHuxH8qv7v2hDlYxJr70DDvhMGxEx+bqv8nsVpxLed09Nt2atEZuDVhjob+wkOmfzzH
 tw5vTvZmdcSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="247848301"
Received: from mnagar-mobl.amr.corp.intel.com (HELO [10.254.66.68]) ([10.254.66.68])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2020 08:05:50 -0700
Subject: Re: [PATCH v17 06/12] Documentation: PCI: Remove reset_link
 references
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a46938d227f6a11c010943800450a10aac39b7d3.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200317144203.GE23471@infradead.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ebb79d02-53f5-cc23-0b38-72a351a05097@linux.intel.com>
Date:   Tue, 17 Mar 2020 08:05:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317144203.GE23471@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/17/20 7:42 AM, Christoph Hellwig wrote:
> On Tue, Mar 03, 2020 at 06:36:29PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
> 
> This should be folded into the patch removing the method.
This is also folded in the mentioned patch.
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=review/edr&id=7a18dc6506f108db3dc40f5cd779bc15270c4183
> 
