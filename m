Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D9512118
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiD0PJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiD0PIp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 11:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B8564FC6B
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651071932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3t/sLcxk5ON+nCAOFqDjHqbbXWr7HEuBu+6M9wcEXV8=;
        b=RCjuKPo24WbpulEqEAHMcnF4mRNXiRdg06g3UX0u09GGp/Mhk82+SxNZSybYupc30h5gj8
        oZpeRv3XfQm5XSU2Jvrsy0ov49TBUDmpEz7GU221Lfngl79RIfgh8K/C//MJ6owfv+WbGp
        AWpHPUvsT/JOH0W3e4/gG0m2AjKbh/4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-eWDpQQ_0NzKD6NqsKvPNig-1; Wed, 27 Apr 2022 11:05:30 -0400
X-MC-Unique: eWDpQQ_0NzKD6NqsKvPNig-1
Received: by mail-ed1-f70.google.com with SMTP id l24-20020a056402231800b00410f19a3103so1160014eda.5
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 08:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3t/sLcxk5ON+nCAOFqDjHqbbXWr7HEuBu+6M9wcEXV8=;
        b=Uj4mM6Su2v7jsua6nGme4RZguqmZoNbIBB6J2yCbSdA4MU14fx3v6VLYYqocIimACj
         aBpUsviRZXoJvNqjPGn3z8+BS2zMriW8iVrO+ZEP64RXt5e3kDCkn8US42p0vTllw7sp
         ZFgp+HsbmavxDDN954t3VOt7Ctw+f/UxKRs4IVwnXa+kx5+cZONiR+CePRtERKL4ngVf
         2nPhUbS0xDDu8LzZb0QJZ40pGikxQAcdL73CAIsgxEAY8QOLNoJYDxl/TrPmd2Pqk87R
         Ibq0CIX68YtesiAF+A9N5LoajRK4fpsNNqUwV5W0Hz7jgnODxWsYZYyZ2Bip96V5wL4y
         ByvA==
X-Gm-Message-State: AOAM532M4HjAfkYC76UhHC02UTlzFTBk4n5Ph9OVOe5lVJdM8MUaE84/
        EXyI1MpPEnKBNZA40Ft1bh5spfea1Wa7KzyQEZp0xZXmBxjMiElI52utVXIsQqftS6Oj1R6PsOV
        tKJUPo+CpM+YCVReXUuB2
X-Received: by 2002:a17:906:1b1b:b0:6f3:9044:5fb4 with SMTP id o27-20020a1709061b1b00b006f390445fb4mr15892653ejg.763.1651071929708;
        Wed, 27 Apr 2022 08:05:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW6QYNB9mO1C2n0d8BB/YK/nWa+lxH0HlS4zgjNQP35Gfh0Ka65UPPL3YcQEW3fJBKBrFN3A==
X-Received: by 2002:a17:906:1b1b:b0:6f3:9044:5fb4 with SMTP id o27-20020a1709061b1b00b006f390445fb4mr15892643ejg.763.1651071929527;
        Wed, 27 Apr 2022 08:05:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906924200b006f3d1141693sm656369ejx.44.2022.04.27.08.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 08:05:28 -0700 (PDT)
Message-ID: <1c5df3fc-98a3-5cc4-a542-1c8920e709e5@redhat.com>
Date:   Wed, 27 Apr 2022 17:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: PCIE ASPM-related trouble with S0ix on Thinkpad X1
 (NVME-related?)
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        "Box, David E" <david.e.box@intel.com>,
        "Wang, Wendy" <wendy.wang@intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <87k0bvutxf.fsf@toke.dk>
 <MW3PR11MB4522A97808B70EFA41122723A1ED9@MW3PR11MB4522.namprd11.prod.outlook.com>
 <8735ii384z.fsf@toke.dk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8735ii384z.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

On 4/12/22 12:31, Toke Høiland-Jørgensen wrote:
> "Box, David E" <david.e.box@intel.com> writes:
> 
>> There are a few things that could be going on. Please file a bug
>> report at bugzilla.kernel.org under Power Management. Provide all this
>> information and include the output from lspci -vvv when ran as root.
>> Thanks.
> 
> Alright, thanks! Opened
> https://bugzilla.kernel.org/show_bug.cgi?id=215832

David, Toke has provided the requested info at the above bugreport,
but sofar no-one has responded to this bug report yet.

Can you respond / follow up with Toke in the bug report please?

Regards,

Hans

