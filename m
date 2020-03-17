Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6318885E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCQOzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 10:55:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:9571 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgCQOzs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 10:55:48 -0400
IronPort-SDR: +AwL8ns/o1/Mi2avIUrvyYesrQ6bf35Jcjor/Dk2Yv/Bc+GwVFGjPb52eGb02hbpO0nzxPx1SA
 HaNjDUb/CwXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 07:55:48 -0700
IronPort-SDR: F5WVtNGoovVCH4D/0UgxTfl963XCSHxim8CK/sXKmp/Jf2OYVLWSwk7NHZYjnmI/0eCdZ3WZhU
 U1PQTRo1T8xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="247843647"
Received: from mnagar-mobl.amr.corp.intel.com (HELO [10.254.66.68]) ([10.254.66.68])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2020 07:55:47 -0700
Subject: Re: [PATCH v17 05/12] PCI: portdrv: remove reset_link member from
 pcie_port_service_driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <13d4866abf46f034f706f255287258cda99fadb4.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200317144143.GD23471@infradead.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <496e07cf-2bdb-b1a5-c246-246103740ca1@linux.intel.com>
Date:   Tue, 17 Mar 2020 07:55:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317144143.GD23471@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/17/20 7:41 AM, Christoph Hellwig wrote:
> On Tue, Mar 03, 2020 at 06:36:28PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
it.
> 
> This should be folded into
> "PCI/ERR: Remove service dependency in pcie_do_recovery()"
I think Bjorn already folded them together. Please check.
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=review/edr&id=7a18dc6506f108db3dc40f5cd779bc15270c4183

> 
