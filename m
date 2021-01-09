Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB852EFDA6
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 05:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhAIEGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 23:06:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:12132 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbhAIEGg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 23:06:36 -0500
IronPort-SDR: JWe+BfksJa9PXBYZv30wGuP4eyQNMvlzG+kJeVDaNyd77tkcup2zmVpQrnoHTctdRUUnOJyH74
 QfD2C38wUqKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="164763421"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="164763421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 20:04:49 -0800
IronPort-SDR: OkuaDQclVPfdP1nLAynpvylUzFC681Nu4S1W4D1r4rDKddFpKHNEV5ubQZ3YFeuA2bUK9GewYY
 AqewMlSPns8w==
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="399195880"
Received: from tanmingy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.247.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 20:04:49 -0800
Subject: Re: [PATCH v4 1/1] PCI/ERR: don't clobber status after reset_link()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Hedi Berriche <hedi.berriche@hpe.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Russ Anderson <rja@hpe.com>, Joerg Roedel <jroedel@suse.com>,
        stable@kernel.org, Keith Busch <kbusch@kernel.org>
References: <20210108223043.GA1477254@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <01c316b7-afae-5ce5-0c5a-8878310fa1f6@linux.intel.com>
Date:   Fri, 8 Jan 2021 20:04:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108223043.GA1477254@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/8/21 2:30 PM, Bjorn Helgaas wrote:
> Can we push this forward now?  There are several pending patches in
> this area from Keith and Sathyanarayanan; I haven't gotten to them
> yet, so not sure whether they help address any of this.

Following two patches should also address the same issue.

My patch:

https://patchwork.kernel.org/project/linux-pci/patch/6f63321637fef86b6cf0beebf98b987062f9e811.1610153755.git.sathyanarayanan.kuppuswamy@linux.intel.com/

Keith's patch:

https://patchwork.kernel.org/project/linux-pci/patch/20210104230300.1277180-4-kbusch@kernel.org/



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
