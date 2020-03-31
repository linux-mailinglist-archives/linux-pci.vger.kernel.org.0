Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF4199B77
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgCaQ2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 12:28:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:53503 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCaQ2Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 12:28:24 -0400
IronPort-SDR: 3ve4jLUO/SK+KdTsF6Cw5HSJ7YzMGvIDQwEiVBpc8+iltN3vMgBvOGKnIJ1hS1nty2MZuAL1/q
 XtV7aW82criw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 09:28:23 -0700
IronPort-SDR: zm6TknQZyBWflmCfSeBedo7z97XVXGTJGNsuMJc+rUJW+x40JANgNkImoK8bBUhI4qS/rRvp4G
 vfOFf/o4dCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="237760489"
Received: from agvardha-mobl.amr.corp.intel.com (HELO [10.254.114.72]) ([10.254.114.72])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2020 09:28:22 -0700
Subject: Re: [PATCH v18 00/11] Add Error Disconnect Recover (EDR) support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200331152805.GA188783@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f1ee3d04-97f5-9249-dbaa-0f08198ca19d@linux.intel.com>
Date:   Tue, 31 Mar 2020 09:28:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331152805.GA188783@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/31/20 8:28 AM, Bjorn Helgaas wrote:
> Applied to pci/edr for v5.7, except these two:
Great. Thanks.
> 
>      PCI: move {pciehp,shpchp}_is_native() definitions to pci.c
>      PCI/DPC: Fix DPC recovery issue in non hotplug case
