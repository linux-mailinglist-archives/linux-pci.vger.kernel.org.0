Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FDC6ECD2F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjDXNVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjDXNVP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:21:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB2714EEF;
        Mon, 24 Apr 2023 06:20:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29708D75;
        Mon, 24 Apr 2023 06:21:41 -0700 (PDT)
Received: from [10.57.21.60] (unknown [10.57.21.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 224FE3F64C;
        Mon, 24 Apr 2023 06:20:56 -0700 (PDT)
Message-ID: <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com>
Date:   Mon, 24 Apr 2023 14:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Content-Language: en-GB
To:     Jason Adriaanse <jason_a69@yahoo.co.uk>, hch@lst.de
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
References: <20230416065503.GB6410@lst.de>
 <fc9f4cef-9426-c9d2-3c2c-3ce12fe5f6c3@yahoo.co.uk>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <fc9f4cef-9426-c9d2-3c2c-3ce12fe5f6c3@yahoo.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-04-22 07:25, Jason Adriaanse wrote:
> Hi Christoph,
> 
> Sorry for my late reply, I have been on the road.
> 
> So, if I boot with
> intel_iommu=off
> Then the server boots fine..although that is not a solution because I 
> need Intel iommu for virtualisation.
> 
> Also, I build all my kernels with CONFIG_INTEL_IOMMU=y
> 

If you boot 5.15 *without* the "iommu=soft" argument, just 
"intel_iommu=on", does that also break?

Robin.
