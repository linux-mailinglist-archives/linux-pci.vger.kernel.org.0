Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D99793453
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 06:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjIFEOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjIFEOS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 00:14:18 -0400
Received: from out-214.mta0.migadu.com (out-214.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A0184
        for <linux-pci@vger.kernel.org>; Tue,  5 Sep 2023 21:14:14 -0700 (PDT)
Message-ID: <eccd1d51-68f5-2bd8-890e-6d7c422abce6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693973653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReUbfyeD3q8qKsZb9bv3mQc4hrhuGmFA0TdHPFwtCxA=;
        b=v516R8djVSQGBsC8dKVonWQw8LG8OnWSMj1zPxIIlXE12/9RexGW4MGevXucxjR0rNJrmV
        3BtBSLSs7/GM22h6yWJqwC6ViryP4klO1hhy4Sx/M0r1YrJ5F0rWpvqi2nfUBshaG1o+Kr
        NPnzupOYzec1IsJJ9tzGoxXDJhFy538=
Date:   Wed, 6 Sep 2023 12:14:01 +0800
MIME-Version: 1.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        suijingfeng <suijingfeng@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
 <5afd2efb-f838-f9b7-02a9-2cf4d4fd2382@loongson.cn>
 <773be4c6-0b3d-be39-7857-b3e2942007d9@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <773be4c6-0b3d-be39-7857-b3e2942007d9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/9/5 23:05, Thomas Zimmermann wrote:
> You might have found a bug in the ast driver. Ast has means to detect 
> if the device has been POSTed and maybe do that. If this doesn't work 
> correctly, it needs a fix.
>
That sounds fine.

The bug is not a big deal, I'm just take it as an example and report it to you.
But a real fix can be complex, because there are quite a lot of servers
ship with ASpeed BMC hardware.

Honestly I don't have the time fix it on formal way.
I have already tons patches in pending and I will focus on solve VGAARB related problem.


Because I want to test your patch occasionally.
So this series is useful for myself at corner cases.

