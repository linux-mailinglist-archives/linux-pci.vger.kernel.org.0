Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1532852A595
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349563AbiEQPDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349545AbiEQPDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 11:03:46 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99124286F1;
        Tue, 17 May 2022 08:03:45 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q2so18969190vsr.5;
        Tue, 17 May 2022 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S4e8UP5BJWcehEd5lvqnvGFisDV1bTubwTjUFBZmIpM=;
        b=it+A4dqWumEFH1OSAjnGrn0chRuB/5FpiUDVDsQus4pGIE77uwkNPajTFqp43yaQQV
         0K4FVAfDKxGbfdWuXwGMuG7OWRggbGm9UcyR6gkdkalqgO7NTI8voWH0N6d7cHwOuPLb
         tAwe5tmJsOrauX8ChVqllBdIg4J3215TuS3u6DcHR4ERrH0PN+5+kH7m93V1Cye9CgP+
         vUeIStn210AYuqJef07EjLTloaNfpoPGmO2ohlLbpqZ8tzNhJ+mEmaAVYk7w2HQe2lqo
         29xH4Y+sUjHCMOxqVITXcyH9o5Ob+H1KoW7qMDLlKIeQsHopFS681ikGrcVWoXCqVTOv
         JKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S4e8UP5BJWcehEd5lvqnvGFisDV1bTubwTjUFBZmIpM=;
        b=Ixa3kqQJh7u+rcI8FT00j7ISHXObOAuEOvDw2JNo+O7PVH+hZuH5wdbbubopfMl6z9
         +faYjoycZ0+OoE1NvLm7OBai0h5blQhD84sqSq5n2Xko2XO/OlaZH0IqFQ1CvLGiwJ6J
         bNKJLNDMqedaOKX258T4uR7EckLhzTV0S4Sy3LJbPdkZ2tTDrp9AEw7CH+tpZXnV61Y0
         PL7c2ickuhzKeqb65xbapHLTiD8qEk9AezxP3GhAgPU1hYVqpk2tMYCMIA3nIMkvqkM+
         yjiwe+v1IG2pPVzai7yDMAFjbrW5QAdgpIKFX0e4EnNBiJCRd8QPKVuX91nxGePbyTn7
         GlwA==
X-Gm-Message-State: AOAM532WFodYtpWp+320nPRJ9k19+i3BiljLlHNer1nDvUW/bHXDdEyK
        0NENvGddh9kslkksnb5jV5I=
X-Google-Smtp-Source: ABdhPJxRUVIxQQmWioisYDsZbORonfIHNKzTiaRi23XzztneUyBk5dUPpWSFnz0dCz+HHvz3xLdiRA==
X-Received: by 2002:a05:6102:548a:b0:32d:8c72:ee18 with SMTP id bk10-20020a056102548a00b0032d8c72ee18mr9187660vsb.70.1652799824751;
        Tue, 17 May 2022 08:03:44 -0700 (PDT)
Received: from [192.168.1.140] ([65.35.200.237])
        by smtp.gmail.com with ESMTPSA id b20-20020a056102233400b0032d275e6922sm1207602vsa.34.2022.05.17.08.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:03:44 -0700 (PDT)
Message-ID: <30bb7968-06fb-308c-a5f0-df316dfb240e@gmail.com>
Date:   Tue, 17 May 2022 11:03:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] of: always populate a root node
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <20220427094502.456111-2-clement.leger@bootlin.com>
 <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
 <d356acbe-daff-1c66-6511-aab97a171c82@gmail.com>
 <20220517093729.214c33a3@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220517093729.214c33a3@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/17/22 02:37, Clément Léger wrote:
> Le Mon, 16 May 2022 23:11:03 -0400,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> On 5/3/22 08:45, Rob Herring wrote:
>>> On Wed, Apr 27, 2022 at 11:45:00AM +0200, Clément Léger wrote:  
>>>> When enabling CONFIG_OF on a platform where of_root is not populated by
>>>> firmware, we end up without a root node. In order to apply overlays and
>>>> create subnodes of the root node, we need one. This commit creates an
>>>> empty root node if not present.  
>>>
>>> The existing unittest essentially does the same thing for running the 
>>> tests on non-DT systems. It should be modified to use this support 
>>> instead. Maybe that's just removing the unittest code that set of_root.
>>>
>>> I expect Frank will have some comments.  
>>
>> My preference would be for unflatten_and_copy_device_tree() to
>> use a compiled in FDT that only contains a root node, in the
>> case that no valid device tree is found (in other words,
>> "if (!initial_boot_params)".
> 
> Ok, so basically, instead of creating the root node manually, you
> expect a device-tree which contains the following to be builtin the
> kernel and unflattened if needed:
> 
> / {
> 
> };

Yes.  If you agree with this I can create a patch to implement it.  I think
it is useful even stand alone from the rest of the series.

> 
> Maybe "chosen" and "aliases" nodes should also be provided as empty
> nodes since the unittest are creating them anyway and the core DT code
> also uses them.

No. Unittest does not create both of them (I'm pretty sure, but I'm not
going to double check).  If I recall correctly, unittest adds a property
in one of those two nodes, and thus implicitly creates the node if not
already present.  Unittest does populate internal pointers to those two
nodes if the nodes are present (otherwise the pointers will have the
value of null).  There is no need for the nodes to be present if empty.

-Frank

> 
> Thanks,
> 
> Clément
> 
>>
>> unflatten_and_copy_device_tree() calls unittest_unflatten_overlay_base()
>> after unflattening the device tree passed into the booting kernel.  This
>> step is needed for a specific portion of the unittests.
>>
>> I'm still looking at the bigger picture of using overlays for the PCIe
>> card, so more comments will be coming about that bigger picture.
>>
>> -Frank
>>
> 
> 

