Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2D3D03D7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 23:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhGTUpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 16:45:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:42766 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233545AbhGTUpF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 16:45:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211329654"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="211329654"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 14:25:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="661661150"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.64.39]) ([10.212.64.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 14:25:42 -0700
Subject: Re: [PATCH v2 0/2] Issue secondary bus reset and domain window reset
To:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
References: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Message-ID: <4fde3255-ae6c-aac9-d76b-dcdff934d5c9@linux.intel.com>
Date:   Tue, 20 Jul 2021 14:25:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/20/2021 1:50 PM, Nirmal Patel wrote:
> During VT-d pass-through, the VMD driver occasionally fails to
> enumerate underlying NVMe devices when repetitive reboots are
> performed in the guest OS. The issue seems to be resolved by
> performing secondary bus resets and reinitializing the root
> port's bridge windows.
>
> Nirmal Patel (2):
>   PCI: vmd: Trigger secondary bus reset
>   PCI: vmd: Issue vmd domain window reset
>
>  drivers/pci/controller/vmd.c | 81 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
There is no v1 of this patch. I made a newbie mistake and didn't remove v2 after internal review. Please let me know if you have alternate suggestion to fix this issue.

