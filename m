Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05DB793587
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 08:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjIFGr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 02:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIFGr2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 02:47:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BFECFC;
        Tue,  5 Sep 2023 23:47:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-307d20548adso2768758f8f.0;
        Tue, 05 Sep 2023 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693982841; x=1694587641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8sWie/AS6uY3OK7RU4F+xWFwmy+yKN5/EnMqbo0bWo=;
        b=A+68sj/TjCVXgcPIZCVSVkRWnGpgC8rIq4Cl4VgLDJ2K/Y+M34syJqvgTdm6MjBM/U
         VgvQfsW/QhOXHXRG/IK7BGfJFXjJ4IBis8X4p2sGiNoSXUxQvL522l21lCCGXgL1lipt
         d9slJxPxjvasOTvyj2ygSg91PRnaHRTiDOF++27gAEA7CgFf3Vyo1/rJePo661ouyuiG
         xJtKuHd6z3ykHVCnm8ACnl8fJzAqnPih/np0gYTGDD7fwQgTPqzBrYB374FsPAfNlgjQ
         ubQJ0JQX/J3YMbPofTxZcZS+1o6t82B+xD//U+eKUZWxvxg9gUPgU3Mcl8xgIaCbXlq1
         Lseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982841; x=1694587641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8sWie/AS6uY3OK7RU4F+xWFwmy+yKN5/EnMqbo0bWo=;
        b=NbIHBiUSCClYlfIvDvoK/TqqZWV6kxif+XfrnD+DTecGVQH0P7tOJ+GyH7kETIvB+s
         H7Uc4UAlwmkarrIVGOhSdtOIY3EM/t96NK7bxeB6wBD+nzxzcvwdtA14Ca4AQaEidNul
         AGcepFA27qP7ECPxoOovsnhcckFetBbvgxgA/5NRDRWGG/IuUop6/gBAv/WYGAunOst+
         HrF44k1T3k8HDMZjzcyCVn5sf4lby4uSMGtCTmApdwjhxRA/q8UsyPe7+ReTnoAnYPw5
         7qu2lSBBlprTx7+MvUconGIh2OuMt/qaSkSBiKf3Vr9+zHu7WXVM6d7oQO1JmdzTqwrM
         6Oxg==
X-Gm-Message-State: AOJu0YzR6ZBsAwHz7h1vFlKAp+JGm2lc6HomxAsDRYMaaK6TDwU6CRij
        XpBmvF5Ecty8AUYEVefmbHs=
X-Google-Smtp-Source: AGHT+IF5XtNyYf7L15ODjbW2VFNlEMRZDHuCirLrnpA/NSlI86bWQg0h5niAewTjfoMC8VkyIEtm1w==
X-Received: by 2002:adf:f144:0:b0:319:8436:d77d with SMTP id y4-20020adff144000000b003198436d77dmr1550153wro.37.1693982841358;
        Tue, 05 Sep 2023 23:47:21 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id dd18-20020a0560001e9200b0031f3ad17b2csm11939943wrb.52.2023.09.05.23.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 23:47:14 -0700 (PDT)
Message-ID: <ffa04976-c2c4-9a63-2b43-7cb7ea3d92ea@gmail.com>
Date:   Wed, 6 Sep 2023 08:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user to select
 the primary video adapter at boot time
Content-Language: en-US
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
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
 <e3d2d996-a2c1-c4b8-7722-f67aefac8193@linux.dev>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <e3d2d996-a2c1-c4b8-7722-f67aefac8193@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 05.09.23 um 16:28 schrieb Sui Jingfeng:
> Hi,
>
> On 2023/9/5 21:28, Christian König wrote:
>>>>
>>>> 2) Typically, those non-86 machines don't have a good UEFI firmware
>>>>     support, which doesn't support select primary GPU as firmware 
>>>> stage.
>>>>     Even on x86, there are old UEFI firmwares which already made 
>>>> undesired
>>>>     decision for you.
>>>>
>>>> 3) This series is attempt to solve the remain problems at the 
>>>> driver level,
>>>>     while another series[1] of me is target to solve the majority 
>>>> of the
>>>>     problems at device level.
>>>>
>>>> Tested (limited) on x86 with four video card mounted, Intel UHD 
>>>> Graphics
>>>> 630 is the default boot VGA, successfully override by ast2400 with
>>>> ast.modeset=10 append at the kernel cmd line.
>>> The value 10 is incredibly arbitrary, and multiplied as a magic number
>>> all over the place.
>>
>> +1 
>
>
> This is the exact reason why I made this series as RFC, because this 
> is a open-ended problem.
> The choices of 3,4,5,6,7,8 and 9 are as arbitrary as the number of 
> '10'. '1' and '2' is
> definitely not suitable, because the seat has already been taken.

Well you are completely missing the point. *DON'T* abuse the modeset 
module parameters for this!

If you use 10 or any other value doesn't matter.

Regards,
Christian.

>
> Take the drm/nouveau as an example:
>
>
> ```
>
> MODULE_PARM_DESC(modeset, "enable driver (default: auto, "
>                   "0 = disabled, 1 = enabled, 2 = headless)");
> int nouveau_modeset = -1;
> module_param_named(modeset, nouveau_modeset, int, 0400);
>
> ```
>
>
> '1' is for enable the drm driver, some driver even override the 
> 'nomodeset' parameter.
>
> '2' is not suitable, because nouveau use it as headless GPU 
> (render-only or compute class GPU?)
>
> '3' is also not likely the best, the concerns is that
> what if a specific drm driver want to expand the usage in the future?
>
>
> The reason I pick up the digit '10' is that
>
>
> 1) The modeset parameter is unlikely to get expanded up to 10 usages.
>
> Other drm drivers only use the '-1', '0' and 1, choose '2' will 
> conflict with drm/nouveau.
> By pick the digit '10', it leave some space(room) to various device 
> driver authors.
> It also helps to keep the usage consistent across various drivers.
>
>
> 2) An int taken up 4 byte, I don't want to waste even a single byte,
>
> While in the process of defencing my patch, I have to say
> draft another kernel command line would cause the wasting of precious 
> RAM storage.
>
> An int can have 2^31 usage, why we can't improve the utilization rate?
>
> 3) Please consider the fact that the modeset is the most common and 
> attractive parameter
>
> No name is better than the 'modeset', as other name is not easy to 
> remember.
>
> Again, this is for Linux user, thus it is not arbitrary.
> Despite simple and trivial, I think about it more than one week.
>

