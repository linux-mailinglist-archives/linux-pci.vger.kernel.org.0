Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8B17AD7D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 18:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCERoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 12:44:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:41684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCERoz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Mar 2020 12:44:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 09:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="240889179"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 05 Mar 2020 09:44:41 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 1946658058B;
        Thu,  5 Mar 2020 09:44:41 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v16 7/9] PCI/DPC: Export DPC error recovery functions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <ef15401783b3d4f33072f8ffe84073cea178486d.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200305163723.GB14299@infradead.org>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <b4d0be7f-1cbe-22c9-ebb1-e2205ff5a732@linux.intel.com>
Date:   Thu, 5 Mar 2020 09:42:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305163723.GB14299@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/5/20 8:37 AM, Christoph Hellwig wrote:
> Please fix your subject.  Nothing is being exported in this patch.
I will do it. I meant it as its being used outside dpc..

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

