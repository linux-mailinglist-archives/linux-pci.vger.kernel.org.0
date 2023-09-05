Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FBB7928AE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjIEQXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354797AbjIEO20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 10:28:26 -0400
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [IPv6:2001:41d0:1004:224b::da])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B10189
        for <linux-pci@vger.kernel.org>; Tue,  5 Sep 2023 07:28:21 -0700 (PDT)
Message-ID: <e3d2d996-a2c1-c4b8-7722-f67aefac8193@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693924098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UR1E0EgY5MLLLn/rotdUHKRy5Nxe3OW4mUJd7Y8S7Ac=;
        b=f82FFX3ED+RO8uacw2rhS2YPv3o9jaMPTNOmmpLcmCuk5FgapClX0a64QrddQ0431Won7u
        3xWw4hB8t8g3ByC+AcVTZNZBKfLw1/o2iWi8F0esh9FSw9iqyg6m/2vliRccsaX40+fZHo
        +At90VECeg91hXCSsjHb/OR4Zc5Cglo=
Date:   Tue, 5 Sep 2023 22:28:02 +0800
MIME-Version: 1.0
Subject: Re: [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user to select
 the primary video adapter at boot time
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <874jk8j45s.fsf@intel.com> <b11fedb4-d577-d007-0ef8-ac62775d9eee@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <b11fedb4-d577-d007-0ef8-ac62775d9eee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/9/5 21:28, Christian König wrote:
>>>
>>> 2) Typically, those non-86 machines don't have a good UEFI firmware
>>>     support, which doesn't support select primary GPU as firmware 
>>> stage.
>>>     Even on x86, there are old UEFI firmwares which already made 
>>> undesired
>>>     decision for you.
>>>
>>> 3) This series is attempt to solve the remain problems at the driver 
>>> level,
>>>     while another series[1] of me is target to solve the majority of 
>>> the
>>>     problems at device level.
>>>
>>> Tested (limited) on x86 with four video card mounted, Intel UHD 
>>> Graphics
>>> 630 is the default boot VGA, successfully override by ast2400 with
>>> ast.modeset=10 append at the kernel cmd line.
>> The value 10 is incredibly arbitrary, and multiplied as a magic number
>> all over the place.
>
> +1 


This is the exact reason why I made this series as RFC, because this is a open-ended problem.
The choices of 3,4,5,6,7,8 and 9 are as arbitrary as the number of '10'. '1' and '2' is
definitely not suitable, because the seat has already been taken.

Take the drm/nouveau as an example:


```

MODULE_PARM_DESC(modeset, "enable driver (default: auto, "
		          "0 = disabled, 1 = enabled, 2 = headless)");
int nouveau_modeset = -1;
module_param_named(modeset, nouveau_modeset, int, 0400);

```


'1' is for enable the drm driver, some driver even override the 'nomodeset' parameter.

'2' is not suitable, because nouveau use it as headless GPU (render-only or compute class GPU?)

'3' is also not likely the best, the concerns is that
what if a specific drm driver want to expand the usage in the future?


The reason I pick up the digit '10' is that


1) The modeset parameter is unlikely to get expanded up to 10 usages.

Other drm drivers only use the '-1', '0' and 1, choose '2' will conflict with drm/nouveau.
By pick the digit '10', it leave some space(room) to various device driver authors.
It also helps to keep the usage consistent across various drivers.


2) An int taken up 4 byte, I don't want to waste even a single byte,

While in the process of defencing my patch, I have to say
draft another kernel command line would cause the wasting of precious RAM storage.

An int can have 2^31 usage, why we can't improve the utilization rate?

3) Please consider the fact that the modeset is the most common and attractive parameter

No name is better than the 'modeset', as other name is not easy to remember.

Again, this is for Linux user, thus it is not arbitrary.
Despite simple and trivial, I think about it more than one week.

